class Address < ApplicationRecord
  belongs_to :prefecture
  belongs_to :purchase
end
