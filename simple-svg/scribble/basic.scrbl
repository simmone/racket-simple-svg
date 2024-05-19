#lang scribble/manual

@title{Usage}

@section{Basic steps to use simple-svg}

1. use svg-out to define a canvas and a lambda to define all the things, at the end, output complete svg string.

2. all svg defines shoud be included in the lambda.

3. use svg-def-shape and new-* create a shape with basic properties.

4. use sstyle-new and set-SSTYLE-* define a new style.

5. if needed, use svg-def-group to combine a more complicated pattern.

6. use svg-place-widget to show a shape or a group at specific postion and style.

7. caution: position axis is (x . y), if you want use row, column to locate, it means (colunm . row).

@codeblock|{
(svg-out (->* (positive? positive? procedure?)
           (
             #:background (or/c #f string?)
             #:viewBox (or/c #f VIEW-BOX?)
           )
           string?
           ))
}|

  specify width and height manully.

  background: background color, if not null, will create a rectangle with this color on the bottom of canvas.
  
  viewBox: use (new-view-box x y width height) to create a view-box, if needed.

@codeblock|{
  (svg-def-shape (-> (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                           POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?)
                           string?))
}|

  deinfe a shape, each shape has its create function.

@codeblock|{
 (svg-def-group (-> procedure? void?))
}|
  create a group if needed.

  all svg actions in procedure will be added to the group.

@codeblock|{
  [svg-place-widget (->* (string?)
                         (
                          #:style SSTYLE?
                          #:at (cons/c (not/c negative?) (not/c negative?))
                         )
                         void?)]
}|
  place a widget(shape or group) in current group.

  specify a style and a postion, if no position, default to '(0 . 0)

@section{basic usage}

define shape first, then reuse shape and style in group(s).

@codeblock|{
(svg-out
  100 100
  (lambda ()
    (let ([rec_id (svg-def-shape (new-rect 100 100))]
          [_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "#BBC42A")
      (svg-place-widget rec_id #:style _sstyle))))
}|
@image{showcase/shapes/rect/rect.svg}

@section{background}

create a rectangle as background, same as you create a rectrangle manully.

@codeblock|{
(svg-out
 100 100
 #:background "#BBC42A"
 (lambda ()
   (let ([rec_id (svg-def-shape (new-rect 50 50))]
         [_sstyle (sstyle-new)])
     (set-SSTYLE-fill! _sstyle "#FFFFFF")
     (svg-place-widget rec_id #:style _sstyle #:at '(25 . 25)))))
}|
@image{showcase/basic/rect_in_background.svg}

@section{multiple shapes}

@codeblock|{
(svg-out
  150 150
  (lambda ()
    (let (
      [blue_rec_id (svg-def-shape (new-rect 150 150))]
      [_blue_sstyle (sstyle-new)]
      [green_rec_id (svg-def-shape (new-rect 100 100))]
      [_green_sstyle (sstyle-new)]
      [red_rec_id (svg-def-shape (new-rect 50 50))]
      [_red_sstyle (sstyle-new)])

      (set-SSTYLE-fill! _blue_sstyle "blue")
      (svg-place-widget blue_rec_id #:style _blue_sstyle)

      (set-SSTYLE-fill! _green_sstyle "green")
      (svg-place-widget green_rec_id #:style _green_sstyle #:at '(25 . 25))

      (set-SSTYLE-fill! _red_sstyle "red")
      (svg-place-widget red_rec_id #:style _red_sstyle #:at '(50 . 50)))))
}|
@image{showcase/shapes/rect/m_rect.svg}

@section{use group}

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