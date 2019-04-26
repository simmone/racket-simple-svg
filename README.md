# racket-simple-svg

A SVG(Scalable Vector Graphics) generate tool for Racket
==================

# Install
    raco pkg install simple-svg

# Basic Usage
```racket
  (require simple-svg)
  
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
