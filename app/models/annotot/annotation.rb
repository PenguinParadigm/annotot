module Annotot
  class Annotation < ApplicationRecord
    validates :uuid, presence: true, uniqueness: true
    validates :canvas, presence: true

    serialize :data, JSON
  end
end
