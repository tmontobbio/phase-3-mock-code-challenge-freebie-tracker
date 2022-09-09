class Company < ActiveRecord::Base
    has_many :freebies
    has_many :devs, through: :freebies


############# Handled by macros ################
    def freebies
      Freebie.where("company_id == ?", self.id)
    end

    def devs
      Freebie.all.where("dev_id == ?", self.id)
    end
################################################


    def give_freebie(dev, item_name, value)
      Freebie.create(dev_id: dev, company_id:self.id, item_name: item_name, value: value)
    end


    # why is self implied even though method definition self doesnt matter
    def self.oldest_company
      #calling .order on the whole class because self in this context is all the companies
      # ascending is the default
      order(:founding_year).first

      Company.all.order(founding_year: :asc).first
    end

    # neat extra thing
    def self.oldest_company_age
      Time.now.year - oldest_company.founding_year
    end 
end
