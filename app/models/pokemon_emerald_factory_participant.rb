class PokemonEmeraldFactoryParticipant < ApplicationRecord
  # 指定された名前のポケモンのタイプを返すクラスメソッド
  def self.get_types_by_name(name)
    pokemon = find_by(name:)
    [pokemon&.type1, pokemon&.type2]
  end

  def self.ransackable_attributes(_auth_object = nil)
    # 検索条件を追加
    %w[name lap1_show lap2_show lap3_show lap4_show lap5_show lap6_show lap7_show lap8_show]
  end

  # 周ごとのフィルタをカスタムスコープとして追加
  def self.ransackable_scopes(_auth_object = nil)
    %i[with_lap_show]
  end

  # 周ごとのカラムの値が1のレコードをフィルタするスコープ
  def self.with_lap_show(lap_number)
    where("lap#{lap_number}_show = ?", 1)
  end
end
