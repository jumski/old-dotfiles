#!/usr/bin/python

# Xhotkeys - Bind keys and mouse events to commands in the X-Window
#
# Copyright (C) 2006 Arnau Sanchez
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation, 
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

# Some ideas taken from KeyLauch (thanks to Ken Lynch and Stefan Pfetzing)
# Feel free to contact me at <arnau@ehas.org>

# Python modules
import os, sys, time, signal
import urllib, re, optparse
import inspect, threading

# Xlib modules
import Xlib.display, Xlib.X, Xlib.XK
import Xlib.Xatom, Xlib.keysymdef.xkb

# PyGTK and Glade modules
import pygtk
pygtk.require("2.0")
import gtk, gtk.glade, gobject

####################################
__version__ = "$Revision: 1.9 $"
__author__ = "Arnau Sanchez <arnau@ehas.org>"
__depends__ = ['Xlib', 'PyGTK2', 'Glade', 'Python-2.3']
__copyright__ = """Copyright (C) 2006 Arnau Sanchez <arnau@ehas.org>.
This code is distributed under the terms of the GNU General Public License."""

### Global variables
NAME = "xhotkeys"
DISABLE_HOTKEY = Xlib.XK.XK_BackSpace
DISABLED_STRING = "Disabled"
MOUSE_STRING = "Button"
SETTINGS_WINDOW = "window: %d,%d (%dx%d)"
SETTINGS_COLUMN = "table: %d,%d,%d"
TARGET_TYPE_URI_LIST = 80

## Verbose levels
LEVELS_STRING = "error", "info", "debug"
ERROR, INFO, DEBUG = range(3)

x = Xlib.X
MODIFIERS = [("shift", x.ShiftMask), ("lock", x.LockMask), ("control", x.ControlMask), \
	("alt", x.Mod1Mask), ("mod2", x.Mod2Mask), ("mod3", x.Mod3Mask), \
	("winkey", x.Mod4Mask), ("altgr", x.Mod5Mask)]

########################################
## From Peter Norvig's Infrequently Answered Questions
def create_dict(**dict): 
	return dict

#######################################################
def debug(text, verbose_level, level, exit=None):
	"""Give some debug messages.
	
	verbose_level -- verbose level for this message: DEBUG, INFO, ERROR
	level -- current log-level: DEBUG, INFO, ERROR
	exit -- if defined, finish with this exit code"""
	if level <= verbose_level:
		text = "%s: %s" %(LEVELS_STRING[level], text)
		sys.stderr.write(text + "\n")
		sys.stderr.flush()
	if exit != None: 
		sys.exit(exit)

###################################################
def run_command(command):
	"""Run command using SHELL variable from environment. If not found, use sh"""
	if not command: return
	shell = os.getenv("SHELL", "/bin/sh")
	os.spawnvp(os.P_NOWAIT, shell, [os.path.basename(shell), "-c", command])

######################################
######################################
class XhotkeysServer(threading.Thread):
	"""Wait for key combinations and run command if configured"""

	##################################################
	def __init__(self, verbose_level=INFO):
		"""Init server Hotkey server. verbose_level -- DEBUG, INFO, ERROR"""
		self.verbose_level = verbose_level
		self.display = Xlib.display.Display()
		self.root = self.display.screen().root
		self.combinations = []
		self.init_signals([signal.SIGCHLD])
		self.get_keylock_masks()
		self.stop_flag = False
		threading.Thread.__init__(self)

	########################################
	def string_to_mask(self, strmods):
		"""Return modifier mask from its name: "shift", "alt", ..."""
		mask = 0
		for strmod in strmods:
			mask |= dict(MODIFIERS)[strmod.lower()]
		return mask

	########################################
	def string_to_keycode(self, strcode):
		if len(strcode) > 2 and strcode[0] == "@" and strcode[-1] == "@":
			return "key", int(strcode[1:-1])
		if strcode.find(MOUSE_STRING) == 0:
			return "button", int(strcode[-1])
		for key in inspect.getmembers(Xlib.XK):
			if key[0].find("XK_") != 0 or strcode.lower() != key[0].replace("XK_", "").lower(): continue
			return "key", self.display.keysym_to_keycode(key[1])

	##################################################
	def get_keylock_masks(self):
		"""Get Caps/Num/Scroll Lock masks. Needed because must their value 
		must be ignored in key combinations"""
		kc, ktk = Xlib.XK, self.display.keysym_to_keycode
		keycodes = {ktk(kc.XK_Caps_Lock): "caps", ktk(kc.XK_Num_Lock): "num", ktk(kc.XK_Scroll_Lock): "scroll"}
		self.locks_mask = dict([(x, 0) for x in keycodes.values()])
		for index, mask in enumerate(self.display.get_modifier_mapping()):
			try: self.locks_mask[keycodes[mask[0]]] = 1 << index
			except: pass

	##################################################
	def init_signals(self, signals):
		"""Get name signals and set handler for child process signals"""
		self.signames = {}
		for key, value in inspect.getmembers(signal):
			if key.find("SIG") == 0 and key.find("SIG_") != 0: 
				self.signames[value] = key
		for sig in signals:
			signal.signal(sig, self.signal_handler)

	####################################
	def signal_handler(self, signum, frame):
		"""Process received signals:
		
		SIGCHLD -- Waits return value for a finished child
		"""	
		signame = self.signames.get(signum, "unknown")
		self.debug("signal received: %s" %signame)
		if signum == signal.SIGCHLD:
			self.debug("wait a child")
			try: pid, retval = os.wait()
			except: self.debug("error waiting a child"); return
			self.debug("child pid = %d - return value = %d" %(pid, retval))

	#######################################################
	def debug(self, text, level=DEBUG, exit=None):
		debug(text, self.verbose_level, level, exit)

	#######################################
	def ungrab(self):
		"""Ungrab keyboard and mouse bindings"""
		self.display.ungrab_keyboard(Xlib.X.CurrentTime)
		self.display.flush()
		self.root.ungrab_key(Xlib.X.AnyKey, Xlib.X.AnyModifier)
		self.root.ungrab_button(Xlib.X.AnyButton, Xlib.X.AnyModifier)
		
	#######################################
	def set_combination(self, combinations):
		"""Set the current hotkey table"""
		self.ungrab()
		self.combinations = []
		for comb in combinations:
			hotkey = comb["hotkey"]
			type = mask = keycode = 0
			if hotkey.lower() != DISABLED_STRING.lower():
				modifiers = re.findall("<(\w+)>", hotkey)
				mask = self.string_to_mask(modifiers)
				try: key = re.findall("(@?\w+@?)$", hotkey)[0]
				except: self.debug("error parsing hotkey: %s" %hotkey, ERROR); continue
				try: type, keycode = self.string_to_keycode(key)
				except: self.debug("error parsing: %s" %key, ERROR); continue
			newcomb = create_dict(name=comb["name"], command=comb["command"], \
				type=type, mask=mask, keycode=keycode)
			self.combinations.append(newcomb)

		self.configure()

	##################################################
	def stop(self):
		"""Stop the thread"""
		self.stop_flag = True

	##################################
	def grab_button(self, button, modifiers, owner_events, event_mask, \
		pointer_mode, keyboard_mode, confine_to, cursor, onerror=None):
		"""This need an explanation: at this moment, June 2006, Python-Xlib is broken
		at grab_button(), a basic function to grab mouse events. A bug on this issue was 
		already reported at the ends of 2004, with no response... the project seems 
		temporally dead. 
		
		So, here we make a direct call to GrabButton() with the correct parameters. 
		The problem was that the "cursor=cursor" parameter was missing, that's all"""
		Xlib.protocol.request.GrabButton(display=self.root.display, onerror=onerror, \
			owner_events=owner_events, grab_window=self.root.id, event_mask=event_mask, \
			pointer_mode=pointer_mode, keyboard_mode=keyboard_mode, \
			confine_to= confine_to, button=button, cursor=cursor, modifiers=modifiers)

	##################################################
	def configure(self):
		"""Set hotkeys and hotbuttons from the current table"""
		mode = Xlib.X.GrabModeAsync
		
		# I don't know why, but events are received even without calling change_attributes...
		self.root.change_attributes(event_mask=Xlib.X.KeyPressMask | Xlib.X.ButtonPressMask)
		for comb in self.combinations:
			if not comb["keycode"]: continue
			key, mod, type = [comb[x] for x in ("keycode", "mask", "type")]
			cl, nl, sl = [self.locks_mask[x] for x in ("caps", "num", "scroll")]
			for mask in (0, cl, nl, sl, cl | nl, cl | sl, cl | nl | sl):
				if type == "button":
					self.grab_button(key, mod|mask, self.root, Xlib.X.ButtonPressMask, mode, mode, 0, 0)
				elif type == "key":
					self.root.grab_key(key, mod|mask, 0, mode, mode)
		
	##################################################
	def run(self):
		"""Main run thread. Read X events and look for configured hotkeys"""
		while not self.stop_flag:
			while self.display.pending_events():
				event = self.display.next_event()
				mask = event.state
				self.debug(event)
				if event.type == Xlib.X.KeyPress:
					keycode = event.detail					
					for comb in self.combinations:
						if comb["type"] == "key" and comb["keycode"] == keycode and comb["mask"] == mask:
							run_command(comb["command"])
				elif event.type == Xlib.X.ButtonPress:
					button = event.detail
					for comb in self.combinations:
						if comb["type"] == "button" and comb["keycode"] == button and comb["mask"] == mask:
							run_command(comb["command"])
			
			# Give the CPU a breath (1/4 second should be fine)
			time.sleep(0.25)
		
		self.ungrab()

#######################
#######################
class Xhotkeys:
	####################################
	def __init__(self, cfile, pidfile, settingsfile, verbose_level=DEBUG):
		self.cfile = cfile
		self.verbose_level = verbose_level 
		self.pidfile = pidfile
		self.settingsfile = settingsfile
		self.display = Xlib.display.Display()
		self.root = self.display.screen().root
		self.hkserver = None
		self.create_keysym_mask(MODIFIERS)

	####################################
	def create_keysym_mask(self, modifiers):
		self.keysym_to_mask = {}
		self.keysym_to_maskname = {}
		for maskindex, mmlist in enumerate(self.display.get_modifier_mapping()):
			for ks in [self.display.keycode_to_keysym(mm, index) for mm in mmlist if mm != 0 for index in range(0,4)]:
				if ks != Xlib.X.NoSymbol: 
					self.keysym_to_maskname[ks], self.keysym_to_mask[ks] = modifiers[maskindex]
		self.debug("keysym_to_maskname table: %s" %str(self.keysym_to_maskname))

	####################################
	def signal_handler(self, signum, frame):
		"""Process signals
		
		SIGHUP -- reload configuration
		SIGTERM/SIGINT -- make a clean exit"""
		
		signame = self.signames.get(signum, "unknown")
		self.debug("signal received: %s" %signame)
		
		if signum == signal.SIGHUP:
			self.debug("send reload configuration command")
			self.reload()
		elif signum in (signal.SIGTERM, signal.SIGINT):
			self.debug("%s stopped (pid %d)" %(NAME, os.getpid()), INFO)
			if self.state == "server": self.delete_pidfile()
			if self.hkserver: self.stop_server()
			os._exit(0)

	#######################################################
	def debug(self, text, level=DEBUG, exit=None):
		debug(text, self.verbose_level, level, exit)

	#########################################
	def reload(self):
		self.read_configuration()
		self.hkserver.set_combination(self.combinations)

	########################################
	def is_keycode_modifier(self, keycode):
		return bool([ks for ks in self.keysym_to_mask if keycode == self.display.keysym_to_keycode(ks)])

	########################################
	def keycodes_to_mask(self, keycodes):
		"""Walk keycodes elements and returns only modifiers masks"""
		mask = 0
		for keycode in keycodes:
			for keysym in self.keysym_to_mask:
				if keycode in self.display.keysym_to_keycodes(keysym):
					mask |= self.keysym_to_mask[keysym]
		return mask
		
	########################################
	def keycodes_to_string(self, keycodes, default_string=DISABLED_STRING):
		if not keycodes: return default_string			
		keycodes_to_modifier = {}
		for keycode in keycodes:
			for keysym in self.keysym_to_mask:
				if keycode in [x[0] for x in self.display.keysym_to_keycodes(keysym)]:
					string = self.keysym_to_maskname[keysym]
					if string.lower() == "altgr": name = "AltGr"
					elif string.lower() == "winkey": name = "WinKey"
					else: name = string.title()
					print name
					keycodes_to_modifier[keycode] = name
		strmod = strkey = ""
		current_modifiers = []
		for keycode in keycodes:
			if keycode in keycodes_to_modifier:
				string = keycodes_to_modifier[keycode]
				if string in current_modifiers: continue
				strmod += "<" + string + ">"
				current_modifiers.append(string)
				continue
			keysym = self.display.keycode_to_keysym(keycode, 0)
			for key in inspect.getmembers(Xlib.XK):
				if len(key) != 2 or key[0].find("XK_") != 0 or key[1] != keysym: continue
				strkey = key[0].replace("XK_", "").title()
				break
			else: strkey = "@%d@" %keycode
			break
		return strmod + strkey

	#######################################
	def read_configuration(self, exit_on_error=True):
		self.combinations = []
		self.debug("opening configuration file: %s" %self.cfile, INFO)
		try: fd = open(self.cfile)
		except IOError: 
			if not exit_on_error: return []
			self.debug("configuration file not found: %s" %self.cfile)
			return self.combinations
			
		for numline, line in enumerate(fd.readlines()):
			# example: calculator=<shift><control>F1:xcalc
			line = line.strip()
			if not line or line[0] == "#": continue
			try: 
				name, options = [x.strip() for x in line.split("=", 1)]
				hotkey, command = options.split(":", 1)
			except: continue
			comb = create_dict(name=name, hotkey=hotkey, command=command)
			for combination in self.combinations:
				if combination["name"] == name: 
					self.debug("hotkey name (%s) already loaded, ignored" %name, ERROR)
					comb = None
					break
			if not comb: continue
			self.debug("adding key combination: %s = %s -> %s" %(comb["name"], comb["hotkey"], comb["command"]))
			self.combinations.append(comb)
		self.debug("%d combinations read" %len(self.combinations), INFO)
		fd.close()

	###################################
	def delete_pidfile(self):
		self.debug("deleting pidfile: %s" %self.pidfile)
		try: os.unlink(self.pidfile)
		except: self.debug("error deleting pidfile", ERROR)

	#######################################
	def write_configuration(self):
		self.debug("opening configuration file to get old configuration: %s" %self.cfile, INFO)
		try: fd = open(self.cfile, "r")
		except IOError: original = []
		else: original = fd.readlines()	; fd.close()
		
		self.debug("opening configuration file for writing: %s" %self.cfile, INFO)
		try: fd = open(self.cfile, "w")
		except IOError:
			self.debug("configuration file couldn't be opened for writing: %s" %self.cfile, ERROR)
			sys.exit(1)

		entries = dict([ (comb["name"], comb["hotkey"] + ":" + comb["command"]) for comb in self.combinations])
		entries_processed = []
		for oline in original:
			line = oline.strip()
			if not line: fd.write(oline); continue
			try: name, value = line.split("=", 1)
			except: fd.write(oline); continue
			name, value = name.strip(), value.strip()
			if name not in entries:
				self.debug("old entry removed: %s" %oline.strip())
				continue
			if value == entries[name]:
				self.debug("keep old entry: %s" %oline.strip())
				entries_processed.append(name)
				fd.write(oline)
				continue
			else:
				line = name + "=" + entries[name]
				self.debug("modified entry saved: %s" %line)
				entries_processed.append(name)
				fd.write(line + "\n")
				continue
		
		for entry, value in entries.items():
			if entry in entries_processed: continue
			line = entry + "=" + value
			self.debug("new entry saved: %s" %line)
			fd.write(line + "\n")
				
		fd.close()

	#######################################
	def end_combinations_keys(self):
		if self.hkserver.isAlive():
			self.hkserver.join(0.1)
			gobject.idle_add(self.end_combinations_keys)

	#######################################
	def filechooser_file(self, widget):
		command = widget.get_filename()
		self.widgets["command"].set_text(command)
		widget.destroy()

	#######################################
	def set_hotkey_text(self, text):
		self.widgets["hotkey"].set_text(text)
		
	#######################################
	def error_message_response(self, widget, retval):
		widget.destroy()
		self.apply_widgets("set_sensitive", addwindow=True, hotkey=False, change=True)
		self.set_hotkey_text(self.current_comb["hotkey"])

	######################################
	def error_message(self, text):
		message = gtk.MessageDialog(None, gtk.DIALOG_MODAL, \
			gtk.MESSAGE_ERROR, gtk.BUTTONS_CLOSE, text)
		message.connect("response", self.error_message_response)
		self.widgets["addwindow"].set_sensitive(False)
		message.show()
		return

	######################################
	def hotkey_end(self, keycodes=None, hotkey=None, disable=False):
		self.widgets["change"].set_label(self.old_change_label)
		self.apply_widgets("set_sensitive", hotkey=False, change= True, cancel=True, \
			name=True, command=True, browse=True)
		if self.current_comb["name"] and self.current_comb["command"]:
			self.apply_widgets("set_sensitive", accept=True, test=True)
		self.state = "normal"
		if disable:
			self.current_comb["hotkey"] = DISABLED_STRING
			self.set_hotkey_text(DISABLED_STRING)
			return
		if not keycodes: self.set_hotkey_text(self.current_comb["hotkey"]); return			
		mask = self.keycodes_to_mask(keycodes)
		keycode = keycodes[-1]
		newcomb = create_dict(mask=mask, keycode=keycode, hotkey=hotkey)

		for index, comb in enumerate(self.combinations):
			if comb == self.old_comb: continue
			if comb["hotkey"] == newcomb["hotkey"]:
				text =  "This hotkey (%s) is already used by %s" %(newcomb["hotkey"], comb["name"])
				self.error_message(text)
				return
	
		self.set_hotkey_text(newcomb["hotkey"])
		self.current_comb["hotkey"] = newcomb["hotkey"]
		
	###################################
	def textbox_check(self, widget, key):
		self.current_comb[key] = widget.get_text()
		sensitive = bool(self.current_comb["name"] and self.current_comb["command"] and "=" not in self.current_comb["name"])
		self.widgets["accept"].set_sensitive(sensitive)

	#######################################
	def open_add_window(self):
		self.widgets["mainwindow"].set_sensitive(False)
		self.widgets["name"].set_text(self.current_comb["name"])
		self.widgets["command"].set_text(self.current_comb["command"])
		self.set_hotkey_text(self.current_comb["hotkey"])
		self.widgets["addwindow"].set_transient_for(self.widgets["mainwindow"])
		self.widgets["addwindow"].set_position(gtk.WIN_POS_CENTER_ON_PARENT)
		self.widgets["addwindow"].show()

	###################################
	def create_pidfile(self):
		self.debug("creating pidfile: %s" %self.pidfile)
		try: fd = open(self.pidfile, "w")
		except: self.debug("cannot open file for writing: %s" %self.pidfile, ERROR, exit =1)
		pid = fd.write(str(os.getpid()) + "\n")
		fd.close()
		
	#######################################
	def check_active(self, stop=False):
		try: fd = open(self.pidfile)
		except IOError: self.debug("no pidfile found"); return
		try: pid = int(fd.readline().strip())
		except: self.debug("could not read pid from %s" %self.pidfile, ERROR); return
		
		# Check /proc info to check if it is really a xhotkeys process
		statfile = "/proc/%d/stat" % pid 
		try: fd = open(statfile)
		except IOError: self.debug("cannot read process status (%s)" %statfile); return
		if fd.readline().split()[1].find("(%s" %NAME) != 0: 
			self.debug("pidfile found but not a %s daemon, so deleting it" %NAME)
			try: os.unlink(self.pidfile)
			except: self.debug("error deleting pidfile" %self.pidfile, ERROR)
			return
		# Ok, no doubt it's a xhotkeys process, return PID
		return pid

	#######################################
	def stop_server(self):
		self.debug("stopping xhotkey server")
		self.hkserver.stop()
		self.hkserver.join()
		self.debug("hotkey server finished")

	#######################################
	def exit_conf(self):
		self.save_settings()
		gtk.main_quit()
		if self.hkserver and self.hkserver.isAlive():
			self.stop_server()
		os._exit(0)

	#######################################		
	def get_combinations(self, row):
		if row < 0: return
		cr = self.combinations[row]
		return create_dict(name=cr["name"], command=cr["command"], hotkey=cr["hotkey"])

	#######################################		
	def apply_widgets(self, function, **args):
		for key, value in args.items():
			getattr(self.widgets[key], function)(value)

	#########################################
	def get_current_rows(self):
		return self.treeselection.get_selected_rows()[1]
	
	#######################################
	def delete_entry(self, widget, answer, iters, rows):
		widget.destroy()
		if answer == gtk.RESPONSE_YES:
			for iter in iters:
				self.liststore.remove(iter)
			for index, entry in enumerate(self.combinations[:]):
				if index in rows:
					self.combinations.remove(entry)
			self.apply_widgets("set_sensitive", delete=False, modify=False)
			self.save_and_reload()
		self.widgets["mainwindow"].set_sensitive(True)

	#######################################
	def drag_received(self, widget, context, x, y, selection, targetType, time):
		path = urllib.url2pathname(selection.data)
		filestr = ('file:\\\\\\', 'file://', 'file:')
		for s in filestr:
			if path.startswith(s):
				path = path[len(s):].replace('\n', '').replace('\r', '')
				break
		if not path.endswith(".desktop"): return
		try: fd = open(path)
		except: self.debug("error opening desktop file: %s" %path, INFO); return
		namelist, lang = ["Name"], os.getenv("LANG")
		if lang: namelist.append("Name[%s]" %lang)
		if lang.find("_") > 0: namelist.append("Name[%s]" %(lang[:lang.find("_")]))
		names, command = [], ""
		for line in fd:
			line = line.strip()
			if not line: continue
			try: key, value = line.split("=")
			except: continue
			if key in namelist:
				names.append([key, value.strip()])
			elif not command and key == "Exec":
				command = value.strip()
		fd.close()
		if not command or not names: self.debug("error parsing desktop file: %s" %path, INFO); return
		names.sort()
		name = names[-1][1]
		return name, command

	#######################################
	## WIDGETS ###############################
	#######################################

	#######################################
	def on_mainwindow_delete_event(self, widget, event):
		self.exit_conf()
		
	#######################################
	def on_addwindow_delete_event(self, widget, event):
		self.on_cancel_clicked(widget)
		# Return True to keep the window (we only want to hide it, not destroy it!)
		return True

	#######################################
	def on_exit_clicked(self, widget):
		self.exit_conf()

	#######################################
	def on_hotkeytable_drag_data_received(self, *args):
		ret = self.drag_received(*args)
		if not ret: return
		name, command = ret
		hotkey = self.keycodes_to_string([])
		self.current_comb = create_dict(name=name, command=command, hotkey=hotkey)
		self.old_comb = None
		self.open_add_window()
		self.old_comb = None
		self.textbox_check(self.widgets["name"], "name")
		self.textbox_check(self.widgets["command"], "command")
		self.new_window = "add"

	#######################################
	def on_accept_clicked(self, widget):
		for index, combination in enumerate(self.combinations):
			if self.new_window == "modify" and index == self.active_row: continue
			if combination["name"] == self.current_comb["name"]:
				self.error_message("This hotkey name (%s) is already being used" %combination["name"])
				return

		if self.new_window == "modify":
			self.combinations[self.active_row] = self.current_comb
			rows = self.get_current_rows()
			treemodel, selected = self.treeselection.get_selected_rows()
			iter = [treemodel.get_iter(path) for path in selected][0]
			treemodel.set_value(iter, 0, self.current_comb["name"])
			treemodel.set_value(iter, 1, self.current_comb["command"])
			treemodel.set_value(iter, 2, self.current_comb["hotkey"].title())
		else:
			self.combinations.append(self.current_comb)
			self.liststore.insert(len(self.combinations)-1, [self.current_comb["name"], self.current_comb["command"], self.current_comb["hotkey"].title()])
			self.treeview.set_cursor(len(self.combinations)-1)

		self.widgets["addwindow"].hide()
		self.widgets["mainwindow"].set_sensitive(True)
		
		if self.old_comb != self.current_comb:
			self.save_and_reload()

	#######################################
	def on_cancel_clicked(self, widget):
		self.widgets["addwindow"].hide()
		self.widgets["mainwindow"].set_sensitive(True)
		if self.old_comb:
			self.current_comb = self.old_comb.copy()

	#######################################
	def on_modify_clicked(self, widget):
		row = self.get_current_rows()[0][0]
		self.active_row = row
		self.current_comb = self.combinations[row].copy()
		self.old_comb = self.current_comb.copy()
		treemodel, selected = self.treeselection.get_selected_rows()
		self.open_add_window()
		self.new_window = "modify"

	#######################################
	def on_test_clicked(self, widget):
		command = self.widgets["command"].get_text()
		run_command(command)

	#######################################
	def on_add_clicked(self, widget):
		hotkey = self.keycodes_to_string([])
		self.current_comb = create_dict(name="", command="", hotkey=hotkey)
		self.apply_widgets("set_sensitive", accept=False, test=False)		
		self.widgets["name"].grab_focus()
		self.old_comb = None
		self.open_add_window()
		self.new_window = "add"
		
	#######################################
	def on_change_clicked(self, widget):
		if self.state == "recording": self.hotkey_end(); return
		self.keycodes_pressed = []
		self.old_change_label = self.widgets["change"].get_label()
		self.widgets["change"].set_label("Cancel")
		self.state = "recording"
		self.set_hotkey_text("BackSpace to disable")
		self.apply_widgets("set_sensitive", hotkey=True, accept =False, \
			cancel=False, name=False, test=False, command=False, browse=False)
		self.widgets["hotkey"].grab_focus()
		
	#########################################
	def on_name_key_press_event(self, widget, event):
		if event.string == "\r": 
			self.on_accept_clicked(self.widgets["accept"])

	#########################################
	def on_command_key_press_event(self, widget, event):		
		if event.string == "\r": 
			self.on_accept_clicked(self.widgets["accept"])

	#########################################
	def on_addwindow_key_press_event(self, widget, event):
		if event.keyval == gtk.keysyms.Escape and self.state != "recording": 
			self.on_cancel_clicked(widget)

	#########################################
	def on_hotkey_button_press_event(self, widget, event):
		if not self.keycodes_to_mask(self.keycodes_pressed): return
		string = self.keycodes_to_string(self.keycodes_pressed)
		self.hotkey_end(self.keycodes_pressed, string + MOUSE_STRING + str(event.button))
		widget.stop_emission("button_press_event")

	#########################################
	def on_hotkey_key_press_event(self, widget, event):
		keycode = event.hardware_keycode		
		if event.keyval == gtk.keysyms.Escape: self.hotkey_end(); return
		elif event.keyval == DISABLE_HOTKEY: self.hotkey_end(disable=True); return
		if keycode not in self.keycodes_pressed:	
			self.keycodes_pressed.append(keycode)
		string = self.keycodes_to_string(self.keycodes_pressed)
		self.set_hotkey_text(string)
		if not self.is_keycode_modifier(keycode):
			self.hotkey_end(self.keycodes_pressed, string)
		widget.stop_emission("key_press_event")

	#########################################
	def on_status_key_release_event(self, widget, event):
		pass

	#########################################
	def on_hotkey_key_release_event(self, widget, event):
		keycode = event.hardware_keycode
		while keycode in self.keycodes_pressed:
			self.keycodes_pressed.remove(keycode)
		string = self.keycodes_to_string(self.keycodes_pressed, "")
		self.set_hotkey_text(string)

	#######################################
	def on_delete_clicked(self, widget):
		rows = self.get_current_rows()
		model, selected = self.treeselection.get_selected_rows()
		iters = [model.get_iter(path) for path in selected]
		names = [self.combinations[row[0]]["name"] for row in rows]
		todelete = "\n".join(names)
		message = gtk.MessageDialog(self.widgets["mainwindow"], gtk.DIALOG_MODAL, \
			gtk.MESSAGE_WARNING, gtk.BUTTONS_YES_NO, "Are you sure you want to delete the following entries?\n%s" \
			%todelete)
		message.set_position(gtk.WIN_POS_CENTER_ON_PARENT)
		rowstodelete = [row[0] for row in rows]
		message.connect("response", self.delete_entry, iters, rowstodelete)
		self.widgets["mainwindow"].set_sensitive(False)
		message.show()

	#######################################
	def on_browse_clicked(self, widget):
		self.widgets["filechooser"] = gtk.FileChooserDialog()
		self.widgets["filechooser"].connect("file-activated", self.filechooser_file)
		self.widgets["filechooser"].show()

	#########################################
	def on_name_changed(self, widget):
		self.textbox_check(widget, "name")
		
	#########################################
	def on_command_changed(self, widget):
		self.textbox_check(widget, "command")
		self.widgets["test"].set_sensitive(self.widgets["command"].get_text() != "")

	#######################################
	def on_hotkeytable_row_activated(self, widget, rows, column):
		self.on_modify_clicked(self.widgets["modify"])

	#######################################
	def on_hotkeytable_button_press_event(self, treeview, event):
		if not treeview.get_path_at_pos(int(event.x), int(event.y)): 
			if event.button != 3: self.treeselection.unselect_all()
			else: items = ("gtk-add", self.on_add_clicked),
		elif event.button == 3: 
			self.rbutton_event = event.time
	
	#########################################
	def hotkeytable_selection_changed(self, *args):
		rows = self.get_current_rows()
		if self.rbutton_event:
			menu = gtk.Menu()
			items = [("gtk-delete", self.on_delete_clicked)]
			if len(rows) == 1:
				items.append(("gtk-edit", self.on_modify_clicked))
			for stock_id, connect in items:
				item = gtk.ImageMenuItem(stock_id=stock_id)
				menu.append(item)
				item.connect("activate", connect)
				item.show()
			menu.popup(None, None, None, 3, self.rbutton_event)
			self.rbutton_event = None
		if len(rows) == 0: self.apply_widgets("set_sensitive", delete=False, modify=False)
		elif len(rows) == 1: self.apply_widgets("set_sensitive", delete=True, modify=True)
		else: self.apply_widgets("set_sensitive", delete=True, modify=False)
	
	#####################################################
	#####################################################

	#############################################
	def configure_signals(self, signals):
		# Create signals dictionary: key = <signal_int> - value = <signal_name">
		for signum in signals:
			signal.signal(signum, self.signal_handler)
		self.signames = {}
		for key, value in inspect.getmembers(signal):
			if key.find("SIG") == 0 and key.find("SIG_") != 0: 
				self.signames[value] = key

	#######################################
	def save_and_reload(self):
		self.write_configuration()
		if self.hkserver: 
			self.read_configuration()
			self.hkserver.set_combination(self.combinations)
			return
		if not self.daemon_pid: return
		try: os.kill(self.daemon_pid, signal.SIGHUP)
		except IOError: self.debug("error sending SIGHUP to daemon", ERROR); return
		return self.daemon_pid

	#####################################################
	def open_glade(self, files):
		for file in files:
			try: os.path.exists(file)
			except: self.debug("not found: %s" %file); continue
			try: self.tree = gtk.glade.XML(file)
			except: self.debug("cannot load xml: %s" %file, ERROR); continue
			else: break
		else: self.debug("no glade files found", ERROR, exit=1)

	#####################################################
	def load_widgets(self):
		self.widgets = {}
		for item, value in inspect.getmembers(self):
			if item.find("on_") != 0: continue
			widget, sig = item.split("_", 2)[1:]
			if not self.widgets.has_key(widget):
				self.widgets[widget] = self.tree.get_widget(widget)
			self.widgets[widget].connect(sig, getattr(self, item))
		
	#####################################################
	def create_table(self, widget_name, options):
		self.treeview = self.tree.get_widget(widget_name)
		self.treeselection = self.treeview.get_selection()
		self.rbutton_event =None
		self.treeselection.connect("changed", self.hotkeytable_selection_changed)
		self.treeselection.set_mode(gtk.SELECTION_MULTIPLE)
		format = tuple([str]) * len(options)
		self.liststore = gtk.ListStore(*format)
		self.treeview.set_model(self.liststore)			
		for index, (name, min_width, expand) in enumerate(options):
			renderer = gtk.CellRendererText()
			column = gtk.TreeViewColumn(name, renderer, text=index)
			column.set_clickable(True)
			column.set_resizable(True)
			column.set_sizing(gtk.TREE_VIEW_COLUMN_FIXED)
			column.set_expand(expand)
			column.set_min_width(min_width)
			self.treeview.append_column(column)
		self.apply_widgets("set_sensitive", delete=False, modify=False)
		list = [ ( 'text/uri-list', 0, TARGET_TYPE_URI_LIST ) ]
		self.treeview.drag_dest_set(gtk.DEST_DEFAULT_MOTION | gtk.DEST_DEFAULT_HIGHLIGHT | \
			gtk.DEST_DEFAULT_DROP, list, gtk.gdk.ACTION_COPY)


	#####################################################
	def save_settings(self):
		try: fd = open(self.settingsfile, "w")
		except: self.debug("settings could not be opened for writing: %s" %self.settingsfile); return
		fd.write("# automatically saved settings xhotkeys\n")
		x, y = self.widgets["mainwindow"].get_position()
		width, height = self.widgets["mainwindow"].get_size()
		fd.write(SETTINGS_WINDOW % (x, y, width, height) + "\n")
		widths = tuple([column.get_width() for column in self.widgets["hotkeytable"].get_columns()])
		fd.write(SETTINGS_COLUMN % widths + "\n")
		fd.close()
		self.debug("window settings saved")
				
	#####################################################
	def load_settings(self):
		try: fd = open(self.settingsfile)
		except: self.debug("settings file not found: %s" %self.settingsfile); return
		match_window = SETTINGS_WINDOW.replace(" ", "\s+").replace("(", "\(").replace(")", "\)").replace("%d", "(\d+)")
		match_column = SETTINGS_COLUMN.replace(" ", "\s+").replace("%d", "(\d+)")
		for line in fd.readlines():
			match = re.findall(match_window, line)
			if match:
				try: x, y, width, height = [int(x) for x in match[0]]
				except: continue
				self.widgets["mainwindow"].move(x, y)
				self.widgets["mainwindow"].resize(width, height)
			match = re.findall(match_column, line)
			if match:
				try: widths = [int(x) for x in match[0]]
				except: continue
				columns = self.widgets["hotkeytable"].get_columns()
				[columns[x].set_fixed_width(widths[x]) for x in range(len(columns))]
		fd.close()
		self.debug("window settings loaded")
			
	#####################################################
	def config(self):
		self.state = "config"
		self.daemon_pid = self.check_active()	
		glade_files = [NAME + ".glade", os.path.join("/usr/share/", NAME, NAME + ".glade")]
		self.open_glade(glade_files)
		self.load_widgets()
		table = ("Name", 100, False), ("Command", 300, True), ("Hotkey", 150, True)
		self.read_configuration(self.cfile)
		self.create_table("hotkeytable", table)		
		self.load_settings()
		for comb in self.combinations:
			self.liststore.append([comb["name"], comb["command"], comb["hotkey"].title()])
		if self.check_active():
			self.widgets["status"].push(0, " Xhotkeys daemon is running (pid %d)" %self.daemon_pid)
		else: self.widgets["status"].push(0, " Xhotkeys daemon is not running")
		
		self.configure_signals([signal.SIGTERM, signal.SIGINT])
		self.widgets["mainwindow"].show()
		gtk.main()

	#########################################
	def server(self):
		self.state = "server"
		if not os.path.exists(self.cfile):
			self.debug("configuration file not found: %s" %self.cfile, ERROR)
			self.debug("run %s --config" %NAME, ERROR, 1)
		else: self.debug("using configuration file: %s" %self.cfile, INFO)
		self.hkserver = None
		pid = self.check_active()
		if pid: 
			self.debug("oops, %s daemon is already running (pid %s)" %(NAME, pid), ERROR)
			self.debug("run '%s --config' to open configurator" %NAME, ERROR, exit=1)
			
		self.debug("starting Xhotkeys server")
		self.configure_signals([signal.SIGTERM, signal.SIGINT, signal.SIGHUP])
		self.hkserver = XhotkeysServer(self.verbose_level)
		self.read_configuration(self.cfile)
		self.hkserver.set_combination(self.combinations)
		self.hkserver.start()
		self.create_pidfile()
		while 1:
			try: self.hkserver.join(0.1)
			except: break
			
		self.delete_pidfile()
		os._exit(0)

#######################################################
#######################################################
def main():
	usage = """usage: xhotkeys [options] 

Bind keys and mouse combinations to commands in the X-Window System""" 
	home, user = os.getenv("HOME"), os.getenv("USER")
	default_cfile = os.path.join(home, ".%s" %NAME)
	default_pidfile = os.path.join(home, ".%s.pid-%s" %(NAME, user))
	default_settings = os.path.join(home, ".%s.settings-%s" %(NAME, user))
	parser = optparse.OptionParser(usage)
	parser.add_option('-v', '--verbose', default=0, dest='verbose_level', action="count", help='Increase verbose level')
	parser.add_option('-c', '--config', dest='config', default=False, action='store_true', help='Open a GTK+ interface configurator')
	parser.add_option('-f', '--configuration-file', dest='cfile', default=default_cfile, metavar='FILE', type='string', help='Alternative configuration file')
	options, args = parser.parse_args()
	
	xhk = Xhotkeys(options.cfile, default_pidfile, default_settings, verbose_level=options.verbose_level)
	if options.config: xhk.config()
	else: xhk.server()
	
#########
#############
#########################

if __name__ == '__main__':
	main()
