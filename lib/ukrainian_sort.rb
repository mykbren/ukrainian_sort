# frozen_string_literal: true

module UkrainianSort
  class Error < StandardError; end
end

require_relative 'ukrainian_sort/version'
require_relative 'ukrainian_sort/sorter'

module UkrainianSort
  # Convenience method for sorting arrays of strings
  def self.sort(array)
    Sorter.new.sort(array)
  end

  # Convenience method for sorting arrays of strings in descending order
  def self.sort_desc(array)
    Sorter.new.sort_desc(array)
  end

  # Convenience method for comparing two strings
  def self.compare(str1, str2)
    Sorter.new.compare(str1, str2)
  end
end
