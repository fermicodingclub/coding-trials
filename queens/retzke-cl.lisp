(defclass location ()
  ((col :initarg :col :accessor col)
   (row :initarg :row :accessor row)
   (ranks :initarg :ranks :accessor ranks)))

(defun make-location (row col)
  (make-instance 'location
		 :row row
		 :col col
		 :ranks (list
			 ;; 2 2 2
			 ;; 1 1 1
			 ;; 0 0 0
			 row
			 ;; 0 1 2
			 ;; 0 1 2
			 ;; 0 1 2
			 col
			 ;; -2 -1  0
			 ;; -1  0  1
			 ;;  0  1  2
			 (- col row)
			 ;; 2 3 4
			 ;; 1 2 3
			 ;; 0 1 2
			 (+ col row))))

(defun n-queens (n queens)
  (if (= n 0)
      "CORRECT"
      (let ((new-queen (make-location (read) (read))))
	(if (some (lambda (q)
		    (some '= (ranks q) (ranks new-queen)))
		  queens)
	    "INCORRECT"
	    (n-queens (1- n) (push new-queen queens))))))


(format t "~A~%" (n-queens (read) nil))
