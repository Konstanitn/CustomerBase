# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  middle_name  :string(255)
#  phone_number :string(255)
#  address      :string(255)
#  info         :text
#  who_updated  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

