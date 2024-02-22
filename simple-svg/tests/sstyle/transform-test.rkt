#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path transform1_svg "../../showcase/sstyle/transform1.svg")
(define-runtime-path transform2_svg "../../showcase/sstyle/transform2.svg")

(define test-all
  (test-suite
   "test-sstyle"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            150 150
            (lambda ()
              (let ([rec_id (svg-def-shape (new-rect 100 100))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (set-SSTYLE-translate! _sstyle '(75 . 5))
                (set-SSTYLE-rotate! _sstyle 45)
                (svg-place-widget rec_id #:style _sstyle))))])
      
      (call-with-input-file transform1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            250 240
            (lambda ()
              (let ([rec_id (svg-def-shape (new-circle 50))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (set-SSTYLE-scale! _sstyle 2)
                (set-SSTYLE-skewX! _sstyle 20)
                (svg-place-widget rec_id #:style _sstyle #:at '(40 . 60)))))])
      
      (call-with-input-file transform2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all) 
