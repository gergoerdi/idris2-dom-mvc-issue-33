module Main

import Web.MVC
import Web.MVC.Util
import Web.Html

%default total

data Ev : Type where
  Init : Ev
  Toggle : Ev

0 St : Type
St = Bool

update : Ev -> St -> St
update Init = id
update Toggle = not

btn : Ref Tag.Button
btn = Id "button"

checkbox : Ref Tag.Input
checkbox = Id "checkbox"

div : Ref Tag.Div
div = Id "main"

checked : Ref Tag.Input -> Bool -> Cmd ev
checked r b = C $ \h => castElementByRef r >>= (HTMLInputElement.checked =. b)

display : Ev -> St -> Cmd Ev
display Init _ = batch
  [ attr btn $ onClick Toggle
  , attr checkbox $ onChecked $ const Toggle
  ]
display Toggle s = batch
  [ checked checkbox s
  , child div $ Text $ show s
  ]

covering
main : IO ()
main = runMVC update display (putStrLn . dispErr) Init False
