class Message
  include Dynamoid::Document
  table key: :channel_id, read_capacity: 2, write_capacity: 1
  range :created_at
  field :body, :string
  field :created_at, :datetime
  field :updated_at, :datetime
  def to_param
    created_at.to_time.to_f.to_s.sub('.', '-')
  end
  def self.from_param(str)
    str.sub('-', '.').to_f
  end
  def channel
    Channel.find(channel_id)
  end
end

