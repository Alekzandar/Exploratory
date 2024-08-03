SELECT * from product;

SELECT product_name, price
FROM product;

--LEETCODE MEDIUM
CREATE FUNCTION getNthHighestSaralry(N INT) RETURNS INT
BEGIN
	SET N = N-1
	RETURN(
	 --QUERY
		SELECT salary
		FROM employee
		ORDER BY salary DESC
		LIMIT 1 OFFSET N
	);
END