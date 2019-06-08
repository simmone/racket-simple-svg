#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Ellipse}

@defmodule[simple-svg #:link-target? #f]

@defproc[(svg-def-ellipse
          [radius (cons/c natural? natural?)]
        )
        string?]{

  define a ellipse by radius length: '(x . y).
}

@section{ellipse}

@codeblock{
(let ([ellipse (svg-def-ellipse '(100 . 50))]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#7AA20D")
  (svg-use-shape ellipse _sstyle #:at? '(100 . 50))
  (svg-show-default))
}
@image{showcase/shapes/ellipse/ellipse.svg}

