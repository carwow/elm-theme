port module CarwowTheme.ModalPorts exposing (fixScroll)

{-| Ports used by modals to apply side effects outside of the current elm app.


# Fix/liberate body scroll

@docs fixScroll

-}


{-| Port to fix/liberate main body scroll when the modal is opened.
-}
port fixScroll : Bool -> Cmd msg
