jumski dotfiles
---------------

manual tasks
------------

* rubygems_cache
    
    $ mkdir ~/installed
    $ git clone git@github.com:akitaonrails/rubygems_proxy.git ~/installed/
    # install nginx (preferably from passenger)
    $ rm -rf /opt/nginx/conf
    $ ln -s $DOTFILES_PATH/conf/nginx /opt/nginx/conf

