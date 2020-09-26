require_relative '../lib/case_constraint'

Rails.application.routes.draw do
  constraints CaseConstraint.new do
    get    '/named_contacts',      to: 'named_contacts#show',    as: :named_contact
    get    '/named_contacts/new',  to: 'named_contacts#new',     as: :new_named_contact
    get    '/named_contacts/edit', to: 'named_contacts#edit',    as: :edit_named_contact
    post   '/named_contacts',      to: 'named_contacts#create'
    patch  '/named_contacts',      to: 'named_contacts#update'
    delete '/named_contacts',      to: 'named_contacts#destroy'
  end
end
