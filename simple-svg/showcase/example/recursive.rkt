#lang racket

(require simple-svg)

(let ([canvas_size 400])
  (with-output-to-file
      "recursive.svg" #:exists 'replace
      (lambda ()
        (printf "~a\n"
                (svg-out
                 canvas_size canvas_size
                 (lambda ()
                   (let ([_sstyle (sstyle-new)])
                     (sstyle-set! _sstyle 'stroke "red")
                     (sstyle-set! _sstyle 'stroke-width 1)

                     (letrec ([recur-circle 
                               (lambda (x y radius)
                                 (let ([circle (svg-def-circle radius)])
                                   (svg-use-shape circle _sstyle #:at? (cons x y)))

                                 (when (> radius 8)
                                   (recur-circle (+ x radius) y (floor (/ radius 2)))
                                   (recur-circle (- x radius) y (floor (/ radius 2)))
                                   (recur-circle x (+ y radius) (floor (/ radius 2)))
                                   (recur-circle x (- y radius) (floor (/ radius 2)))))])
                       (recur-circle 200 200 100)))
                   
                   (svg-show-default)))))))
