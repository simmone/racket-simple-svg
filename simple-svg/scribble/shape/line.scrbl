#lang scribble/manual

@title{Line}

@codeblock|{
(new-line (-> (cons/c number? number?) (cons/c number? number?) LINE?))
}|

@section{line}

@codeblock|{
(svg-out
 110 110
 (lambda ()
   (let ([line_id (svg-def-shape (new-line '(0 . 0) '(100 . 100)))]
         [_sstyle (sstyle-new)])
     
     (set-SSTYLE-stroke-width! _sstyle 10)
     (set-SSTYLE-stroke! _sstyle "#765373")
     (svg-place-widget line_id #:style _sstyle #:at '(5 . 5)))))
}|
@image{showcase/shapes/line/line.svg}

