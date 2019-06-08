#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Polyline}

@defmodule[simple-svg #:link-target? #f]

@defproc[(svg-def-polyline
          [points (listof (cons/c natural? natural?))]
        )
        string?]{
  define a polyline by points list.
}

@section{polyline}

@codeblock{
(let ([polyline
         (svg-def-polyline
           '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'stroke-width 5)
  (sstyle-set! _sstyle 'stroke "#BBC42A")
  (sstyle-set! _sstyle 'fill "blue")

  (svg-use-shape polyline _sstyle #:at? '(5 . 5))
  (svg-show-default))
}
@image{showcase/shapes/polyline/polyline.svg}

