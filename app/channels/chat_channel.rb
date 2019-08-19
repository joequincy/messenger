class ChatChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find_or_create_by(name: params[:room])
    stream_for room
  end
end
