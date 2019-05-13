#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/circle.rkt"))

@title{Circle}

draw a circle.

@defproc[(svg-circle-def
          [center_point (cons/c natural? natural?)]
          [radius natural?]
        )
        void?]{

  draw a circle by center_point: '(x . y) and radius length.

}

@section{circle}

@codeblock{
  (let ([circle (svg-circle-def '(100 . 100) 50)])
    (svg-use circle #:fill? "#ED6E46")
    (svg-show-default))
}

@image{showcase/shapes/circle/circle.svg}

