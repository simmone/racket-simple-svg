#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/ellipse.rkt"))

@title{Ellipse}

define a ellipse.

@defproc[(svg-ellipse-def
          [radius (cons/c natural? natural?)]
        )
        string?]{

  define a ellipse by radius length: '(x . y).
}

@section{ellipse}

@codeblock{
(let ([ellipse (svg-ellipse-def '(100 . 50))])
  (svg-use ellipse #:at? '(100 . 50) #:fill? "#7AA20D")
  (svg-show-default))
}

@image{showcase/shapes/ellipse/ellipse.svg}

