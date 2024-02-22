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
                   (let ([_sstyle (sstyle-new)])
                     (set-SSTYLE-stroke! _sstyle "red")
                     (set-SSTYLE-stroke-width! _sstyle 1)

                     (letrec ([recur-circle 
                               (lambda (x y radius)
                                 (let ([circle_id (svg-def-shape (new-circle radius))])
                                   (svg-place-widget circle_id #:style _sstyle #:at (cons x y)))

                                 (when (> radius 8)
                                   (recur-circle (+ x radius) y (/ radius 2))
                                   (recur-circle (- x radius) y (/ radius 2))
                                   (recur-circle x (+ y radius) (/ radius 2))
                                   (recur-circle x (- y radius) (/ radius 2))))])
                       (recur-circle 200 200 100)))))))))
