# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Default Ruby Sort vs Ukrainian Sort' do
  let(:ukrainian_words) do
    %w[
      яблуко апельсин ґава їжак єдинорог іржа
      банан виноград груша дуб ель жито зерно
      ива йогурт капуста лимон щавель юка ялина
    ]
  end

  let(:expected_ukrainian_order) do
    %w[
      апельсин банан виноград груша ґава дуб
      ель єдинорог жито зерно ива іржа їжак
      йогурт капуста лимон щавель юка яблуко
      ялина
    ]
  end

  describe 'Default Ruby sort' do
    it 'fails to sort Ukrainian words correctly' do
      # This test proves that default Ruby sort doesn't handle Ukrainian alphabet properly
      default_ruby_sorted = ukrainian_words.sort
      ukrainian_sorted = UkrainianSort.sort(ukrainian_words)

      # They should be different
      expect(default_ruby_sorted).not_to eq(ukrainian_sorted)
      expect(default_ruby_sorted).not_to eq(expected_ukrainian_order)

      # Show what default Ruby sort produces (incorrect for Ukrainian)
      puts "\nDefault Ruby sort result:"
      puts default_ruby_sorted.inspect
      puts "\nCorrect Ukrainian sort result:"
      puts ukrainian_sorted.inspect

      # Verify our Ukrainian sort is correct
      expect(ukrainian_sorted).to eq(expected_ukrainian_order)
    end

    it 'incorrectly orders special Ukrainian characters' do
      # Test specific Ukrainian characters that are sorted incorrectly by default Ruby
      test_chars = %w[ґ г є е і и ї й]

      ruby_sorted = test_chars.sort
      ukrainian_sorted = UkrainianSort.sort(test_chars)

      # They should be different
      expect(ruby_sorted).not_to eq(ukrainian_sorted)

      # Ukrainian sort should put these in the correct order according to Ukrainian alphabet
      expect(ukrainian_sorted).to eq(%w[г ґ е є и і ї й])

      # Show the difference
      puts "\nSpecial characters - Default Ruby sort:"
      puts ruby_sorted.inspect
      puts 'Special characters - Ukrainian sort:'
      puts ukrainian_sorted.inspect
    end

    it 'demonstrates the problem with Unicode code points' do
      # Show why default sorting fails: it uses Unicode code points, not alphabet order
      chars_with_codes = %w[г ґ е є и і й ї].map do |char|
        { char: char, code: char.ord }
      end

      puts "\nUnicode code points for Ukrainian characters:"
      chars_with_codes.each do |item|
        puts "#{item[:char]} -> #{item[:code]}"
      end

      # Sort by Unicode code points (what Ruby does by default)
      sorted_by_unicode = chars_with_codes.sort_by { |item| item[:code] }
      unicode_order = sorted_by_unicode.map { |item| item[:char] }

      # Sort by Ukrainian alphabet order
      ukrainian_order = UkrainianSort.sort(chars_with_codes.map { |item| item[:char] })

      puts "\nSorted by Unicode code points (Ruby default):"
      puts unicode_order.inspect
      puts 'Sorted by Ukrainian alphabet order:'
      puts ukrainian_order.inspect

      # They should be different, proving the problem
      expect(unicode_order).not_to eq(ukrainian_order)

      # Our Ukrainian sort should be correct
      expect(ukrainian_order).to eq(%w[г ґ е є и і ї й])
    end
  end

  describe 'Edge cases where default sort fails' do
    it 'handles words starting with special Ukrainian characters' do
      words = %w[їжак іржа єдинорог яблуко ялина юка]

      ruby_sorted = words.sort
      ukrainian_sorted = UkrainianSort.sort(words)

      # Should be different
      expect(ruby_sorted).not_to eq(ukrainian_sorted)

      # Ukrainian sort should be correct
      expect(ukrainian_sorted).to eq(%w[єдинорог іржа їжак юка яблуко ялина])
    end

    it 'handles mixed case scenarios correctly' do
      mixed_words = %w[Яблуко апельсин Ґрунт єдинорог виноград]

      ruby_sorted = mixed_words.sort
      ukrainian_sorted = UkrainianSort.sort(mixed_words)

      # Should be different
      expect(ruby_sorted).not_to eq(ukrainian_sorted)

      # Ukrainian sort should handle case properly
      expect(ukrainian_sorted).to eq(%w[апельсин виноград Ґрунт єдинорог Яблуко])
    end
  end
end
