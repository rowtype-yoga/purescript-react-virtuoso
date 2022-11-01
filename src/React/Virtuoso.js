import { Virtuoso } from "react-virtuoso"
export const virtuosoImpl = Virtuoso;

export const scrollerRefToWindowImpl = just => nothing => ref => () =>
  (ref instanceof Window) ? just(ref) : nothing

export const scrollerRefToHTMLElementImpl = just => nothing => ref => () =>
  (ref instanceof HTMLElement) ? just(ref) : nothing
