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
      return "A"
    when 11 then
      return "J"
    when 12 then
      return "Q"
    when 13 then
      return "K"
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
  attr_accessor :list
  attr_accessor :point
  attr_accessor :burst_flg

  def initialize
    @list = []          # 手札
    @point = 0          # 合計点数
    @burst_flg = false  # バーストフラグ
  end

  def draw_card(deck)
    @list.push(deck.draw)
    @point += @list.last.calc_number
    @burst_flg = check_burst(@point)
  end

  def check_burst(point)
    if point > 21
      return true
    else
      return false
    end
  end

end

# プレイヤークラス
class Player < User
  def add_card(deck)
    puts "カードを引きますか？引く場合は『YES』、勝負する場合は『GO(YES以外)』を入力してください！"
    response = gets.downcase.chomp
    while response == "yes"
      draw_card(deck)
      self.list.last.show
      if @point > 21
        puts "合計『#{@point}』でバーストです。あなたの負けです。"
        exit
      else
        puts "合計は『#{@point}』です。もう一度引きますか？"
        response = gets.downcase.chomp
      end
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

# デッキを用意する
deck = Deck.new

# プレイヤーを用意する
player = Player.new
dealer = Dealer.new

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


# ---------------------------ここからは配列バージョン




# バトル
def goBattle(sum_player_card, sum_dealer_card)
	puts "あなたのカードの合計は『#{sum_player_card}』!"
	puts "ディーラーのカードの合計は『#{sum_dealer_card}』!"
	if sum_player_card < sum_dealer_card
		puts "お前の負けだ！"
	elsif sum_player_card > sum_dealer_card
		puts "お前の...勝ちだ!!!!!!"
	else
		puts "ドローッッ!"
	end

end



# 勝負!!
goBattle(player.point, dealer.point)
