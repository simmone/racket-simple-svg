#lang racket

(require rackunit)

(provide (contract-out
          [check-lines? (-> input-port? input-port? void?)]
          ))

(define-check (check-lines? expected_port test_port)
  (let* ([expected_lines (port->lines expected_port)]
         [test_lines (port->lines test_port)]
         [test_length (length test_lines)])
    (if (= (length expected_lines) 0)
        (when (not (= test_length 0))
          (fail-check (format "error! expect no content, but actual have [~a] lines" test_length)))
        (let loop ([loop_lines expected_lines]
                   [line_no 0])
          (when (not (null? loop_lines))
            (cond
             [(>= line_no test_length)
              (fail-check (format "error! line[~a] expected:[~a] actual:null" (add1 line_no) (car loop_lines)))]
             [(not (string=? (car loop_lines) (list-ref test_lines line_no)))
              (fail-check (format "error! line[~a] expected:[~a] actual:[~a]" (add1 line_no) (car loop_lines) (list-ref test_lines line_no)))])
            (loop (cdr loop_lines) (add1 line_no)))))))
