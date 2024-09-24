select -- 모든 행 칼럼 조회
*
from
employee;

select -- 테이블의 사번, 이름 조회
EMP_NAME,
EMP_ID
from
employee;

select -- 부서코드가 d9인 사원 조회
EMP_NAME,
DEPT_CODE
from
employee
where
DEPT_CODE = 'D9';

select -- 테이블 급여 300만원 이상인 사원
EMP_ID,
EMP_NAME,
DEPT_CODE,
SALARY
from
employee
where
SALARY >= 3000000;

select -- 부서코드가 D6이고 급여 200만원 이상인 직원
EMP_NAME,
DEPT_CODE,
SALARY
from
employee
where
DEPT_CODE = 'D6' and SALARY > 2000000;

select
*
from
employee;

select -- 보너스 지급받지 않는 사원
EMP_ID,
EMP_NAME,
SALARY,
BONUS
from
employee
where
BONUS is null;

select -- 급여 350만원 이상 550만원 이하 직원
EMP_ID,
EMP_NAME,
SALARY,
DEPT_CODE,
JOB_CODE
from
employee
where
SALARY >= 3500000 AND SALARY < 5500000;

select -- 성이 김씨인 직원
EMP_ID,
EMP_NAME,
HIRE_DATE
from
employee
where
EMP_NAME like '김%';

select -- 하가 포함된 직원
EMP_NAME,
EMP_NO,
DEPT_CODE
from
employee
where
EMP_NAME like '%하%';

select -- 전화번호 국번이 9로 시작하는 사원
EMP_ID,
EMP_NAME,
PHONE
from
employee
where
PHONE like '___9%';  -- 010 551 2290

select -- 국번이 4자리 이면서 9로 시작
EMP_ID,
EMP_NAME,
PHONE
from
employee
where
PHONE like '___9_______';

select -- 부서코드가 d6 이거나 d8인 직원
EMP_NAME,
DEPT_CODE,
SALARY
from
employee
where
DEPT_CODE in ('D6', 'D8');

select 
EMP_ID,
EMP_NAME, -- 이씨성이 아닌 직원의 사번, 이름, 이메일주소
EMAIL
from
employee
where
EMP_NAME NOT like '이%';

select -- J2 직급의 200만원 이상 받는 직원이거나 J7 직급인 사람
EMP_NAME,
SALARY,
JOB_CODE
from
employee
where
JOB_CODE = 'J2' OR 'J2' = 2000000 OR JOB_CODE = 'J7';

select -- J7 직급이거나 J2 직급인 중 급여가 200만원 이상인 직원
EMP_NAME,
SALARY,
JOB_CODE
from
employee
where
JOB_CODE in ('J2', 'J7') AND SALARY >= 2000000;








