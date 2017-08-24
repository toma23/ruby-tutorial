#encoding: utf-8

side = 3  #一辺の長さ
turn = ["o", "x"]  #先手，後手のマーク
pos = 1

#碁盤の作成
arr = [1, 2, 3,
       4, 5, 6,
       7, 8, 9]

=begin
class Exe 
  def initialize(arr)
    @arr = arr
  end
  
  def board ()
    for i in 0..8 do
      print " #{arr[i]} |"
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
      if input == num then
        arr[num-1] = turn[pos]
        pos = !pos
      end
    end
  end
end
=end

class Exe
  def initialize(table=Array.new)
    @table = table
  end

  def board ()
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
end

print "〇×ゲームを始めます\n\n"
exe = Exe.new(arr)
print "#{exe.board}"
print "場所を入力してください＞"
input = gets.to_i  #場所の入力(数値)