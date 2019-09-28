# カードクラスを宣言
class Card
  attr_reader :mark
  attr_reader :number
  
  def initialize(mark, number)
    @mark = mark
    @number = number
  end

  def show
    puts "あなたが引いたカードは『#{@mark} 』の『#{display_number}』です"
  end

  # 計算用に数値を変換する
  def calc_number
    if @number == 11 || @number == 12 || @number == 13
      return 10
    end
    return @number
  end
	
  # カードを表示する
  def display_number
    case @number
    when 1 then
      return "A(エース)"
    when 11 then
      return "J(ジャック))"
    when 12 then
      return "Q(クイーン)"
    when 13 then
      return "K(キング)"
    else
      return @number.to_s
    end
  end
end	

# デッキクラスを宣言
class Deck
  attr_accessor :cards

  # 52枚の山札を作成する
  def initialize
    @cards = []
    for mark in ["ダイヤ", "スペード", "ハート", "クローバー"]
      for number in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
        card = Card.new(mark, number)
        @cards << card
      end
    end
  end

  def draw
    pointer = rand(@cards.length)
    get_card = @cards[pointer]
    @cards.delete_at(pointer)
    return get_card
  end

  def shuffle
    cards = @cards.shuffle!
    return cards
  end

end

# ユーザークラス
class User
  attr_accessor :name
  attr_accessor :list
  attr_accessor :point

  def initialize(name)
    @name = name
    @list = []          # 手札
    @point = 0          # 合計点数
  end

  def draw_card(deck)
    @list.push(deck.draw)   # カードを引いて手札に追加する
    calc_point              # 手札の合計を計算する
    check_burst   # バーストしていないか確認する
  end

  def calc_point
    @point = 0

    # 手札の1以外の合計点を算出する
    @list.each do |card|
      if card.number != 1
        @point += card.calc_number
      end
    end 

    # 手札にある1の計算を行う
    @list.each do |card|
      if card.calc_number == 1
        if @point > 10
          @point += 1
        else
          @point += 11
        end
      end
    end
  end

  def check_burst
    if @point > 21
      puts "合計『#{@point}』でバーストです。#{@name}の負けです。"
      exit
    end
  end

end

# プレイヤークラス
class Player < User
  def add_card(deck)
    puts "カードを引きますか？引く場合は『YES』、勝負する場合は『GO(YES以外)』を入力してください！"
    response = gets.downcase.chomp
    while response == "yes"
      draw_card(deck)         # カードを引く
      self.list.last.show     # 結果を表示する
      puts "合計は『#{@point}』です。もう一度引きますか？"
      response = gets.downcase.chomp
    end
  end
end

# ディーラークラス
class Dealer < User
  def repeat_17_points_exceeded(deck)
    while @point < 17
      draw_card(deck)
    end
  end
end

# ---------------------------ここまでクラス

# 勝負判定用のメソッド
def goBattle(sum_player_card, sum_dealer_card)
	puts "あなたのカードの合計は『#{sum_player_card}』!"
  puts "ディーラーのカードの合計は『#{sum_dealer_card}』!"
  puts
	if sum_player_card < sum_dealer_card
		puts "あなたの敗北です。You Lose..."
	elsif sum_player_card > sum_dealer_card
		puts "あなたの勝利です。You Wins!"
  else
		puts "引き分けです。draw game..."
	end

end

# デッキを用意する
deck = Deck.new

# プレイヤーを用意する
player = Player.new("プレイヤー")
dealer = Dealer.new("ディーラ(CPU)")

# プレイヤーとディーラーにカードを配る
2.times do
  player.draw_card(deck)
  dealer.draw_card(deck)
end

# ブラックジャック開始
puts "ブラックジャックにようこそ!!"
puts "これからブラックジャックを開始します"
puts
puts "あなたが1枚目に引いたカードは『#{player.list.first.mark}』の『#{player.list.first.display_number}』です！"
puts "あなたが2枚目に引いたカードは『#{player.list.last.mark}』の『#{player.list.last.display_number}』です！"
puts
puts "ディーラが１枚目に引いたカードは『#{dealer.list.first.mark}』の『#{dealer.list.first.display_number}』です！"
puts "ディーラが2枚目に引いたカードはわかりません"
puts

# プレイヤーはカードを引くかどうか選択する（21を超えた場合、プレイヤーの敗北）
player.add_card(deck)

# ディーラーは17以上が出るまで引き続ける
dealer.repeat_17_points_exceeded(deck)

# 勝負!!
goBattle(player.point, dealer.point)
