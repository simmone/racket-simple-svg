#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../shapes/circle.rkt"))

@title{Circle}

define a circle.

@defproc[(svg-circle-def
          [radius natural?]
        )
        string?]{
  define a circle by radius length.
}

@section{circle}

@codeblock{
(let ([circle (svg-circle-def 50)]
      [_sstyle (new-sstyle)])

  (set-sstyle-fill! _sstyle "#BBC42A")
  (svg-use-shape circle _sstyle #:at? '(50 . 50))
  (svg-show-default))
}
@image{showcase/shapes/circle/circle.svg}

@section{multiple circle}

@codeblock{
(let ([circle (svg-circle-def 50)]
      [red_sstyle (new-sstyle)]
      [yellow_sstyle (new-sstyle)]
      [blue_sstyle (new-sstyle)]
      [green_sstyle (new-sstyle)])

  (set-sstyle-fill! red_sstyle "red")
  (svg-use-shape circle red_sstyle #:at? '(50 . 50))

  (set-sstyle-fill! yellow_sstyle "yellow")
  (svg-use-shape circle yellow_sstyle #:at? '(150 . 50))

  (set-sstyle-fill! blue_sstyle "blue")
  (svg-use-shape circle blue_sstyle #:at? '(50 . 150))

  (set-sstyle-fill! green_sstyle "green")
  (svg-use-shape circle green_sstyle #:at? '(150 . 150))

  (svg-show-default))
}
@image{showcase/shapes/circle/circle3.svg}
