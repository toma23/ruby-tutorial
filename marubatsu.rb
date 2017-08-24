#〇×ゲーム
side = 3  #一辺の長さ
turn = ["〇", "×"]  #先手，後手のマーク

print "〇×ゲームを始めます\n\n"

#碁盤の作成
arr = [1, 2, 3,
       4, 5, 6,
       7, 8, 9]

for i in 0..8 do
  print " #{arr[i]} |"
  if (arr[i]%3) == 0 then
    print "\n"
    for j in 1..3 do
        print "---+"
    end
    print "\n"
  end
end

print "場所を入力してください＞"
input = gets.to_i  #場所の入力(数値)

=begin
#入力された数値とのマッチング
num = 0
while input != num do
  if input == num then
=end
