module Main

import Web.MVC

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

display : Ev -> St -> Cmd Ev
display Init _ = batch
  [ attr btn $ onClick Toggle
  , attr checkbox $ onChecked $ const Toggle
  ]
display Toggle s = batch
  [ attr checkbox $ checked s
  , child div $ Text $ show s
  ]

covering
main : IO ()
main = runMVC update display (putStrLn . dispErr) Init False
