class Freebie < ActiveRecord::Base
    belongs_to :company
    belongs_to :dev

   ########### Handled by macros #############
    def dev
      Dev.all.where("id == ?", self.dev_id)
    end

    def company
      Company.all.where("id == ?", self.company_id)
    end
   ############################################


    #morgan did this differently than me
    def print_details
      "#{self.dev.pluck(:name)[0]} owns a #{self.item_name} from #{self.company.pluck(:name)[0]}."
    end

end
