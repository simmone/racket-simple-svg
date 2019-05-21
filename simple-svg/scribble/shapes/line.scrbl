#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/line.rkt"))

@title{Line}

define a line.

@defproc[(svgf-line-def
          [start_point (cons/c natural? natural?)]
          [end_point (cons/c natural? natural?)]
        )
        string?]{
  define a line by start point and end point.
}

@section{line}

@codeblock{
(let ([line (svg-line-def '(0 . 0) '(100 . 100))])
  (svg-use line #:stroke? '(10 . "#765373"))
  (svg-show "default" '(5 . 5)))
}
@image{showcase/shapes/line/line.svg}

