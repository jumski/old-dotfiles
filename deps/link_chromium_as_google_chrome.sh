link_chromium_as_google_chrome() {

  is_met() {
    which google-chrome
  }

  meet() {
    if missing google-chrome && present chromium-browser; then
      sudo ln -s $(which chromium-browser) /usr/bin/google-chrome
    fi
  }
}
