;; frame-tag-plus.el 
;; Minor mode that assigns a unique number to each frame for easy switching

;; Date: Tue Oct  2 21:36:35 CST 2012
;; Author: louxiu lou.0211[at]gmail.com

;; frame-tag-plus base on frame-tag written by Wong Liang Zan zan[at]liangzan.net

;;; Usage:

;; frame-tag-plus mode allows you to switch between frames quickly. 
;; Frames are orderd by their create sequence.
;; The first created frame is assigned the number 1. 
;; The second frame is assigned 2 and so on.
;; If you close one frame, the order will be reassigned accordingly. 
;; It behaves just like tabs in browser.
;; To switch to the frames, press M-1 to switch to frame 1.
;; It assigns a maximum of 9 frames to switch from.

;;; Installation

;; (add-to-list 'load-path "/path/to/frame-tag-plus")
;; (require 'frame-numbering)
;; (frame-tag-plus-mode 1)

;;; Code:

(eval-when-compile (require 'cl))

(setq num-jp ["いち" "に" "さん" "し" "ご" "るく" "しち" "はち" "きゅう"])

(defun update-frame-nth(frames seq)
  (if (car frames)
      (progn
        (set-frame-name-another 
         (car frames) 
         (concat frame-title-format "-" (aref num-jp (- seq 1))))
        (update-frame-nth (cdr frames) (- seq 1)))))

;; (frame-parameter (car (frame-list)) 'name)
;; (update-frame-nth (frame-list) (length (frame-list)))

(defun set-frame-name-another (frame name)
  (modify-frame-parameters frame
			   (list (cons 'name name))))

(defun frame-tag-plus-find-frame (index)
  "Finds the frame given the index"
  (nth (- (length (frame-list)) (+ index 1)) (frame-list)))

(defun frame-tag-plus-select-frame-by-number (index)
  "Selects the frame given a number."
  (update-frame-nth (frame-list) (length (frame-list)))
  (if (<= index (- (length (frame-list)) 1))
      (select-frame-set-input-focus (frame-tag-plus-find-frame index))
  (error "No frames found")))

;; define interactive functions for keymap
(dotimes (i 10)
  (eval `(defun ,(intern (format "frame-tag-plus-select-frame-%s" i)) (&optional arg)
           ,(format "Select the frame with number %i." i)
           (interactive "P")
           (frame-tag-plus-select-frame-by-number ,(- i 1)))))

(defvar frame-tag-plus-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map "\M-1" 'frame-tag-plus-select-frame-1)
    (define-key map "\M-2" 'frame-tag-plus-select-frame-2)
    (define-key map "\M-3" 'frame-tag-plus-select-frame-3)
    (define-key map "\M-4" 'frame-tag-plus-select-frame-4)
    (define-key map "\M-5" 'frame-tag-plus-select-frame-5)
    (define-key map "\M-6" 'frame-tag-plus-select-frame-6)
    (define-key map "\M-7" 'frame-tag-plus-select-frame-7)
    (define-key map "\M-8" 'frame-tag-plus-select-frame-8)
    (define-key map "\M-9" 'frame-tag-plus-select-frame-9)
    map)
  "Keymap used in by `frame-tag-plus-mode'.")

;;;###autoload
(define-minor-mode frame-tag-plus-mode
  "A minor mode that assigns a number to the frames by position order"
  nil nil frame-tag-plus-keymap :global t)

(provide 'frame-tag-plus)

;;; frame-tag-plus.el ends here
