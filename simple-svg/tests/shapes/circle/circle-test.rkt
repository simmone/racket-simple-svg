#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path circle_svg "../../../showcase/shapes/circle/circle.svg")
(define-runtime-path circle3_svg "../../../showcase/shapes/circle/circle3.svg")

(define test-all
  (test-suite
   "test-circle"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([circle (svg-circle-def 50)]
                    [_svgview (new-svgview)])
                (set-svgview-fill! _svgview "#BBC42A")
                (set-svgview-pos! _svgview '(50 . 50))
                (svg-use-shape circle _svgview)
                (svg-show-default))))])
      
      (call-with-input-file circle_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-circle3"

    (let ([actual_svg
           (svg-out
            200 200
            (lambda ()
              (let ([circle (svg-circle-def 50)]
                    [red_svgview (new-svgview)]
                    [yellow_svgview (new-svgview)]
                    [blue_svgview (new-svgview)]
                    [green_svgview (new-svgview)])
                
                (set-svgview-fill! red_svgview "red")
                (set-svgview-pos! red_svgview '(50 . 50))
                (svg-use-shape circle red_svgview)

                (set-svgview-fill! yellow_svgview "yellow")
                (set-svgview-pos! yellow_svgview '(150 . 50))
                (svg-use-shape circle yellow_svgview)

                (set-svgview-fill! blue_svgview "blue")
                (set-svgview-pos! blue_svgview '(50 . 150))
                (svg-use-shape circle blue_svgview)

                (set-svgview-fill! green_svgview "green")
                (set-svgview-pos! green_svgview '(150 . 150))
                (svg-use-shape circle green_svgview)

                (svg-show-default))))])
      
      (call-with-input-file circle3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
