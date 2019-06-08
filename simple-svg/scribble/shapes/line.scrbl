#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Line}

@defmodule[simple-svg #:link-target? #f]

@defproc[(svg-def-line
          [start_point (cons/c natural? natural?)]
          [end_point (cons/c natural? natural?)]
        )
        string?]{
  define a line by start point and end point.
}

@section{line}

@codeblock{
(let ([line (svg-def-line '(0 . 0) '(100 . 100))]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'stroke-width 10)
  (sstyle-set! _sstyle 'stroke "#765373")
  (svg-use-shape line _sstyle #:at? '(5 . 5))
  (svg-show-default))
}
@image{showcase/shapes/line/line.svg}

