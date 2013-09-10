class Record
  include Mongoid::Document
  include Mongoid::Timestamps

  field :dn, type: String
    field :name, type: String
    field :mail, type: String
    field :departments, type: Array
    field :phone, type: Integer
    field :title, type: String
    field :mobile, type: String
    field :active, type: Boolean

end
