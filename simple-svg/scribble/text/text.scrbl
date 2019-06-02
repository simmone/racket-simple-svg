#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../text/text.rkt"))

@title{Text}

define a text programmtially.

@defproc[(svg-def-text
          [text string?]
          [#:font-size? font-size? (or/c #f natural?) #f]
          [#:font-family? font-family? (or/c #f string?) #f]
          [#:dx? dx? (or/c #f integer?) #f]
          [#:dy? dy? (or/c #f integer?) #f]
          [#:rotate? rotate? (or/c #f (listof integer?)) #f]
          [#:textLength? textLength? (or/c #f natural?) #f]
          [#:kerning? kerning? (or/c #f natural? 'auto 'inherit) #f]
          [#:letter-space? letter-space? (or/c #f natural? 'normal 'inherit) #f]
          [#:word-space? word-space? (or/c #f natural? 'normal 'inherit) #f]
          [#:text-decoration? text-decoration? (or/c #f 'overline 'underline 'line-through) #f]
          [#:path? path? (or/c #f string?) #f]
          [#:path-startOffset? path-startOffset? (or/c #f (integer-in 0 100)) #f]
         )
        string?]{
  dx, dy: relative position.
  kerning, letter-space, word-space: all about letter and word spaces.
}

@codeblock{
(let ([text (svg-def-text "城春草木深" #:font-size? 50)]
      [_sstyle (sstyle-new)])
    (set-sstyle-fill! _sstyle "#ED6E46")
    (svg-use-shape text _sstyle #:at? '(30 . 50))
    (svg-show-default))
}
@image{showcase/text/text1.svg}

rotate: a list of rotate angles, it represent each letter's rotate, only one means each letter have same angle.

@codeblock{
(let ([text (svg-def-text "城春草木深" #:font-size? 50 #:rotate? '(10 20 30 40 50) #:textLength? 300)]
      [_sstyle (sstyle-new)])
    (set-sstyle-fill! _sstyle "#ED6E46")
    (svg-use-shape text _sstyle #:at? '(30 . 60))
    (svg-show-default))
}
@image{showcase/text/text2.svg}

@codeblock{
(let (
     [text1 (svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'overline)]
     [text2 (svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'underline)]
     [text3 (svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'line-through)]
     [_sstyle (sstyle-new)]
     )
   (set-sstyle-fill! _sstyle "#ED6E46")
   (svg-use-shape text1 _sstyle #:at? '(30 . 60))
   (svg-use-shape text2 _sstyle #:at? '(30 . 160))
   (svg-use-shape text3 _sstyle #:at? '(30 . 260))
   (svg-show-default))
}
@image{showcase/text/text3.svg}

let text follow a path:
@codeblock{
(let* ([path
        (svg-def-path
         (lambda ()
           (svg-path-moveto* '(10 . 60))
           (svg-path-qcurve* '(110 . 10) '(210 . 60))
           (svg-path-qcurve* '(310 . 110) '(410 . 60))))]
       [path_sstyle (sstyle-new)]
       [text
        (svg-def-text "国破山河在 城春草木深 感时花溅泪 恨别鸟惊心"
                      #:path? path
                      #:path-startOffset? 5)]
       [text_sstyle (sstyle-new)])
  (set-sstyle-fill! text_sstyle "#ED6E46")
  (svg-use-shape path path_sstyle #:hidden? #t)
  (svg-use-shape text text_sstyle)
  (svg-show-default))
}
@image{showcase/text/text4.svg}

