# frozen_string_literal: true

module UkrainianSort
  class Sorter
    # Ukrainian alphabet in correct order - each letter position with lowercase first
    UKRAINIAN_ALPHABET = %w[
      а б в г ґ д е є ж з и і
      ї й к л м н о п р с т у
      ф х ц ч ш щ ь ю я
    ].freeze

    # Create a mapping from each lowercase Ukrainian character to its position
    CHAR_ORDER = UKRAINIAN_ALPHABET.each_with_index.to_h.freeze

    def initialize
      @char_order = CHAR_ORDER
    end

    # Sort an array of strings using Ukrainian alphabet order
    def sort(array)
      array.sort { |a, b| compare(a, b) }
    end

    # Sort an array of strings in descending order
    def sort_desc(array)
      array.sort { |a, b| compare(b, a) }
    end

    # Compare two strings according to Ukrainian alphabet order
    def compare(str1, str2)
      return 0 if str1 == str2

      chars1 = normalize(str1)
      chars2 = normalize(str2)

      [chars1.length, chars2.length].min.times do |i|
        order1 = char_order_position(chars1[i])
        order2 = char_order_position(chars2[i])
        return order1 <=> order2 if order1 != order2
      end

      # If all compared characters equal, shorter wins
      chars1.length <=> chars2.length
    end

    private

    def normalize(str)
      str.downcase.chars.grep(/\p{L}/) # keep all letters
    end

    def char_order_position(char)
      if @char_order.key?(char)
        @char_order[char]
      else
        1000 + char.ord # sort non-Ukrainian letters after Ukrainian ones
      end
    end
  end
end
