import Signal exposing (..)
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import NewCounter exposing (..)

view : Signal.Address Action -> State -> Html
view address state = div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString state) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]

countStyle : Attribute
countStyle =
  style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]

mailbox : Signal.Mailbox Action
mailbox = Signal.mailbox NewCounter.Nop

main : Signal Html
main = Signal.map (view mailbox.address) (NewCounter.counterComp 0 mailbox.signal)
