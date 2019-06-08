#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Circle}

@defmodule[simple-svg #:link-target? #f]

@defproc[(svg-def-circle
          [radius natural?]
        )
        string?]{
  define a circle by radius length.
}

@section{circle}

@codeblock{
(let ([circle (svg-def-circle 50)]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#BBC42A")
  (svg-use-shape circle _sstyle #:at? '(50 . 50))
  (svg-show-default))
}
@image{showcase/shapes/circle/circle.svg}

@section{multiple circle}

@codeblock{
(let ([circle (svg-def-circle 50)]
      [red_sstyle (sstyle-new)]
      [yellow_sstyle (sstyle-new)]
      [blue_sstyle (sstyle-new)]
      [green_sstyle (sstyle-new)])

  (sstyle-set! red_sstyle 'fill "red")
  (svg-use-shape circle red_sstyle #:at? '(50 . 50))

  (sstyle-set! yellow_sstyle 'fill "yellow")
  (svg-use-shape circle yellow_sstyle #:at? '(150 . 50))

  (sstyle-set! blue_sstyle 'fill "blue")
  (svg-use-shape circle blue_sstyle #:at? '(50 . 150))

  (sstyle-set! green_sstyle 'fill "green")
  (svg-use-shape circle green_sstyle #:at? '(150 . 150))

  (svg-show-default))
}
@image{showcase/shapes/circle/circle3.svg}
