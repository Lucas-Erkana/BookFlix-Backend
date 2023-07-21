class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :role, :full_name
  attribute :created_date do |user|
    user&.created_at&.strftime('%d/%m/%Y')
  end
end
