class Enums
  class << self
    def quest_division
      YAML.load_file(Rails.root.join("config", "mhxx", "quest_division.yml"))['quest_division']
    end

    # 以下に追加していく
    # def another_enum
    #   YAML.load_file(Rails.root.join("config", "mhxx", "another_enum.yml"))['another_enum']
    # end
  end
end
