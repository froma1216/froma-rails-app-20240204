require "test_helper"

class PokemonEmeraldFactoryParticipantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pokemon_emerald_factory_participants_index_url
    assert_response :success
  end
end
