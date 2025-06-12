module Main (main) where

import Universe.World (world)

main :: IO ()
main = do
  putStrLn $ "Hello, " <> world <> "!!!"
