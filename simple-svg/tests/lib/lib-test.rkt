#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/global.rkt"
         "../../src/lib.rkt")

(define test-all
  (test-suite
   "test-tool"

   (test-case
    "test-svg-precision"

    (parameterize
        ([*PRECISION* 4])
      (check-equal? (svg-precision 30.0) "30")
      (check-equal? (svg-precision 30) "30")
      (check-equal? (svg-precision 30.0000) "30")
      (check-equal? (svg-precision 30.0001) "30.0001")
      (check-equal? (svg-precision 30.00001) "30")
      (check-equal? (svg-precision 30) "30")
      (check-equal? (svg-precision 30.123) "30.123")
      (check-equal? (svg-precision 30.1234) "30.1234")
      (check-equal? (svg-precision 30.12344) "30.1234")
      (check-equal? (svg-precision 30.12345) "30.1235")
      (check-equal? (svg-precision 167.88854381999835) "167.8885")
      (check-equal? (svg-precision 167.88855) "167.8886"))

    (parameterize
        ([*PRECISION* 0])
      (check-equal? (svg-precision 0.12345678) "0"))

    (parameterize
        ([*PRECISION* 1])
      (check-equal? (svg-precision 0.12345678) "0.1"))

    (parameterize
        ([*PRECISION* 2])
      (check-equal? (svg-precision 0.12345678) "0.12"))

    (parameterize
        ([*PRECISION* 3])
      (check-equal? (svg-precision 0.12345678) "0.123"))

    (parameterize
        ([*PRECISION* 4])
      (check-equal? (svg-precision 0.12345678) "0.1235"))

    (parameterize
        ([*PRECISION* 5])
      (check-equal? (svg-precision 0.12345678) "0.12346"))

    (parameterize
        ([*PRECISION* 6])
      (check-equal? (svg-precision 0.12345678) "0.123457"))
    )

   ))

(run-tests test-all) 
