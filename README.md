# black_jack_ruby
Rubyでブラックジャックを作成してみました。

# 遊び方
ファイルをローカルにコピーして下記のコマンドをターミナルから実行してください！
Rubyの動作する環境であれば大抵動作すると思います。
```
$ ruby blackjack.rb
```

# 実行結果の例
```
ブラックジャックにようこそ!!
これからブラックジャックを開始します
使うカードの枚数は52枚です

あなたが1枚目に引いたカードは『クローバー』の『J(ジャック)』です！
あなたが2枚目に引いたカードは『ダイヤ』の『6』です！

ディーラが１枚目に引いたカードは『ハート』の『6』です！
ディーラが2枚目に引いたカードはわかりません

カードを引きますか？引く場合は『YES』、勝負する場合は『GO(YES以外)』を入力してください！
no
あなたのカードの合計は『16』!
ディーラーのカードの合計は『21』!

あなたの敗北です。You Lose...

------プレイヤーの引いたカード------
あなたが引いたカードは『クローバー 』の『J(ジャック))』です
あなたが引いたカードは『ダイヤ 』の『6』です
合計『16』

------ディーラ(CPU)の引いたカード------
あなたが引いたカードは『ハート 』の『6』です
あなたが引いたカードは『スペード 』の『5』です
あなたが引いたカードは『ハート 』の『Q(クイーン)』です
合計『21』

------残りのデッキの枚数------
残ったカードは47枚です
```

# 用意したクラス
card
deck
user
player
dealer
