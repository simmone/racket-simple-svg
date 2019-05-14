#lang racket

(provide (contract-out
          [svg-out (->* (procedure?)
                        (
                         #:width? natural?
                         #:height? natural?
                         #:padding? natural?
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                         #:canvas? (or/c #f (list/c natural? string? string?))
                         )
                        string?)]
          [svg-use (->* (string?)
                        (
                         #:at? (cons/c natural? natural?)
                         #:fill? string?
                         #:stroke? (cons/c natural? string?)
                        )
                        void?)]
          [svg-show-default (-> void?)]
          [*shape-index* parameter?]
          [*add-shape* parameter?]
          ))

(define *svg* (make-parameter #f))
(define *shape-index* (make-parameter #f))
(define *group-index* (make-parameter #f))
(define *add-shape* (make-parameter #f))
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
(define *max-width* (make-parameter #f))
(define *max-height* (make-parameter #f))
(define *padding* (make-parameter #f))
(define *canvas* (make-parameter #f))
(define *shapes-list* (make-parameter #f))
(define *groups-list* (make-parameter #f))
(define *show-list* (make-parameter #f))
(define *width* (make-parameter #f))
(define *height* (make-parameter #f))
(define *viewBox* (make-parameter #f))

(define (svg-out write_proc
                 #:width? [width? #f]
                 #:height? [height? #f]
                 #:padding? [padding? 10]
                 #:viewBox? [viewBox? #f]
                 #:canvas? [canvas? #f]
                 )

  (let ([max_width 0]
        [max_height 0]
        [shapes_count 0]
        [groups_count 0]
        [shapes_list '()]
        [shapes_map (make-hash)]
        [groups_list '()]
        [groups_map (make-hash)]
        [group_width_map (make-hash)]
        [group_height_map (make-hash)]
        [show_list '()])
    (parameterize
     (
      [*debug_port* (current-output-port)]
      [*max-width* (lambda () max_width)]
      [*max-height* (lambda () max_height)]
      [*max-size*
       (lambda (_width _height)
         (when (> _width max_width) (set! max_width _width))
         (when (> _height max_height) (set! max_height _height)))]
      [*padding* padding?]
      [*canvas* canvas?]
      [*shape-index* (lambda () (set! shapes_count (add1 shapes_count)) (format "s~a" shapes_count))]
      [*group-index* (lambda () (set! groups_count (add1 groups_count)) (format "g~a" groups_count))]
      [*size-func* 
       (lambda (_group _width _height)
         (let ([group_width (hash-ref group_width_map _group 0)]
               [group_height (hash-ref group_height_map _group 0)])
           (when (> _width group_width) (hash-set! group_width_map _group _width))
           (when (> _height group_height) (hash-set! group_height_map _group _height))))]
      [*group_width_map* group_width_map]
      [*group_height_map* group_height_map]
      [*shapes-list* (lambda () shapes_list)]
      [*add-shape*
       (lambda (_index shape)
         (set! shapes_list `(,@shapes_list ,_index))
         (hash-set! shapes_map _index shape)
         _index)]
      [*groups_map* groups_map]
      [*groups-list* (lambda () groups_list)]
      [*shapes_map* shapes_map]
      [*add-group*
       (lambda (_index at? fill? stroke?)
         (hash-set! groups_map
                    (*current_group*)
                    `(,@(hash-ref groups_map (*current_group*) '())
                      ,(list _index at? fill? stroke?))))]
      [*add-to-show* (lambda (group_index at?) (set! show_list `(,@show_list ,(list group_index at?))))]
      [*show-list* (lambda () show_list)]
      [*current_group* "default"]
      [*width* width?]
      [*height* height?]
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

(define (svg-use shape_index
                 #:at? [at? #f]
                 #:fill? [fill? #f]
                 #:stroke? [stroke? #f]
                 )
  ((*add-group*) shape_index at? fill? stroke?)
  
  (let* ([shape (hash-ref (*shapes_map*) shape_index)]
         [stroke_width (* (sub1 (if stroke? (car stroke?) 1)) 2)])
    (cond
     [(eq? (hash-ref shape 'type) 'rect)
      ((*size-func*)
       (*current_group*)
       (+ (if at? (car at?) 0) (hash-ref shape 'width) stroke_width)
       (+ (if at? (cdr at?) 0) (hash-ref shape 'height) stroke_width))]
     [(eq? (hash-ref shape 'type) 'circle)
      ((*size-func*)
       (*current_group*)
       (+ (car (hash-ref shape 'center_point)) (hash-ref shape 'radius) stroke_width)
       (+ (cdr (hash-ref shape 'center_point)) (hash-ref shape 'radius) stroke_width))]
     [(eq? (hash-ref shape 'type) 'ellipse)
      ((*size-func*)
       (*current_group*)
       (+ (car (hash-ref shape 'center_point)) (car (hash-ref shape 'radius)) stroke_width)
       (+ (cdr (hash-ref shape 'center_point)) (cdr (hash-ref shape 'radius)) stroke_width))]
     [(eq? (hash-ref shape 'type) 'line)
      ((*size-func*)
       (*current_group*)
       (+ (hash-ref shape 'max_width) stroke_width)
       (+ (hash-ref shape 'max_height) stroke_width))]
     [(eq? (hash-ref shape 'type) 'polygon)
      ((*size-func*)
       (*current_group*)
       (+ (hash-ref shape 'max_width) stroke_width)
       (+ (hash-ref shape 'max_height) stroke_width))]
     ))
  )

(define (svg-show-default)
  (svg-show "default"))

(define (svg-show group_index #:at? [at? '(0 . 0)])
  ((*add-to-show*) group_index at?)
  
  ((*max-size*)
   (hash-ref (*group_width_map*) group_index)
   (hash-ref (*group_height_map*) group_index)))

(define (flush-data)
  (let ([_width #f]
        [_height #f])

    (if (or (*width*) (*height*))
        (begin
          (set! _width (*width*))
          (set! _height (*height*)))
        (begin
          (set! _width ((*max-width*)))
          (set! _height ((*max-height*)))))

      (printf "    width=\"~a\" height=\"~a\"\n"
              (+ _width (* (*padding*) 2))
              (+ _height (* (*padding*) 2)))

      (when (*viewBox*)
        (printf "    viewBox=\"~a ~a ~a ~a\"\n"
                (first (*viewBox*)) (second (*viewBox*)) (third (*viewBox*)) (fourth (*viewBox*))))
      
      (printf "    >\n")

      (when (*canvas*)
        (printf "  <rect width=\"~a\" height=\"~a\" stroke-width=\"~a\" stroke=\"~a\" fill=\"~a\" />\n\n"
                (+ _width (* (*padding*) 2))
                (+ _height (* (*padding*) 2))
                (first (*canvas*))
                (second (*canvas*))
                (third (*canvas*)))))
  
  (when (not (null? ((*shapes-list*))))
    (printf "  <defs>\n")
    (let loop ([defs ((*shapes-list*))])
      (when (not (null? defs))
        (let ([shape (hash-ref (*shapes_map*) (car defs))])
          (printf "~a\n" ((hash-ref shape 'format-def) (car defs) shape)))
        (loop (cdr defs))))
    (printf "  </defs>\n\n"))
  
  (let loop-group ([groups ((*show-list*))])
    (when (not (null? groups))
      (let ([group_index (list-ref (car groups) 0)])
        (printf "  <symbol id=\"~a\">\n" group_index)
        (let loop-shape ([shapes (hash-ref (*groups_map*) group_index)])
          (when (not (null? shapes))
            (let ([shape_index (list-ref (car shapes) 0)]
                  [shape_at (list-ref (car shapes) 1)]
                  [shape_fill (list-ref (car shapes) 2)]
                  [shape_stroke (list-ref (car shapes) 3)])
              (printf "    <use xlink:href=\"#~a\" ~a/>\n"
                      shape_index
                      (with-output-to-string
                        (lambda ()
                          (when shape_at
                            (printf "x=\"~a\" y=\"~a\" " (car shape_at) (cdr shape_at)))

                          (when shape_fill
                            (printf "fill=\"~a\" " shape_fill))
                          
                          (when shape_stroke
                            (printf "stroke-width=\"~a\" stroke=\"~a\" " (car shape_stroke) (cdr shape_stroke)))

                          (when shape_stroke
                            (printf "transform=\"translate(~a ~a)\" " (sub1 (car shape_stroke)) (sub1 (car shape_stroke))))
                          ))))
            (loop-shape (cdr shapes))))
        (printf "  </symbol>\n\n")
        (loop-group (cdr groups)))))
    
  (let loop-group ([groups ((*show-list*))])
    (when (not (null? groups))
      (let ([group_index (list-ref (car groups) 0)]
            [group_at (list-ref (car groups) 1)])
        (printf "  <use xlink:href=\"#~a\" ~a/>\n"
                group_index
                (with-output-to-string
                  (lambda ()
                    (when (not (equal? group_at '(0 . 0)))
                      (printf "x=\"~a\" y=\"~a\" " (car group_at) (cdr group_at)))
                    
                    (when (not (= (*padding*) 0))
                      (printf "transform=\"translate(~a ~a)\" " (*padding*) (*padding*)))
                    ))))
      (loop-group (cdr groups))))
  )
