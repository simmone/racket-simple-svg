#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path recursive_svg "../../showcase/example/recursive.svg")

(define test-recursive
  (test-suite
   "test-recursive"

   (test-case
    "test-recursive"

    (let ([svg_str
           (svg-out
            400 400
            (lambda ()
              (let ([_sstyle (sstyle-new)]
                    [top_group_id
                     (svg-def-group
                      (lambda ()
                        (let loop ([loop_x 200]
                                   [loop_y 200]
                                   [loop_radius 100])
                          (when (> loop_radius 6)
                            (let ([circle_id (svg-def-shape (new-circle loop_radius))])
                              (svg-place-widget circle_id #:at (cons loop_x loop_y)))

                            (loop (+ loop_x loop_radius) loop_y (/ loop_radius 2))
                            (loop (- loop_x loop_radius) loop_y (/ loop_radius 2))
                            (loop loop_x (+ loop_y loop_radius) (/ loop_radius 2))
                            (loop loop_x (- loop_y loop_radius) (/ loop_radius 2))))))])

                (set-SSTYLE-stroke! _sstyle "red")
                (set-SSTYLE-stroke-width! _sstyle 1)

                (svg-place-widget top_group_id #:style _sstyle))))])

      (call-with-input-file recursive_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-recursive)
