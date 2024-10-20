#lang racket

(provide (contract-out
          [struct ARROW
                  (
                   (start_x number?)
                   (start_y number?)
                   (end_x number?)
                   (end_y number?)
                   (handle_base number?)
                   (head_height number?)
                   (head_base number?)
                   )
                  ]
          [new-arrow (-> (cons/c number? number?) (cons/c number? number?) number? number? number? ARROW?)]
          [format-arrow (-> string? ARROW? string?)]
          ))

(struct ARROW (
              [start_x #:mutable]
              [start_y #:mutable]
              [end_x #:mutable]
              [end_y #:mutable]
              [handle_base #:mutable]
              [head_height #:mutable]
              [head_base #:mutable]
              )
        #:transparent
        )

(define (new-arrow start_point end_point handle_base head_height head_base)
  (ARROW (car start_point) (cdr start_point) (car end_point) (cdr end_point) handle_base head_height head_base))

(define (format-arrow shape_id arrow)
  (let* (
         [start_x (ARROW-start_x arrow)]
         [start_y (ARROW-start_y arrow)]
         [end_x (ARROW-end_x arrow)]
         [end_y (ARROW-end_y arrow)]
         [horizontal_direction (if (< start_x end_x) 'RIGHT 'LEFT)]
         [vertical_direction (if (< start_y end_y) 'DOWN 'UP)]
         [handle_base (ARROW-handle_base arrow)]
         [head_height (ARROW-head_height arrow)]
         [head_base (ARROW-head_base arrow)]
         [total_base (+ handle_base head_base)]
         [x_offset (- end_x start_x)]
         [y_offset (- end_y start_y)]
         [theta (atan (/ y_offset x_offset))]
         [alpha (- (/ pi 2) theta)]
         [handle_delta_q (cons (* handle_base (cos alpha)) (* handle_base (sin alpha)))]
         [handle_bottom_left (cons (- start_x (car handle_delta_q)) (+ start_y (cdr handle_delta_q)))]
         [handle_bottom_right (cons (- end_x (car handle_delta_q)) (+ end_y (cdr handle_delta_q)))]
         [handle_top_left (cons (+ start_x (car handle_delta_q)) (- start_y (cdr handle_delta_q)))]
         [handle_top_right (cons (+ end_x (car handle_delta_q)) (- end_y (cdr handle_delta_q)))]
         [head_delta_q (cons (* total_base (cos alpha)) (* total_base (sin alpha)))]
         [Q (cons (- end_x (car head_delta_q)) (+ end_y (cdr head_delta_q)))]
         [delta_r (cons (* head_height (cos theta)) (* head_height (sin theta)))]
         [R (cons ((if (eq? horizontal_direction 'RIGHT) + -) end_x (car delta_r)) ((if (eq? vertical_direction 'DOWN) + -) end_y (cdr delta_r)))]
         [S (cons (+ end_x (car head_delta_q)) (- end_y (cdr head_delta_q)))]
         )

    (format "    <polygon id=\"~a\"\n~a"
            shape_id
            (with-output-to-string
              (lambda ()
                (printf "          points=\"\n")
                (printf "            ~a,~a\n" (car handle_bottom_left) (cdr handle_bottom_left))
                (printf "            ~a,~a\n" (car handle_bottom_right) (cdr handle_bottom_right))
                (printf "            ~a,~a\n" (car Q) (cdr Q))
                (printf "            ~a,~a\n" (car R) (cdr R))
                (printf "            ~a,~a\n" (car S) (cdr S))
                (printf "            ~a,~a\n" (car handle_top_right) (cdr handle_top_right))
                (printf "            ~a,~a\n" (car handle_top_left) (cdr handle_top_left))
                (printf "            \"/>\n")
                )))))
