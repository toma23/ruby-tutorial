#encoding: utf-8

turn = ["o", "x"]  #先手，後手のマーク
pos = 0  #0→先手, 1→後手
count = 9

#碁盤の作成
table = Array.new(3).map{Array.new(3, 0)}  #全体
table = [[1,2,3], [4,5,6], [7,8,9]]

class Exe
  #初期化
  def initialize(table=Array.new, turn=Array.new, pos, count)
    @table = table
    @turn = turn
    @pos = pos
    @count = count
  end

  #碁盤の表示
  def board ()
    print "\n"
    for i in 0..2 do
      for j in 0..2 do
        print " #{@table[i][j]} |"
        if ((j+1)%3) == 0 then
          print "\n"
          for k in 1..3 do
            print "---+"
          end
          print "\n"
        end
      end
    end
  end
  
  #入力された数値とのマッチング
  def isLeagal (input)
    num = 0
    #count_s = 0
    for num in 1..9 do
      if input == num then  #正しい場所を入力したら
        @table[(num-1)/3][(num-1)%3] = @turn[@pos]  #指定された場所に〇または×を置く
        @pos = (@pos+1)%2  #先手(後手)→後手(先手)に変更
        @count -= 1
      elsif input > 9  #正しくない場所を入力したら
        print "正しくない場所を入力しました\n"
        break
      end
    end
  end

  #3つ並んでいるか探索
  #def search (input)
    
  #end

  #対戦終了
  def finish ()
    if @count == 0 then
      print "\n---------試合終了---------\n"
      return true
    end
  end
end

#main
print "〇×ゲームを始めます\n"
print "---------試合開始---------\n"
exe = Exe.new(table, turn, pos, count)

#1回の対局動作をループ
while true do
  if exe.finish == true then
    break
  end
  exe.board
  print "場所を入力してください＞"
  input = gets.to_i  #場所の入力(数値)
  if exe.isLeagal(input) == true then  #合法手か調べる
    break
  end
end

#試合終了後の処理
exe.board