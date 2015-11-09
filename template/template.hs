:%s!MODULE_NAME!\=expand('%:r:s?src/??:gs?/?.?')!
module MODULE_NAME
(

)
where

main :: IO ()
main = do
    putStrLn "hello, world"
