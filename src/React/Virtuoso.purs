module React.Virtuoso
  ( Components
  , FollowOutput
  , ListRange
  , ScrollSeekConfiguration
  , ScrollerRef
  , VirtuosoInstance
  , components
  , followOutputAuto
  , followOutputFalse
  , followOutputSmooth
  , followOutputTrue
  , scrollToIndex
  , scrollerRefToHTMLElement
  , scrollerRefToWindow
  , virtuoso
  , virtuosoImpl
  ) where

import Data.Function.Uncurried (Fn2, Fn3)
import Data.Maybe (Maybe(..))
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, runEffectFn1, runEffectFn2)
import Prim.Row (class Union)
import React.Basic (JSX, ReactComponent)
import React.Basic.Hooks (ReactChildren)
import React.Basic as React
import React.Basic.DOM (CSS)
import Unsafe.Coerce (unsafeCoerce)
import Web.HTML (HTMLElement, Window)

foreign import virtuosoImpl ∷ ∀ p. ReactComponent p

foreign import data VirtuosoInstance :: Type

scrollToIndex :: { smooth :: Boolean } -> Int -> VirtuosoInstance -> Effect Unit
scrollToIndex options idx inst =
  runEffectFn2 (unsafeCoerce inst).scrollToIndex idx options

type VirtuosoProps ctx item =
  ( style ∷ CSS
  , data ∷ Array item
  , endReached ∷ EffectFn1 Int Unit
  , initialTopMostItemIndex :: Int
  , alignToBottom :: Boolean
  , atBottomStateChange :: EffectFn1 Boolean Unit
  , atBottomThreshold :: Int
  , atTopStateChange :: EffectFn1 Boolean Unit
  , atTopThreshold :: Int
  , components :: Components ctx
  -- , computeItemKey
  , context :: ctx
  , customScrollParent :: HTMLElement
  , defaultItemHeight :: Number
  , endReached :: EffectFn1 Int Unit
  , firstItemIndex :: Int
  , fixedItemHeight :: Number
  , followOutput :: FollowOutput
  , headerFooterTag :: String
  , increaseViewportBy :: { bottom :: Number, top :: Number }
  , initialItemCount :: Int
  , initialScrollTop :: Number
  -- , initialTopMostItemIndex::
  , isScrolling :: EffectFn1 Boolean Unit
  , itemContent ∷ Fn3 Int item ctx JSX
  , itemSize ∷ EffectFn2 HTMLElement String Number
  , itemsRendered :: EffectFn1 (Array { data :: item }) Unit
  , overscan :: { main :: Number, reverse :: Number }
  , rangeChanged :: EffectFn1 ListRange Unit
  , scrollSeekConfiguration :: ScrollSeekConfiguration
  , scrollerRef :: EffectFn1 ScrollerRef Unit
  , startReached :: EffectFn1 Int Unit
  , topItemCount :: Int
  , totalCount :: Int
  , totalListHeightChanged :: EffectFn1 Number Unit
  , useWindowScroll ∷ Boolean
  )

foreign import data Components :: Type -> Type

type AllComponents ctx =
  ( "EmptyPlaceholder" :: ReactComponent { context :: ctx }
  , "Footer" :: ReactComponent { context :: ctx }
  , "Group" :: ReactComponent { style :: CSS, children :: ReactChildren JSX, context :: ctx }
  , "Header" :: ReactComponent { context :: ctx }
  , "Item" :: ReactComponent { context :: ctx }
  )

components :: forall ctx r r_. Union r r_ (AllComponents ctx) => { | r } -> Components ctx
components = unsafeCoerce

type ScrollSeekConfiguration =
  { change :: EffectFn2 Number ListRange Unit
  , enter :: EffectFn2 Number ListRange Boolean
  , exit :: EffectFn2 Number ListRange Boolean
  }

foreign import data ScrollerRef :: Type
foreign import scrollerRefToWindowImpl :: forall a. (a -> Maybe a) -> (Maybe a) -> ScrollerRef -> Effect (Maybe Window)

scrollerRefToWindow ∷ ScrollerRef → Effect (Maybe Window)
scrollerRefToWindow = scrollerRefToWindowImpl Just Nothing

foreign import scrollerRefToHTMLElementImpl :: forall a. (a -> Maybe a) -> (Maybe a) -> ScrollerRef -> Effect (Maybe HTMLElement)

scrollerRefToHTMLElement ∷ ScrollerRef → Effect (Maybe Window)
scrollerRefToHTMLElement = scrollerRefToWindowImpl Just Nothing

type ListRange = { startIndex :: Int, endIndex :: Int }

foreign import data FollowOutput :: Type

followOutputTrue :: FollowOutput
followOutputTrue = unsafeCoerce true

followOutputFalse :: FollowOutput
followOutputFalse = unsafeCoerce false

followOutputSmooth :: FollowOutput
followOutputSmooth = unsafeCoerce "smooth"

followOutputAuto :: FollowOutput
followOutputAuto = unsafeCoerce "auto"

virtuoso
  ∷ ∀ item ctx p p_
  . Union p p_ (VirtuosoProps ctx item)
  ⇒ ReactComponent
      { data ∷ Array item
      | p
      }
virtuoso = virtuosoImpl
