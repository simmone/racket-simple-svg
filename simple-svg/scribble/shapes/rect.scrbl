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
          [#:start_point? start_poiont? (or/c #f (cons/c natural? natural?)) #f]
          [#:radius? radius? (or/c #f (cons/c natural? natural?)) #f]
        )
        void?]{
  draw a rectangle.

  start_point?: '(x .y)

  radius?: '(radiusX . radiusY)
}

@section{rect}

@codeblock{
  (rect 100 100 "#BBC42A")
}

@image{showcase/shapes/rect/rect.svg}

@section{rect with start point(no padding)}

@codeblock{
  (rect 100 100 "#BBC42A" #:start_point '(50 . 50))
}

@image{showcase/shapes/rect/rect_y.svg}

@section{rect with radius}

@codeblock{
  (rect 100 100 "#BBC42A" #:radius? '(5 . 10))
}

@image{showcase/shapes/rect/rect_radius.svg}

@section{multiple rect}

@codeblock{
  (rect 150 150 "blue")
  (rect 100 100 "green")
  (rect 50 50 "red")
}

@image{showcase/shapes/rect/m_rect.svg}
