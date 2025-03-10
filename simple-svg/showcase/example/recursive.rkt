#lang racket

(require "../../main.rkt")

(let ([canvas_size 400])
  (with-output-to-file
      "recursive.svg" #:exists 'replace
      (lambda ()
        (printf "~a\n"
                (svg-out
                 canvas_size canvas_size
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

                     (let loop ([loop_x 200]
                                [loop_y 200]
                                [loop_radius origin_radius])
                       (when (> loop_radius 6)
                         (let ([circle_id (hash-ref radius_to_circle_id_map loop_radius)])
                           (svg-place-widget circle_id #:style _sstyle #:at (cons loop_x loop_y)))

                         (loop (+ loop_x loop_radius) loop_y (/ loop_radius 2))
                         (loop (- loop_x loop_radius) loop_y (/ loop_radius 2))
                         (loop loop_x (+ loop_y loop_radius) (/ loop_radius 2))
                         (loop loop_x (- loop_y loop_radius) (/ loop_radius 2)))))))))))
