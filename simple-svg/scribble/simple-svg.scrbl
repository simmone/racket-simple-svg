#lang scribble/manual

@(require "../main.rkt")
@(require racket/runtime-path)
@(require racket/port)

@(require (for-label racket))
@(require (for-label "../main.rkt"))

@title{Simple-Svg: Scalable Vector Graphics}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to write svg.

@table-of-contents[]

@section[#:tag "install"]{Install}

raco pkg install simple-svg

@section{Usage}

@defmodule[simple-svg]

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

      (sstyle-set! _sstyle 'fill "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}

generated svg file:

@verbatim[
(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-def-rect 100 100)]
          [_sstyle (sstyle-new)])

      (sstyle-set! _sstyle 'fill "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
]

@image{showcase/shapes/rect/rect.svg}

@subsection{Svg Style}

each shape and group can have multiple styles: stroke, fill etc.

sstyle is a struct, use sstyle-get and sstyle-set! to use it.

svg-use-shape and svg-show-group should use the sstyle.

@defstruct*[sstyle (
     [fill string?]
     [fill-rule (or/c #f 'nonzero 'evenodd 'inerit)]
     [fill-opacity (or/c #f (between/c 0 1))]
     [stroke (or/c #f string?)]
     [stroke-width (or/c #f natural?)]
     [stroke-linecap (or/c #f 'butt 'round 'square 'inherit)]
     [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
     [stroke-miterlimit (or/c #f (>=/c 1))]
     [stroke-dasharray (or/c #f string?)]
     [stroke-dashoffset (or/c #f natural?)]
     [translate (or/c #f (cons/c natural? natural?))]
     [rotate (or/c #f integer?)]
     [scale (or/c #f natural? (cons/c natural? natural?))]
     [skewX (or/c #f natural?)]
     [skewY (or/c #f natural?)]
     [fil-gradient (or/c #f string?)]
     )]{
}

@defproc[(sstyle-new) sstyle/c]{
  init a empty svg style.                    
}

@defproc[(sstyle-clone
           [sstyle sstyle/c]
         ) sstyle/c]{
  init a empty svg style.                    
}

@defproc[(sstyle-get
           [sstyle sstyle/c]
           [key symbol?]
         ) sstyle/c]{
  get a sstyle property.
}

@defproc[(sstyle-set!
           [sstyle sstyle/c]
           [key symbol?]
           [val any/c]
         ) void?]{
  set a sstyle property.
}

@subsection{Rectangle}

define a rectangle.

@defproc[(svg-def-rect
          [width natural?]
          [height natural?]
          [#:radius? radius? (or/c #f (cons/c natural? natural?)) #f]
        )
        string?]{
  define a rectangle.

  radius?: '(radiusX . radiusY)
}

@subsubsection{rect}

@codeblock{
(let ([rec (svg-def-rect 100 100)]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#BBC42A")
  (svg-use-shape rec _sstyle)
  (svg-show-default))
}
@image{showcase/shapes/rect/rect.svg}

@subsubsection{rect with start point(no padding)}

@codeblock{
(let ([rec (svg-def-rect 100 100)]
      [_sstyle (sstyle-new)])

  (sstyle-set! _sstyle 'fill "#BBC42A")
  (svg-use-shape rec _sstyle #:at? '(50 . 50))
  (svg-show-default))
}
@image{showcase/shapes/rect/rect_y.svg}

@subsubsection{rect with radius}

@subsubsection{multiple rect}

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
