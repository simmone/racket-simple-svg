#lang scribble/manual

@(require (for-label racket))

@title{Simple-SVG: Scalable Vector Graphics generator}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to generate svg.

@table-of-contents[]

@section[#:tag "install"]{Install}

raco pkg install simple-svg

@section{Usage}

@defmodule[simple-svg]
@(require (for-label simple-svg))

@defproc[(with-output-to-svg (->* (output-port? procedure?)
              [data (string?)]
              [output_file_path (path-string?)]
              [#:mode mode string? "B"]
              [#:error_level error_level string? "H"]
              [#:module_width module_width natural? 5]
              [#:express? express? boolean? #f]
              [#:express_path express_path path-string? "imgfile + '.write.express'"]
              )
            void?]{
  output qr code image to file.
}

@verbatim{
           (call-with-output-string
                   (lambda (output)
                    (with-output-to-svg
             output 
             (lambda   ()
               (rect 100 100 "#BBC42A")))))
