# frozen_string_literal: true

RSpec.describe UkrainianSort do
  let(:ukrainian_words) do
    [
      'яблуко', 'апельсин', 'банан', 'виноград', 'груша', 'ґава',
      'дуб', 'ель', 'єдинорог', 'жито', 'зерно', 'ирій', 'іржа',
      'їжак', 'йогурт', 'капуста', 'лимон', 'мандарин', 'насіння',
      'огірок', 'папая', 'редис', 'слива', 'томат', 'уряд',
      'фініки', 'хурма', 'цибуля', 'чорниця', 'шпинат', 'щавель',
      "м'ясо", 'юкка', 'ялина'
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
      'юкка',
      'яблуко',
      'ялина'
    ]
  end

  describe '.sort' do
    it 'sorts Ukrainian words correctly' do
      result = UkrainianSort.sort(ukrainian_words)
      expect(result).to eq(expected_sorted_order)
    end

    it 'ignores apostrophes when sorting' do
      words_with_apostrophes = ["м'ясо", 'мед', 'молоко', "м'ята"]
      result = UkrainianSort.sort(words_with_apostrophes)
      # м'ясо and м'ята should be sorted by their alphabetic characters only
      expect(result).to eq(['мед', 'молоко', "м'ясо", "м'ята"])
    end

    it 'handles mixed punctuation correctly' do
      mixed_words = %w[кіт-собака кіт кітер кіт123]
      result = UkrainianSort.sort(mixed_words)
      # All should be sorted by alphabetic characters only
      expect(result).to eq(%w[кіт кіт123 кітер кіт-собака])
    end

    it 'handles empty arrays' do
      expect(UkrainianSort.sort([])).to eq([])
    end

    it 'handles single element arrays' do
      expect(UkrainianSort.sort(['яблуко'])).to eq(['яблуко'])
    end

    it 'handles mixed case properly' do
      mixed_case = %w[Яблуко апельсин Банан виноград]
      result = UkrainianSort.sort(mixed_case)
      expect(result).to eq(%w[апельсин Банан виноград Яблуко])
    end
  end

  describe '.sort_desc' do
    it 'sorts Ukrainian words in descending order' do
      result = UkrainianSort.sort_desc(ukrainian_words)
      expect(result).to eq(expected_sorted_order.reverse)
    end
  end

  describe '.compare' do
    it 'compares Ukrainian strings correctly' do
      expect(UkrainianSort.compare('апельсин', 'банан')).to eq(-1)
      expect(UkrainianSort.compare('банан', 'апельсин')).to eq(1)
      expect(UkrainianSort.compare('яблуко', 'яблуко')).to eq(0)
    end

    it 'handles special Ukrainian characters correctly' do
      expect(UkrainianSort.compare('ґава', 'груша')).to eq(1)
      expect(UkrainianSort.compare('їжак', 'йогурт')).to eq(-1)
      expect(UkrainianSort.compare('єдинорог', 'жито')).to eq(-1)
      expect(UkrainianSort.compare('іржа', 'їжак')).to eq(-1)
    end

    it 'handles strings of different lengths' do
      expect(UkrainianSort.compare('кіт', 'кітер')).to eq(-1)
      expect(UkrainianSort.compare('кітер', 'кіт')).to eq(1)
    end

    it 'handles non-Ukrainian characters' do
      # Non-Ukrainian characters should be placed after Ukrainian characters
      expect(UkrainianSort.compare('яблуко', 'яблуко1')).to eq(0)
      expect(UkrainianSort.compare('apple', 'яблуко')).to eq(1)
    end

    it 'ignores apostrophes and non-alphabetic characters during comparison' do
      expect(UkrainianSort.compare("м'ясо", 'мясо')).to eq(0) # Should be equal when ignoring apostrophe
      expect(UkrainianSort.compare('кіт-собака', 'кітсобака')).to eq(0) # Should be equal when ignoring hyphen
      expect(UkrainianSort.compare('test123', 'test')).to eq(0) # Should be equal when ignoring numbers
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
