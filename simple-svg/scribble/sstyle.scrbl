#lang scribble/manual

@(require simple-svg)

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Svg Style}

each shape and group can have multiple styles: stroke, fill etc.

sstyle is a struct, it represent a shape or group's style.

svg-use-shape and svg-show-group should use the sstyle.

@defmodule[simple-svg]

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