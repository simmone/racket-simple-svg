#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Polyline}

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

  (set-sstyle-stroke-width! _sstyle 5)
  (set-sstyle-stroke! _sstyle "#BBC42A")
  (set-sstyle-fill! _sstyle "blue")

  (svg-use-shape polyline _sstyle #:at? '(5 . 5))
  (svg-show-default))
}
@image{showcase/shapes/polyline/polyline.svg}

