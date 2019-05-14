#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/ellipse.rkt"))

@title{Ellipse}

draw a ellipse.

@defproc[(svg-ellipse-def
          [center_point (cons/c natural? natural?)]
          [radius (cons/c natural? natural?)]
        )
        string?]{

  draw a ellipse by center_point: '(x . y) and radius: '(width . height).
}

@section{ellipse}

@codeblock{
  (let ([ellipse (svg-ellipse-def '(100 . 50) '(100 . 50))])
    (svg-use ellipse #:fill? "#7AA20D")
    (svg-show-default))
}

@image{showcase/shapes/ellipse/ellipse.svg}

