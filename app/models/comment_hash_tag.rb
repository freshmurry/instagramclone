class CommentHashTag < ApplicationRecord
  belongs_to :comment
  belongs_to :hash_tag
end