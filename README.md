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

