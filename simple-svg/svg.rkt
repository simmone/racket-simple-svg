#lang racket

(provide (contract-out
          [svg-out (->* (procedure?)
                        (
                         #:padding? natural?
                         #:width? (or/c #f natural?)
                         #:height? (or/c #f natural?)
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
(define *size-func* (make-parameter #f))
(define *current_group* (make-parameter #f))

(define (svg-out write_proc
                 #:padding? [padding? 10]
                 #:width? [width? #f]
                 #:height? [height? #f]
                 #:viewBox? [viewBox? #f]
                 #:canvas? [canvas? #f]
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
           (let* ([max_width 0]
                  [max_height 0]
                  [shapes_count 0]
                  [groups_count 0]
                  [shapes_map (make-hash)]
                  [groups_map (make-hash)]
                  [show_list '()])
             (parameterize
              (
               [*shape-index* (lambda () (set! shapes_count (add1 shapes_count)) (format "s~a" shapes_count))]
               [*group-index* (lambda () (set! groups_count (add1 groups_count)) (format "g~a" groups_count))]
               [*size-func* 
                (lambda (_width _height)
                  (when (> _width max_width) (set! max_width _width))
                  (when (> _height max_height) (set! max_height _height)))]
               [*add-shape*
                (lambda (_index shape)
                  (hash-set! shapes_map _index shape)
                  _index)]
               [*groups_map* (make-hash)]
               [*add-group*
                (lambda (_index at)
                  (hash-set! (*groups_map*)
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
              (write_proc))))
         (lambda ()
           (flush-data)
           (printf "</svg>\n"))))))

(define (svg-set-property index property value)
  ((*set-property*) index property value))

(define (svg-use index #:at? [at? '(0 . 0)])
  ((*add-group*) index at?))

(define (svg-show-default)
  (svg-show "default"))

(define (svg-show group_index)
  ((*add-to-show*) group_index))

(define (flush-data)
  (void)
  )
