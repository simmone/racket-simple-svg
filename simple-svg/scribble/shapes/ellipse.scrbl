#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/rect.rkt"))

@title{Ellipse}

draw a ellipse.

@defproc[(rect
          [center_point pair?]
          [radius_width natural?]
          [radius_height natural?]
          [fill string?]
        )
        void?]{
  draw a ellipse by center_point and radius.
}

@section{ellipse}

@codeblock{
  (ellipse '(150 . 150) 100 50 "#7AA20D")
}

@image{showcase/shapes/ellipse/ellipse.svg}

