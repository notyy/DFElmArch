import Signal exposing (..)
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import NewCounterPair exposing (..)

type alias Model = { topCounterState: State, bottomCounterState: State }

view : (Signal.Address Action, Signal.Address Action) -> Signal.Address ResetAction -> State -> State -> Html
view (counter1, counter2) resetAddress topCounterState bottomCounterState = div []
  [
    div []
      [ button [ onClick counter1 Decrement ] [ text "-" ]
      , div [ countStyle ] [ text (toString topCounterState) ]
      , button [ onClick counter1 Increment ] [ text "+" ]
      ],
    div []
      [ button [ onClick counter2 Decrement ] [ text "-" ]
      , div [ countStyle ] [ text (toString bottomCounterState) ]
      , button [ onClick counter2 Increment ] [ text "+" ]
      ],
    button [ onClick resetAddress {address = [counter1, counter2]}] [ text "RESET" ]
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

resetMailbox : Signal.Mailbox ResetAction
resetMailbox = Signal.mailbox {address = []}

topCounterMailbox : Signal.Mailbox Action
topCounterMailbox = Signal.mailbox NewCounterPair.Nop

bottomCounterMailbox : Signal.Mailbox Action
bottomCounterMailbox = Signal.mailbox NewCounterPair.Nop

main : Signal Html
main = Signal.map2
          (view (topCounterMailbox.address, bottomCounterMailbox.address) resetMailbox.address)
          (NewCounterPair.counterComp 0 topCounterMailbox.signal) (NewCounterPair.counterComp 0 bottomCounterMailbox.signal)
