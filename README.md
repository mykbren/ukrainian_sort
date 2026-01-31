# Ukrainian Sort Gem

## Мотивація
Сортування українського тексту не працює у Ruby через стандартний механізм сортування, який базується на Unicode-кодах. Результат не відповідає порядку українського алфавіту.

Ця бібліотека забезпечує правильне сортування відповідно до українського алфавіту, вирішуючи проблеми, як-от розташування 'ґ' та 'є'.

## Motivation
Sorting Ukrainian text correctly is a challenge with Ruby's default sorting mechanism. By default, Ruby sorts strings based on Unicode code points, which does not align with the Ukrainian alphabet.

This gem ensures proper sorting according to the Ukrainian alphabet, addressing discrepancies like the placement of 'ґ' and 'є'.

### Приклад / Example
- Стандартне сортування Ruby / Default sort in Ruby:
```
["г", "е", "и", "й", "є", "і", "ї", "ґ"]
```
- ukrainian_sort gem:
```
["г", "ґ", "е", "є", "и", "і", "ї", "й"]
```

### Unicode значення / Unicode values
- г -> 1075
- ґ -> 1169
- е -> 1077
- є -> 1108
- и -> 1080
- і -> 1110
- й -> 1081
- ї -> 1111

### Сортування за Unicode-кодами (стандартне для Ruby) / Sort by Unicode (default in Ruby)
```
["г", "е", "и", "й", "є", "і", "ї", "ґ"]
```
### ukrainian_sort gem:
```
["г", "ґ", "е", "є", "и", "і", "ї", "й"]
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ukrainian_sort'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install ukrainian_sort
```

## Usage
To sort an array of Ukrainian strings:

```ruby
require 'ukrainian_sort'

words = ["яблуко", "ґава", "виноград", "єдинорог"]
sorted_words = UkrainianSort.sort(words)
puts sorted_words
```

## Testing
Run the test suite to ensure everything is working correctly:

```bash
$ rspec
```

## Sponsor

Development of this gem is sponsored by [tseivo.com](https://tseivo.com)