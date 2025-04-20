#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
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
              (let ([radius_to_circle_id_map (make-hash)]
                    [origin_radius 100]
                    [_sstyle (sstyle-new)])
                
                (let loop-radius ([loop_radius origin_radius])
                  (when (> loop_radius 6)
                    (hash-set! radius_to_circle_id_map loop_radius (svg-def-shape (new-circle loop_radius)))
                    (loop-radius (/ loop_radius 2))))
                
                (set-SSTYLE-stroke! _sstyle "red")
                (set-SSTYLE-stroke-width! _sstyle 1)
                
                (let ([top_group_id
                       (svg-def-group
                        (lambda ()
                          (let loop ([loop_x 200]
                                     [loop_y 200]
                                     [loop_radius origin_radius])
                            (when (> loop_radius 6)
                              (let ([circle_id (hash-ref radius_to_circle_id_map loop_radius)])
                                (svg-place-widget circle_id #:at (cons loop_x loop_y)))

                              (loop (+ loop_x loop_radius) loop_y (/ loop_radius 2))
                              (loop (- loop_x loop_radius) loop_y (/ loop_radius 2))
                              (loop loop_x (+ loop_y loop_radius) (/ loop_radius 2))
                              (loop loop_x (- loop_y loop_radius) (/ loop_radius 2))))))])
                  (svg-place-widget top_group_id #:style _sstyle)))))])

      (call-with-input-file recursive_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-recursive)
