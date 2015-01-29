class Application < ActiveRecord::Base

  belongs_to :disposition
  belongs_to :maturity

end
