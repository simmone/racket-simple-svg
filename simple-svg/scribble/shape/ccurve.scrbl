#lang scribble/manual

@title{svg-path-ccurve/ccurve*}

@image{showcase/path/ccurve.jpg}

@codeblock|{
(svg-path-ccurve (->
                   (cons/c number? number?)
                   (cons/c number? number?)
                   (cons/c number? number?)
                   )
  void?)           
(svg-path-ccurve* (->
                   (cons/c number? number?)
                   (cons/c number? number?)
                   (cons/c number? number?)
                   )
       void?)
}|

@codeblock|{
(svg-out
 200 120
 (lambda ()
   (let ([path_id
          (svg-def-shape
            (new-path
              (lambda ()
                (svg-path-moveto* '(10 . 60))
                (svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
                (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
              )))]
         [path_style (sstyle-new)]
         [red_dot_id (svg-def-shape (new-circle 5))]
         [dot_style (sstyle-new)])

     (set-SSTYLE-fill! path_style "none")
     (set-SSTYLE-stroke-width! path_style 3)
     (set-SSTYLE-stroke! path_style "#333333")
     (svg-place-widget path_id #:style path_style)

     (set-SSTYLE-fill! dot_style "red")
     (svg-place-widget red_dot_id #:style dot_style #:at '(10 . 60))
     (svg-place-widget red_dot_id #:style dot_style #:at '(30 . 15))
     (svg-place-widget red_dot_id #:style dot_style #:at '(80 . 15))
     (svg-place-widget red_dot_id #:style dot_style #:at '(100 . 60))
     (svg-place-widget red_dot_id #:style dot_style #:at '(120 . 105))
     (svg-place-widget red_dot_id #:style dot_style #:at '(170 . 105))
     (svg-place-widget red_dot_id #:style dot_style #:at '(190 . 60)))))
}|

little red pots show the control points.

@image{showcase/path/ccurve1.svg}
