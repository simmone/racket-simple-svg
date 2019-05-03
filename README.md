# racket-simple-svg

A SVG(Scalable Vector Graphics) generate tool for Racket
==================

# Install
    raco pkg install simple-svg

# Basic Usage
```racket
(call-with-output-file
  "basic.svg"
  (lambda (output)
    (with-output-to-svg
      output
      #:canvas? '(1 "red" "white")
      (lambda ()
        (rect 100 100 "#BBC42A")))))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect.svg)

# with-output-to-svg
```racket
(define (with-output-to-svg output_port write_proc
                            [#:padding? padding? natural? 10]
                            [#:width? width? (or/c #f natural?) #f]
                            [#:height? height? (or/c #f natural?) #f]
                            [#:viewBox? viewBox? (or/c #f (list/c natural? natural? natural? natural?)) #f]
                            [#:canvas? canvas? (or/c #f (list/c natural? string? string?)) #f]
                            )
```

  use output_port to write svg to a file or a string, all the svg actions should occur in the procedure.

  canvas size is automatically calculated.
  default generate a svg by a 10 padding.
  you can set size manully by #:width? and #:height?.

  viewBox?: '(x y width height), if needed.

  canvas?: '(stroke-width stroke-fill fill), if needed.
  
# Shapes

## Rectangle

```racket
(define (rect width height fill
              #:start_point? [start_point? #f]
              #:radius? [radius? #f]))
```

  draw a rectangle at start point '(x . y).

  use radius to set corner radius: '(radiusX . radiusY).

### rect
```racket
(rect 100 100 "#BBC42A")
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect.svg)

### with start_point(no padding)
```racket
(rect 100 100 "#BBC42A" #:start_point '(50 . 50))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect_y.svg)

### with start_point and corner radius
```racket
(rect 100 100 "#BBC42A" #:start_point '(50 . 50) #:radius '(5 . 10))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect_radius.svg)

### multiple rect
```racket
(rect 150 150 "blue")
(rect 100 100 "green")
(rect 50 50 "red")
```
![ScreenShot](simple-svg/showcase/shapes/rect/m_rect.svg)

## Circle

```racket
(define (circle center_point radius fill))
```
  draw a circle by center_point: '(x . y) and radius length.
  
### circle
```racket
(circle '(100 . 100) 50 "#ED6E46")
```
![ScreenShot](simple-svg/showcase/shapes/circle/circle.svg)

## Ellipse

```racket
(define (ellipse center_point radius_width radius_height fill))
```
  draw a ellipse by center_point and radius.
  
### ellipse
```racket
(ellipse '(150 . 150) 100 50 "#7AA20D")
```
![ScreenShot](simple-svg/showcase/shapes/ellipse/ellipse.svg)

## Line

```racket
(define (line start_point end_point stroke_fill stroke_width))
```
  draw a line by start, end point.
  
### line
```racket
(line '(0 . 0) '(100 . 100) "#765373" 8)
```
![ScreenShot](simple-svg/showcase/shapes/line/line.svg)

## Polyline

```racket
(define (polyline points stroke_fill stroke_width fill))
```
  draw a polyline by points list.
  
### polyline
```racket
(polyline 
    '((0 . 40) (40 . 40) (40 . 80) (80 . 80) (80 . 120) (120 . 120) (120 . 160))
    "#BBC42A" 6 "blue")
```
![ScreenShot](simple-svg/showcase/shapes/polyline/polyline.svg)

## Polygon

```racket
(define (polygon points fill)
```
  draw a polygon by points list.
  
### polygon
```racket
(polygon 
    '((50 . 5) (100 . 5) (125 . 30) (125 . 80) (100 . 105) (50 . 105) (25 . 80) (25 . 30))
        "#ED6E46")
```
![ScreenShot](simple-svg/showcase/shapes/polygon/polygon.svg)

## Raw Path

```racket
(define (raw-path width height raw_data
              #:fill? [fill? "none"]
              #:stroke-fill? [stroke-fill? "#333333"]
              #:stroke-width? [stroke-width? 1]
              #:stroke-linejoin? [stroke-linejoin? "round"])
```
  draw a path by raw data.

  raw data normally come from other svg tools.

  raw path's size can't be calculated, so width and height is mandatory.

### rawpath
```racket
(raw-path
  240 166
  "M248.761,92c0,9.801-7.93,17.731-17.71,17.731c-0.319,0-0.617,0-0.935-0.021
  c-10.035,37.291-51.174,65.206-100.414,65.206 c-49.261,0-90.443-27.979-100.435-65.334
  c-0.765,0.106-1.531,0.149-2.317,0.149c-9.78,0-17.71-7.93-17.71-17.731
  c0-9.78,7.93-17.71,17.71-17.71c0.787,0,1.552,0.042,2.317,0.149
  C39.238,37.084,80.419,9.083,129.702,9.083c49.24,0,90.379,27.937,100.414,65.228h0.021
  c0.298-0.021,0.617-0.021,0.914-0.021C240.831,74.29,248.761,82.22,248.761,92z"
  #:fill? "#7AA20D"
  #:stroke-fill? "#7AA20D"
  #:stroke-width? 9
  #:stroke-linejoin? "round")
```
![ScreenShot](simple-svg/showcase/path/raw_path.svg)


## Path

```racket
(define (path path_proc
              #:fill? [fill? "none"]
              #:stroke-fill? [stroke-fill? "#333333"]
              #:stroke-width? [stroke-width? 1]
              #:stroke-linejoin? [stroke-linejoin? "round"])
```
  draw a path programmtially.

  fill?, stroke-fill?, stroke-width? stroke-linejoin? same as raw-path.

  every path step should write in this procedure: moveto, curve etc.

### moveto
```racket
(define (moveto point)
(define (moveto* point)
```
  moveto* use absolute position.

  moveto use relative position, don't use moveto as the path start.

```racket
  (moveto* '(100 . 100))
```

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
(define (qcurve point1 point2)
(define (qcurve* point1 point2)
```
  use two control points to draw a Quadratic Bezier Curve.

  qcurve* use absolute position.

  qcurve use relative position, relative to the start position.

```racket
  (path
    #:stroke-fill? "#333333"
    #:stroke-width? 3
    (lambda ()
      (moveto* '(0 . 50))
      (qcurve* '(50 . 0) '(100 . 50))
      (qcurve* '(150 . 100) '(200 . 50))))
```
![ScreenShot](simple-svg/showcase/path/qcurve1.svg)