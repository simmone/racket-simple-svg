#lang scribble/manual

@title{Arrow}

Arrow is a arrow shape's polygon.

@codeblock|{
[new-arrow (-> (cons/c number? number?) (cons/c number? number?) number? number? number? ARROW?)]
}|

define a arrow by start point, end point, handle_base, head_base, head_height to draw it.

each argument's meaning is the image below:

@image{showcase/arrow/arrow1_show.svg}

@section{arrow}

@codeblock|{
(svg-out
 300 300
 (lambda ()
   (let (
         [arrow_id (svg-def-shape (new-arrow '(50 . 50) '(280 . 280) 40 40 80))]
         [sstyle_arrow (sstyle-new)]
         )

     (set-SSTYLE-stroke-width! sstyle_arrow 5)
     (set-SSTYLE-stroke! sstyle_arrow "teal")
     (set-SSTYLE-fill! sstyle_arrow "lavender")
     (svg-place-widget arrow_id #:style sstyle_arrow)
     )))
}|

@image{showcase/arrow/arrow1.svg}

@image{showcase/arrow/arrow2.svg}


