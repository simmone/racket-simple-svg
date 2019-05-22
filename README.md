# racket-simple-svg

A SVG(Scalable Vector Graphics) generate tool for Racket
==================

# Install
    raco pkg install simple-svg

# Basic Usage
```racket
(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-rect-def 100 100)])
      (svg-use rec #:fill? "#BBC42A")
      (svg-show-default))))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect.svg)

## svg-out
```racket
(svg-out
  width natural?
  height natural?
  procedure procedure?
  [#:viewBox? viewBox? (or/c #f (list/c natural? natural? natural? natural?)) #f]
```
  specify width and height manully.

  viewBox?: '(x y width height), if needed.

## basic usage

  1. all svg drawings should occur in the svg-out's procedure.
  2. use svg-...-def define shape first.
  3. svg-use reuse the shape in group, if not specify which group, all svg-use included in the default group.
  4. svg-show-default shows default group at '(0 . 0), or svg-show the specific group at any point.

  define shape first, then define group, reuse shape in group(s) any times and styles, show group(s) in canvas any times.

  the shape's define just contains it's basic properties.
  svg-use add the axis, fill, stroke etcs.

  ie: define a rect by width and height, then resue it by svg-use any times,
      each svg-use can use different axis, fill or stroke.

```racket
(let (
      [blue_rec (svg-rect-def 150 150)]
      [green_rec (svg-rect-def 100 100)]
      [red_rec (svg-rect-def 50 50)]
      )
  (svg-use blue_rec #:fill? "blue")
  (svg-use green_rec #:fill? "green" #:at? '(25 . 25))
  (svg-use red_rec #:fill? "red" #:at? '(50 . 50))
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/rect/m_rect.svg)

# Shapes

## Rectangle

```racket
(svg-rect-def
  width natural?
  height natural?
  #:radius? [radius? #f]
```
  define a rectangle.

  use radius to set corner radius: '(radiusX . radiusY).

### rect
```racket
(let ([rec (svg-rect-def 100 100)])
  (svg-use rec #:fill? "#BBC42A")
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect.svg)

### with start_point(no padding)
```racket
(let ([rec (svg-rect-def 100 100)])
  (svg-use rec #:fill? "#BBC42A" #:at? '(50 . 50))
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect_y.svg)

### corner radius
```racket
(let ([rec (svg-rect-def 100 100 #:radius? '(5 . 10))])
  (svg-use rec #:fill? "#BBC42A")
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect_radius.svg)

### multiple rect
```racket
(let (
  [blue_rec (svg-rect-def 150 150)]
  [green_rec (svg-rect-def 100 100)]
  [red_rec (svg-rect-def 50 50)]
  )
  (svg-use blue_rec #:fill? "blue")
  (svg-use green_rec #:fill? "green" #:at? '(25 . 25))
  (svg-use red_rec #:fill? "red" #:at? '(50 . 50))
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/rect/m_rect.svg)

## Circle

```racket
(svg-circle-def
   radius natural?)
```
  define a circle by radius length.
  
### circle
```racket
(let ([circle (svg-circle-def 50)])
  (svg-use circle #:at? '(50 . 50) #:fill? "#ED6E46")
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/circle/circle.svg)

### multiple circle
```racket
  (let ([circle (svg-circle-def 50)])
    (svg-use circle #:at? '(50 . 50) #:fill? "red")
    (svg-use circle #:at? '(150 . 50) #:fill? "yellow")
    (svg-use circle #:at? '(50 . 150) #:fill? "blue")
    (svg-use circle #:at? '(150 . 150) #:fill? "green")
    (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/circle/circle3.svg)

## Ellipse

```racket
(svg-ellipse-def
  radius (cons/c natural? natural?))
```
  define a ellipse by radius length: '(width . height).
  
### ellipse
```racket
(let ([ellipse (svg-ellipse-def '(100 . 50))])
  (svg-use ellipse #:at? '(100 . 50) #:fill? "#7AA20D")
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/ellipse/ellipse.svg)

## Line

```racket
(svg-line-def
    start_point (cons/c natural? natural?)
    end_point (cons/c natural? natural?))
```
  define a line by start, end point.
  
### line
```racket
(let ([line (svg-line-def '(0 . 0) '(100 . 100))])
  (svg-use line #:at? '(5 . 5) #:stroke? '(10 . "#765373"))
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/line/line.svg)

## Polyline

```racket
(define (polyline points))
```
  define a polyline by points list.
  
### polyline
```racket
(let ([polyline
  (svg-polyline-def
    '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))])
  (svg-use polyline #:at? '(5 . 5) #:stroke-width? 5 #:stroke? "#BBC42A" #:fill? "blue")
  (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/polyline/polyline.svg)

## Polygon

```racket
(svg-polygon-def
    points (listof (cons/c natural? natural?)))
```
  define a polygon by points list.
  
### polygon
```racket
(let ([polygon
  (svg-polygon-def
    '((0 . 25) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75)))])
    (svg-use polygon #:at? '(5 . 5) #:stroke-width? 5 #:stroke? "#765373" #:fill? "#ED6E46")
    (svg-show-default))
```
![ScreenShot](simple-svg/showcase/shapes/polygon/polygon.svg)

## Path

define a path programmtially.

```racket
(define (svg-path-def
          path_proc procedure?))
```
  all path actions should be include in this procedure: moveto, curve etc.

### Raw Path

```racket
(define (svg-path-raw
          raw_data string?))
```
  define a bunch path by raw data.

### rawpath
```racket
(let ([path
       (svg-path-def
         (lambda ()
         (svg-path-raw
         "M248.761,92c0,9.801-7.93,17.731-17.71,17.731c-0.319,0-0.617,0-0.935-0.021
         c-10.035,37.291-51.174,65.206-100.414,65.206 c-49.261,0-90.443-27.979-100.435-65.334
         c-0.765,0.106-1.531,0.149-2.317,0.149c-9.78,0-17.71-7.93-17.71-17.731
         c0-9.78,7.93-17.71,17.71-17.71c0.787,0,1.552,0.042,2.317,0.149
         C39.238,37.084,80.419,9.083,129.702,9.083c49.24,0,90.379,27.937,100.414,65.228h0.021
         c0.298-0.021,0.617-0.021,0.914-0.021C240.831,74.29,248.761,82.22,248.761,92z")))])

         (svg-use path
           #:fill? "#7AA20D"
           #:stroke-width? 9
           #:stroke? "#7AA20D"
           #:stroke-linejoin? 'round)

         (svg-show-default))
```
![ScreenShot](simple-svg/showcase/path/raw_path.svg)

### svg-path-moveto/moveto*
```racket
(define (svg-path-moveto point)
(define (svg-path-moveto* point)
```
  moveto* use absolute position.

  moveto use relative position.

### svg-close-path
```racket
(define (svg-path-close))
```
close a path.

### svg-path-lineto/lineto*/hlineto/vlineto

```racket
(define (svg-path-lineto point)
```
  lineto* is the absolute version.
  horizontal line: hlineto.
  vertical line: vlineto.

```racket
(let ([path
  (svg-path-def
    (lambda ()
      (svg-path-moveto* '(10 . 10))
      (svg-path-hlineto 100)
      (svg-path-vlineto 100)
      (svg-path-lineto '(-50 . 50))
      (svg-path-lineto '(-50 . -50))
      (svg-path-close)))]
     [red_dot (svg-circle-def 2)])

     (svg-use path
       #:stroke-width? 1
       #:stroke? "#7AA20D"
       #:stroke-linejoin? 'round)

       (svg-use red_dot #:at? '(10 . 10) #:fill? "red")
       (svg-use red_dot #:at? '(110 . 110) #:fill? "red")
       (svg-use red_dot #:at? '(10 . 110) #:fill? "red")
       (svg-use red_dot #:at? '(110 . 10) #:fill? "red")

     (svg-show-default))
```
![ScreenShot](simple-svg/showcase/path/lineto.svg)

### Cubic Bezier Curve

```racket
(define (ccurve point1 point2 point3)
(define (ccurve* point1 point2 point3)
```
  use three control points to draw a Cubic Bezier Curve.

  ccurve* use absolute position.

  ccurve use relative position, relative to the start position.

```racket
  (path
    #:stroke-fill? "#333333"
    #:stroke-width? 3
    (lambda ()
      (moveto* '(0 . 50))
      (ccurve* '(20 . 5) '(70 . 5) '(90 . 50))
      (ccurve* '(110 . 95) '(160 . 95) '(180 . 50))))
```
![ScreenShot](simple-svg/showcase/path/ccurve1.svg)

### Quadratic Bezier Curve

```racket
(define (svg-path-qcurve point1 point2)
(define (svg-path-qcurve* point1 point2)
```
  use two control points to draw a Quadratic Bezier Curve.

  qcurve* use absolute position.

  qcurve use relative position, relative to the start position.

```racket
(svg-out
  #:canvas? '(1 "red" "white")
  (lambda ()
    (let ([path
            (svg-path-def
              (lambda ()
              (svg-path-moveto* '(10 . 60))
              (svg-path-qcurve* '(60 . 10) '(110 . 60))
              (svg-path-qcurve* '(160 . 110) '(210 . 60))))
            ]
          [red_dot (svg-circle-def 2)])

    (svg-use path
      #:fill? "white"
      #:stroke? "#333333"
      #:stroke-width? 3)

      (svg-use red_dot #:at? '(10 . 60) #:fill? "red")
      (svg-use red_dot #:at? '(60 . 10) #:fill? "red")
      (svg-use red_dot #:at? '(110 . 60) #:fill? "red")
      (svg-use red_dot #:at? '(160 . 110) #:fill? "red")
      (svg-use red_dot #:at? '(210 . 60) #:fill? "red")

      (svg-show-default))))
```

```racket
(svg-path-moveto* '(10 . 60))
(svg-path-qcurve '(50 . -50) '(100 . 0))
(svg-path-qcurve '(50 . 50) '(100 . 0))
```
![ScreenShot](simple-svg/showcase/path/qcurve1.svg)

### Cubic Bezier Curve

```racket
(define (svg-path-ccurve point1 point2 point3)
(define (svg-path-ccurve* point1 point2 point3)
```
  use three control points to draw a Cubic Bezier Curve.

  ccurve* use absolute position.

  ccurve use relative position, relative to the start position.

```racket
(svg-out
  #:canvas? '(1 "red" "white")
  (lambda ()
    (let ([path
            (svg-path-def
              (lambda ()
              (svg-path-moveto* '(10 . 60))
              (svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
              (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
            ))]
          [red_dot (svg-circle-def 2)])

          (svg-use path
            #:stroke? "#333333"
            #:stroke-width? 3)

          (svg-use red_dot #:at? '(10 . 60) #:fill? "red")
          (svg-use red_dot #:at? '(30 . 15) #:fill? "red")
          (svg-use red_dot #:at? '(80 . 15) #:fill? "red")
          (svg-use red_dot #:at? '(100 . 60) #:fill? "red")
          (svg-use red_dot #:at? '(120 . 105) #:fill? "red")
          (svg-use red_dot #:at? '(170 . 105) #:fill? "red")
          (svg-use red_dot #:at? '(190 . 60) #:fill? "red")

          (svg-show-default))))
```

```racket
(svg-path-moveto* '(10 . 60))
(svg-path-ccurve '(20 . -45) '(70 . -45) '(90 . 0))
(svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
```
![ScreenShot](simple-svg/showcase/path/ccurve1.svg)

### arc

```racket
(define (arc point radius direction size)
```
  arc* is the absolute version.

  point is the end point.
  
  radius spcify the ellipse's size.
  
  direction is a simplified large-arc-flag and sweep-flag's comibination.
  
  as the arc's size can't be calculated, so should set the arc size manully.
```racket
(path
  #:stroke-fill? "#ccccff"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'left_big '(160 . 75))))

(path
  #:stroke-fill? "green"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'left_small '(160 . 75))))

(path
  #:stroke-fill? "blue"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'right_big '(280 . 110))))

(path
  #:stroke-fill? "yellow"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'right_small '(160 . 75))))
```
![ScreenShot](simple-svg/showcase/path/arc.svg)
