#〇×ゲーム
side = 3  #一辺の長さ

print "〇×ゲームを始めます\n\n"

#碁盤の作成
for i in 1..9 do
  print " #{i} |"
  if (i%3) == 0 then
    print "\n"
    for j in 1..3 do
        print "---+"
    end
    print "\n"
  end
end