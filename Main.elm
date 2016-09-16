module Main exposing (..)

import Html exposing (Html, text)
import Html.App exposing (program)
import AnimatingExistable exposing (AnimatingExistable(..), update)


type alias Model =
    { thing : AnimatingExistable String }


initialModel : Model
initialModel =
    { thing = Enter "sandman"
    }


type Msg
    = AnimatingExistable' AnimatingExistable.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimatingExistable' aeMsg ->
            let
                ( newThing, aeCmd ) =
                    AnimatingExistable.update aeMsg model.thing
            in
                { model | thing = newThing } ! [ aeCmd ]


main =
    let
        model =
            initialModel
    in
        program
            { init = model ! [ Cmd.map AnimatingExistable' <| AnimatingExistable.init model.thing ]
            , update = update
            , view = view
            , subscriptions = always Sub.none
            }


view : Model -> Html msg
view model =
    case model.thing of
        Enter str ->
            text <| "Enter: " ++ str

        Present str ->
            text <| "Present: " ++ str

        Leave str ->
            text <| "Leave: " ++ str

        Gone ->
            text "gone"
