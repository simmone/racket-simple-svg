#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path arc_svg "../../showcase/path/arc.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-arc"

    (let ([actual_svg
           (svg-out
            300 130
            (lambda ()
              (let (
                    [arc1
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'left_big)))]
                    [arc2
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'left_small)))]
                    [arc3
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'right_big)))]
                    [arc4
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'right_small)))]
                    [arc_style (sstyle-new)]
                    [red_dot (svg-def-circle 5)]
                    [dot_style (sstyle-new)]
                    )

                (sstyle-set! arc_style 'stroke-width 3)
                
                (let ([_arc_style (sstyle-clone arc_style)])
                  (sstyle-set! _arc_style 'stroke "#ccccff")
                  (svg-use-shape arc1 _arc_style))

                (let ([_arc_style (sstyle-clone arc_style)])
                  (sstyle-set! _arc_style 'stroke "green")
                  (svg-use-shape arc2 _arc_style))

                (let ([_arc_style (sstyle-clone arc_style)])
                  (sstyle-set! _arc_style 'stroke "blue")
                  (svg-use-shape arc3 _arc_style))

                (let ([_arc_style (sstyle-clone arc_style)])
                  (sstyle-set! _arc_style 'stroke "yellow")
                  (svg-use-shape arc4 _arc_style))

                (sstyle-set! dot_style 'fill "red")
                (svg-use-shape red_dot dot_style #:at? '(130 . 45))
                (svg-use-shape red_dot dot_style #:at? '(170 . 85))

                (svg-show-default))))])

      (call-with-input-file arc_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
