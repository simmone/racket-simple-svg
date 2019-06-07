#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path group1_svg "../../showcase/group/group1.svg")

(define test-all
  (test-suite
   "test-group"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            220 280
            (lambda ()
              (let (
                    [line1 (svg-def-line '(0 . 0) '(30 . 30))]
                    [line2 (svg-def-line '(0 . 15) '(30 . 15))]
                    [line3 (svg-def-line '(15 . 0) '(15 . 30))]
                    [line4 (svg-def-line '(30 . 0) '(0 . 30))]
                    [_sstyle (sstyle-new)]
                    [group_sstyle (sstyle-new)])
                (sstyle-set! _sstyle 'stroke-width 5)
                (sstyle-set! _sstyle 'stroke "#765373")
                (svg-def-group
                 "pattern"
                 (lambda ()
                   (svg-use-shape line1 _sstyle #:at? '(5 . 5))
                   (svg-use-shape line2 _sstyle #:at? '(5 . 5))
                   (svg-use-shape line3 _sstyle #:at? '(5 . 5))
                   (svg-use-shape line4 _sstyle #:at? '(5 . 5))))
                (svg-show-group "pattern" group_sstyle #:at? '(50 . 50))
                (svg-show-group "pattern" group_sstyle #:at? '(100 . 100))
                (svg-show-group "pattern" group_sstyle #:at? '(80 . 200))
                (svg-show-group "pattern" group_sstyle #:at? '(150 . 100))
                )))])

      (call-with-input-file group1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
