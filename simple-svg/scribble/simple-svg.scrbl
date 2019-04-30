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
          [#:width? width? (or/c #f natural?) #f]
          [#:height? height? (or/c #f natural?) #f]
          [#:viewBox? viewBox? (or/c #f (list/c natural? natural? natural? natural?)) #f]
          [#:canvas? canvas? (or/c #f (list/c natural? string? string?)) #f]
        )
        void?]{
  use output_port to write svg to a file or a string, all the svg actions should occur in the procedure.

  canvas size is automatically calculated.
  default generate a svg with a 10 padding.
  you can set size manully by #:width? and #:height?.

  viewBox?: '(x y width height), if needed.

  canvas?: '(stroke-width stroke-fill fill), if needed.
}

@subsection{basic usage}

@codeblock{
  (call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:canvas? '(1 "red" "white")
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@verbatim{
  @(call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:canvas? '(1 "red" "white")
        #:viewBox? '(60 0 120 120)
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
        #:canvas? '(1 "red" "white")
        (lambda ()
          (rect 100 100 "#BBC42A")))))
}

@verbatim{
  @(call-with-output-string
    (lambda (output)
      (with-output-to-svg
        output
        #:canvas? '(1 "red" "white")
        #:viewBox? '(60 0 120 120)
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

@include-section{path/raw-path.scrbl}