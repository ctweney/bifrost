class TransferMethod < ActiveRecord::Base

  has_many :interfaces, :inverse_of => :transfer_method

  rails_admin do
    fields do
      help false
    end
    configure :transfer_method_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
