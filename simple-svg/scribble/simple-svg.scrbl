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

@defproc[(svg-use-shape
           [shape_index string?]
           [shape_style sstyle/c]
           [#:at? at? (cons/c natural? natural?) '(0 . 0)]
           [#:hidden? hidden? boolean? #f]
        )
        string?]{
  use a shape in group.
  
  hidden? set to true means just use it, but not show it. 
}

@defproc[(svg-def-group
           [group_name string?]
           [use-proc procedure?]
         )
         void?]{
  default, all svg-use-* will be added to "default" group.

  use svg-def-group to define a named group to use later.

  all svg-use-* in use-proc will be added to the group.
}

@defproc[(svg-show-group
           [group_name string?]
           [group_style sstyle/c]
           [#:at? at? (cons/c natural? natural?) '(0 . 0)]
          )
          void?]{
  show a group by name with style and position.
}

@defproc[(svg-show-default)
         void?]{
  (svg-show-group "default" (sstyle-new))
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
    (let ([rec (svg-def-rect 100 100)]
          [_sstyle (sstyle-new)])

      (set-sstyle-fill! _sstyle "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}

generated svg file:

@verbatim{
@(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-def-rect 100 100)]
          [_sstyle (sstyle-new)])

      (set-sstyle-fill! _sstyle "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}

@image{showcase/shapes/rect/rect.svg}

@subsection{multiple shapes}

@codeblock{
(let (
      [blue_rec (svg-def-rect 150 150)]
      [_blue_sstyle (sstyle-new)]
      [green_rec (svg-def-rect 100 100)]
      [_green_sstyle (sstyle-new)]
      [red_rec (svg-def-rect 50 50)]
      [_red_sstyle (sstyle-new)]
     )

      (set-sstyle-fill! _blue_sstyle "blue")
      (svg-use-shape blue_rec _blue_sstyle)

      (set-sstyle-fill! _green_sstyle "green")
      (svg-use-shape green_rec _green_sstyle #:at? '(25 . 25))

      (set-sstyle-fill! _red_sstyle "red")
      (svg-use-shape red_rec _red_sstyle #:at? '(50 . 50))

      (svg-show-default))
}

@subsection{use group}

@codeblock{
(let (
     [line1 (svg-def-line '(0 . 0) '(30 . 30))]
     [line2 (svg-def-line '(0 . 15) '(30 . 15))]
     [line3 (svg-def-line '(15 . 0) '(15 . 30))]
     [line4 (svg-def-line '(30 . 0) '(0 . 30))]
     [_sstyle (sstyle-new)]
     [group_sstyle (sstyle-new)])

  (set-sstyle-stroke-width! _sstyle 5)
  (set-sstyle-stroke! _sstyle "#765373")
  (svg-def-group
   "pattern"
   (lambda ()
     (svg-use-shape line1 _sstyle #:at? '(5 . 5))
     (svg-use-shape line2 _sstyle #:at? '(5 . 5))
     (svg-use-shape line3 _sstyle #:at? '(5 . 5))
     (svg-use-shape line4 _sstyle #:at? '(5 . 5))))
  (svg-show-group "pattern" group_sstyle #:at? '(50 . 50))
  (svg-show-group "pattern" group_sstyle #:at? '(100 . 100))
  (svg-show-group "pattern" group_sstyle #:at? '(80 . 200))
  (svg-show-group "pattern" group_sstyle #:at? '(150 . 100))
  )
}
@image{showcase/group/group1.svg}

@include-section["sstyle.scrbl"]
@include-section["shapes/rect.scrbl"] 
@include-section["shapes/circle.scrbl"]
@include-section["shapes/ellipse.scrbl"]
@include-section["shapes/line.scrbl"]
@include-section["shapes/polyline.scrbl"]
@include-section["shapes/polygon.scrbl"]
@include-section["path/path.scrbl"]
@include-section["text/text.scrbl"]
@include-section["gradient/gradient.scrbl"]
