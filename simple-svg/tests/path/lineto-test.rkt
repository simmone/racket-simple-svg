#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

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
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(5 . 5))
                         (svg-path-hlineto 100)
                         (svg-path-vlineto 100)
                         (svg-path-lineto '(-50 . 50))
                         (svg-path-lineto '(-50 . -50))
                         (svg-path-close))))]
                    [sstyle_path (sstyle-new)])

                (set-SSTYLE-fill! sstyle_path "none")
                (set-SSTYLE-stroke-width! sstyle_path 5)
                (set-SSTYLE-stroke! sstyle_path "#7AA20D")
                (set-SSTYLE-stroke-linejoin! sstyle_path 'round)
                (svg-place-widget path_id #:style sstyle_path))))])

      (call-with-input-file lineto_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
