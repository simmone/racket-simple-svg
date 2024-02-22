#lang scribble/manual

@title{svg-path-arc/arc*}

@image{showcase/path/arc.png}

@codeblock|{
(svg-path-arc (->
      (cons/c number? number?)
      (cons/c number? number?)
      (or/c 'left_big 'left_small 'right_big 'right_small)
      void?))
(svg-path-arc* (->
      (cons/c number? number?)
      (cons/c number? number?)
      (or/c 'left_big 'left_small 'right_big 'right_small)
      void?))
}|
  define a elliptical arc.

  the arc is a part of ellipse, through start and end point.

  point is the end point.
  
  radius specify the ellipse's size.
  
  direction is a simplified large-arc-flag and sweep-flag's comibination.

@codeblock|{
(svg-out
 300 130
 (lambda ()
   (let (
         [arc1_id
           (svg-def-shape
             (new-path
               (lambda ()
                 (svg-path-moveto* '(130 . 45))
                 (svg-path-arc* '(170 . 85) '(80 . 40) 'left_big))))]
         [arc2_id
           (svg-def-shape
             (new-path
               (lambda ()
                 (svg-path-moveto* '(130 . 45))
                 (svg-path-arc* '(170 . 85) '(80 . 40) 'left_small))))]
         [arc3_id
           (svg-def-shape
             (new-path
               (lambda ()
                 (svg-path-moveto* '(130 . 45))
                 (svg-path-arc* '(170 . 85) '(80 . 40) 'right_big))))]
         [arc4_id
           (svg-def-shape
             (new-path
               (lambda ()
                 (svg-path-moveto* '(130 . 45))
                 (svg-path-arc* '(170 . 85) '(80 . 40) 'right_small))))]
         [arc_style (sstyle-new)]
         [red_dot_id (svg-def-shape (new-circle 5))]
         [dot_style (sstyle-new)]
         )

     (set-SSTYLE-stroke-width! arc_style 3)
     (set-SSTYLE-fill! arc_style "none")
     
     (let ([_arc_style (struct-copy SSTYLE arc_style)])
       (set-SSTYLE-stroke! _arc_style "#ccccff")
       (svg-place-widget arc1_id #:style _arc_style))

     (let ([_arc_style (struct-copy SSTYLE arc_style)])
       (set-SSTYLE-stroke! _arc_style "green")
       (svg-place-widget arc2_id #:style _arc_style))

     (let ([_arc_style (struct-copy SSTYLE arc_style)])
       (set-SSTYLE-stroke! _arc_style "blue")
       (svg-place-widget arc3_id #:style _arc_style))

     (let ([_arc_style (struct-copy SSTYLE arc_style)])
       (set-SSTYLE-stroke! _arc_style "yellow")
       (svg-place-widget arc4_id #:style _arc_style))

     (set-SSTYLE-fill! dot_style "red")
     (svg-place-widget red_dot_id #:style dot_style #:at '(130 . 45))
     (svg-place-widget red_dot_id #:style dot_style #:at '(170 . 85)))))
}|
@image{showcase/path/arc.svg}
