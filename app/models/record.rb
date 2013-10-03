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
    field :checksum, type: String

  def serialize
    serializable_hash(only: [:_id, :ident, :birthdate, :name, :mail, :title, :phone, :department, :active])
  end

  def to_json
    serialize.to_json
  end

end
