#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@(require simple-svg)

@title{Usage}

@defmodule[simple-svg]

@section{Example: Recursive Circle}

@codeblock{
#lang racket

(require simple-svg)

(let ([canvas_size 400])
  (with-output-to-file
      "recursive.svg" #:exists 'replace
      (lambda ()
        (printf "~a\n"
                (svg-out
                 canvas_size canvas_size
                 (lambda ()
                   (let ([_sstyle (sstyle-new)])
                     (sstyle-set! _sstyle 'stroke "red")
                     (sstyle-set! _sstyle 'stroke-width 1)

                     (letrec ([recur-circle 
                               (lambda (x y radius)
                                 (let ([circle (svg-def-circle radius)])
                                   (svg-use-shape circle _sstyle #:at? (cons x y)))

                                 (when (> radius 8)
                                   (recur-circle (+ x radius) y (floor (/ radius 2)))
                                   (recur-circle (- x radius) y (floor (/ radius 2)))
                                   (recur-circle x (+ y radius) (floor (/ radius 2)))
                                   (recur-circle x (- y radius) (floor (/ radius 2)))))])
                       (recur-circle 200 200 100)))
                   
                   (svg-show-default)))))))
}
@image{showcase/example/recursive.svg}

@section{Basic Function}

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

@section{basic usage}

@itemlist[
  #:style 'ordered
  @item{use svg-out to generate svg content}
  @item{all svg drawings should occur in the svg-out's procedure.}
  @item{you should specify the svg whole size manully.}
  @item{use svg-def-... define shape first, it includes shape's baisc properties: width, height, radius etc.}
  @item{use sstyle-new and sstyle-set! etc to give shape style properties: stroke, fill etc.}
  @item{svg-use-shape to claim how to show a shape in a group by style(sstyle) and position(#:at?). if not specify which group, all svg-use included in the default group.}
  @item{svg-show-default shows default group at '(0 . 0)}
  @item{svg-show-group reuse group}
]

define shape first, then define group, reuse shape and style in group(s), show group(s) with style in canvas.

@codeblock{
(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-def-rect 100 100)]
          [_sstyle (sstyle-new)])

      (sstyle-set! _sstyle 'fill "#BBC42A")
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

      (sstyle-set! _sstyle 'fill "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}
@image{showcase/shapes/rect/rect.svg}

@section{multiple shapes}

@codeblock{
(let (
      [blue_rec (svg-def-rect 150 150)]
      [_blue_sstyle (sstyle-new)]
      [green_rec (svg-def-rect 100 100)]
      [_green_sstyle (sstyle-new)]
      [red_rec (svg-def-rect 50 50)]
      [_red_sstyle (sstyle-new)]
     )

      (sstyle-set! _blue_sstyle 'fill "blue")
      (svg-use-shape blue_rec _blue_sstyle)

      (sstyle-set! _green_sstyle 'fill "green")
      (svg-use-shape green_rec _green_sstyle #:at? '(25 . 25))

      (sstyle-set! _red_sstyle 'fill "red")
      (svg-use-shape red_rec _red_sstyle #:at? '(50 . 50))

      (svg-show-default))
}

@section{use group}

@codeblock{
(let (
     [line1 (svg-def-line '(0 . 0) '(30 . 30))]
     [line2 (svg-def-line '(0 . 15) '(30 . 15))]
     [line3 (svg-def-line '(15 . 0) '(15 . 30))]
     [line4 (svg-def-line '(30 . 0) '(0 . 30))]
     [_sstyle (sstyle-new)]
     [group_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'stroke-width 5)
  (sstyle-set! _sstyle 'stroke "#765373")
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