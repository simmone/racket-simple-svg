#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/line.rkt"))

@title{Line}

draw a line.

@defproc[(line
          [start_point (cons/c natural? natural?)]
          [end_point (cons/c natural? natural?)]
        )
        void?]{
}

@section{line}

@codeblock{
(let ([line (svg-line-def '(0 . 0) '(100 . 100))])
  (svg-use line #:stroke? '(3 . "#765373"))
  (svg-show-default))
}

@image{showcase/shapes/line/line.svg}

