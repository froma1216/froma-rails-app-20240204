module PokemonEmeraldFactoryParticipantsHelper
  def create_pokemon_image_path(image_name, folder_name)
    # フォルダ名に応じてマッピングを選択
    case folder_name
    when "pokemons"
      mapping = POKEMON_NAME_MAPPINGS
    when "types"
      mapping = POKEMON_TYPE_MAPPINGS
    when "items"
      mapping = POKEMON_ITEM_MAPPINGS
    else
      return nil # 適切なマッピングが存在しない場合はnilを返す
    end
    # マッピングからローマ字名を取得
    romanized_name = mapping[image_name]
    # ローマ字名が存在する場合のみパスを生成
    "pokemon_emerald_factory_participant/#{folder_name}/#{romanized_name}.png" if romanized_name
  end
end
