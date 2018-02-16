module CarwowTheme.ProductListing exposing (featuredView, condensedView, groupedLeaseDealView, GroupedLeaseDealListing, ProductListing, OptionProperties)

{-| ProductListing


# Exports

@docs featuredView, condensedView, ProductListing, OptionProperties

-}

import Erl exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import CarwowTheme.Icons exposing (icon)


type alias PricingProperties =
    { firstPart : String
    , secondPart : String
    , topText : String
    , bottomText : String
    }

{-| Placeholder
-}
type alias OptionProperties =
    { name : String
    , value : String
    , icon : String
    }


type alias DealerProperties =
    { distance : String
    , name : String
    , supplier : String
    }

{-| Placeholder
-}
type alias ProductListing =
    { id : Int
    , image : Maybe String
    , make : String
    , model : String
    , derivativeName : String
    , options : List OptionProperties
    , price : PricingProperties
    , dealer : DealerProperties
    }


{-| Placeholder
-}
type alias GroupedLeaseDealListing =
    { makeName : String
    , makeSlug : String
    , monthlyRentalPounds : String
    , monthlyRentalPennies : String
    , includesVAT : Bool
    , modelName: String
    , modelSlug: String
    , thumbnailUrl: Maybe String
    , pricingPeriod: String
    }


{-| Placeholder
-}
groupedLeaseDealView : GroupedLeaseDealListing -> String -> Html msg -> List (Html msg) -> Html msg
groupedLeaseDealView groupedLeaseDeal url groupedDealCtaView groupedDealVATCopy =
    div [ class "product-listing product-listing--grouped" ]
    [ figure [ class "product-image-container product-image-container--grouped" ]
        [ a [ attribute "data-interaction" "styleguide_data_attribute", href url ]
            [ renderThumbnail groupedLeaseDeal.thumbnailUrl
            ]
        ]
    , div [ class "product-listing__main-characteristics" ]
        [ div [ class "product-listing__details" ]
            [ div [ class "product-details-container" ]
                [ figcaption [ class "product-details" ]
                    [ div [ class "product-details__title product-details__title--grouped" ]
                        [ a [ href url ]
                            [ span [ class "product-title__part" ]
                                [ text groupedLeaseDeal.makeName ]
                            , span [ class "product-title__part" ]
                                [ text groupedLeaseDeal.modelName ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "product-listing__price--grouped" ]
            [ span [ class "product-price__amount-copy" ]
                [ text "From" ]
            , strong [ class "product-price__amount-price" ]
                [ text groupedLeaseDeal.monthlyRentalPounds
                , span [ class "product-price__amount-price-decimal" ]
                    [ text groupedLeaseDeal.monthlyRentalPennies ]
                , span [ class "product-price__amount-price-text" ]
                    [ text groupedLeaseDeal.pricingPeriod ]
                ]
            , ul [ class "product-price__additional-info-list" ]
                [ li [ class "product-price__additional-info-list-item product-price__additional-info-list-item--saving" ]
                    groupedDealVATCopy
                ]
            ]
        ]
    , div [ class "product-enquiry-grouped-container" ]
        [ groupedDealCtaView ]
    ]


{-| Placeholder
-}
condensedView : ProductListing -> Html msg -> Html msg
condensedView productDetails ctaContent =
    div [ class "product-listing" ]
        [ div [ class "product-listing__main-characteristics" ]
            [ pricePartialView productDetails.price
            ]
        , div [ class "product-listing__information-container" ]
            [ dealerPartialView productDetails.dealer
            , ctaContent
            ]
        ]


renderThumbnail : Maybe String -> Html msg
renderThumbnail imageUrl =
    case imageUrl of
        Just image ->
            img [ class "product-image", src image ]
                []

        Nothing ->
            div [ class "product-image--empty" ]
                [ icon "location" { size = "x-large", colour = "light-grey", colouring = "outline" }
                ]

{-| Placeholder
-}
featuredView : ProductListing -> Html msg -> Html msg -> Html msg
featuredView details ctaContent availableColoursCta =
    div [ class "product-listing" ]
        [ div [ class "product-listing__ribbon" ]
            [ span [ class "product-listing__ribbon-text product-listing__ribbon-text--yellow" ]
                [ text "Your best price" ]
            ]
        , div [ class "product-listing__main-characteristics" ]
            [ figure [ class "product-image-container product-image-container--featured" ]
                [ renderThumbnail details.image
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
                        , availableColoursCta
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
                    [ text details.price.topText ]
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
            , ctaContent
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
                , span [ class "product-dealer__status" ]
                    [ text dealer.supplier
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
            [ text price.topText ]
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
