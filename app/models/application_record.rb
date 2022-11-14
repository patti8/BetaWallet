class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_create :generate_random_id

  private

        def generate_random_id
            self.id = SecureRandom.uuid # + Time.now.strftime("%Y")
        end
end
