#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/circle.rkt"))

@title{Circle}

draw a circle.

@defproc[(circle
          [center_point (cons/c natural? natural?)]
          [radius natural?]
          [fill string?]
        )
        void?]{
  draw a circle by center_point: '(x . y) and radius length.
}

@section{circle}

@codeblock{
  (circle '(100 . 100) 50 "#ED6E46")
}

@image{showcase/shapes/circle/circle.svg}

