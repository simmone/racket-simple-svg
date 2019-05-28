#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/polyline.rkt"))

@title{Polyline}

define a polyline.

@defproc[(svg-polyline-def
          [points (listof (cons/c natural? natural?))]
        )
        string?]{
  define a polyline by points list.
}

@section{polyline}

@codeblock{
(let ([polyline
         (svg-polyline-def
           '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))]
      [_sstyle (new-sstyle)])

  (set-sstyle-stroke-width! _sstyle 5)
  (set-sstyle-stroke! _sstyle "#BBC42A")
  (set-sstyle-fill! _sstyle "blue")

  (svg-use-shape polyline _sstyle #:at? '(5 . 5))
  (svg-show-default))
}
@image{showcase/shapes/polyline/polyline.svg}

