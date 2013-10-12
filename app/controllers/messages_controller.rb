class MessagesController < ApplicationController
  before_action :set_channel
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = @channel.messages.scan_index_forward(false).limit(20)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show

  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.channel_id = @channel.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to channel_message_url(@channel, @message), notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: channel_message_url(@channel, @message) }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find_by_composite_key(@channel.id, Message.from_param(params[:id]))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body)
    end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end
end
