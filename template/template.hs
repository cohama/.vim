:%s!MODULE_NAME!\=expand('%:r:s?src/??:gs?/?.?')!
module MODULE_NAME
( main
)
where

main :: IO ()
main = do
    putStrLn "hello, world"
