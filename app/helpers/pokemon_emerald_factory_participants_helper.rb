module PokemonEmeraldFactoryParticipantsHelper
  # 画像表示
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

  # 弱点～効果なしのタイプを二重配列で返す
  def type_effective_arr(type1, type2)
    # 各タイプに対する相性を定義
    effectiveness = {
      "ノーマル" => { "かくとう" => 2, "ゴースト" => 0 },
      "ほのお" => { "ほのお" => 0.5, "みず" => 2, "くさ" => 0.5, "こおり" => 0.5, "じめん" => 2, "むし" => 0.5, "いわ" => 2, "はがね" => 0.5 },
      "みず" => { "ほのお" => 0.5, "みず" => 0.5, "でんき" => 2, "くさ" => 2, "こおり" => 0.5, "はがね" => 0.5 },
      "でんき" => { "でんき" => 0.5, "じめん" => 2, "ひこう" => 0.5, "はがね" => 0.5 },
      "くさ" => { "ほのお" => 2, "みず" => 0.5, "でんき" => 0.5, "くさ" => 0.5, "こおり" => 2, "どく" => 2, "じめん" => 0.5, "ひこう" => 2,
                "むし" => 2 },
      "こおり" => { "ほのお" => 2, "こおり" => 0.5, "かくとう" => 2, "いわ" => 2, "はがね" => 2 },
      "かくとう" => { "ひこう" => 2, "エスパー" => 2, "むし" => 0.5, "いわ" => 0.5, "あく" => 0.5 },
      "どく" => { "くさ" => 0.5, "かくとう" => 0.5, "どく" => 0.5, "じめん" => 2, "エスパー" => 2, "むし" => 0.5 },
      "じめん" => { "みず" => 2, "でんき" => 0, "くさ" => 2, "こおり" => 2, "どく" => 0.5, "いわ" => 0.5 },
      "ひこう" => { "でんき" => 2, "くさ" => 0.5, "こおり" => 2, "かくとう" => 0.5, "じめん" => 0, "むし" => 0.5, "いわ" => 2 },
      "エスパー" => { "かくとう" => 0.5, "エスパー" => 0.5, "むし" => 2, "ゴースト" => 2, "あく" => 2 },
      "むし" => { "ほのお" => 2, "くさ" => 0.5, "かくとう" => 0.5, "じめん" => 0.5, "ひこう" => 2, "いわ" => 2 },
      "いわ" => { "ノーマル" => 0.5, "ほのお" => 0.5, "みず" => 2, "くさ" => 2, "かくとう" => 2, "どく" => 0.5, "じめん" => 2, "ひこう" => 0.5,
                "はがね" => 2 },
      "ゴースト" => { "ノーマル" => 0, "かくとう" => 0, "どく" => 0.5, "むし" => 0.5, "ゴースト" => 2, "あく" => 2 },
      "ドラゴン" => { "ほのお" => 0.5, "みず" => 0.5, "でんき" => 0.5, "くさ" => 0.5, "こおり" => 2, "ドラゴン" => 0.5 },
      "あく" => { "かくとう" => 2, "エスパー" => 0, "むし" => 2, "ゴースト" => 0.5, "あく" => 0.5 },
      "はがね" => { "ノーマル" => 0.5, "ほのお" => 2, "くさ" => 0.5, "こおり" => 0.5, "かくとう" => 2, "どく" => 0, "じめん" => 2,
                 "ひこう" => 0.5, "エスパー" => 0.5, "むし" => 0.5, "いわ" => 0.5, "ゴースト" => 0.5, "ドラゴン" => 0.5, "あく" => 0.5,
                 "はがね" => 0.5 }
    }

    # 効果を保持するためのハッシュ
    results = {
      "4_times" => [],
      "2_times" => [],
      "0.5_times" => [],
      "0.25_times" => [],
      "0_times" => []
    }

    # 効果を判定する関数
    get_effectiveness = lambda { |effectiveness_data, type1_data, type2_data|
      if effectiveness_data[type1_data] && effectiveness_data[type1_data][type2_data]
        effectiveness_data[type1_data][type2_data]
      else
        1.0
      end
    }

    # 全てのタイプについて効果を計算
    effectiveness.each_key do |type|
      # 効果を計算（タイプ1とタイプ2の効果を掛け合わせる）
      effect = get_effectiveness.call(effectiveness, type1, type) * get_effectiveness.call(effectiveness, type2, type)
      case effect
      when 4.0
        results["4_times"] << type
      when 2.0
        results["2_times"] << type
      when 0.5
        results["0.5_times"] << type
      when 0.25
        results["0.25_times"] << type
      when 0.0
        results["0_times"] << type
      end
    end

    results
  end

  # 努力値の後に改行を入れる
  def format_effort_values(effort_values)
    formatted_values = effort_values.gsub(/(\d+)(?!\d|\s)/, '\1<br>')
    formatted_values.html_safe
  end
end
