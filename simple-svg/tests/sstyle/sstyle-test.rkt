#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib.rkt"
         "../../src/global.rkt"
         "../../src/define/sstyle.rkt"
         racket/runtime-path)

(define test-all
  (test-suite
   "test-unit"

   (test-case
    "test-fill1"

    (let ([_sstyle (sstyle-new)])
      (set-SSTYLE-fill-gradient! _sstyle "s1")
      (set-SSTYLE-fill-rule! _sstyle 'nonzero)
      (set-SSTYLE-fill-opacity! _sstyle 0.5)

      (check-equal?
       (parameterize
           ([*PRECISION* 4])
         (sstyle-format _sstyle))
       " fill=\"url(#s1)\" fill-rule=\"nonzero\" fill-opacity=\"0.5\""
       )))

   (test-case
    "test-fill2"

    (let ([_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "red")
      (set-SSTYLE-fill-rule! _sstyle 'nonzero)
      (set-SSTYLE-fill-opacity! _sstyle 0.5)

      (check-equal?
       (parameterize
           ([*PRECISION* 4])
         (sstyle-format _sstyle))
       " fill=\"red\" fill-rule=\"nonzero\" fill-opacity=\"0.5\""
       )))

   (test-case
    "test-stroke"

    (let ([_sstyle (sstyle-new)])
      (set-SSTYLE-stroke-width! _sstyle 5)
      (set-SSTYLE-stroke! _sstyle "#ABABAB")
      (set-SSTYLE-stroke-linejoin! _sstyle 'round)
      (set-SSTYLE-stroke-linecap! _sstyle 'square)
      (set-SSTYLE-stroke-miterlimit! _sstyle 2)
      (set-SSTYLE-stroke-dasharray! _sstyle "40,10")
      (set-SSTYLE-stroke-dashoffset! _sstyle 5)

      (check-equal?
       (parameterize
           ([*PRECISION* 4])
         (sstyle-format _sstyle))
       " fill=\"none\" stroke-width=\"5\" stroke=\"#ABABAB\" stroke-linejoin=\"round\" stroke-linecap=\"square\" stroke-miterlimit=\"2\" stroke-dasharray=\"40,10\" stroke-dashoffset=\"5\""
       )))

   (test-case
    "test-transform1"

    (let ([_sstyle (sstyle-new)])
      (set-SSTYLE-translate! _sstyle '(0.1 . 0.2))
      (set-SSTYLE-rotate! _sstyle 30)
      (set-SSTYLE-scale! _sstyle 1)
      (set-SSTYLE-skewX! _sstyle 2)
      (set-SSTYLE-skewY! _sstyle 3)

      (check-equal?
       (parameterize
           ([*PRECISION* 4])
         (sstyle-format _sstyle))
       " fill=\"none\" transform=\"translate(0.1 0.2) rotate(30) scale(1) skewX(2) skewY(3)\""
       )))

   (test-case
    "test-transform2"

    (let ([_sstyle (sstyle-new)])
      (set-SSTYLE-scale! _sstyle '(2 . 3))

      (check-equal?
       (parameterize
           ([*PRECISION* 4])
         (sstyle-format _sstyle))
       " fill=\"none\" transform=\"scale(2 3)\""
       )))
   ))

(run-tests test-all) 
