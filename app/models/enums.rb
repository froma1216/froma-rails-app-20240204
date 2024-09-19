class Enums
  class << self
    # クエスト区分
    def quest_division
      YAML.load_file(Rails.root.join("config", "mhxx", "quest_division.yml"))['quest_division']
    end

    # 武器種区分
    def weapon_type_division
      YAML.load_file(Rails.root.join("config", "mhxx", "weapon_type_division.yml"))['weapon_type_division']
    end

    # 属性
    def element
      YAML.load_file(Rails.root.join("config", "mhxx", "element.yml"))['element']
    end

    # スキル区分
    def skill_division
      YAML.load_file(Rails.root.join("config", "mhxx", "skill_division.yml"))['skill_division']
    end
    # 以下に追加
  end
end
