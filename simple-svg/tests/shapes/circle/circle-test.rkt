#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../lib/display.rkt")
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
                    [_display (new-display)])
                (set-display-fill! _display "#BBC42A")
                (set-display-pos! _display '(50 . 50))
                (svg-use-shape circle _display)
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
                    [red_display (new-display)]
                    [yellow_display (new-display)]
                    [blue_display (new-display)]
                    [green_display (new-display)])
                
                (set-display-fill! red_display "red")
                (set-display-pos! red_display '(50 . 50))
                (svg-use-shape circle red_display)

                (set-display-fill! yellow_display "yellow")
                (set-display-pos! yellow_display '(150 . 50))
                (svg-use-shape circle yellow_display)

                (set-display-fill! blue_display "blue")
                (set-display-pos! blue_display '(50 . 150))
                (svg-use-shape circle blue_display)

                (set-display-fill! green_display "green")
                (set-display-pos! green_display '(150 . 150))
                (svg-use-shape circle green_display)

                (svg-show-default))))])
      
      (call-with-input-file circle3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
