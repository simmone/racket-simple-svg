#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/polyline.rkt"))

@title{Polyline}

draw a polyline.

@defproc[(svg-polyline-def
          [points (listof (cons/c natural? natural?))]
        )
        string?]{
  draw a polyline by points list.
}

@section{polyline}

@codeblock{
(let ([polyline
  (svg-polyline-def
    '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))])
  (svg-use polyline #:stroke? '(5 . "#BBC42A") #:fill? "blue")
  (svg-show-default))
}

@image{showcase/shapes/polyline/polyline.svg}

