#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-path-def (-> procedure? string?)]
          [*add-path* parameter?]
          [*size-func* parameter?]
          [*set-position* parameter?]
          [*get-position* parameter?]
          ))

(define *add-path* (make-parameter #f))
(define *size-func* (make-parameter #f))
(define *set-position* (make-parameter #f))
(define *get-position* (make-parameter #f))

(define (svg-path-def path_proc)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)]
        [defs '()])

    (hash-set! properties_map 'type 'path)

    (let ([max_width 0]
          [max_height 0]
          [current_position '(0 . 0)])
      (parameterize
          (
           [*add-path*
            (lambda (def)
              (set! defs `(,@defs ,def)))]
           [*size-func* 
            (lambda (_point)
              (when (> (car _point) max_width) (set! max_width (car _point)))
              (when (> (cdr _point) max_height) (set! max_height (cdr _point))))]
           [*set-position* (lambda (pos) (set! current_position pos))]
           [*get-position* (lambda () current_position)])
        (path_proc))
      
      (hash-set! properties_map 'width max_width)
      (hash-set! properties_map 'height max_height))

    (hash-set! properties_map 'format-def
               (lambda (index path)
                 (with-output-to-string
                   (lambda ()
                     (dynamic-wind
                         (lambda ()
                           (printf "    <path id=\"~a\"\n" shape_id)
                           (printf "          d=\"\n"))
                         (lambda ()
                           (let loop ([_defs defs])
                             (when (not (null? _defs))
                               (printf "             ~a\n" (car _defs))
                               (loop (cdr _defs)))))
                         (lambda ()
                           (printf "            \"/>" )))))))

    ((*add-shape*) shape_id properties_map)))
