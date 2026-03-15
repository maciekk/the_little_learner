#lang racket

(require malt)

;; 53:24
(define sum-1
  (λ (t)
    (summed t (sub1 (tlen t)) 0.0)))

(define summed
  (λ (t i a)
    (cond
      ((zero? i) (+ (tref t 0) a))
      (else
        (summed t (sub1 i) (+ (tref t i) a))))))

;; 54:29

; First, we need `line` definition
(include "chapter-1.rkt")

((line (tensor 2 7 5 11)) (list 4 6))

;; --- test
(sum-1 (tensor 10.0 12.0 14.0))
