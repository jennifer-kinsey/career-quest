require "spec_helper"

describe Correspondence do
  it { should belong_to :user_detail }
  it { should belong_to :contact }
  it { should belong_to :position }
end
