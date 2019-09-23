# トランプカード52枚の用意
number = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K' ]
card = Array.new(4).map{Array.new(number)}

# マークを返す
def getMarkName(point)
	case point
	when 0 then
		return "ダイヤ"
	when 1 then
		return "スペード"
	when 2 then
		return "ハート"
	else
		return "クローバー"
	end
end

# プレイヤーのカードを取得
def getCard(card)
	mark_point = rand(4)
	number_point = rand(card[mark_point].length)
  get_mark = getMarkName(mark_point)
	get_number = card[mark_point][number_point]
  card[mark_point].delete_at(number_point)
	
	# カードセット
  get_card = [get_mark, get_number]
	return get_card
end

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

# 文字札を引いた時に数字（10)に変換する
def changeString(str_card)
	if str_card.class == String
		str_card = 10
	end
	return str_card
end

# カードを引いて合計する
def addCard(card, sum_card)
	sum_card += changeString(getCard(card)[1]).to_i
end

# メイン処理
player_card_01 = getCard(card)
player_card_02 = getCard(card)
dealer_card_01 = getCard(card)
dealer_card_02 = getCard(card)

# オープニング
puts "ブラックジャックにようこそ!!"
puts "これからブラックジャックを開始します"
puts ""

# カードを表示する
puts "あなたが1枚目に引いたカードは『#{player_card_01[0]}』の『#{player_card_01[1]}』です！"
puts "あなたが2枚目に引いたカードは『#{player_card_02[0]}』の『#{player_card_02[1]}』です！"
puts ""
puts "ディーラが１枚目に引いたカードは『#{dealer_card_01[0]}』の『#{dealer_card_01[1]}』です！"
puts "ディーラが2枚目に引いたカードはわかりません"
puts ""

# 合計
sum_player_card = changeString(player_card_01[1]).to_i + changeString(player_card_02[1]).to_i
sum_dealer_card = changeString(dealer_card_01[1]).to_i + changeString(dealer_card_02[1]).to_i

# 勝負するか？
puts "カードを引きますか？引く場合は『YES』、勝負する場合は『GO(YES以外)』を入力してください！"
response = gets.downcase.chomp
while response == "yes"
	add_card = getCard(card)
	puts "あなたが引いたカードは#{add_card[0]}の#{add_card[1]}です。"
	sum_player_card += changeString(add_card[1]).to_i
	if sum_player_card > 21
		puts "合計『#{sum_player_card}』でバーストです。あなたの負けです。"
		exit
	else
		puts "合計は『#{sum_player_card}』です。もう一度引きますか？"
		response = gets.downcase.chomp
	end
end

# ディーラーはカードの合計が17になるまでカードを引く
while sum_dealer_card < 17
	sum_dealer_card += changeString(getCard(card)[1]).to_i
	if sum_dealer_card > 21
		puts "ディーラーの合計は『#{sum_dealer_card}』でバーストしました"
		puts "あなたの勝ちです!"
		exit
	end
end

# 勝負!!
goBattle(sum_player_card, sum_dealer_card)
