let g:rails_projections = {
  \ "app/models/concerns/*.rb": {
  \   "command": "concern",
  \   "template":
  \     "module %S\n  include ActiveSupport::Concern\n\n  included do\n  end\nend",
  \   "keywords": "included"
  \ },
  \ "app/decorators/*_decorator.rb": {
  \   "command": "decorator",
  \   "alternate": "spec/decorators/%s_decorator_spec.rb",
  \   "affinity": "model"
  \ },
  \ "spec/features/*_spec.rb": {
  \   "command": "feature",
  \ },
  \ "spec/support/*.rb": {
  \   "command": "support",
  \ },
  \ "app/workers/*.rb": {
  \   "command": "worker",
  \   "template": "class %S\n  include Sidekiq::Worker\n\n  def perform\n  end\nend",
  \ },
  \ "spec/shared/*.rb": {
  \   "command": "shared",
  \ },
  \ "spec/factories/*.rb": {
  \   "command": "factory",
  \   "affinity": "collection"
  \ }
  \}
