#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../src/lib/lib.rkt")
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
              (let ([circle (svg-def-circle 50)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#BBC42A")
                (svg-use-shape circle _sstyle #:at? '(50 . 50))
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
              (let ([circle (svg-def-circle 50)]
                    [red_sstyle (sstyle-new)]
                    [yellow_sstyle (sstyle-new)]
                    [blue_sstyle (sstyle-new)]
                    [green_sstyle (sstyle-new)])
                
                (set-sstyle-fill! red_sstyle "red")
                (svg-use-shape circle red_sstyle #:at? '(50 . 50))

                (set-sstyle-fill! yellow_sstyle "yellow")
                (svg-use-shape circle yellow_sstyle #:at? '(150 . 50))

                (set-sstyle-fill! blue_sstyle "blue")
                (svg-use-shape circle blue_sstyle #:at? '(50 . 150))

                (set-sstyle-fill! green_sstyle "green")
                (svg-use-shape circle green_sstyle #:at? '(150 . 150))

                (svg-show-default))))])
      
      (call-with-input-file circle3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
