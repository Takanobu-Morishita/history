class Document < ApplicationRecord
  belongs_to :user
  attachment :image
end
