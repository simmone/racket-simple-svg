#lang scribble/manual

@(require "../main.rkt")
@(require racket/runtime-path)
@(require racket/port)

@(define-runtime-path basic_svg "basic.svg")

@(require (for-label racket))
@(require (for-label "../main.rkt"))

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
        )
        void?]{
  use output_port to represent a file or a string, all svg actions should in this lambda.
}

@verbatim{
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

@verbatim {
@(call-with-output-file
   basic_svg
   #:exists 'replace
   (lambda (output)
     (with-output-to-svg
       output
       (lambda ()
         (rect 100 100 "#BBC42A")))))
}

@image{@basic_svg}