require 'rails_helper'

describe ChatChannel, type: :channel do
  let(:user){ User.create(name: "Example") }
  let(:room){ Room.create(name: "Coding") }

  it 'subscribes to a room' do
    stub_connection current_user: user
    subscribe room: room.name

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(room)
  end

  it 'unsubscribes from a room' do
    stub_connection current_user: user
    subscribe room: room.name
    unsubscribe

    expect(subscription).to_not have_stream_for(room)
  end
end
