require 'date'

class DataParser
  attr_reader :input, :log_level_chars, :dates, :process_ids, :log_levels, :messages
  def initialize(input)
    @input = input.split("\n")
    @log_level_chars = []
    @dates = []
    @process_ids = []
    @log_levels = []
    @messages = []
  end

  def find_log_level_chars
    input.each do |line|
      log_level_chars << line.split(',').first
    end
  end

  def find_date
    input.each do |line|
      date = line.split(',').join.split(' ').join.split('#').first
      date[0..1] = ''
      date = Date.parse(date)
      dates << "#{date.year}-#{date.month}-#{date.day}"
    end
  end

  def find_process_id
    input.each do |line|
      process_id = line.split(',').join.split(' ').join.split('#')[1].split(']').first
      process_ids << "#"+process_id
    end
  end

  def find_log_level
    input.each do |line|
      log_level = line.split(',').join.split(' ').join.split('#')[1].split(']')[1].split('-').first
      log_levels << log_level
    end
  end

  def find_message
    input.each do |line|
      message = line.split(',').join.split('#').join.split(']')[1].split('-')[2].split(':')[1].strip
      messages << message
    end
  end

end