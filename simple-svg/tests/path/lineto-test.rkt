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
                        (svg-path-close)))]
                    [svgview_path (new-svgview)])

                (set-svgview-stroke-width! svgview_path 5)
                (set-svgview-stroke! svgview_path "#7AA20D")
                (set-svgview-stroke-linejoin! svgview_path 'round)
                (svg-use-shape path svgview_path)

                (svg-show-default))))])
      
      (call-with-input-file lineto_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
