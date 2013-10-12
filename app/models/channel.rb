class Channel
  include Dynamoid::Document
  table key: :id
  field :name, :string
  field :current_no, :integer
  field :created_at, :datetime
  field :updated_at, :datetime
  validates_presence_of :name

  def messages
    Message.where(channel_id: id)
  end
end
