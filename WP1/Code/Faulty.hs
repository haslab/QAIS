
module Faulty where

import Data.List
import Probability
import Qais
import Cp

--- Variants of fault-injected addition

x += y = D [(0,0.05),(x+y,0.95)]
x +. y = D [(y,0.1),(x+y,0.9)] -- this is fadd5 in Matlab
x .+ y = D [(x,0.1),(x+y,0.9)] -- this is fadd1 in Matlab
x .+. y = mynormal (x+y) where mynormal n = normal [n-n `div` 2..n+n `div` 2]

fadd1 :: Int -> Int -> Dist Int
fadd1 x y = D[(x+y,0.9),(x,0.1)]

fadd2 :: Int -> Int -> Dist Int
fadd2 x y = D[(x+y,0.8),(x,0.1),(y,0.1)]

fadd3 :: Int -> Int -> Dist Int
fadd3 x y = uniform [x,y] --- fadd3 x y = D[(x,0.5),(y,0.5)]

fadd4 :: Int -> Int -> Dist Int
fadd4 x y = uniform [x+y,x,y]

-- a faulty succ: does nothing with probability q
fsucc :: (Enum a) => ProbRep -> a -> Dist a
fsucc q = schoice q id succ

-- faulty (2+)
fp2 q = (fsucc q) .! (fsucc q)

-- a faulty add : yields 0 with probability q
fadd_old p a x = choose p 0 (a+x)

-- as in the paper
fadd p x = schoice p id (x+)

-- faulty id on lists: skips elements with probability p
-- cf lossy channels 
fid p = mfoldr (fcons p) [] where
          fcons p = curry (schoice p lose send)
          lose = p2
          send = uncurry(:)

-- faulty length: skips count with probability p
flength p = mfoldr (fcount p) 0 where
            fcount p = curry (fsucc p . p2)

-- faulty length: resets counter with probability p
fstoplength p = mfoldr (fcount p) 0 where
            fcount p = curry ((schoice p (const 0) succ) . p2)

-- Example: cata-absorption
-- counting data from a lossy channel is the same as a faulty counter on a perfect channel:
-- (((return.length) .! (fid 0.05))  "abcde") == (flength 0.05 "abcde")

