#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path text1_svg "../../showcase/text/text1.svg")
(define-runtime-path text2_svg "../../showcase/text/text2.svg")
(define-runtime-path text3_svg "../../showcase/text/text3.svg")

(define test-all
  (test-suite
   "test-text"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            310 70
            (lambda ()
              (let ([text (svg-text-def "城春草木深" #:font-size? 50)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#ED6E46")
                (svg-use-shape text _sstyle #:at? '(30 . 60))
                (svg-show-default))))])

      (call-with-input-file text1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-rotate"

    (let ([actual_svg
           (svg-out
            350 120
            (lambda ()
              (let ([text (svg-text-def "城春草木深" #:font-size? 50 #:rotate? '(10 20 30 40 50) #:textLength? 300)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#ED6E46")
                (svg-use-shape text _sstyle #:at? '(30 . 60))
                (svg-show-default))))])

      (call-with-input-file text2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-decoration"

    (let ([actual_svg
           (svg-out
            350 300
            (lambda ()
              (let (
                    [text1 (svg-text-def "国破山河在" #:font-size? 50 #:text-decoration? 'overline)]
                    [text2 (svg-text-def "国破山河在" #:font-size? 50 #:text-decoration? 'underline)]
                    [text3 (svg-text-def "国破山河在" #:font-size? 50 #:text-decoration? 'line-through)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#ED6E46")
                (svg-use-shape text1 _sstyle #:at? '(30 . 60))
                (svg-use-shape text2 _sstyle #:at? '(30 . 160))
                (svg-use-shape text3 _sstyle #:at? '(30 . 260))
                (svg-show-default))))])

      (call-with-input-file text3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
