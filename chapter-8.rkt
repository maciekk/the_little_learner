#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-7.rkt"))
(require "chapter-7.rkt")

;; 149:23
(declare-hyper μ)

;; 150:26
(define velocity-i
  (λ (p)
    (list p (zeroes p))))

;; 151:29
(define velocity-d
  (λ (P)
    (ref P 0)))

;; 151:30
(define velocity-u
  (λ (P g)
    (let ((v (- (* μ (ref P 1)) (* α g))))
      (list (+ (ref P 0) v) v))))

;; 151:31
(define velocity-gradient-descent
  (gradient-descent-crazy
    velocity-i velocity-d velocity-u))

;; 152:32
(define try-plane
  (λ (a-gradient-descent a-revs)
    (with-hypers
      ((revs a-revs)
       (α 0.001)
       (batch-size 4))
      (a-gradient-descent
        (sampling-obj
          (l2-loss plane) plane-xs plane-ys)
        (list (tensor 0.0 0.0) 0.0)))))

(module+ main
  (with-hypers
    ((μ 0.9))
    (try-plane
      velocity-gradient-descent 5000))
)
