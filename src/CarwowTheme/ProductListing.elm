module CarwowTheme.ProductListing exposing (featuredView, condensedView, ProductListing, ListingType(..), SupplierType(..), OptionProperties)

{-| ProductListing


# Exports

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import CarwowTheme.Icons exposing (icon)


type ListingType
    = Condensed
    | Featured
    | Grouped
    | Leasing
    | Stock

type SupplierType
    = Broker
    | Dealer

type alias PricingProperties =
    { firstPart : String
    , secondPart : String
    , topText: String
    , bottomText: String
    }

type alias OptionProperties =
    { name : String
    , value : String
    , icon : String
    }

type alias DealerProperties =
    { distance : String
    , name: String
    , supplier: SupplierType
    }

type alias ProductListing =
    { image: String
    , make : String
    , model : String
    , derivativeName : String
    , options: List OptionProperties
    , price : PricingProperties
    , dealer: DealerProperties
    , coloursAvailable: String
    }


condensedView : ProductListing -> Html msg
condensedView productDetails =
    div [ class "product-listing" ]
    [ div [ class "product-listing__main-characteristics" ]
        [ pricePartialView productDetails.price
        ]
    , div [ class "product-listing__information-container" ]
        [ dealerPartialView productDetails.dealer
        , div [ class "product-enquiry-cta-container" ]
            [ div [ class "product-enquiry-cta--dealer" ]
                [ label [ class "btn btn-short btn-action"]
                    [ text "Call dealer" ]
                ]
            , div [ class "product-enquiry-cta--message" ]
                [ a [ class "btn btn-short" ]
                    [ text "Message" ]
                ]
            ]
        ]
    ]


dealerPartialView : DealerProperties -> Html msg
dealerPartialView dealer =
    div [ class "product-listing__information-items" ]
            [ div [ class "product-dealer-container" ]
                [ div [ class "product-dealer__name" ]
                    [ label [ class "product-dealer__link" ]
                        [ text dealer.name ]
                    , text " - "
                    ,span [ class "product-dealer__status" ]
                        [ text (supplierType dealer.supplier)
                        ]
                    ]
                , div [ class "product-dealer__location" ]
                    [ icon "location" { size = "small", colour = "dark-grey", colouring = "outline" }
                    , span [ class "product-dealer__location-text" ]
                        [ text dealer.distance ]
                    ]
                ]
            ]

pricePartialView : PricingProperties -> Html msg
pricePartialView price =
    div [ class "product-listing__price--condensed" ]
        [ span [ class "product-price__amount-copy" ]
            [ text price.topText]
        , strong [ class "product-price__amount-price" ]
            [ text price.firstPart
            , span [ class "product-price__amount-price-decimal" ]
                [ text ("." ++ price.secondPart) ]
            ]
        , ul [ class "product-price__additional-info-list" ]
            [ li [ class "product-price__additional-info-list-item product-price__additional-info-list-item--saving" ]
                [ text price.bottomText
                ]
            ]
        ]

supplierType : SupplierType -> String
supplierType supplier =
    case supplier of
        Broker ->
            "Broker"
        Dealer ->
            "Dealer"


{-| Properties for the pagination component
-}
featuredView : ProductListing -> Html msg
featuredView details =
    div [ class "product-listing" ]
        [ div [ class "product-listing__ribbon" ]
            [ span [ class "product-listing__ribbon-text product-listing__ribbon-text--green" ]
                [ text "Featured deal" ]
            ]
        , div [ class "product-listing__main-characteristics" ]
            [ figure [ class "product-image-container product-image-container--featured" ]
                [ img [ class "product-image", src details.image ]
                    []
                ]
            , div [ class "product-listing__details" ]
                [ div [ class "product-details-container" ]
                    [ figcaption [ class "product-details" ]
                        [ div [ class "product-details__title product-details__title--featured" ]
                            [ span [ class "product-title__part" ]
                                [ text (details.make ++ " ") ]
                            , span [ class "product-title__part" ]
                                [ text details.model ]
                            , span [ class "product-title__part" ]
                                [ text details.derivativeName ]

                            ]
                        , div [ class "product-colours" ]
                            [ icon "brush" { size = "small", colour = "black", colouring = "outline" }
                            , label [ class "product-colours__link product-colours__link" ]
                                [ text details.coloursAvailable ]
                            ]
                        , ul [ class "product-details__specifications-list product-details__specifications-list--leasing" ]
                            ((details.options)
                                |> List.map
                                    (\option ->
                                        li [ class "product-details__options-list-item" ]
                                            [ icon option.icon { size = "small", colour = "black", colouring = "outline" }
                                            , span [ class "product-details__options-list-item-text" ]
                                                [ text option.value ]
                                            ]
                                    )
                            )
                        ]
                    ]
                ]
            , div [ class "product-listing__price--featured" ]
                [ span [ class "product-price__amount-copy" ]
                    [ text  details.price.topText ]
                , strong [ class "product-price__amount-price" ]
                    [ text details.price.firstPart
                    , span [ class "product-price__amount-price-decimal" ]
                        [ text ("." ++ details.price.secondPart) ]
                    ]
                , ul [ class "product-price__additional-info-list" ]
                    [ li [ class "product-price__additional-info-list-item product-price__additional-info-list-item--saving" ]
                        [ text details.price.bottomText
                        ]
                    ]
                ]
            ]
        , div [ class "product-listing__information-container" ]
            [ div [ class "product-listing__information-items" ]
                [ dealerPartialView details.dealer
                ]
            , div [ class "product-enquiry-cta-container" ]
                [ div [ class "product-enquiry-cta--dealer" ]
                    [ label [ class "btn btn-short btn-action" ]
                        [ text "Call dealer" ]
                    ]
                , div [ class "product-enquiry-cta--message" ]
                    [ a [ class "btn btn-short" ]
                        [ text "Message" ]
                    ]
                ]
            ]
        ]