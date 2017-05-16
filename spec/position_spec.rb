require "spec_helper"

describe Position do
  it { should belong_to :user_detail }
  it { should belong_to :company }
end
