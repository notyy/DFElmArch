module NewCounterPair where

import Signal
import List exposing (..)
import Task

type Action = Init | Increment | Decrement | Nop

type alias State = Int

counterComp : State -> Signal Action -> Signal State
counterComp = Signal.foldp process

process : Action -> State -> State
process action state =
  case action of
    Init -> 0
    Increment -> state + 1
    Decrement -> state - 1
    Nop -> state

type alias ResetAction = { address : List (Signal.Address Action)}

resetComp : Signal ResetAction -> Signal (List (Task.Task x ()))
resetComp resetAction = Signal.map (\rsa -> reset rsa.address) resetAction

reset : List (Signal.Address Action) -> List (Task.Task x ())
reset addresses = map (\addr -> Signal.send addr Init) addresses
