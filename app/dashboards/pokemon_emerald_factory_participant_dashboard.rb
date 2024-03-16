require "administrate/base_dashboard"

class PokemonEmeraldFactoryParticipantDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    character: Field::String,
    effort_values: Field::String,
    item: Field::String,
    lap1_show: Field::Number,
    lap2_show: Field::Number,
    lap3_show: Field::Number,
    lap4_show: Field::Number,
    lap5_show: Field::Number,
    lap6_show: Field::Number,
    lap7_show: Field::Number,
    lap8_show: Field::Number,
    move1: Field::String,
    move2: Field::String,
    move3: Field::String,
    move4: Field::String,
    name: Field::String,
    no: Field::Number,
    type1: Field::String,
    type2: Field::String,
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
    character
    effort_values
    item
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    character
    effort_values
    item
    lap1_show
    lap2_show
    lap3_show
    lap4_show
    lap5_show
    lap6_show
    lap7_show
    lap8_show
    move1
    move2
    move3
    move4
    name
    no
    type1
    type2
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    character
    effort_values
    item
    lap1_show
    lap2_show
    lap3_show
    lap4_show
    lap5_show
    lap6_show
    lap7_show
    lap8_show
    move1
    move2
    move3
    move4
    name
    no
    type1
    type2
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

  # Overwrite this method to customize how pokemon emerald factory participants are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(pokemon_emerald_factory_participant)
  #   "PokemonEmeraldFactoryParticipant ##{pokemon_emerald_factory_participant.id}"
  # end
end
