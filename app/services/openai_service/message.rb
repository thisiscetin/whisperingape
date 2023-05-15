# frozen_string_literal: true

module OpenaiService
  class Message
    include ActiveModel::Serializers::JSON

    attr_reader :role, :content

    def initialize(role, content)
      @role = role
      @content = content
    end

    def attributes
      { 'role' => nil, 'content' => nil }
    end
  end
end
