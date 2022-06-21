module React.Virtuoso (virtuosoImpl, virtuosoWithData, virtuosoWithCount) where

import Data.Function.Uncurried (Fn2)
import Data.Unit (Unit)
import Effect.Uncurried (EffectFn1)
import Prim.Row (class Union)
import React.Basic (JSX, ReactComponent)
import React.Basic.DOM (CSS)

foreign import virtuosoImpl ∷ ∀ p. ReactComponent p

type VirtuosoPropsWithTotalCount
  = ( style ∷ CSS
    , totalCount ∷ Int
    , itemContent ∷ Int → JSX
    , useWindowScroll ∷ Boolean
    )

type VirtuosoPropsWithData a
  = ( style ∷ CSS
    , data ∷ Array a
    , itemContent ∷ Fn2 Int a JSX
    , useWindowScroll ∷ Boolean
    , endReached ∷ EffectFn1 Int Unit
    )

virtuosoWithCount ∷
  ∀ p p_.
  Union p p_ VirtuosoPropsWithTotalCount ⇒
  ReactComponent
    { totalCount ∷ Int
    , itemContent ∷ Int → JSX
    | p
    }
virtuosoWithCount = virtuosoImpl

virtuosoWithData ∷
  ∀ item p p_.
  Union p p_ (VirtuosoPropsWithData item) ⇒
  ReactComponent
    { data ∷ Array item
    , itemContent ∷ Fn2 Int item JSX
    | p
    }
virtuosoWithData = virtuosoImpl
