#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/polyline.rkt"))

@title{Polyline}

draw a polyline.

@defproc[(polyline
          [points (listof pair?)]
          [stroke_fill string?]
          [stroke_width natural?]
          [fill string?]
        )
        void?]{
  draw a polyline by points list.
}

@section{polyline}

@codeblock{
  (polyline 
    '((0 . 40) (40 . 40) (40 . 80) (80 . 80) (80 . 120) (120 . 120) (120 . 160))
    "#BBC42A" 6 "blue")
}

@image{showcase/shapes/polyline/polyline.svg}

