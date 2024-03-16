require "administrate/base_dashboard"

class PawapuroPlayerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    back_name: Field::String,
    bats: Field::String,
    birthday: Field::Date,
    created_by: Field::String,
    first_name: Field::String,
    kaifuku: Field::Number,
    kegasinikusa: Field::Number,
    last_name: Field::String,
    main_position: Field::Number,
    note: Field::Text,
    other_special_abilities: Field::String,
    p11_proper: Field::Number,
    p12_proper: Field::Number,
    p13_proper: Field::Number,
    p2_proper: Field::Number,
    p3_proper: Field::Number,
    p4_proper: Field::Number,
    p5_proper: Field::Number,
    p6_proper: Field::Number,
    p7_proper: Field::Number,
    pawapuro_fielder: Field::HasOne,
    pawapuro_pitcher: Field::HasOne,
    player_name: Field::String,
    throws: Field::String,
    updated_by: Field::String,
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
    back_name
    bats
    birthday
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    back_name
    bats
    birthday
    created_by
    first_name
    kaifuku
    kegasinikusa
    last_name
    main_position
    note
    other_special_abilities
    p11_proper
    p12_proper
    p13_proper
    p2_proper
    p3_proper
    p4_proper
    p5_proper
    p6_proper
    p7_proper
    pawapuro_fielder
    pawapuro_pitcher
    player_name
    throws
    updated_by
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    back_name
    bats
    birthday
    created_by
    first_name
    kaifuku
    kegasinikusa
    last_name
    main_position
    note
    other_special_abilities
    p11_proper
    p12_proper
    p13_proper
    p2_proper
    p3_proper
    p4_proper
    p5_proper
    p6_proper
    p7_proper
    pawapuro_fielder
    pawapuro_pitcher
    player_name
    throws
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

  # Overwrite this method to customize how pawapuro players are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(pawapuro_player)
  #   "PawapuroPlayer ##{pawapuro_player.id}"
  # end
end
