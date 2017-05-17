require 'spec_helper'

describe Quote do
  it 'creates a quote' do
    quote = Quote.create({tip: "we r awesome"})
    expect(quote.tip).to eq("we r awesome")
  end
end
