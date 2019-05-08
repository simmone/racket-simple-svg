#lang racket

(provide (contract-out
          [svg-out (->* (output-port? procedure?)
                                   (#:padding? natural?
                                    #:width? (or/c #f natural?)
                                    #:height? (or/c #f natural?)
                                    #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                                    #:canvas? (or/c #f (list/c natural? string? string?))
                                    )
                                   void?)]
          [*svg* parameter?]
          [*shape-index* parameter?]
          [*group-index* parameter?]
          [*add-shape* parameter?]
          [*add-group* parameter?]
          [*size-func* parameter?]
          ))

(define *svg* (make-parameter #f))
(define *shape-index* (make-parameter #f))
(define *group-index* (make-parameter #f))
(define *add-shape* (make-parameter #f))
(define *add-group* (make-parameter #f))
(define *size-func* (make-parameter #f))

(define (svg-out output_port write_proc
                            #:padding? [padding? 10]
                            #:width? [width? #f]
                            #:height? [height? #f]
                            #:viewBox? [viewBox? #f]
                            #:canvas? [canvas? #f]
                            )
  (parameterize 
   ([*svg* output_port])
   (dynamic-wind
       (lambda () 
         (fprintf 
          (*svg*)
          "<svg\n    ~a\n    ~a\n    ~a\n"
          "version=\"1.1\""
          "xmlns=\"http://www.w3.org/2000/svg\""
          "xmlns:xlink=\"http://www.w3.org/1999/xlink\"\n")
       (lambda ()
         (let* ([max_width 0]
                [max_height 0]
                [shapes_count 0]
                [groups_count 0]
                [shapes_map (make-hash)]
                [groups_map (make-hash)]
                [content
                 (call-with-output-string
                  (lambda (svg_output_port)
                    (parameterize
                        (
                         [*svg* svg_output_port]
                         [*shape-index* (lambda () (set! shapes_count (add1 shapes_count)) shapes_count)]
                         [*group-index* (lambda () (set! groups_count (add1 groups_count)) groups_count)]
                         [*size-func* 
                          (lambda (_width _height)
                            (when (> _width max_width) (set! max_width _width))
                            (when (> _height max_height) (set! max_height _height)))]
                         [*add-shape*
                          (lambda (_shape_index shape)
                            (hash-set! shapes_map _shape_index shape)
                            (hash-set! groups_map "default" `(,@(hash-ref groups_map "default" '()) ,_shape_index)))]
                         )
                      (write_proc))))])
           
           (fprintf (*svg*) "    width=\"~a\" height=\"~a\"\n"
                    (if width? width? (+ max_width (* padding? 2)))
                    (if height? height? (+ max_height (* padding? 2))))

           (when viewBox?
                 (fprintf (*svg*) "    viewBox=\"~a ~a ~a ~a\"\n"
                          (first viewBox?) (second viewBox?) (third viewBox?) (fourth viewBox?)))
           
           (fprintf (*svg*) "    >\n")
         
           (when canvas?
                 (fprintf (*svg*) "  <rect width=\"~a\" height=\"~a\" stroke-width=\"~a\" stroke=\"~a\" fill=\"~a\" />\n"
                          (if width? width? (+ max_width (* padding? 2)))
                          (if height? height? (+ max_height (* padding? 2)))
                    (first canvas?) (second canvas?) (third canvas?)))
          
           (fprintf (*svg*) "~a" content)))
       (lambda ()
         (fprintf (*svg*) "</svg>\n"))))))
