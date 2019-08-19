class ChatChannel < ApplicationCable::Channel
  on_subscribe :announce_user

  def subscribed
    room.users << current_user
    ensure_confirmation_sent
    stream_for room
  end

  def unsubscribed
    room.users.delete(current_user)
    room.reload
    ChatChannel.broadcast_to room, message: {
      type: 'user-left',
      data: {
        name: current_user.name,
        current: room.subscribers.map{|s| s.name}
      }
    }.to_json
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
      last_messages = room.messages.order(created_at: :desc).limit(5)
      ChatChannel.broadcast_to room, message: {
        type: 'user-joined',
        data: {
          name: current_user.name,
          current: room.subscribers.map{|s| s.name},
          lastMessages: last_messages.reverse.map do |m|
            {
              user: m.user.name,
              message: m.content,
              timestamp: m.created_at
            }
          end
        }
      }.to_json
    end

    def room
      @_room ||= Room.find_or_create_by(name: params[:room])
    end
end
