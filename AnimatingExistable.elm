module AnimatingExistable exposing (AnimatingExistable(..), update, init, Msg)

import Task
import Process


type AnimatingExistable a
    = Enter a
    | Present a
    | Leave a
    | Gone


type Msg
    = Transition


update : Msg -> AnimatingExistable a -> ( AnimatingExistable a, Cmd msg )
update msg thing =
    case Debug.log "aemsg" msg of
        Transition ->
            let
                newThing =
                    case thing of
                        Enter a ->
                            Present a

                        Present a ->
                            Leave a

                        Leave a ->
                            Gone

                        Gone ->
                            Gone
            in
                newThing ! []


init : AnimatingExistable a -> Cmd Msg
init thing =
    Task.perform
        (always Transition)
        (always Transition)
        (Process.sleep 1000)
