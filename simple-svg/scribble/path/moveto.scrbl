#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{svg-path-moveto/svg-path-moveto*}

@defproc[(svg-path-moveto* [point (cons/c natural? natural?)])
        void?]{
  moveto* use absolute position.

  moveto use relative position.
}
