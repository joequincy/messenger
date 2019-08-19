require 'rails_helper'

describe ApplicationCable::Connection, type: :channel do
  it 'successfully connects' do
    user = User.create(name: "Example")
    room = Room.create(name: "Coding")
    connect "/ws", params: {
      name: user.name,
      room: room.name
    }

    expect(connection.current_user).to eq(user)
  end

  it 'rejects connection' do
    expect { connect '/ws'}.to have_rejected_connection
  end
end
