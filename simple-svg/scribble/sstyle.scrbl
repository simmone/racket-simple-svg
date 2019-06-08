#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Svg Style}

@defmodule[simple-svg #:link-target? #f]

each shape and group can have multiple styles: stroke, fill etc.

sstyle is a struct, use sstyle-new, sstyle-clone, sstyle-get and sstyle-set! to manage it.

sstyle used in svg-use-shape and svg-show-group.

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
