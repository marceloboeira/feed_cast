class EpisodesController < ApplicationController
  def show
    episode = Episode.includes(:channel).find_for(channel_slug, episode_slug)
    @episode = episode.decorate

    EpisodeListen.create(user_id: user_id, episode: episode)
  end

  def list
    @episodes = Episode.order_by(published_at: :desc).page(page).per(24).decorate
  end

  private

  def channel_slug
    params[:channel]
  end

  def episode_slug
    params[:episode]
  end

  def page
    params[:page]
  end
end
