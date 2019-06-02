#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path text1_svg "../../showcase/text/text1.svg")
(define-runtime-path text2_svg "../../showcase/text/text2.svg")
(define-runtime-path text3_svg "../../showcase/text/text3.svg")
(define-runtime-path text4_svg "../../showcase/text/text4.svg")

(define test-all
  (test-suite
   "test-text"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            310 70
            (lambda ()
              (let ([text (svg-def-text "城春草木深" #:font-size? 50)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#ED6E46")
                (svg-use-shape text _sstyle #:at? '(30 . 50))
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
              (let ([text (svg-def-text "城春草木深" #:font-size? 50 #:rotate? '(10 20 30 40 50) #:textLength? 300)]
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
            310 280
            (lambda ()
              (let (
                    [text1 (svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'overline)]
                    [text2 (svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'underline)]
                    [text3 (svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'line-through)]
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

   (test-case
    "test-path"

    (let ([actual_svg
           (svg-out
            500 100
            (lambda ()
              (let* ([path
                      (svg-def-path
                       (lambda ()
                         (svg-path-moveto* '(10 . 60))
                         (svg-path-qcurve* '(110 . 10) '(210 . 60))
                         (svg-path-qcurve* '(310 . 110) '(410 . 60))))]
                     [path_sstyle (sstyle-new)]
                     [text
                      (svg-def-text "国破山河在 城春草木深 感时花溅泪 恨别鸟惊心"
                                    #:path? path
                                    #:path-startOffset? 5)]
                     [text_sstyle (sstyle-new)])
                (set-sstyle-fill! text_sstyle "#ED6E46")
                (svg-use-shape path path_sstyle #:hidden? #t)
                (svg-use-shape text text_sstyle)
                (svg-show-default))))])
      
      (call-with-input-file text4_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
