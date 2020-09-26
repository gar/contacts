class NamedContact < ApplicationRecord
  validates :case_id, presence: true, allow_blank: false, uniqueness: true
end
