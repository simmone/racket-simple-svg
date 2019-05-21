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
  (let ([rec (svg-rect-def 100 100)])
    (svg-use rec #:fill? "#BBC42A")
    (svg-show-default))
}

@image{showcase/shapes/rect/rect.svg}

@section{rect with start point(no padding)}

@codeblock{
(let ([rec (svg-rect-def 100 100)])
  (svg-use rec #:fill? "#BBC42A" #:at? '(50 . 50))
  (svg-show-default))
}

@image{showcase/shapes/rect/rect_y.svg}

@section{rect with radius}

@codeblock{
(let ([rec (svg-rect-def 100 100 #:radius? '(5 . 10))])
  (svg-use rec #:fill? "#BBC42A")
  (svg-show-default))
}

@image{showcase/shapes/rect/rect_radius.svg}

@section{multiple rect}

@codeblock{
(let (
      [blue_rec (svg-rect-def 150 150)]
      [green_rec (svg-rect-def 100 100)]
      [red_rec (svg-rect-def 50 50)]
      )
  (svg-use blue_rec #:fill? "blue")
  (svg-use green_rec #:fill? "green" #:at? '(25 . 25))
  (svg-use red_rec #:fill? "red" #:at? '(50 . 50))
  (svg-show-default))
}

@image{showcase/shapes/rect/m_rect.svg}
