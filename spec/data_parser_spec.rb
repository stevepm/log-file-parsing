require 'spec_helper'
require 'data_parser'

describe DataParser do
  it 'can read all of the log level chars' do
    input = "W, [2014-05-10T13:49:19.049260 #83516]  WARN -- : deliver B2C systems\nW, [2014-05-10T13:49:19.049408 #83516]  WARN -- : transition sticky bandwidth"
    data = DataParser.new(input)
    data.find_log_level_chars
    expect(data.log_level_chars).to eq(['W', 'W'])
    data.find_date
    expect(data.dates).to eq(['2014-5-10', '2014-5-10'])
    data.find_process_id
    expect(data.process_ids).to eq(['#83516', '#83516'])
    data.find_log_level
    expect(data.log_levels).to eq(['WARN', 'WARN'])
    data.find_message
    expect(data.messages).to eq(['deliver B2C systems', 'transition sticky bandwidth'])
  end
end