class Dev < ActiveRecord::Base
    has_many :freebies
    has_many :companies, through: :freebies


################ Handled by macros ############### 
    def freebies
      Freebie.all.where("dev_id == ?", self.id)
    end
##################################################


    def recieved_one? item_name
      #               ("item_name == ?", item_name)
      self.freebies.where(item_name: item_name) != []

      # Morgan's solution
      freebies.where(item_name: item_name).any?
      !self.freebies.where(item_name: item_name).empty?
      !!freebies.find_by(item_name: item_name)
      !!Freebie.find_by(item_name: item_name, dev: self)

    end

    
    ########## stuck #########
    def give_away dev, freebie
      #the dev giving away "self"
      self.freebies.where(id:freebie.id)
      freebie.dev_id == self.id

      # morgans solution
      # self is the dev give_away was called on
      # dev is the dev they're giving the freebie to
      # freebie is the freebie instance being given
      
      if freebie.dev == self
        # Both perameters can be converted to (dev: dev)
        freebie.update(dev_id: dev.id)
      end
      # or
      freebie.update(dev_id: dev.id) if self == freebie.dev
      # or
      freebie.update(dev: dev) unless freebie.dev != self
    end
    ###########################
end
