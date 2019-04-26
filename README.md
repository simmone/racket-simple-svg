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
        #:stroke-width? 1
        (lambda ()
          (rect 100 100 "#BBC42A")))))
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect.svg)

# with-output-to-svg
```racket
(define (with-output-to-svg output_port write_proc
                            #:width? [width? 300]
                            #:height? [height? 300]
                            #:viewBoxX? [viewBoxX? 0]
                            #:viewBoxY? [viewBoxY? 0]
                            #:viewBoxWidth? [viewBoxWidth? width?]
                            #:viewBoxHeight? [viewBoxHeight? height?]
                            #:stroke-width? [stroke-width? 0]
                            #:stroke-fill? [stroke-fill? "red"]
                            #:fill? [fill? "white"]
                            )
```

  output_port to represent a file or a string, all svg actions should in the procedure.
  
  #:width? and #:height? set canvas size, or it'll be a 300X300.

  default is no stroke, use stroke should set #:stroke-width? > 0.

  #:stroke-fill? set the stroke color, default is "red".

  #:fill? set the canvas color, default is "white".
# Shapes

## Rectangle

```racket
(define (rect width height fill
              #:start_point [start_point '(0 . 0)]
              #:radius [radius '(0 . 0)])
```

  draw a rectangle at start point '(x . y).

  use radius to set corner radius: '(radiusX . radiusY).

### rect
```racket
  (rect 100 100 "#BBC42A")
```
![ScreenShot](simple-svg/showcase/shapes/rect/rect.svg)

### with start_point
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
(define (circle center_point radius fill)
```
  draw a circle by center_point and radius.
  
### circle
```racket
  (circle '(100 . 100) 50 "#ED6E46")
```
![ScreenShot](simple-svg/showcase/shapes/circle/circle.svg)
