#lang scribble/manual

@title{Ellipse}

@codeblock|{
(new-ellipse (-> number? number? ELLIPSE?))
}|

  define a ellipse by radius length: '(x . y).

@section{ellipse}

@codeblock|{
(svg-out
 200 100
 (lambda ()
   (let ([ellipse_id (svg-def-shape (new-ellipse 100 50))]
         [_sstyle (sstyle-new)])
     
     (set-SSTYLE-fill! _sstyle "#7AA20D")
     (svg-place-widget ellipse_id #:style _sstyle #:at '(100 . 50)))))
}|
@image{showcase/shapes/ellipse/ellipse.svg}

