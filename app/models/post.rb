
class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      #binding.pry
      if category_attribute[:name] == ""
        return nil
      else 
        category_attribute[:name] = Category.find_or_create_by(category_attribute)
        self.categories << category_attribute[:name]
      end
    end
  end
end
