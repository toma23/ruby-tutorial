#encoding: utf-8

side = 3  #一辺の長さ
turn = ["o", "x"]  #先手，後手のマーク
pos = 0  #0→先手, 1→後手
count = 9

#碁盤の作成
arr = [1, 2, 3,
       4, 5, 6,
       7, 8, 9]

class Exe
  def initialize(table=Array.new, turn=Array.new, pos, count)
    @table = table
    @turn = turn
    @pos = pos
    @count = count
  end

  #碁盤の表示
  def board ()
    print "\n"
    for i in 0..8 do
      print " #{@table[i]} |"
      if ((i+1)%3) == 0 then
        print "\n"
        for j in 1..3 do
          print "---+"
        end
        print "\n"
      end
    end
  end
  
  #入力された数値とのマッチング
  def isLeagal (input)
    num = 0
    for num in 1..9 do
      if input == num then  #正しい場所を入力したら
        @table[num-1] = @turn[@pos]
        @pos = (@pos+1)%2
        @count -= 1
      elsif input > 9  #正しくない場所を入力したら
        print "正しくない場所を入力しました\n"
        break
      end
    end
  end
  
  #対戦終了
  def finish ()
    if @count == 0 then
      print "---------試合終了---------\n"
      return true
    end
  end
end

#main
print "〇×ゲームを始めます\n"
print "---------試合開始---------\n"
exe = Exe.new(arr, turn, pos, count)
while true do  #1回の対局をループ
  if exe.finish == true then
    break
  end
  exe.board
  print "場所を入力してください＞"
  input = gets.to_i  #場所の入力(数値)
  exe.isLeagal(input)
end

#試合終了後の処理
exe.board