require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one(:membership) }

  it { is_expected.to validate_presence_of(:email) }
end
