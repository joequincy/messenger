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

  it 'broadcasts users joining' do
    stub_connection current_user: user

    expect{subscribe room: room.name}
      .to have_broadcasted_to(room)
      .from_channel(ChatChannel)
      .once
      .with{ |data|
        message = JSON.parse(data[:message], symbolize_names: true)
        expect(message[:type]).to eq("user-joined")

        payload = message[:data]
        expected = {
          name: user.name,
          current: [
            user.name
          ]
        }
        expect(payload).to eq(expected)
      }
  end
end
