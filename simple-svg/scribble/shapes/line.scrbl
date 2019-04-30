#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/line.rkt"))

@title{Line}

draw a line.

@defproc[(line
          [start_point (cons/c natural? natural?)]
          [end_point (cons/c natural? natural?)]
          [stroke_fill string?]
          [stroke_width natural?]
        )
        void?]{
}

@section{line}

@codeblock{
  (line '(0 . 0) '(100 . 100) "#765373" 8)
}

@image{showcase/shapes/line/line.svg}

