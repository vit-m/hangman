class ConsoleInterface
  FIGURES =
      Dir[__dir__ + '/../data/figures/*.txt'].sort.
      map { |figure| File.read(figure) }

  def initialize(game)
    @game = game
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def figure
    return FIGURES[@game.errors_made]
  end

  def get_input
    print "Введите следующую букву: "
    letter = STDIN.gets[0].upcase
    return letter
  end

  def print_out
    puts <<~END
      #{word_to_show}
      #{figure}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Штош, в другой раз. Слово: #{@game.word}"
    end
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter.nil?
          "__"
        else
          letter
        end
      end
    result.join(' ')
  end
end
