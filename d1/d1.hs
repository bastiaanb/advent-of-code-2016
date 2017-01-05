input = ["R4", "R4", "L1", "R3", "L5", "R2", "R5", "R1", "L4", "R3", "L5", "R2", "L3", "L4", "L3", "R1", "R5", "R1", "L3", "L1", "R3", "L1", "R2", "R2", "L2", "R5", "L3", "L4", "R4", "R4", "R2", "L4", "L1", "R5", "L1", "L4", "R4", "L1", "R1", "L2", "R5", "L2", "L3", "R2", "R1", "L194", "R2", "L4", "R49", "R1", "R3", "L5", "L4", "L1", "R4", "R2", "R1", "L5", "R3", "L5", "L4", "R4", "R4", "L2", "L3", "R78", "L5", "R4", "R191", "R4", "R3", "R1", "L2", "R1", "R3", "L1", "R3", "R4", "R2", "L2", "R1", "R4", "L5", "R2", "L2", "L4", "L2", "R1", "R2", "L3", "R5", "R2", "L3", "L3", "R3", "L1", "L1", "R5", "L4", "L4", "L2", "R5", "R1", "R4", "L3", "L5", "L4", "R5", "L4", "R5", "R4", "L3", "L2", "L5", "R4", "R3", "L3", "R1", "L5", "R5", "R1", "L3", "R2", "L5", "R5", "L3", "R1", "R4", "L5", "R4", "R2", "R3", "L4", "L5", "R3", "R4", "L5", "L5", "R4", "L4", "L4", "R1", "R5", "R3", "L1", "L4", "L3", "L4", "R1", "L5", "L1", "R2", "R2", "R4", "R4", "L5", "R4", "R1", "L1", "L1", "L3", "L5", "L2", "R4", "L3", "L5", "L4", "L1", "R3"]

step pos dir vis 0 = (pos, dir, vis)
step pos dir vis l = step newPos dir (vis ++ [newPos]) (l - 1) where newPos = pos `move` dir

turnAndMove (pos, dir, vis) (t:l) = step pos newDir vis (read l :: Int) where newDir = (turn t dir)

move [px, py] [ dx, dy ] = [ px + dx, py + dy ]

turn 'L' [x, y] = [ y, -x ]
turn 'R' [x, y] = [ -y, x ]

distance [x, y] = abs x + abs y

visited (_, _, vis) = vis
position (pos, _, _) = pos

firstDuplicate [] = []
firstDuplicate (x:xs) = if x `elem` xs then x else firstDuplicate xs

walk = foldl turnAndMove ([0, 0], [1, 0], [[0, 0]]) input

main = do
  print $ distance $ position walk
  print $ distance $ firstDuplicate $ visited walk
