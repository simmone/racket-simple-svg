#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/rect.rkt"))

@title{Line}

draw a line.

@defproc[(rect
          [start_point pair?]
          [end_point pair?]
          [stroke_fill string?]
          [stroke_width natural?]
        )
        void?]{
  draw a line by start, end point.
}

@section{line}

@codeblock{
  (line '(5 . 5) '(100 . 100) "#765373" 8)
}

@image{showcase/shapes/line/line.svg}

