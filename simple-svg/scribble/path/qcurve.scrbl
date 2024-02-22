#lang scribble/manual

@title{svg-path-qcurve/qcurve*}

@image{showcase/path/qcurve.jpg}

@codeblock|{
(svg-path-qcurve (-> 
                   (cons/c number? number?)
                   (cons/c number? number?)
                   void?))
(svg-path-qcurve* (->
                    (cons/c number? number?)
                    (cons/c number? number?)
                    void?))
}|
  use two control points to draw a Quadratic Bezier Curve.

  qcurve use relative position, relative to the start position.
  
  qcurve use absolute position.

@codeblock|{
(svg-out
 220 120
 (lambda ()
   (let ([path_id
          (svg-def-shape
            (new-path
              (lambda ()
                (svg-path-moveto* '(10 . 60))
                (svg-path-qcurve* '(60 . 10) '(110 . 60))
                (svg-path-qcurve* '(160 . 110) '(210 . 60)))))]
         [path_style (sstyle-new)]
         [red_dot_id (svg-def-shape (new-circle 5))]
         [dot_style (sstyle-new)])

     (set-SSTYLE-fill! path_style "none")
     (set-SSTYLE-stroke-width! path_style 3)
     (set-SSTYLE-stroke! path_style "#333333")
     (svg-place-widget path_id #:style path_style)

     (set-SSTYLE-fill! dot_style "red")
     (svg-place-widget red_dot_id #:style dot_style #:at '(10 . 60))
     (svg-place-widget red_dot_id #:style dot_style #:at '(60 . 10))
     (svg-place-widget red_dot_id #:style dot_style #:at '(110 . 60))
     (svg-place-widget red_dot_id #:style dot_style #:at '(160 . 110))
     (svg-place-widget red_dot_id #:style dot_style #:at '(210 . 60)))))
}|
@image{showcase/path/qcurve1.svg}

little red pots show the control points.


