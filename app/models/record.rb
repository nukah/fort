class Record
  include Mongoid::Document
  include Mongoid::Timestamps

  field :dn, type: String
    field :name, type: String
    field :mail, type: String
    field :department, type: String
    field :phone, type: Integer
    field :title, type: String
    field :mobile, type: String
    field :active, type: Boolean
    field :ident, type: String
    field :birthdate, type: DateTime

end
