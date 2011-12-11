jumski dotfiles
---------------

manual tasks
------------

* rubygems_cache
    
    $ mkdir ~/installed
    $ git clone git@github.com:akitaonrails/rubygems_proxy.git ~/installed/

* nginx for rubygems_cache
  install passenger with nginx, then:

    $ rm -rf /opt/nginx/conf
    $ ln -s $DOTFILES_PATH/conf/nginx /opt/nginx/conf

