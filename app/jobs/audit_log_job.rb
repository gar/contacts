class AuditLogJob < ApplicationJob
  queue_as :default

  def perform(user_id, action, case_id, changed_attributes)
    puts "[AuditLog] User #{user_id} #{action} named contact for case #{case_id}. Fields: #{changed_attributes}."
  end
end
