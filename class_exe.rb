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
  def legal? (input)
    num = 0
    for num in 1..9 do
      if input == num then  #正しい場所を入力したら
        if @table[(num-1)/3][(num-1)%3] == @turn[@pos] || @table[(num-1)/3][(num-1)%3] == @turn[(@pos+1)%2] then  #指定した場所にすでに置かれていたら
          print "指定された場所はすでに置かれています\n"
          break
        else
          @table[(num-1)/3][(num-1)%3] = @turn[@pos]  #指定された場所に〇または×を置く
          $pos_c = @pos
          @pos = (@pos+1)%2  #先手(後手)→後手(先手)に変更
          @count -= 1
        end
      elsif input > 9  || input < 1 #正しくない場所を入力したら
        print "正しくない場所を入力しました\n"
        break
      end
    end
  end

  #探索用関数
  def m_x (j, i, mark)
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
    end
    if @table[0][1] ==  @turn[$pos_c] then  #起点
      mark_y = 0
      mark_y += 1
      for i in 1..2 do
        mark_y = m_x(i, 1, mark_y)  #縦
        if mark_y >= 3 then
          return true
        end
      end
    end
    if @table[0][2] ==  @turn[$pos_c] then  #起点
      mark_y = 0
      mark_y += 1
      mark_yx += 1
      for i in 1..2 do
        mark_y = m_x(i, 2, mark_y)  #縦
        mark_yx = m_x(i, 2-i, mark_yx)  #斜め
        if mark_y >= 3 || mark_yx >= 3 then
          return true
        end
      end
    end
    if @table[1][0] ==  @turn[$pos_c] then  #起点
      mark_x = 0
      mark_x += 1
      for i in 1..2 do
        mark_x = m_x(1, i, mark_x)  #横
        if mark_x >= 3 then
          return true
        end
      end
    end
    if @table[2][0] ==  @turn[$pos_c] then  #起点
      mark_x = 0
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