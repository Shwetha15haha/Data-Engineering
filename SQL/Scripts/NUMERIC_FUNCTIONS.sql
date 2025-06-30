--ROUND
SELECT
  3.516,
  ROUND(3.516, 2) AS round_2,
  ROUND(3.516, 1) AS round_1,
  ROUND(3.516, 0) AS round_0;

--Result
--3.516| 3.520| 3.500| 4.000|
--ABS
SELECT
  -10,
  ABS(-10),
  ABS(10);

--10 is the result