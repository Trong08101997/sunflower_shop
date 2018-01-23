class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: Settings.maximum_length.name }
  has_secure_password
  validates :password, presence: true, length: { minimum: Settings.minimum_length.password }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: Settings.maximum_length.email },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  VALID_PHONE_REGEX = /[0-9\-\+\(\)]/
  validates :phone_number, length: {in: Settings.minimum_length.phone..Settings
    .maximum_length.phone }, presence: true,
    format: {with: VALID_PHONE_REGEX}
  validates :address, length: {maximum: Settings.maximum_length.address}, presence: true
  enum role: [:user, :admin]
  scope :infor_user, -> {select(:id, :name, :email, :phone_number, :address, :role)}
end
