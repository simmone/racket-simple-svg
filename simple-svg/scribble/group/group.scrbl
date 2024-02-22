#lang scribble/manual

@title{Group}

@section{Combine shapes to group}

@codeblock|{
(svg-out
 220 280
 (lambda ()
   (let (
         [line1_id (svg-def-shape (new-line '(0 . 0) '(30 . 30)))]
         [line2_id (svg-def-shape (new-line '(0 . 15) '(30 . 15)))]
         [line3_id (svg-def-shape (new-line '(15 . 0) '(15 . 30)))]
         [line4_id (svg-def-shape (new-line '(30 . 0) '(0 . 30)))]
         [_sstyle (sstyle-new)]
         [group_sstyle (sstyle-new)])

     (set-SSTYLE-stroke-width! _sstyle 5)
     (set-SSTYLE-stroke! _sstyle "#765373")
     (let ([pattern_id 
            (svg-def-group
             (lambda ()
               (svg-place-widget line1_id #:style _sstyle #:at '(5 . 5))
               (svg-place-widget line2_id #:style _sstyle #:at '(5 . 5))
               (svg-place-widget line3_id #:style _sstyle #:at '(5 . 5))
               (svg-place-widget line4_id #:style _sstyle #:at '(5 . 5))))])

       (svg-place-widget pattern_id #:at '(50 . 50))
       (svg-place-widget pattern_id #:at '(100 . 100))
       (svg-place-widget pattern_id #:at '(80 . 200))
       (svg-place-widget pattern_id #:at '(150 . 100))))))
}|
@image{showcase/group/group1.svg}

@section{Define group, then use it in other group}

@codeblock|{
(svg-out
 100 100
 (lambda ()
   (let (
         [rect_id (svg-def-shape (new-rect 50 50))]
         [line1_id (svg-def-shape (new-line '(10 . 0) '(0 . 50)))]
         [line2_id (svg-def-shape (new-line '(0 . 0) '(10 . 50)))]
         [rect_sstyle (sstyle-new)]
         [group_sstyle (sstyle-new)]
         [cross_line_id #f]
         [pattern_id #f]
         )

     (set-SSTYLE-stroke-width! group_sstyle 1)
     (set-SSTYLE-stroke! group_sstyle "black")
     (set! cross_line_id
           (svg-def-group
            (lambda ()
              (svg-place-widget line1_id #:style group_sstyle)
              (svg-place-widget line2_id #:style group_sstyle)
              )))

     (set-SSTYLE-stroke-width! rect_sstyle 2)
     (set-SSTYLE-stroke! rect_sstyle "red")
     (set-SSTYLE-fill! rect_sstyle "orange")
     (set! pattern_id
           (svg-def-group
            (lambda ()
              (svg-place-widget rect_id #:style rect_sstyle)
              (svg-place-widget cross_line_id #:at '(0 . 0))
              (svg-place-widget cross_line_id #:at '(10 . 0))
              (svg-place-widget cross_line_id #:at '(20 . 0))
              (svg-place-widget cross_line_id #:at '(30 . 0))
              (svg-place-widget cross_line_id #:at '(40 . 0)))))

     (svg-place-widget pattern_id #:at '(0 . 0))
     (svg-place-widget pattern_id #:at '(50 . 0))
     (svg-place-widget pattern_id #:at '(0 . 50))
     (svg-place-widget pattern_id #:at '(50 . 50))
     )))
}|
@image{showcase/group/group2.svg}
