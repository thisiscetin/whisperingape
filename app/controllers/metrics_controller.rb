# frozen_string_literal: true

class MetricsController < ApplicationController
  def counts
    render json: {
      ape_count: Ape.count,
      link_count: Link.count,
      scrape_count: Scrape.where.not(gpt_content: nil).count,
      embedding_count: Embedding.where.not(v: nil).count
    }
  end

  def contents
    scrapes = Scrape.includes(:link, :embedding)
                    .where.not(gpt_content: nil)
                    .order(created_at: :desc)

    box = Struct.new(:id, :content, :gpt_content, :link, :active)
    render json: scrapes.map do |s|
      box.new(s.id, s.content, s.gpt_content, s.link.destination, s.embedding ? s.embedding.active : false)
    end
  end

  def links
    render json: Link.all.order(destination: :asc).pluck(:destination)
  end
end
