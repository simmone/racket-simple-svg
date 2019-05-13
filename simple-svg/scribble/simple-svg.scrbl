#lang scribble/manual

@(require "../main.rkt")
@(require racket/runtime-path)
@(require racket/port)

@(require scribble/eval
          (for-label racket racket/runtime-path "../main.rkt"))

@(require (for-label racket))
@(require (for-label "../main.rkt"))

@(define-runtime-path basic_svg "basics.svg")

@title{Simple-Svg: Scalable Vector Graphics}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to write svg.

@table-of-contents[]

@section[#:tag "install"]{Install}

raco pkg install simple-svg

@section{Usage}

@defproc[(svg-out
          [procedure procedure?]
          [#:width? width? (or/c #f natural?) #f]
          [#:height? height? (or/c #f natural?) #f]
          [#:padding? padding? natural? 10]
          [#:viewBox? viewBox? (or/c #f (list/c natural? natural? natural? natural?)) #f]
          [#:canvas? canvas? (or/c #f (list/c natural? string? string?)) #f]
        )
        string?]{
  canvas size is automatically calculated.
  default generate a svg with a 10 padding.
  you can set size manully by #:width? and #:height?.

  viewBox?: '(x y width height), if needed.

  canvas?: '(stroke-width stroke-fill fill), if needed.
}

@subsection{basic usage}

@itemlist[
  #:style 'ordered
  @item{all svg drawings should occur in the svg-out's procedure.}
  @item{use svg-...-def define shape first.}
  @item{svg-use reuse the shape in group, if not specify which group, all svg-use included in the default group.}
  @item{svg-show-default shows default group, or svg-show the specific group.}
]

define shape first, then define group, reuse shape in group(s) any times and styles, show group(s) in canvas any times.

the shape's define just contains it's basic properties.
svg-use add the axis, fill, stroke etcs.

ie: define a rect by width and height, then resue it by svg-use any times,
    each svg-use can use different axis, fill or stroke.

@codeblock{
  (svg-out
    #:canvas? '(1 "red" "white")
    (lambda ()
      (let ([rec (svg-rect-def 100 100)])
        (svg-use rec #:fill? "#BBC42A")
        (svg-show-default))))
}

generated svg file:

@verbatim{
  @(svg-out
    #:canvas? '(1 "red" "white")
    (lambda ()
      (let ([rec (svg-rect-def 100 100)])
        (svg-use rec #:fill? "#BBC42A")
        (svg-show-default))))
}

@image{showcase/shapes/rect/rect.svg}

@subsection{multiple shapes}

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

@include-section["shapes/rect.scrbl"]

@include-section["shapes/circle.scrbl"]

@include-section["shapes/ellipse.scrbl"]

@include-section["shapes/line.scrbl"]