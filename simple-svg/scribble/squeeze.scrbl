#lang scribble/manual

@title{Reduce size}

@section{Shape is auto squeezed}

Shape define is unique, you can define a shape with same arguments many times, in the svg, it'll be defined only once!

Example:

You defined same size rectangle many times, it'll define only once in the result svg file.

@codeblock|{
...
(rec1_id (svg-def-shape (new-rect 100 100)))
...
(rec2_id (svg-def-shape (new-rect 100 100)))
...
(rec3_id (svg-def-shape (new-rect 100 100)))
}|

In generated svg, it is define only once, used many times.

@codeblock|{
  <defs>
    <rect id="s1" width="100" height="100" />
  </defs>
...
  <use xlink:href="#s1" fill="red" />
...
  <use xlink:href="#s1" fill="blue" />
...
  <use xlink:href="#s1" fill="black" />
}|

@section{Use group to reduce size}

Svg is a plain xml file, so you can use group to include same style shape/group/gadget.

Second, set this group style, it can reduce svg size.

Example:

Below is the recursive circles's code, simple and clean.

@codeblock|{
(svg-out
 canvas_size canvas_size
 (lambda ()
   (let ([_sstyle (sstyle-new)])
     (set-SSTYLE-stroke! _sstyle "red")
     (set-SSTYLE-stroke-width! _sstyle 1)

     (letrec ([recur-circle 
               (lambda (x y radius)
                 (let ([circle_id (svg-def-shape (new-circle radius))])
                   (svg-place-widget circle_id #:style _sstyle #:at (cons x y)))

                 (when (> radius 8)
                   (recur-circle (+ x radius) y (/ radius 2))
                   (recur-circle (- x radius) y (/ radius 2))
                   (recur-circle x (+ y radius) (/ radius 2))
                   (recur-circle x (- y radius) (/ radius 2))))])
       (recur-circle 200 200 100)))))
}|
@image{showcase/example/recursive.svg}

But open svg file, you will see this:

@codeblock|{
  <use xlink:href="#s1" x="200" y="200" fill="none" stroke-width="1" stroke="red" />
  <use xlink:href="#s2" x="300" y="200" fill="none" stroke-width="1" stroke="red" />
  <use xlink:href="#s3" x="350" y="200" fill="none" stroke-width="1" stroke="red" />
  <use xlink:href="#s4" x="375" y="200" fill="none" stroke-width="1" stroke="red" />
}|

Each circle have same stroke-width and stroke-color, style info is duplicated! It'll make the svg file too big.

So if needed, sacrifice some code clean, use group to reduce duplicated style.

@codeblock|{
(svg-out
 canvas_size canvas_size
 (lambda ()
   (let ([radius_to_circle_id_map (make-hash)]
         [origin_radius 100]
         [_sstyle (sstyle-new)])
     
     (let loop-radius ([loop_radius origin_radius])
       (when (> loop_radius 6)
         (hash-set! radius_to_circle_id_map loop_radius (svg-def-shape (new-circle loop_radius)))
         (loop-radius (/ loop_radius 2))))
     
     (set-SSTYLE-stroke! _sstyle "red")
     (set-SSTYLE-stroke-width! _sstyle 1)
     
     (let ([top_group_id
            (svg-def-group
             (lambda ()
               (let loop ([loop_x 200]
                          [loop_y 200]
                          [loop_radius origin_radius])
                 (when (> loop_radius 6)
                   (let ([circle_id (hash-ref radius_to_circle_id_map loop_radius)])
                     (svg-place-widget circle_id #:at (cons loop_x loop_y)))

                   (loop (+ loop_x loop_radius) loop_y (/ loop_radius 2))
                   (loop (- loop_x loop_radius) loop_y (/ loop_radius 2))
                   (loop loop_x (+ loop_y loop_radius) (/ loop_radius 2))
                   (loop loop_x (- loop_y loop_radius) (/ loop_radius 2))))))])
       (svg-place-widget top_group_id #:style _sstyle)))))
}|

Svg file size shrink from 30k to 15k.