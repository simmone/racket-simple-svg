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
(svg-out
  #:canvas? '(1 "red" "white")
  (lambda ()
    (let ([path
      (svg-path-def
        (lambda ()
          (svg-path-moveto* '(10 . 10))
          (svg-path-hlineto 100)
          (svg-path-vlineto 100)
          (svg-path-lineto '(-50 . 50))
          (svg-path-lineto '(-50 . -50))
          (svg-path-close)))]
     [red_dot (svg-circle-def 2)])

     (svg-use path
       #:fill? "white"
       #:stroke-width? 1
       #:stroke? "#7AA20D"
       #:stroke-linejoin? 'round)

       (svg-use red_dot #:at? '(10 . 10) #:fill? "red")
       (svg-use red_dot #:at? '(110 . 110) #:fill? "red")
       (svg-use red_dot #:at? '(10 . 110) #:fill? "red")
       (svg-use red_dot #:at? '(110 . 10) #:fill? "red")

       (svg-show-default))))
}

@image{showcase/path/lineto.svg}
