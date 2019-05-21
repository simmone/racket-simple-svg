#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/circle.rkt"))

@title{Circle}

define a circle.

@defproc[(svg-circle-def
          [radius natural?]
        )
        string?]{
  define a circle by radius length.
}

@section{circle}

@codeblock{
(let ([circle (svg-circle-def 50)])
  (svg-use circle #:at? '(50 . 50) #:fill? "#ED6E46")
  (svg-show-default))
}

@image{showcase/shapes/circle/circle.svg}

@codeblock{
(let ([circle (svg-circle-def 50)])
  (svg-use circle #:at? '(50 . 50) #:fill? "red")
  (svg-use circle #:at? '(150 . 50) #:fill? "yellow")
  (svg-use circle #:at? '(50 . 150) #:fill? "blue")
  (svg-use circle #:at? '(150 . 150) #:fill? "green")
  (svg-show-default))
}

@image{showcase/shapes/circle/circle3.svg}
