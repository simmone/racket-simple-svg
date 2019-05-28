#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/rect.rkt"))

@title{Rectangle}

define a rectangle.

@defproc[(svg-rect-def
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
(let ([rec (svg-rect-def 100 100)]
      [_sstyle (new-sstyle)])
  (set-sstyle-fill! _sstyle "#BBC42A")
  (svg-use-shape rec _sstyle)
  (svg-show-default))
}

@image{showcase/shapes/rect/rect.svg}

@section{rect with start point(no padding)}

@codeblock{
(let ([rec (svg-rect-def 100 100)]
      [_sstyle (new-sstyle)])

  (set-sstyle-fill! _sstyle "#BBC42A")
  (svg-use-shape rec _sstyle #:at? '(50 . 50))
  (svg-show-default))
}

@image{showcase/shapes/rect/rect_y.svg}

@section{rect with radius}

@codeblock{
(let ([rec (svg-rect-def 100 100 #:radius? '(5 . 10))]
      [_sstyle (new-sstyle)])
  (set-sstyle-fill! _sstyle "#BBC42A")
  (svg-use-shape rec _sstyle)
  (svg-show-default))
}

@image{showcase/shapes/rect/rect_radius.svg}

@section{multiple rect}

@codeblock{
(let (
      [blue_rec (svg-rect-def 150 150)]
      [_blue_sstyle (new-sstyle)]
      [green_rec (svg-rect-def 100 100)]
      [_green_sstyle (new-sstyle)]
      [red_rec (svg-rect-def 50 50)]
      [_red_sstyle (new-sstyle)])

  (set-sstyle-fill! _blue_sstyle "blue")
  (svg-use-shape blue_rec _blue_sstyle)

  (set-sstyle-fill! _green_sstyle "green")
  (svg-use-shape green_rec _green_sstyle #:at? '(25 . 25))

  (set-sstyle-fill! _red_sstyle "red")
  (svg-use-shape red_rec _red_sstyle #:at? '(50 . 50))

  (svg-show-default))
}

@image{showcase/shapes/rect/m_rect.svg}
