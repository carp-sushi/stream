module Main (main) where

import Control.Monad.Par
import Par.Stream

-- Calculate the n-th Fibonacci number using 0 to handle negatives.
fib :: Integer -> Integer
fib n
    | n <= 0 = 0
    | n == 1 = 1
    | otherwise = fib (n - 1) + fib (n - 2)

-- Use streams to calculate the sum of fibonacci numbers
pipeline :: Int -> [Integer] -> Integer
pipeline n xs =
    runPar $ do
        s0 <- streamFromList n xs -- emit list in batches of size `n`
        s1 <- streamFilter even (n `div` 2) s0 -- emit even numbers + halve batch size
        s2 <- streamMap fib n s1 -- calc fib number
        sm <- streamFold (+) 0 s2 -- streaming sum
        return sm

-- Calculate and print the sum of some even Fibonacci numbers.
main :: IO ()
main = do
    putStrLn $ show (pipeline 10 [1 .. 38])
