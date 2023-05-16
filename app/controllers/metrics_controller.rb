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

    contents = []
    box = Struct.new(:id, :content, :gpt_content, :link, :active)

    scrapes.each do |s|
      active = s.embedding ? s.embedding.active : false
      contents << box.new(s.id, s.content, s.gpt_content, s.link.destination, active)
    end
    render json: contents
  end

  def links
    render json: Link.all.order(destination: :asc).pluck(:destination)
  end
end
