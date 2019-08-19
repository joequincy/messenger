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

    next_user = User.create(name: 'YetAnotherExampleUser')
    stub_connection current_user: next_user

    expect{subscribe room: room.name}
      .to have_broadcasted_to(room)
      .from_channel(ChatChannel)
      .once
      .with{ |data|
        message = JSON.parse(data[:message], symbolize_names: true)
        expect(message[:type]).to eq("user-joined")

        payload = message[:data]
        expected = {
          name: next_user.name,
          current: [
            user.name,
            next_user.name
          ]
        }
        expect(payload).to eq(expected)
      }
  end

  it 'does not mix rooms' do
    stub_connection current_user: user

    expect{subscribe room: room.name}
      .to have_broadcasted_to(room)

    expect{subscribe room: 'Not' + room.name}
      .to_not have_broadcasted_to(room)
  end

  it 'relays a message' do
    stub_connection current_user: user
    subscribe room: room.name
    new_message = {'text' => 'This is a chat message'}

    expect{subscription.send_message(new_message)}
      .to have_broadcasted_to(room)
      .from_channel(ChatChannel)
      .once
      .with{ |data|
        message = JSON.parse(data[:message], symbolize_names: true)
        expect(message[:type]).to eq("message")

        payload = message[:data]
        expected = {
          user: user.name,
          message: new_message['text'],
          timestamp: a_string_matching(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z/)
        }
        expect(payload).to include(expected)
      }
  end
end
