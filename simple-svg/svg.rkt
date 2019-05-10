#lang racket

(provide (contract-out
          [svg-out (->* (procedure?)
                        (
                         #:padding? natural?
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                         #:canvas? (or/c #f (list/c natural? string? string?))
                         )
                        string?)]
          [svg-set-property (-> string? symbol? any/c void?)]
          [svg-use (->* (string?) (#:at? (cons/c natural? natural?)) void?)]
          [svg-show-default (-> void?)]
          [*shape-index* parameter?]
          [*add-shape* parameter?]
          ))

(define *svg* (make-parameter #f))
(define *shape-index* (make-parameter #f))
(define *group-index* (make-parameter #f))
(define *add-shape* (make-parameter #f))
(define *set-property* (make-parameter #f))
(define *add-group* (make-parameter #f))
(define *add-to-show* (make-parameter #f))
(define *groups_map* (make-parameter #f))
(define *shapes_map* (make-parameter #f))
(define *group_width_map* (make-parameter #f))
(define *group_height_map* (make-parameter #f))
(define *size-func* (make-parameter #f))
(define *current_group* (make-parameter #f))
(define *debug_port* (make-parameter #f))
(define *max-size* (make-parameter #f))
(define *max_width* (make-parameter #f))
(define *max_height* (make-parameter #f))
(define *padding* (make-parameter #f))

(define (svg-out write_proc
                 #:padding? [padding? 10]
                 #:viewBox? [viewBox? #f]
                 #:canvas? [canvas? #f]
                 )

  (let ([max_width 0]
        [max_height 0]
        [shapes_count 0]
        [groups_count 0]
        [shapes_map (make-hash)]
        [groups_map (make-hash)]
        [group_width_map (make-hash)]
        [group_height_map (make-hash)]
        [show_list '()])

    (parameterize
     ([*debug_port* (current-output-port)]
      [*max-size*
       (lambda (_width _height)
         (when (> _width max_width) (set! max_width _width))
         (when (> _height max_height) (set! max_height _height)))]
      [*max_width* (lambda () max_width)]
      [*max_height* (lambda () max_height)]
      [*padding* (lambda () padding?)]
      [*shape-index* (lambda () (set! shapes_count (add1 shapes_count)) (format "s~a" shapes_count))]
      [*group-index* (lambda () (set! groups_count (add1 groups_count)) (format "g~a" groups_count))]
      [*size-func* 
       (lambda (_group _width _height)
         (let ([group_width (hash-ref group_width_map _group 0)]
               [group_height (hash-ref group_height_map _group 0)])
           (when (> _width group_width) (hash-set! group_width_map _group _width))
           (when (> _height group_height) (hash-set! group_height_map _group _height))))]
      [*group_width_map* (lambda () group_width_map)]
      [*group_height_map* (lambda () group_height_map)]
      [*add-shape*
       (lambda (_index shape)
         (hash-set! shapes_map _index shape)
         _index)]
      [*groups_map* (lambda () groups_map)]
      [*shapes_map* (lambda () shapes_map)]
      [*add-group*
       (lambda (_index at)
         (hash-set! groups_map
                    (*current_group*)
                    `(,@(hash-ref groups_map (*current_group*) '())
                      ,(list _index at))))]
      [*add-to-show* (lambda (group_index) (set! show_list `(,@show_list ,group_index)))]
      [*set-property*
       (lambda (_index property value)
         (let ([property_map (hash-ref shapes_map _index)])
           (hash-set! property_map property value)))]
      [*current_group* "default"]
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

(define (svg-set-property index property value)
  ((*set-property*) index property value))

(define (svg-use shape_index #:at? [at? '(0 . 0)])
  ((*add-group*) shape_index at?)
  
  (fprintf (*debug_port*) "t0: ~a\n" ((*shapes_map*)))

  (let ([shape (hash-ref ((*shapes_map*)) shape_index)])
    (cond
     [(eq? (hash-ref shape 'type) 'rect)
      ((*size-func*) (*current_group*) (+ (car at?) (hash-ref shape 'width)) (+ (cdr at?) (hash-ref shape 'height)))]
     ))

  (fprintf (*debug_port*) "t1: ~a\n" ((*group_width_map*)))
  (fprintf (*debug_port*) "t2: ~a\n" ((*group_height_map*)))
  )

(define (svg-show-default)
  (svg-show "default"))

(define (svg-show group_index #:at? [at? '(0 . 0)])
  ((*add-to-show*) group_index)

  ((*max-size*)
   (hash-ref ((*group_width_map*)) group_index)
   (hash-ref ((*group_height_map*)) group_index)))

(define (flush-data)
  (printf "    width=\"~a\" height=\"~a\"\n    >\n"
          (+ ((*max_width*)) (* ((*padding*)) 2))
          (+ ((*max_height*)) (* ((*padding*)) 2))))
