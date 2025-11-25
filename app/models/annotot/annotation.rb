module Annotot
  class Annotation < ApplicationRecord
    validates :uuid, presence: true, uniqueness: true
    validates :canvas, presence: true

    serialize :data, coder: JSON

    ##
    # Used to differentiate between a numeric id and a uuid. Rails will trim a
    # uuid with leading numbers eg '123a'.to_i => 123
    # @param [String] identifier
    def self.retrieve_by_id_or_uuid(identifier)
      if identifier =~ /\A\d+\z/
        find_by(id: identifier)
      else
        find_by(uuid: identifier)
      end
    end
  end
end
