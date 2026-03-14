#lang racket

(require malt)

;; 36:25
(define rank-wrapped
  (λ (t)
    (cond
      ((scalar? t) 0)
      (else (add1 (rank (tref t 0)))))))

;; 39:37
(define shape
  (λ (t)
    (cond
      ((scalar? t) (list))
      (else (cons (tlen t) (shape (tref t 0)))))))

;; 42:44
(define rank
  (λ (t)
    (ranked t 0)))

(define ranked
  (λ (t a)
    (cond
      ((scalar? t) a)
      (else (ranked (tref t 0) (add1 a))))))

;; --- tests
(rank-wrapped (tensor (tensor 1 2 3) (tensor 4 5 6)))
(shape (tensor (tensor 1 2 3) (tensor 4 5 6)))
(rank (tensor (tensor 0 2 3) (tensor 4 5 6)))
