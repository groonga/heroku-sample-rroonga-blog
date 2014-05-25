class SearchCondition
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :query

  validates_presence_of :query
end
