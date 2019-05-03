#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/moveto.rkt"))

@title{moveto/moveto*}

move to a position.

@defproc[(moveto
          [point (cons/c natural? natural?) void?]
        )
        void?]{
  moveto use relative position.
  moveto* use absolute position.
}

@codeblock{
  (moveto '(100 . 100))
}
