#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path lineto_svg "../../showcase/path/lineto.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-lineto"

    (let ([actual_svg
           (svg-out
            110 160
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(5 . 5))
                        (svg-path-hlineto 100)
                        (svg-path-vlineto 100)
                        (svg-path-lineto '(-50 . 50))
                        (svg-path-lineto '(-50 . -50))
                        (svg-path-close)))])

                (svg-use path
                         #:stroke-width? 5
                         #:stroke? "#7AA20D"
                         #:stroke-linejoin? 'round)

                (svg-show-default))))])
      
      (call-with-input-file lineto_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
