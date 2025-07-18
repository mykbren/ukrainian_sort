# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UkrainianSort do
  let(:ukrainian_words) do
    [
      'яблуко', 'апельсин', 'банан', 'виноград', 'груша', 'ґава',
      'дуб', 'ель', 'єдинорог', 'жито', 'зерно', 'ирій', 'іржа',
      'їжак', 'йогурт', 'капуста', 'лимон', 'мандарин', 'насіння',
      'огірок', 'папая', 'редис', 'слива', 'томат', 'уряд',
      'фініки', 'хурма', 'цибуля', 'чорниця', 'шпинат', 'щавель',
      "м'ясо", 'юка', 'ялина'
    ]
  end

  let(:expected_sorted_order) do
    [
      'апельсин',
      'банан',
      'виноград',
      'груша',
      'ґава',
      'дуб',
      'ель',
      'єдинорог',
      'жито',
      'зерно',
      'ирій',
      'іржа',
      'їжак',
      'йогурт',
      'капуста',
      'лимон',
      'мандарин',
      "м'ясо",
      'насіння',
      'огірок',
      'папая',
      'редис',
      'слива',
      'томат',
      'уряд',
      'фініки',
      'хурма',
      'цибуля',
      'чорниця',
      'шпинат',
      'щавель',
      'юка',
      'яблуко',
      'ялина'
    ]
  end

  describe '.sort' do
    it 'sorts Ukrainian words correctly' do
      result = described_class.sort(ukrainian_words)
      expect(result).to eq(expected_sorted_order)
    end

    it 'ignores apostrophes when sorting' do
      words_with_apostrophes = ["м'ясо", 'мед', 'молоко', "м'ята"]
      result = described_class.sort(words_with_apostrophes)
      # м'ясо and м'ята should be sorted by their alphabetic characters only
      expect(result).to eq(['мед', 'молоко', "м'ясо", "м'ята"])
    end

    it 'handles mixed punctuation correctly' do
      mixed_words = %w[кіт-собака кіт кітер кіт123]
      result = described_class.sort(mixed_words)
      # All should be sorted by alphabetic characters only
      expect(result).to eq(%w[кіт кіт123 кітер кіт-собака])
    end

    it 'handles empty arrays' do
      expect(described_class.sort([])).to eq([])
    end

    it 'handles single element arrays' do
      expect(described_class.sort(['яблуко'])).to eq(['яблуко'])
    end

    it 'handles mixed case properly' do
      mixed_case = %w[Яблуко апельсин Банан виноград]
      result = described_class.sort(mixed_case)
      expect(result).to eq(%w[апельсин Банан виноград Яблуко])
    end
  end

  describe '.sort_desc' do
    it 'sorts Ukrainian words in descending order' do
      result = described_class.sort_desc(ukrainian_words)
      expect(result).to eq(expected_sorted_order.reverse)
    end
  end

  describe '.compare' do
    it 'compares Ukrainian strings correctly' do
      expect(described_class.compare('апельсин', 'банан')).to eq(-1)
      expect(described_class.compare('банан', 'апельсин')).to eq(1)
      expect(described_class.compare('яблуко', 'яблуко')).to eq(0)
    end

    it 'handles special Ukrainian characters correctly' do
      expect(described_class.compare('ґава', 'груша')).to eq(1)
      expect(described_class.compare('їжак', 'йогурт')).to eq(-1)
      expect(described_class.compare('єдинорог', 'жито')).to eq(-1)
      expect(described_class.compare('іржа', 'їжак')).to eq(-1)
    end

    it 'handles strings of different lengths' do
      expect(described_class.compare('кіт', 'кітер')).to eq(-1)
      expect(described_class.compare('кітер', 'кіт')).to eq(1)
    end

    it 'handles non-Ukrainian characters' do
      # Non-Ukrainian characters should be placed after Ukrainian characters
      expect(described_class.compare('яблуко', 'яблуко1')).to eq(0)
      expect(described_class.compare('apple', 'яблуко')).to eq(1)
    end

    it 'ignores apostrophes and non-alphabetic characters during comparison' do
      expect(described_class.compare("м'ясо", 'мясо')).to eq(0) # Should be equal when ignoring apostrophe
      expect(described_class.compare('кіт-собака', 'кітсобака')).to eq(0) # Should be equal when ignoring hyphen
      expect(described_class.compare('test123', 'test')).to eq(0) # Should be equal when ignoring numbers
    end
  end

  describe 'Integration with UkrainianSort::Sorter' do
    let(:sorter) { UkrainianSort::Sorter.new }

    it 'can be used directly' do
      result = sorter.sort(%w[яблуко апельсин банан])
      expect(result).to eq(%w[апельсин банан яблуко])
    end
  end
end
