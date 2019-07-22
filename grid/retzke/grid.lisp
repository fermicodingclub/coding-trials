(defun print-board (board)
  (loop for j from 0 below (array-dimension board 0) do
       (loop for i from 0 below (array-dimension board 1) do
	    (format t "~a " (aref board j i)))
       (format t "~%"))
  (format t "--~%"))

(defun read-grid (ip n m)
  (let ((grid (make-array (list n m))))
    (loop for j from 0 below n do
	 (loop for i from 0 below m do
	      (setf (aref grid j i) (digit-char-p (read-char ip))))
	 (read-char ip nil))
    grid))

(defun run (ip)
  (let* ((n (read ip))
	 (m (read ip))
	 (grid (read-grid ip n m)))
    (print-board grid)
    -1))

(defun test (s a)
  (= a (with-input-from-string (f s)
	 (run f))))

(defun test1 ()
  (test "2 2
11
11" 2))

(defun test2 ()
  (test "2 2
22
22" -1))

(defun test3 ()
  (test "5 4
2120
1203
3113
1120
1110" 6))

;(run *standard-input*)
