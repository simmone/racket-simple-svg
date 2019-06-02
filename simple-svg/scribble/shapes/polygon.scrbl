#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/polygon.rkt"))

@title{Polygon}

define a polygon.

@defproc[(svg-def-polygon
          [points (listof pair?)]
        )
        string?]{
  define a polygon by points list.
}

@section{polygon}

@codeblock{
(let ([polygon
         (svg-def-polygon
           '((0 . 25) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75)))]
      [_sstyle (sstyle-new)])

  (set-sstyle-stroke-width! _sstyle 5)
  (set-sstyle-stroke! _sstyle "#765373")
  (set-sstyle-fill! _sstyle "#ED6E46")

  (svg-use-shape polygon _sstyle #:at? '(5 . 5))
  (svg-show-default))
}
@image{showcase/shapes/polygon/polygon.svg}

