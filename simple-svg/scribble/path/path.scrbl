#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Path}

@defmodule[simple-svg #:link-target? #f]

@defproc[(svg-def-path
          [procedure procedure?]
        )
        void?]{
  all path actions should be include in this procedure: moveto, curve etc.
}

@include-section{raw-path.scrbl}
@include-section{moveto.scrbl}
@include-section{close.scrbl}
@include-section{lineto.scrbl}
@include-section{qcurve.scrbl}
@include-section{ccurve.scrbl}
@include-section{arc.scrbl}
