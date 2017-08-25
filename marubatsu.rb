require("./class_exe")

turn = ["o", "x"]  #先手，後手のマーク
pos = 0  #0→先手, 1→後手
count = 9  #碁盤の空き数

#碁盤の作成
table = [[1,2,3], [4,5,6], [7,8,9]]

#main
print "〇×ゲームを始めます\n"
print "---------試合開始---------\n"
e = Exe.new(table, turn, pos, count)

#1回の対局動作をループ
while true do
  e.board
  print "場所を入力してください＞"
  input = gets.to_i  #場所の入力(数値)
  if e.legal?(input) == false then  #合法手か調べる
    next
  end
  e.move(input)
  if e.search? == true || e.count? == true then  #3つ並んだか，碁盤に置く場所がなくなったらループを抜ける
    break
  end
end

#試合終了後の処理
e.board
if e.search? == true then
  e.finish
elsif e.count? == true then
  e.draw
end