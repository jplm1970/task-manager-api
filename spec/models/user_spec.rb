require 'rails_helper'

RSpec.describe User, type: :model do
  # before { @user = FactoryGirl.build(:user)}
# caso simplificar commentar a seguinte linha
#subject { FactoryGirl.build(:user) }
# sem factorygirl por configuracao no spec_helper
# subject { build(:user) }

# it { expect(@user).to respond_to(:email) }
# it { expect(@user).to respond_to(:name) }
# it { expect(@user).to respond_to(:password) }
# it { expect(@user).to respond_to(:password_confirmation) }
# it { expect(@user).to be_valid }
# subject = User.new

# it { expect(subject).to respond_to(:email) }
# it { expect(subject).to be_valid }
it { is_expected.to respond_to(:email) }

end
