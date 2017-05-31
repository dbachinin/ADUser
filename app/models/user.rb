class User < ApplicationRecord
  belongs_to :server, optional: false

end
