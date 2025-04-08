#lang scribble/manual

@title{Polygon}

@codeblock|{
(new-polygon (-> (listof (cons/c number? number?)) POLYGON?))
}|

define a polygon by points list.

@section{polygon}

@codeblock|{
(svg-out
 110 110
 (lambda ()
   (let ([polygon_id
          (svg-def-shape
            (new-polygon
              '((0 . 25) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75))))]
         [_sstyle (sstyle-new)])

     (set-SSTYLE-stroke-width! _sstyle 5)
     (set-SSTYLE-stroke! _sstyle "#765373")
     (set-SSTYLE-fill! _sstyle "#ED6E46")

     (svg-place-widget polygon_id #:style _sstyle #:at '(5 . 5)))))
}|
@image{showcase/shapes/polygon/polygon.svg}

