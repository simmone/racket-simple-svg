#lang racket

(require racket/serialize)

(provide (contract-out
          [struct ARROW
                  (
                   (start_x number?)
                   (start_y number?)
                   (end_x number?)
                   (end_y number?)
                   (handle_base number?)
                   (head_base number?)
                   (head_height number?)
                   )
                  ]
          [new-arrow (-> (cons/c number? number?) (cons/c number? number?) number? number? number? ARROW?)]
          [format-arrow (-> string? ARROW? string?)]
          ))

(serializable-struct ARROW (
                       [start_x #:mutable]
                       [start_y #:mutable]
                       [end_x #:mutable]
                       [end_y #:mutable]
                       [handle_base #:mutable]
                       [head_base #:mutable]
                       [head_height #:mutable]
                       )
                #:transparent
                )

(define (new-arrow start_point end_point handle_base head_base head_height)
  (ARROW (car start_point) (cdr start_point) (car end_point) (cdr end_point) handle_base head_base head_height))

(define (format-arrow shape_id arrow)
  (let* (
         [start_x (ARROW-start_x arrow)]
         [start_y (ARROW-start_y arrow)]
         [head_height (ARROW-head_height arrow)]
         [handle_base (ARROW-handle_base arrow)]
         [head_base (ARROW-head_base arrow)]
         [total_base (+ handle_base head_base)]
         [pre_end_x (ARROW-end_x arrow)]
         [pre_end_y (ARROW-end_y arrow)]
         [pre_toward_left? (if (> start_x pre_end_x) #t #f)]
         [pre_toward_updown? (if (= start_x pre_end_x) #t #f)]
         [pre_toward_up? (if (and (= start_x pre_end_x) (> start_y pre_end_y)) #t #f)]
         [pre_x_offset (- pre_end_x start_x)]
         [pre_y_offset (- pre_end_y start_y)]
         [pre_theta (atan (if (= pre_x_offset 0) 0 (/ pre_y_offset pre_x_offset)))]
         [pre_delta_r
          (cons (* head_height (cos pre_theta)) (* head_height (sin pre_theta)))]
         [pre_R (cons
                 ((if pre_toward_left? + -) pre_end_x ((if pre_toward_updown? cdr car) pre_delta_r))
                 ((cond
                   [pre_toward_up? +]
                   [pre_toward_left? +]
                   [else -])
                  pre_end_y ((if pre_toward_updown? car cdr) pre_delta_r)))]
         [end_x (car pre_R)]
         [end_y (cdr pre_R)]
         [toward_left? (if (> start_x end_x) #t #f)]
         [toward_updown? (if (= start_x end_x) #t #f)]
         [toward_up? (if (and (= start_x end_x) (> start_y end_y)) #t #f)]
         [x_offset (- end_x start_x)]
         [y_offset (- end_y start_y)]
         [theta (atan (if (= x_offset 0) 0 (/ y_offset x_offset)))]
         [alpha (- (/ pi 2) theta)]
         [delta_r
          (cons (* head_height (cos theta)) (* head_height (sin theta)))]
         [R (cons
             ((if toward_left? - +) end_x ((if toward_updown? cdr car) delta_r))
             ((cond
               [toward_up? -]
               [toward_left? -]
               [else +])
              end_y ((if toward_updown? car cdr) delta_r)))]
         [handle_delta_q
          (cons (* handle_base (cos alpha)) (* handle_base (sin alpha)))]
         [handle_bottom_left
          (cons
           ((if toward_left? + -) start_x ((if toward_updown? cdr car) handle_delta_q))
           ((if toward_left? - +) start_y ((if toward_updown? car cdr) handle_delta_q)))]
         [handle_bottom_right
          (cons
           ((if toward_left? + -) end_x ((if toward_updown? cdr car) handle_delta_q))
           ((if toward_left? - +) end_y ((if toward_updown? car cdr) handle_delta_q)))]
         [handle_top_left
          (cons
           ((if toward_left? - +) start_x ((if toward_updown? cdr car) handle_delta_q))
           ((if toward_left? + -) start_y ((if toward_updown? car cdr) handle_delta_q)))]
         [handle_top_right
          (cons
           ((if toward_left? - +) end_x ((if toward_updown? cdr car) handle_delta_q))
           ((if toward_left? + -) end_y ((if toward_updown? car cdr) handle_delta_q)))]
         [head_delta_q
          (cons (* total_base (cos alpha)) (* total_base (sin alpha)))]
         [Q (cons
             ((if toward_left? + -) end_x ((if toward_updown? cdr car) head_delta_q))
             ((if toward_left? - +) end_y ((if toward_updown? car cdr) head_delta_q)))]
         [S (cons
             ((if toward_left? - +) end_x ((if toward_updown? cdr car) head_delta_q))
             ((if toward_left? + -) end_y ((if toward_updown? car cdr) head_delta_q)))]
         )
    
    (format "    <polygon id=\"~a\"\n~a"
            shape_id
            (with-output-to-string
              (lambda ()
                (printf "          points=\"\n")
                (printf "            ~a,~a\n" (precision (car handle_bottom_left)) (precision (cdr handle_bottom_left)))
                (printf "            ~a,~a\n" (precision (car handle_bottom_right)) (precision (cdr handle_bottom_right)))
                (printf "            ~a,~a\n" (precision (car Q)) (precision (cdr Q)))
                (printf "            ~a,~a\n" (precision (car R)) (precision (cdr R)))
                (printf "            ~a,~a\n" (precision (car S)) (precision (cdr S)))
                (printf "            ~a,~a\n" (precision (car handle_top_right)) (precision (cdr handle_top_right)))
                (printf "            ~a,~a\n" (precision (car handle_top_left)) (precision (cdr handle_top_left)))
                (printf "            \"/>\n")
                )))))

(define (precision x) (~r x #:precision '(= 4)))
