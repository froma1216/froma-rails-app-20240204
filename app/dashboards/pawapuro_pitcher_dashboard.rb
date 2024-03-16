require "administrate/base_dashboard"

class PawapuroPitcherDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    control: Field::Number,
    created_by: Field::String,
    curveball_type_movement: Field::Number,
    curveball_type_pitch: Field::String,
    fastball_type: Field::String,
    forkball_type_movement: Field::Number,
    forkball_type_pitch: Field::String,
    nobi: Field::Number,
    original_pitch: Field::String,
    other_special_abilities: Field::String,
    pace: Field::Number,
    pawapuro_player: Field::BelongsTo,
    quick: Field::Number,
    second_curveball_type_movement: Field::Number,
    second_curveball_type_pitch: Field::String,
    second_fastball_type: Field::String,
    second_forkball_type_movement: Field::Number,
    second_forkball_type_pitch: Field::String,
    second_shootball_type_movement: Field::Number,
    second_shootball_type_pitch: Field::String,
    second_sinker_type_movement: Field::Number,
    second_sinker_type_pitch: Field::String,
    second_slider_type_movement: Field::Number,
    second_slider_type_pitch: Field::String,
    shootball_type_movement: Field::Number,
    shootball_type_pitch: Field::String,
    sinker_type_movement: Field::Number,
    sinker_type_pitch: Field::String,
    slider_type_movement: Field::Number,
    slider_type_pitch: Field::String,
    stamina: Field::Number,
    taihidaridasya: Field::Number,
    taipinch: Field::Number,
    updated_by: Field::String,
    utarezuyosa: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    control
    created_by
    curveball_type_movement
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    control
    created_by
    curveball_type_movement
    curveball_type_pitch
    fastball_type
    forkball_type_movement
    forkball_type_pitch
    nobi
    original_pitch
    other_special_abilities
    pace
    pawapuro_player
    quick
    second_curveball_type_movement
    second_curveball_type_pitch
    second_fastball_type
    second_forkball_type_movement
    second_forkball_type_pitch
    second_shootball_type_movement
    second_shootball_type_pitch
    second_sinker_type_movement
    second_sinker_type_pitch
    second_slider_type_movement
    second_slider_type_pitch
    shootball_type_movement
    shootball_type_pitch
    sinker_type_movement
    sinker_type_pitch
    slider_type_movement
    slider_type_pitch
    stamina
    taihidaridasya
    taipinch
    updated_by
    utarezuyosa
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    control
    created_by
    curveball_type_movement
    curveball_type_pitch
    fastball_type
    forkball_type_movement
    forkball_type_pitch
    nobi
    original_pitch
    other_special_abilities
    pace
    pawapuro_player
    quick
    second_curveball_type_movement
    second_curveball_type_pitch
    second_fastball_type
    second_forkball_type_movement
    second_forkball_type_pitch
    second_shootball_type_movement
    second_shootball_type_pitch
    second_sinker_type_movement
    second_sinker_type_pitch
    second_slider_type_movement
    second_slider_type_pitch
    shootball_type_movement
    shootball_type_pitch
    sinker_type_movement
    sinker_type_pitch
    slider_type_movement
    slider_type_pitch
    stamina
    taihidaridasya
    taipinch
    updated_by
    utarezuyosa
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

  # Overwrite this method to customize how pawapuro pitchers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(pawapuro_pitcher)
  #   "PawapuroPitcher ##{pawapuro_pitcher.id}"
  # end
end
