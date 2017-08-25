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
    for num in 1..9 do
      if input == num then  #正しい場所を入力したら
        @table[(num-1)/3][(num-1)%3] = @turn[@pos]  #指定された場所に〇または×を置く
        $pos_c = @pos
        @pos = (@pos+1)%2  #先手(後手)→後手(先手)に変更
        @count -= 1
      elsif input > 9  #正しくない場所を入力したら
        print "正しくない場所を入力しました\n"
        break
      end
    end
  end

  def m_x (j, i, mark)  #探索用関数
    if @table[j][i] == @turn[$pos_c]
      mark += 1
    end
      return mark
  end

  #3つ並んでいるか探索
  def search ()
    mark_x = 0 #横
    mark_y = 0 #縦
    mark_xy = 0 #右下斜め
    mark_yx = 0 #左下斜め
    if @table[0][0] == @turn[$pos_c] then  #起点
      mark_x += 1
      mark_y += 1
      mark_xy += 1
      for i in 1..2 do
        mark_x = m_x(0, i, mark_x)  #横
        mark_y = m_x(i, 0, mark_y)  #縦
        mark_xy = m_x(i, i, mark_xy)  #斜め
        if mark_x >= 3 || mark_y >= 3 || mark_xy >= 3 then
          return true
        end
      end
    elsif @table[0][1] ==  @turn[$pos_c] then  #起点
      mark_y += 1
      for i in 1..2 do
        mark_y = m_x(i, 1, mark_y)  #縦
        if mark_y >= 3 then
          return true
        end
      end
    elsif @table[0][2] ==  @turn[$pos_c] then  #起点
      mark_y += 1
      mark_yx += 1
      for i in 1..2 do
        mark_y = m_x(i, 2, mark_y)  #縦
        if mark_y >= 3 then
          return true
        end
      end
      mark_yx = m_x(1, 1, mark_yx)  #斜め
      mark_yx = m_x(2, 0, mark_yx)  #斜め
      if mark_yx >= 3 then
        return true
      end
    elsif @table[1][0] ==  @turn[$pos_c] then  #起点
      mark_x += 1
      for i in 1..2 do
        mark_x = m_x(1, i, mark_x)  #横
        if mark_x >= 3 then
          return true
        end
      end
    elsif @table[2][0] ==  @turn[$pos_c] then  #起点
      mark_x += 1
      for i in 1..2 do
        mark_x = m_x(2, i, mark_x)  #横
        if mark_x >= 3 then
          return true
        end
      end
    end
  end

  #対戦終了
  def count () #碁盤がすべて埋まったか
    if @count == 0 then 
      return true
    end
  end

  def draw () #引き分け用
    print "\n---------試合終了---------\n"
    print "引き分けです\n"
  end

  def finish () #どちらかが勝ったとき
    if @count > 0 then
      print "\n---------試合終了---------\n"

      if $pos_c == 0 then 
        print "先手の勝ちです!\n"
      elsif $pos_c == 1 then
        print "後手の勝ちです!\n"
      end
    end
  end
end

#main
print "〇×ゲームを始めます\n"
print "---------試合開始---------\n"
exe = Exe.new(table, turn, pos, count)

#1回の対局動作をループ
while true do
  exe.board
  print "場所を入力してください＞"
  input = gets.to_i  #場所の入力(数値)
  if exe.isLeagal(input) == true then  #合法手か調べる
    break
  end
  if exe.search() == true || exe.count then
    break
  end
end

#試合終了後の処理
exe.board
if exe.count == true then
  exe.draw
else
  exe.finish
end