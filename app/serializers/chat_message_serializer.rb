# frozen_string_literal: true

class ChatMessageSerializer < ActiveModel::Serializer
  attributes :role, :content
end
