class Incident < ApplicationRecord
  validates :severity, :serviceId, :title, :dedupKey, presence: true
  validates :severity, inclusion: {
    in: SEVERITIES
  }
  validates :serviceId, inclusion: {
    in: SERVICE_IDS
  }
  validates :dedupKey, unique: true
end
