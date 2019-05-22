#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/lineto.rkt"))

@title{svg-path-lineto/lineto*/hlineto/vlineto}

define a line path.

@defproc[(svg-path-lineto [point (cons/c integer? integer?)]) void?]{
  svg-path-lineto* is the absolute version.
}

@defproc[(svg-path-hlineto [point integer?]) void?]{
}

@defproc[(svg-path-vlineto [point integer?]) void?]{
}

@codeblock{
(let ([path
  (svg-path-def
    (lambda ()
      (svg-path-moveto* '(5 . 5))
      (svg-path-hlineto 100)
      (svg-path-vlineto 100)
      (svg-path-lineto '(-50 . 50))
      (svg-path-lineto '(-50 . -50))
      (svg-path-close)))])

   (svg-use path
     #:stroke-width? 5
     #:stroke? "#7AA20D"
     #:stroke-linejoin? 'round)

   (svg-show-default))
}
@image{showcase/path/lineto.svg}
