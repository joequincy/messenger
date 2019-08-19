class ChatChannel < ApplicationCable::Channel
  on_subscribe :announce_user

  def subscribed
    room.users << current_user
    ensure_confirmation_sent
    stream_for room
  end

  def send_message(data)
    message = Message.create(user: current_user, room: room, content: data['text'])
    ChatChannel.broadcast_to room, message: {
      type: 'message',
      data: {
        user: current_user.name,
        message: message.content,
        timestamp: message.created_at
      }
    }.to_json
  end

  private
    def announce_user
      ChatChannel.broadcast_to room, message: {
        type: 'user-joined',
        data: {
          name: current_user.name,
          current: room.subscribers.map{|s| s.name}
        }
      }.to_json
    end

    def room
      @_room ||= Room.find_or_create_by(name: params[:room])
    end
end
