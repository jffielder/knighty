
require 'yaml'

class Game

  attr_accessor :word, :attempts, :strikes, :blanks, :lives

  def initialize
    words = []
    File.open("5desk.txt", "r") { |file| 
      while (line = file.gets)
        words.push(line)
      end
     }
     
     @word = words[rand(words.size-1)].split(//).collect do |c| c.downcase end

     @attempts = []

     @strikes = 0

     @lives = 6

     @blanks = Array.new(@word.size, "_")

     @blanks = @blanks[0..-3]


  end#init

  def draw

    puts "\n\n\n\n\n"
    print "\t"

    @blanks.each { |chr| print chr + " " }


    puts "\n\nLives: #{@lives-@strikes}"

    print "Attempts: "
    @attempts.each{|chr| print chr + ", "}
    puts "\n"

    puts "Enter \"save\" to save game"
  end#draw

  def add_attempt(guess)
    @attempts.push(guess) unless @attempts.include? guess
  end

  def update_strikes
    #for each attempt not found in word, add 1
    sum = 0
    @attempts.each do |a|

      con = @word.collect do |letter|
        letter == a ? 1 : 0
      end

      sum += 1 unless con.include? 1
    end
    @strikes = sum
  end#update_strikes

  def update_blanks
    #for each attempt, check against letters in the word
    @attempts.each do |chr|

      @word.each_with_index do |word_chr, i|

        if chr == word_chr
          
          @blanks[i] = chr
        end
      end
    end
    
  end#update_blanks

  #returns true if blanks are all filled, false if underscore found
  def won?
    if !@blanks.include?("_")
      puts "You Win"
      return true
    end
    return @blanks.include?("_") ? false : true
  end

  def lost?
    if ((@blanks.include? "_") && @strikes >= @lives)
      puts "GAME OVER"
      puts "\t#{@word.join("")}"
      return true
    else
      return false
    end
  end

  def to_yaml
    return YAML.dump(self)
  end

end#class