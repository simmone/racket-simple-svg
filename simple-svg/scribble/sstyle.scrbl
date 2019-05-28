#lang scribble/manual

@(require "../main.rkt")

@(require (for-label racket))
@(require (for-label "../lib/sstyle.rkt"))

@title{Svg Style}

each shape and group can have multiple styles: stroke, fill etc.

sstyle is a struct, it represent a shape or group's style.

svg-use-shape and svg-show-group should use the sstyle.

@defstruct*[sstyle (
              [fill string?]
              [stroke (or/c #f string?)]
              [stroke-width (or/c #f natural?)]
              [stroke-linejoin (or/c #f 'miter 'round 'bevel)])]{
}

@defproc[(sstyle-new) sstyle/c]{
  init a empty svg style.                    
}

@defproc[(sstyle-clone
           [sstyle sstyle/c]
         ) sstyle/c]{
  init a empty svg style.                    
}
