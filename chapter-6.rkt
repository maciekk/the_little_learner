#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-5.rkt"))
(require "chapter-5.rkt")

;; 122:22
(define samples
  (λ (n s)
    (sampled n s (list))))

(define sampled
  (λ (n i a)
    (cond
      ((zero? i) a)
      (else
        (sampled n (sub1 i)
                 (cons (random n) a))))))

(module+ main
  (samples 100 10))

;; 125:31 (exercise) & 127:36 (solution)
(declare-hyper batch-size)  ; pulling this up from 126:34
(define sampling-obj
  (λ (expectant xs ys)
    (let ((n (tlen xs)))
          (λ (θ)
            (let ((b (samples n batch-size)))
              ; CAUTION: `trefs`, not `tref`... easy to mess up.
              ((expectant (trefs xs b) (trefs ys b)) θ))))))

(module+ main
  ; NOTE: now that these are stochastic, not only will my answers differ (a
  ; bit) from the ones in book, they will differ between runs too. So when
  ; verifying, it's just a matter of checking for "close enough".

  ;; 127:37
  (with-hypers
    ((revs 1000)
     (α 0.01)
     (batch-size 4))
    (gradient-descent-hyper
      (sampling-obj
        (l2-loss line) line-xs line-ys)
      (list 0.0 0.0)))

  ;; 129:42
  (with-hypers
    ((revs 15000)
     (α 0.001)
     (batch-size 4))
    (gradient-descent-hyper
      (sampling-obj
        (l2-loss plane) plane-xs plane-ys)
      (list (tensor 0.0 0.0) 0.0)))
)

