#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/path.rkt"))

@title{Path}

draw a path programmtially.

@defproc[(path
          [procedure procedure?]
          [#:fill? fill? string?]
          [#:stroke-fill? stroke-fill? string?]
          [#:stroke-width? stroke-width? natural?]
          [#:stroke-linejoin? stroke-linejoin? string?]
        )
        void?]{
  fill?, stroke-fill?, stroke-width? stroke-linejoin? same as raw-path.

  every path step should write in this procedure: moveto, curve etc.
}

@include-section{moveto.scrbl}

@include-section{ccurve.scrbl}

@include-section{qcurve.scrbl}

@include-section{lineto.scrbl}