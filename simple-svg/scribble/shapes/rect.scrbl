#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/rect.rkt"))

@title{Rectangle}

draw a rectangle.

@defproc[(rect
          [width natural?]
          [height natural?]
          [fill string?]
          [#:start_point? start_point? pair? '(0 . 0)]
          [#:radius? radius? pair? '(0 . 0)]
        )
        void?]{
  draw a rectangle at start point '(x . y).

  use radius to set corner radius: '(radiusX . radiusY).
}

@section{rect}

@codeblock{
  (rect 100 100 "#BBC42A")
}

@image{showcase/shapes/rect/rect.svg}

@section{rect with start point}

@codeblock{
  (rect 100 100 "#BBC42A" #:start_point '(50 . 50))
}

@image{showcase/shapes/rect/rect_y.svg}

@section{rect with radius}

@codeblock{
  (rect 100 100 "#BBC42A" #:start_point '(50 . 50) #:radius '(5 . 10))
}

@image{showcase/shapes/rect/rect_radius.svg}

