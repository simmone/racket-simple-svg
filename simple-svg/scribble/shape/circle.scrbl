#lang scribble/manual

@title{Circle}

@codeblock|{
(new-circle (-> number? CIRCLE?))
}|

define a circle by radius length.

@section{circle}

@codeblock|{
(svg-out
  100 100
  (lambda ()
    (let ([circle_id (svg-def-shape (new-circle 50))]
          [_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "#BBC42A")
      (svg-place-widget circle_id #:style _sstyle #:at '(50 . 50)))))
}|
@image{showcase/shapes/circle/circle.svg}

@section{multiple circle}

@codeblock|{
(svg-out
  200 200
  (lambda ()
    (let ([circle_id (svg-def-shape (new-circle 50))]
         [red_sstyle (sstyle-new)]
         [yellow_sstyle (sstyle-new)]
         [blue_sstyle (sstyle-new)]
         [green_sstyle (sstyle-new)])
     
     (set-SSTYLE-fill! red_sstyle "red")
     (svg-place-widget circle_id #:style red_sstyle #:at '(50 . 50))

     (set-SSTYLE-fill! yellow_sstyle "yellow")
     (svg-place-widget circle_id #:style yellow_sstyle #:at '(150 . 50))

     (set-SSTYLE-fill! blue_sstyle "blue")
     (svg-place-widget circle_id #:style blue_sstyle #:at '(50 . 150))

     (set-SSTYLE-fill! green_sstyle "green")
     (svg-place-widget circle_id #:style green_sstyle #:at '(150 . 150)))))
}|
@image{showcase/shapes/circle/circle4.svg}
