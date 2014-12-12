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
  \ },
  \ "app/services/*.rb": {
  \   "command":   "service",
  \   "affinity":  "collection",
  \   "test":      "spec/services/%i_spec.rb",
  \   "template":  "class %S\nend"
  \ },
  \ "app/finders/*.rb": {
  \   "command":   "finder",
  \   "affinity":  "collection",
  \   "test":      "spec/finders/%i_spec.rb",
  \   "template":  "class %S\nend"
  \ },
  \ "app/forms/*_form.rb": {
  \   "command": "form",
  \   "test":    "spec/forms/%i_spec.rb",
  \   "template": "class %S\nend"
  \ }
  \}

" [vim-rails] gem projections - typing `:Efactory users` will open the users factory, etc.
let g:rails_gem_projections = {
    \   "factory_girl": {
    \     "test/factories/*.rb": {
    \       "command":   "factory",
    \       "affinity":  "collection",
    \       "alternate": "app/models/%i.rb",
    \       "related":   "db/schema.rb#%s",
    \       "test":      "test/models/%i_test.rb",
    \       "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
    \       "keywords":  "factory sequence"
    \     },
    \     "spec/factories/*.rb": {
    \       "command":   "factory",
    \       "affinity":  "collection",
    \       "alternate": "app/models/%i.rb",
    \       "related":   "db/schema.rb#%s",
    \       "test":      "spec/models/%i_test.rb",
    \       "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
    \       "keywords":  "factory sequence"
    \     }
    \   },
    \   "capybara": {
    \     "spec/features/*_spec.rb": {
    \       "command":   "feature",
    \       "template":  "require 'spec_helper'\n\nfeature '%h' do\n\nend"
    \     }
    \   },
    \   "activeadmin": {
    \     "app/admin/*.rb": {
    \       "command":   "admin",
    \       "affinity":  "model",
    \       "test":      "spec/admin/%s_spec.rb",
    \       "related":   "app/models/%s.rb",
    \       "template":  "ActiveAdmin.register %S do\n  config.sort_order = 'created_at_desc'\nend"
    \     }
    \   },
    \   "active_model_serializers": {
    \     "app/serializers/*_serializer.rb": {
    \       "command":   "serializer",
    \       "affinity":  "model",
    \       "test":      "spec/serializers/%s_spec.rb",
    \       "related":   "app/models/%s.rb",
    \       "template":  "class %SSerializer < ActiveModel::Serializer\nend"
    \     }
    \   },
    \   "draper": {
    \     "app/decorators/*_decorator.rb": {
    \       "command":   "decorator",
    \       "affinity":  "model",
    \       "test":      "spec/decorators/%s_spec.rb",
    \       "related":   "app/models/%s.rb",
    \       "template":  "class %SDecorator < Draper::Decorator\n  delegate_all\nend"
    \     }
    \   },
    \   "carrierwave": {
    \     "app/uploaders/*_uploader.rb": {
    \       "command":   "uploader",
    \       "affinity":  "model",
    \       "test":      "spec/uploaders/%s_spec.rb",
    \       "related":   "app/models/%s.rb",
    \       "template":  "class %SUploader < CarrierWave::Uploader::Base\nend"
    \     }
    \   },
    \   "pundit": {
    \     "app/policies/*_policy.rb": {
    \       "command":   "policy",
    \       "affinity":  "model",
    \       "test":      "spec/policies/%s_spec.rb",
    \       "related":   "app/models/%s.rb",
    \       "template":  "class %SPolicy < Struct.new(:user, :%s)\nend"
    \     }
    \   },
    \   "resque": {
    \     "app/jobs/*_job.rb": {
    \       "command":   "job",
    \       "test":      "spec/jobs/%s_spec.rb",
    \       "template":  "class %SJob\n\n  def self.perform\n  end\n\nend"
    \     }
    \   }
    \ }
