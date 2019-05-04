#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/lineto.rkt"))
@(require (for-label "../../path/close-path.rkt"))

@title{lineto/lineto*}

draw a line.

@defproc[(close-path)
        void?]{
  use close-path to draw a line from current point to start point.
}

@defproc[(lineto
           [point (cons/c integer? integer?) void?]
         )
         void?]{
  lineto* is the absolute version.

  horizontal line: hlineto and hlineto*.
  vertical line: vlineto and vlineto*.
}

@codeblock{
  (moveto* '(0 . 0))
  (lineto '(100 . 100))
  (hlineto '(-100 . 0))
  (lineto '(100 . -100))
  (close-path)
}

@image{showcase/path/lineto.svg}
