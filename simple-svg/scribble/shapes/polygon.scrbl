#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/polygon.rkt"))

@title{Polygon}

draw a polygon.

@defproc[(polygon
          [points (listof pair?)]
          [fill string?]
        )
        void?]{
  draw a polygon by points list and fill.
}

@section{polygon}

@codeblock{
  (polygon 
    ((50 . 5) (100 . 5) (125 . 30) (125 . 80) (100 . 105) (50 . 105) (25 . 80) (25 . 30))
    "#ED6E46")
}

@image{showcase/shapes/polygon/polygon.svg}

