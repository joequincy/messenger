class ChatChannel < ApplicationCable::Channel
  on_subscribe :announce_user

  def subscribed
    room = Room.find_or_create_by(name: params[:room])
    room.users << current_user
    ensure_confirmation_sent
    stream_for room
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
end
