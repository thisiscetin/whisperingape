# frozen_string_literal: true

class ChatController < ApplicationController
  def reply
    reply = ChatService::Replier.call(p_params[:question])

    render plain: reply
  end

  private

  def p_params
    params.permit(:question)
  end
end
