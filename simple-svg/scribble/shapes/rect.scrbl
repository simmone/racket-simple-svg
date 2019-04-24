#lang scribble/manual

@(require "../../main.rkt")
@(require racket/runtime-path)
@(require racket/port)

@(define-runtime-path basic_svg "basic.svg")
@(define-runtime-path start_point_svg "start_point.svg")
@(define-runtime-path radius_svg "radius.svg")

@(require (for-label racket))
@(require (for-label "../../shapes/rect.rkt"))

@title{Rectangle}

draw a rectangle.

@defproc[(rect
          [width natural?]
          [height natural?]
          [fill string?]
          [#:start_point? start_point? pair? '(0 . 0)]
          [#:radius? radius? pair? '(0 . 0)]
        )
        void?]{
  draw a rectangle at start point '(x . y).

  use radius to set corner radius: '(radiusX . radiusY).
}

@section{basic}

@codeblock{
  (call-with-output-file
    "basic.svg"
    (lambda (output)
      (with-output-to-svg
        output
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@verbatim{
  @(call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@(call-with-output-file
  basic_svg
  #:exists 'replace
  (lambda (output)
    (with-output-to-svg
      output
      (lambda ()
        (rect 100 100 "#BBC42A")))))

@image{@basic_svg}

@section{start_point}

@codeblock{
  (call-with-output-file
    "start_point.svg"
    (lambda (output)
      (with-output-to-svg
        output
        (lambda ()
          (rect 100 100 "#BBC42A"  #:start_point '(50 . 50))))))
}

@verbatim{
  @(call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        (lambda ()
          (rect 100 100 "#BBC42A"  #:start_point '(50 . 50))))))
}

@(call-with-output-file
  start_point_svg
  #:exists 'replace
  (lambda (output)
    (with-output-to-svg
      output
      (lambda ()
        (rect 100 100 "#BBC42A"  #:start_point '(50 . 50))))))

@image{@start_point_svg}

