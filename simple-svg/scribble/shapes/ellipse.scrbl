#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/ellipse.rkt"))

@title{Ellipse}

draw a ellipse.

@defproc[(ellipse
          [center_point (cons/c natural? natural?)]
          [radius (cons/c natural? natural?)]
          [fill string?]
        )
        void?]{
  draw a ellipse by center_point: '(x . y) and radius: '(width . height).
}

@section{ellipse}

@codeblock{
  (ellipse '(150 . 150) 100 50 "#7AA20D")
}

@image{showcase/shapes/ellipse/ellipse.svg}

