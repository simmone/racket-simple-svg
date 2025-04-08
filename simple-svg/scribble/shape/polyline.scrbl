#lang scribble/manual

@title{Polyline}

@codeblock|{
(new-polyline (-> (listof (cons/c number? number?)) POLYLINE?))
}|

define a polyline by points list.

@section{polyline}

@codeblock|{
(svg-out
 130 130
 (lambda ()
   (let ([polyline_id
          (svg-def-shape
            (new-polyline '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120))))]
         [_sstyle (sstyle-new)])
     
     (set-SSTYLE-stroke-width! _sstyle 5)
     (set-SSTYLE-stroke! _sstyle "#BBC42A")
     (set-SSTYLE-fill! _sstyle "blue")
     (svg-place-widget polyline_id #:style _sstyle #:at '(5 . 5)))))
}|
@image{showcase/shapes/polyline/polyline.svg}

