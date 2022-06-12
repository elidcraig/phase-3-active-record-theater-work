class Role < ActiveRecord::Base
  has_many :auditions

  def auditions
    Audition.where(role_id: self.id)
  end

  def actors
    audition_array = self.auditions.select(:actor)
    audition_array.collect {|audition| audition[:actor]}
  end

  def locations
    self.auditions.collect {|audition| audition[:location]}
  end

  def lead
    lead_object = Audition.where(role_id: self.id, hired: true).first
    if lead_object
      lead_object
    else 
      'no actor has been hired for this role'  
    end
  end

  def understudy
    under_object = Audition.where(role_id: self.id, hired: true).second
    if under_object
      under_object
    else
      'no actor has been hired for understudy for this role'  
    end
  end
end