module NoUnused.CustomTypeConstructorArgsTest exposing (all)

import NoUnused.CustomTypeConstructorArgs exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "REPLACEME"


details : List String
details =
    [ "REPLACEME" ]


all : Test
all =
    describe "NoUnused.CustomTypeConstructorArgs"
        [ test "should report an error when custom type constructor argument is never used" <|
            \() ->
                """module A exposing (..)
type CustomType
  = B B_Data

b = B ()

something =
  case foo of
    B _ -> ()
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "B_Data"
                            }
                        ]
        ]
