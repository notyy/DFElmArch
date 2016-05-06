module NewCounter where

import Signal

type Action = Increment | Decrement | Nop

type alias State = Int

counterComp : State -> Signal Action -> Signal State
counterComp = Signal.foldp process

process : Action -> State -> State
process action state =
  case action of
    Increment -> state + 1
    Decrement -> state - 1
    Nop -> state
