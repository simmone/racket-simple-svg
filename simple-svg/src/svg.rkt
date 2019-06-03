#lang racket

(require "lib/sstyle.rkt")

(provide (contract-out
          [svg-out (->* (natural? natural? procedure?)
                        (
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                        )
                        string?)]
          [svg-def-group (->* string? procedure?)]
          [svg-use-shape (->* (string? sstyle/c) 
                              (
                               #:at? (cons/c natural? natural?)
                               #:hidden? boolean?
                              )
                              void?)]
          [svg-show-group (->* (string? sstyle/c)
                              (
                               #:at? (cons/c natural? natural?)
                              )
                              void?)]
          [svg-show-default (-> void?)]
          [*add-shape* parameter?]
          [*add-to-shape-def-list* parameter?]
          ))

(define *svg* (make-parameter #f))
(define *shape-index* (make-parameter #f))
(define *group-index* (make-parameter #f))
(define *add-shape* (make-parameter #f))
(define *set-shapes-map* (make-parameter #f))
(define *add-group* (make-parameter #f))
(define *add-to-show* (make-parameter #f))
(define *groups_map* (make-parameter #f))
(define *shapes_map* (make-parameter #f))
(define *sstyles_map* (make-parameter #f))
(define *set-sstyles-map* (make-parameter #f))
(define *current_group* (make-parameter #f))
(define *debug_port* (make-parameter #f))
(define *shape-def-list* (make-parameter #f))
(define *add-to-shape-def-list* (make-parameter #f))
(define *groups-list* (make-parameter #f))
(define *show-list* (make-parameter #f))
(define *viewBox* (make-parameter #f))
(define *width* (make-parameter #f))
(define *height* (make-parameter #f))

(define (svg-out width height write_proc
                 #:viewBox? [viewBox? #f]
                 )

  (let ([shapes_count 0]
        [groups_count 0]
        [shape_def_list '()]
        [shapes_map (make-hash)]
        [groups_list '()]
        [groups_map (make-hash)]
        [sstyles_map (make-hash)]
        [show_list '()])
    (parameterize
     (
      [*width* width]
      [*height* height]
      [*debug_port* (current-output-port)]
      [*shape-index* (lambda () (set! shapes_count (add1 shapes_count)) (format "s~a" shapes_count))]
      [*group-index* (lambda () (set! groups_count (add1 groups_count)) (format "g~a" groups_count))]
      [*shape-def-list* (lambda () shape_def_list)]
      [*add-to-shape-def-list* (lambda (shape_index) (set! shape_def_list `(,@shape_def_list ,shape_index)))]
      [*set-shapes-map* (lambda (shape_index shape) (hash-set! shapes_map shape_index shape))]
      [*add-shape*
       (lambda (shape)
         (let ([shape_index ((*shape-index*))])
           ((*set-shapes-map*) shape_index shape)
           shape_index))]
      [*groups_map* groups_map]
      [*groups-list* (lambda () groups_list)]
      [*shapes_map* shapes_map]
      [*sstyles_map* sstyles_map]
      [*set-sstyles-map* (lambda (_index _sstyle) (hash-set! sstyles_map _index _sstyle))]
      [*add-group*
       (lambda (_index at?)
         (hash-set! groups_map
                    (*current_group*)
                    `(,@(hash-ref groups_map (*current_group*) '())
                      ,(cons _index at?))))]
      [*add-to-show*
       (lambda (group_index _sstyle at?)
         ((*set-sstyles-map*) group_index _sstyle)
         (set! show_list `(,@show_list ,(cons group_index at?))))]
      [*show-list* (lambda () show_list)]
      [*current_group* "default"]
      [*viewBox* viewBox?]
      )
     (with-output-to-string
       (lambda ()
         (dynamic-wind
             (lambda () 
               (printf 
                "<svg\n    ~a\n    ~a\n    ~a\n"
                "version=\"1.1\""
                "xmlns=\"http://www.w3.org/2000/svg\""
                "xmlns:xlink=\"http://www.w3.org/1999/xlink\""))
             (lambda ()
               (write_proc))
             (lambda ()
               (flush-data)
               (printf "</svg>\n"))))))))

(define (svg-def-group group_name proc)
  (parameterize ([*current-group* group_name])
    (lambda ()
      (proc))))
      
(define (svg-use-shape shape_index _sstyle
                       #:at? [at? #f]
                       #:hidden? [hidden? #f]
                       )
  (let* ([shape (hash-ref (*shapes_map*) shape_index)]
         [new_shape_index shape_index]
         [new_shape shape]
         [new_at? at?])
    (cond
     [(eq? (hash-ref shape 'type) 'circle)
      (set! new_shape_index ((*shape-index*)))
      (set! new_shape (hash-copy shape))
      (when at?
            (hash-set! new_shape 'cx (car new_at?))
            (hash-set! new_shape 'cy (cdr new_at?)))
      (set! new_at? #f)]
     [(eq? (hash-ref shape 'type) 'ellipse)
      (set! new_shape_index ((*shape-index*)))
      (set! new_shape (hash-copy shape))
      (let ([radius (hash-ref shape 'radius)])
        (when at?
              (hash-set! new_shape 'cx (car new_at?))
              (hash-set! new_shape 'cy (cdr new_at?)))
        (set! new_at? #f)
        (hash-set! new_shape 'rx (car radius))
        (hash-set! new_shape 'ry (cdr radius)))])

    ((*add-to-shape-def-list*) new_shape_index)
    ((*set-shapes-map*) new_shape_index new_shape)
    ((*set-sstyles-map*) new_shape_index _sstyle)
    (when (not hidden?)
      ((*add-group*) new_shape_index new_at?))
    ))

(define (svg-show-default)
  (svg-show-group "default" (sstyle-new)))

(define (svg-show-group group_index sstyle
                        #:at? [at? #f])
  ((*add-to-show*) group_index sstyle at?))

(define (flush-data)
  (printf "    width=\"~a\" height=\"~a\"\n" (*width*) (*height*))

  (when (*viewBox*)
    (printf "    viewBox=\"~a ~a ~a ~a\"\n"
            (first (*viewBox*)) (second (*viewBox*)) (third (*viewBox*)) (fourth (*viewBox*))))
      
  (printf "    >\n")

  (when (not (null? ((*shape-def-list*))))
    (printf "  <defs>\n")
    (let loop ([defs ((*shape-def-list*))])
      (when (not (null? defs))
        (let ([shape (hash-ref (*shapes_map*) (car defs))])
          (printf "~a\n" ((hash-ref shape 'format-def) (car defs) shape)))
        (loop (cdr defs))))
    (printf "  </defs>\n\n"))
  
  (let loop-group ([groups ((*show-list*))])
    (when (not (null? groups))
      (let ([group_index (caar groups)])
        (printf "  <symbol id=\"~a\">\n" group_index)
        (let loop-shape ([shapes (hash-ref (*groups_map*) group_index)])
          (when (not (null? shapes))
            (let* ([shape_index (caar shapes)]
                   [shape_at? (cdar shapes)]
                   [shape (hash-ref (*shapes_map*) shape_index)]
                   [_sstyle (hash-ref (*sstyles_map*) shape_index)])
              (printf "    <use xlink:href=\"#~a\" " shape_index)
              
              (when shape_at?
                    (printf "x=\"~a\" y=\"~a\" " (car shape_at?) (cdr shape_at?)))
              
              (printf "~a/>\n" (sstyle-format _sstyle)))
            (loop-shape (cdr shapes))))
        (printf "  </symbol>\n\n")
        (loop-group (cdr groups)))))
    
  (let loop-group ([groups ((*show-list*))])
    (when (not (null? groups))
      (let* ([group_index (caar groups)]
             [group_at? (cdar groups)]
             [_sstyle (hash-ref (*sstyles_map*) group_index)])
        (printf "  <use xlink:href=\"#~a\" " group_index)
        
        (when group_at?
              (printf "x=\"~a\" y=\"~a\" " (car group_at?) (cdr group_at?)))

        (printf "~a/>\n" (sstyle-format _sstyle)))
      (loop-group (cdr groups)))))
