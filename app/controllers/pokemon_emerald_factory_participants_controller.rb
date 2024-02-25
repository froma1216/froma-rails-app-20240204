class PokemonEmeraldFactoryParticipantsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @e_factory_pokemons = PokemonEmeraldFactoryParticipant.all
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = PokemonEmeraldFactoryParticipant.ransack(params[:q])
  end
end
