#lang scribble/manual

@(require "../main.rkt")
@(require racket/runtime-path)
@(require racket/port)

@(require scribble/eval
          (for-label racket racket/runtime-path "../main.rkt"))

@(require (for-label racket))
@(require (for-label "../main.rkt"))

@(define-runtime-path basic_svg "basics.svg")

@title{Simple-Svg: Scalable Vector Graphics}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to write svg.

@table-of-contents[]

@section[#:tag "install"]{Install}

raco pkg install simple-svg

@section{Usage}

@defproc[(with-output-to-svg
          [output_port output-port?]
          [procedure procedure?]
          [#:padding? padding? natural? 10]
          [#:width? width? natural? 0]
          [#:height? height? natural? 0]
          [#:viewBoxX? viewBoxX? natural? 0]
          [#:viewBoxY? viewBoxY? natural? 0]
          [#:viewBoxWidth? viewBoxWidth? natural? 0]
          [#:viewBoxHeight? viewBoxHeight? natural? 0]
          [#:stroke-width? stroke-width? natural? 0]
          [#:stroke-fill? stroke-fill? string? "red"]
          [#:fill? fill? string? "white"]
        )
        void?]{
  use output_port to write svg to a file or a string, all svg actions should in the procedure.

  svg canvas size is automatically calculated by all the content plus padding?.
  default generate a svg by a 10 padding.
  you can set size manully #:width? and #:height?.

  default is no stroke, use stroke should set #:stroke-width? > 0.

  #:stroke-fill? set the stroke color, default is "red".

  #:fill? set the canvas color, default is "white".
}

@subsection{basic usage}

@codeblock{
  (call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:stroke-width? 1
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@verbatim{
  @(call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:stroke-width? 1
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@image{showcase/shapes/rect/rect.svg}

@subsection{viewBox}

@codeblock{
  (call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:stroke-width? 1
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@verbatim{
  @(call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:stroke-width? 1
        #:viewBoxX 60
        #:viewBoxY 0
        #:viewBoxWidth 120
        #:viewBoxHeight 120
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@image{showcase/basic/viewBox.svg}

@include-section{shapes/rect.scrbl}

@include-section{shapes/circle.scrbl}

@include-section{shapes/ellipse.scrbl}

@include-section{shapes/line.scrbl}

@include-section{shapes/polyline.scrbl}

@include-section{shapes/polygon.scrbl}