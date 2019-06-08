#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Rectangle}

@defmodule[simple-svg #:link-target? #f]

@defproc[(svg-def-rect
          [width natural?]
          [height natural?]
          [#:radius? radius? (or/c #f (cons/c natural? natural?)) #f]
        )
        string?]{
  define a rectangle.

  radius?: '(radiusX . radiusY)
}

@section{rect}

@codeblock{
(let ([rec (svg-def-rect 100 100)]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#BBC42A")
  (svg-use-shape rec _sstyle)
  (svg-show-default))
}

@image{showcase/shapes/rect/rect.svg}

@section{rect with start point(no padding)}

@codeblock{
(let ([rec (svg-def-rect 100 100)]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#BBC42A")
  (svg-use-shape rec _sstyle #:at? '(50 . 50))
  (svg-show-default))
}

@image{showcase/shapes/rect/rect_y.svg}

@section{rect with radius}

@codeblock{
(let ([rec (svg-def-rect 100 100 #:radius? '(5 . 10))]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#BBC42A")
  (svg-use-shape rec _sstyle)
  (svg-show-default))
}

@image{showcase/shapes/rect/rect_radius.svg}

@section{multiple rect}

@codeblock{
(let (
      [blue_rec (svg-def-rect 150 150)]
      [_blue_sstyle (sstyle-new)]
      [green_rec (svg-def-rect 100 100)]
      [_green_sstyle (sstyle-new)]
      [red_rec (svg-def-rect 50 50)]
      [_red_sstyle (sstyle-new)])

  (sstyle-set! _blue_sstyle 'fill "blue")
  (svg-use-shape blue_rec _blue_sstyle)

  (sstyle-set! _green_sstyle 'fill "green")
  (svg-use-shape green_rec _green_sstyle #:at? '(25 . 25))

  (sstyle-set! _red_sstyle 'fill "red")
  (svg-use-shape red_rec _red_sstyle #:at? '(50 . 50))

  (svg-show-default))
}

@image{showcase/shapes/rect/m_rect.svg}
