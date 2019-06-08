#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{svg-path-ccurve/ccurve*}

@image{showcase/path/ccurve.jpg}

@defproc[(svg-path-ccurve
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
          [point3 (cons/c natural? natural?)]
        )
        void?]{
  use three control points to draw a Cubic Bezier Curve.

  ccurve use relative position, relative to the start position.
}

@defproc[(svg-path-ccurve*
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
          [point3 (cons/c natural? natural?)]
        )
        void?]{
}

@codeblock{
(let ([path
        (svg-def-path
          (lambda ()
            (svg-path-moveto* '(10 . 60))
            (svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
            (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
          ))]
      [path_style (sstyle-new)]
      [red_dot (svg-def-circle 5)]
      [dot_style (sstyle-new)])

  (set-sstyle-stroke! path_style "#333333")
  (set-sstyle-stroke-width! path_style 3)
  (svg-use-shape path path_style)

  (set-sstyle-fill! dot_style "red")
  (svg-use-shape red_dot dot_style #:at? '(10 . 60))
  (svg-use-shape red_dot dot_style #:at? '(30 . 15))
  (svg-use-shape red_dot dot_style #:at? '(80 . 15))
  (svg-use-shape red_dot dot_style #:at? '(100 . 60))
  (svg-use-shape red_dot dot_style #:at? '(120 . 105))
  (svg-use-shape red_dot dot_style #:at? '(170 . 105))
  (svg-use-shape red_dot dot_style #:at? '(190 . 60))

  (svg-show-default))
}

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-ccurve '(20 . -45) '(70 . -45) '(90 . 0))
(svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
}

little red pots show the control points.

@image{showcase/path/ccurve1.svg}
