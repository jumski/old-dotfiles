
" rails.vim navcommands
autocmd User Rails Rnavcommand admin app/admin/ -suffix=.rb
autocmd User Rails Rnavcommand factories spec/factories/ -suffix=.rb
autocmd User Rails Rnavcommand jobs app/jobs/ -suffix=.rb
autocmd User Rails Rnavcommand overrides app/overrides/ -suffix=.rb
autocmd User Rails Rnavcommand serializers app/serializers/ -suffix=_serializer.rb
autocmd User Rails Rnavcommand support spec/support/ -suffix=.rb
autocmd User Rails Rnavcommand uploaders app/uploaders/ -suffix=.rb

" backbone related
autocmd User Rails Rnavcommand eco app/assets/javascripts/templates/ -glob=**/* -suffix=.jst.eco
autocmd User Rails Rnavcommand javascripts app/assets/javascripts/ -suffix=.js,.js.erb,.js.coffee,.js.coffee.erb
autocmd User Rails Rnavcommand jcollections app/assets/javascripts/collections/ -glob=**/* -suffix=.js.coffee
autocmd User Rails Rnavcommand jmodels app/assets/javascripts/models/ -glob=**/* -suffix=.js.coffee
autocmd User Rails Rnavcommand jviews app/assets/javascripts/views/ -glob=**/* -suffix=.js.coffee
autocmd User Rails Rnavcommand jrouters app/assets/javascripts/routers/ -glob=**/* -suffix=.js.coffee
autocmd User Rails Rnavcommand templates app/assets/javascripts/templates/ -glob=**/* -suffix=.hbs

" project specific
autocmd User Rails Rnavcommand jspec vendor/backbone-widgets/spec/ -glob=**/* -suffix=.js.coffee
autocmd User Rails Rnavcommand widgets vendor/backbone-widgets/src/ -glob=**/* -suffix=.js.coffee