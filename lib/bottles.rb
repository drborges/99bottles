class Bottles
  def verse(verse_number)
    VerseFactory.for(verse_number).text
  end

  def verses(higher, lower)
    higher.downto(lower).map { |verse_number| verse(verse_number) }.join("\n")
  end

  def song
    verses(99, 0)
  end
end

module VerseFactory
  def self.for(verse_number)
    verse_type = VERSE_NUMBER_TO_VERSE_TYPE[verse_number] || DefaultVerse
    verse_type.new(verse_number)
  end
end

class DefaultVerse
  attr_reader :verse_number, :next_verse_number

  def initialize(verse_number)
    @verse_number = verse_number
    @next_verse_number = verse_number - 1
  end

  def text
<<-VERSE
#{verse_number} bottles of beer on the wall, #{verse_number} bottles of beer.
Take one down and pass it around, #{next_verse_number} bottles of beer on the wall.
VERSE
  end
end

class LastVerse < DefaultVerse
  def text
<<-VERSE
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
VERSE
  end
end

class PenultimateVerse < DefaultVerse
  def text
<<-VERSE
#{verse_number} bottle of beer on the wall, #{verse_number} bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
VERSE
  end
end

class AntepenultimateVerse < DefaultVerse
  def text
<<-VERSE
#{verse_number} bottles of beer on the wall, #{verse_number} bottles of beer.
Take one down and pass it around, #{next_verse_number} bottle of beer on the wall.
VERSE
  end
end

VERSE_NUMBER_TO_VERSE_TYPE = {
  0 => LastVerse,
  1 => PenultimateVerse,
  2 => AntepenultimateVerse,
}
