require "administrate/base_dashboard"

class PawapuroFielderDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    arm_strength: Field::Number,
    catcher: Field::Number,
    catching: Field::Number,
    chance: Field::Number,
    created_by: Field::String,
    defense: Field::Number,
    meat: Field::Number,
    other_special_abilities: Field::String,
    pawapuro_player: Field::BelongsTo,
    power: Field::Number,
    running: Field::Number,
    soukyuu: Field::Number,
    sourui: Field::Number,
    taihidaritousyu: Field::Number,
    tourui: Field::Number,
    trajectory: Field::Number,
    updated_by: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    pawapuro_player
    trajectory
    meat
    power
    running
    arm_strength
    defense
    catching
    created_by
    updated_by
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    arm_strength
    catcher
    catching
    chance
    created_by
    defense
    meat
    other_special_abilities
    pawapuro_player
    power
    running
    soukyuu
    sourui
    taihidaritousyu
    tourui
    trajectory
    updated_by
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    arm_strength
    catcher
    catching
    chance
    created_by
    defense
    meat
    other_special_abilities
    pawapuro_player
    power
    running
    soukyuu
    sourui
    taihidaritousyu
    tourui
    trajectory
    updated_by
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how pawapuro fielders are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(pawapuro_fielder)
  #   "PawapuroFielder ##{pawapuro_fielder.id}"
  # end
end
