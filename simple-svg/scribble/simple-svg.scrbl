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
          [#:width? width? natural? 300]
          [#:height? height? natural? 300]
          [#:viewBoxX? viewBoxX? natural? 0]
          [#:viewBoxY? viewBoxY? natural? 0]
          [#:viewBoxWidth? viewBoxWidth? natural? width?]
          [#:viewBoxHeight? viewBoxHeight? natural? height?]
          [#:stroke-width? stroke-width? natural? 0]
          [#:stroke-fill? stroke-fill? string? "red"]
          [#:fill? fill? string? "white"]
        )
        void?]{
  output_port to represent a file or a string, all svg actions should in the procedure.
  
  #:width? and #:height? set canvas size, or it'll be a 300X300.

  default is no stroke, use stroke should set #:stroke-width? > 0.

  #:stroke-fill? set the stroke color, default is "red".

  #:fill? set the canvas color, default is "white".
}

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

@include-section{shapes/rect.scrbl}