# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render json: { fact: 'Humans are Great Apes.' }
  end
end
