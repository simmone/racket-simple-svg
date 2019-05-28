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
          [width natural?]
          [height natural?]
          [procedure procedure?]
          [#:viewBox? viewBox? (or/c #f (list/c natural? natural? natural? natural?)) #f]
        )
        string?]{
  specify width and height manully.
  
  viewBox?: '(x y width height), if needed.
}

@subsection{basic usage}

@itemlist[
  #:style 'ordered
  @item{use svg-out to generate svg content}
  @item{all svg drawings should occur in the svg-out's procedure.}
  @item{you should specify the svg whole size manully.}
  @item{use svg-...-def define shape first, it includes shape's baisc properties: width, height, radius etc.}
  @item{use sstyle struct to give shape style properties: stroke, fill etc.}
  @item{svg-use-shape to claim how to show a shape in a group by style(sstyle) and position(#:at?). if not specify which group, all svg-use included in the default group.}
  @item{svg-show-default shows default group at '(0 . 0)}
]

define shape first, then define group, reuse shape and style in group(s), show group(s) with style in canvas.

@codeblock{
(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-rect-def 100 100)]
          [_sstyle (new-sstyle)])

      (set-sstyle-fill! _sstyle "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}

generated svg file:

@verbatim{
@(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-rect-def 100 100)]
          [_sstyle (new-sstyle)])

      (set-sstyle-fill! _sstyle "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}

@image{showcase/shapes/rect/rect.svg}

@subsection{multiple shapes}

@codeblock{
(let (
      [blue_rec (svg-rect-def 150 150)]
      [_blue_sstyle (new-sstyle)]
      [green_rec (svg-rect-def 100 100)]
      [_green_sstyle (new-sstyle)]
      [red_rec (svg-rect-def 50 50)]
      [_red_sstyle (new-sstyle)]
     )

      (set-sstyle-fill! _blue_sstyle "blue")
      (svg-use-shape blue_rec _blue_sstyle)

      (set-sstyle-fill! _green_sstyle "green")
      (svg-use-shape green_rec _green_sstyle #:at? '(25 . 25))

      (set-sstyle-fill! _red_sstyle "red")
      (svg-use-shape red_rec _red_sstyle #:at? '(50 . 50))

      (svg-show-default))
}

@image{showcase/shapes/rect/m_rect.svg}

@include-section["shapes/rect.scrbl"]

include-section["shapes/circle.scrbl"]

include-section["shapes/ellipse.scrbl"]

include-section["shapes/line.scrbl"]

include-section["shapes/polyline.scrbl"]

include-section["shapes/polygon.scrbl"]

include-section["path/path.scrbl"]
