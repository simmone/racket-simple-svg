#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../src/path/moveto.rkt"))

@title{svg-path-moveto/svg-path-moveto*}

move to a position.

@defproc[(svg-path-moveto* [point (cons/c natural? natural?)])
        void?]{
  moveto* use absolute position.

  moveto use relative position.
}
