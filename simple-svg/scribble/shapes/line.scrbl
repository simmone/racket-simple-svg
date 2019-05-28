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
(let ([line (svg-line-def '(0 . 0) '(100 . 100))]
      [_sstyle (sstyle-new)])

  (set-sstyle-stroke-width! _sstyle 10)
  (set-sstyle-stroke! _sstyle "#765373")
  (svg-use-shape line _sstyle #:at? '(5 . 5))
  (svg-show-default))
}
@image{showcase/shapes/line/line.svg}

