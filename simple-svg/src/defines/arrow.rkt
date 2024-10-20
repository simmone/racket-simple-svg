#lang racket

(provide (contract-out
          [struct ARROW
                  (
                   (start_x number?)
                   (start_y number?)
                   (end_x number?)
                   (end_y number?)
                   (height number?)
                   (base number?)
                   )
                  ]
          [new-arrow (-> (cons/c number? number?) (cons/c number? number?) number? number? ARROW?)]
          [format-arrow (-> string? ARROW? string?)]
          ))

(struct ARROW (
              [start_x #:mutable]
              [start_y #:mutable]
              [end_x #:mutable]
              [end_y #:mutable]
              [height #:mutable]
              [base #:mutable]
              )
        #:transparent
        )

(define (new-arrow start_point end_point height base)
  (ARROW (car start_point) (cdr start_point) (car end_point) (cdr end_point) height base))

(define (format-arrow shape_id arrow)
  (let* (
         [start_x (ARROW-start_x arrow)]
         [start_y (ARROW-start_y arrow)]
         [end_x (ARROW-end_x arrow)]
         [end_y (ARROW-end_y arrow)]
         [height (ARROW-height arrow)]
         [base (ARROW-base arrow)]
         [theta (atan (/ (- end_y start_y) (- end_x start_x)))]
         [alpha (- (/ pi 2) theta)]
         [delta_q (cons (* base (cos alpha)) (* base (sin alpha)))]
         [Q (cons (- end_x (car delta_q)) (+ end_y (cdr delta_q)))]
         [S (cons (+ end_x (car delta_q)) (- end_y (cdr delta_q)))]
         [delta_r (cons (* height (cos theta)) (* height (sin theta)))]
         [R (cons (+ end_x (car delta_r)) (+ end_y (cdr delta_r)))])

    (format "    <polygon id=\"~a\" points=\"~a\" />\n"
            shape_id
            (with-output-to-string
              (lambda ()
                (printf "~a,~a " start_x start_y)
                (printf "~a,~a " end_x end_y)
                (printf "~a,~a " (car Q) (cdr Q))
                (printf "~a,~a " (car R) (cdr R))
                (printf "~a,~a" (car S) (cdr S)))))))
