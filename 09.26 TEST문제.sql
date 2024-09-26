use employee;
-- 문제 1 : EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.

select
EMP_NAME AS '사원명',
substring(EMP_NO, 1, 2) AS 생년,
substring(EMP_NO, 3, 2) AS 생월,
substring(EMP_NO, 5, 2) AS 생일
from
employee;

-- 문제 2 : 날짜 데이터에서 사용할 수 있다.
-- 직원들의 입사일에도 입사년도, 입사월, 입사날짜를 분리 조회
select
	EMP_NAME AS '사원명',
	substring(HIRE_DATE, 3, 2) AS 입사년도,
    substring(HIRE_DATE, 6, 2) AS 입사월,
    substring(HIRE_DATE, 9, 2) AS 입사날짜
from
employee;

-- 문제 3 : WHERE 절에서 함수 사용도 가능하다.
-- 여직원들의 모든 컬럼 정보를 조회

select
*
from
employee
where
substring(EMP_NO, 8, 1) = 2;

-- 문제 4 : 함수 중첩 사용 가능 : 함수안에서 함수를 사용할 수 있음
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-'다음의 값은
-- '*'로 바꿔서 출력

select
	EMP_NAME,
    REPLACE(SUBSTRING(EMP_NO, 1), SUBSTRING(EMP_NO, 8), '*******') AS 주민번호
from
employee;

-- 문제 5 : EMPLOYEE 테이블에서 사원명, 이메일,
-- @이후를 제외한 아이디 조회

select
EMP_NAME,
substring_index(EMAIL, '@', 1)
from
employee;

-- 문제 6 : EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사후 6개월이
-- 되는 날짜를 조회

select
EMP_NAME,
ADDDATE(HIRE_DATE, INTERVAL 6 MONTH)
from
employee;

-- 문제7 : EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
select
EMP_NAME,
floor(datediff(curdate(), HIRE_DATE)/365) as '20년 이상 직원'
from
employee
where
floor(datediff(curdate(), HIRE_DATE)/365) >= 20;

-- 문제8 : EMPLOYEE 테이블에서 사원명, 입사일, 
-- 입사한 월의 근무일수를 조회하세요

select
	EMP_NAME,
    HIRE_DATE,
    LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 AS 근무일수
from
employee;

-- 문제 9 : EMPLOYEE 테이블에서 직원의 이름, 입사일, 근무년수를 조회
-- 단, 근무년수는 현재년도 - 입사년도로 조회
select
EMP_NAME,
HIRE_DATE,
datediff(LAST_DAY(HIRE_DATE), HIRE_DATE) as 근무년수 
from
employee;

-- 문제 10 : EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회 (mod)






