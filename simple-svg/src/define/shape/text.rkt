#lang racket

(require racket/serialize)

(provide (contract-out
          [struct TEXT
                  (
                   (text string?)
                   (font-size (or/c #f number?))
                   (font-family (or/c #f string?))
                   (dx (or/c #f number?))
                   (dy (or/c #f number?))
                   (rotate (or/c #f (listof number?)))
                   (textLength (or/c #f number?))
                   (kerning (or/c #f number? 'auto 'inherit))
                   (letter-space (or/c #f number? 'normal 'inherit))
                   (word-space (or/c #f number? 'normal 'inherit))
                   (text-decoration (or/c #f 'overline 'underline 'line-through))
                   (path (or/c #f string?))
                   (path-startOffset (or/c #f (between/c 0 100)))
                   )]
          [new-text (->*
                     (string?)
                     (
                      #:font-size (or/c #f number?)
                      #:font-family (or/c #f string?)
                      #:dx (or/c #f number?)
                      #:dy (or/c #f number?)
                      #:rotate (or/c #f (listof number?))
                      #:textLength (or/c #f number?)
                      #:kerning (or/c #f number? 'auto 'inherit)
                      #:letter-space (or/c #f number? 'normal 'inherit)
                      #:word-space (or/c #f number? 'normal 'inherit)
                      #:text-decoration (or/c #f 'overline 'underline 'line-through)
                      #:path (or/c #f string?)
                      #:path-startOffset (or/c #f (between/c 0 100))
                      )
                     TEXT?)]
          [format-text (-> string? TEXT? string?)]
          ))

(serializable-struct TEXT (
              [text #:mutable]
              [font-size #:mutable]
              [font-family #:mutable]
              [dx #:mutable]
              [dy #:mutable]
              [rotate #:mutable]
              [textLength #:mutable]
              [kerning #:mutable]
              [letter-space #:mutable]
              [word-space #:mutable]
              [text-decoration #:mutable]
              [path #:mutable]
              [path-startOffset #:mutable]
              )
        #:transparent
        )

(define (new-text text
                  #:font-size [font-size #f]
                  #:font-family [font-family #f]
                  #:dx [dx #f]
                  #:dy [dy #f]
                  #:rotate [rotate #f]
                  #:textLength [textLength #f]
                  #:kerning [kerning #f]
                  #:letter-space [letter-space #f]
                  #:word-space [word-space #f]
                  #:text-decoration [text-decoration #f]
                  #:path [path #f]
                  #:path-startOffset [path-startOffset #f]
                  )
  (TEXT text font-size font-family dx dy rotate textLength kerning letter-space word-space text-decoration path path-startOffset))

(define (format-text shape_id text)
  (format "    <text id=\"~a\"~a>~a</text>\n"
          shape_id
          (with-output-to-string
            (lambda ()
              (when (TEXT-dx text)
                (printf " dx=\"~a\"" (~r (TEXT-dx text))))

              (when (TEXT-dy text)
                (printf " dy=\"~a\"" (~r (TEXT-dy text))))

              (when (TEXT-font-size text)
                (printf " font-size=\"~a\"" (~r (TEXT-font-size text))))

              (when (TEXT-font-family text)
                (printf " font-family=\"~a\"" (TEXT-font-family text)))

              (when (TEXT-rotate text)
                (printf " rotate=\"~a\"" (string-join (map (lambda (degree) (~r degree)) (TEXT-rotate text)))))

              (when (TEXT-textLength text)
                (printf " textLength=\"~a\"" (~r (TEXT-textLength text))))

              (when (TEXT-kerning text)
                (printf " kerning=\"~a\"" (TEXT-kerning text)))

              (when (TEXT-letter-space text)
                (printf " letter-space=\"~a\"" (TEXT-letter-space text)))

              (when (TEXT-word-space text)
                (printf " word-space=\"~a\"" (TEXT-word-space text)))

              (when (TEXT-text-decoration text)
                (printf " text-decoration=\"~a\"" (TEXT-text-decoration text)))
              ))
          (if (TEXT-path text)
              (with-output-to-string
                (lambda ()
                  (printf "\n      <textPath xlink:href=\"#~a\" " (TEXT-path text))
                  (when (TEXT-path-startOffset text)
                    (printf "startOffset=\"~a%\" " (~r (TEXT-path-startOffset text))))
                  (printf ">~a</textPath>\n    " (TEXT-text text))))
              (TEXT-text text))))
