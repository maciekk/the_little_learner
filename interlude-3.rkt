#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-8.rkt"))
(require "chapter-8.rkt")

;; 155:3
(define smooth
  (λ (decay-rate average g)
    (+ (* decay-rate average)
       (* (- 1.0 decay-rate) g))))

(module+ main
  ;; 155:4
  (smooth 0.9 0.0 50.3)

  ;; 156:5
  (smooth 0.9 5.03 22.7)

  ;; 156:6
  (smooth 0.9 6.8 4.3)

  ;; 159:15
  (smooth 0.9 (tensor 0.8 3.1 2.2) (tensor 1.0 1.1 3.0))

  ;; 159:16
  (smooth 0.9 (tensor 0.82 2.9 2.28) (tensor 13.4 18.2 41.4))
  (smooth 0.9 (tensor 2.08 4.43 6.19) (tensor 1.1 0.3 67.3))
)
