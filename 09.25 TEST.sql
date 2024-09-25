USE employee;
-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)
select 
	e.EMP_ID, 
    e.EMP_NAME, 
    j.JOB_NAME, 
    d.DEPT_TITLE, 
    l.LOCAL_NAME, 
    e.SALARY
from 
			job j
		join 
			employee e
		on 
			(j.JOB_CODE = e.JOB_CODE) 
		join
			department d
		on
			(e.DEPT_CODE = d.DEPT_ID)
		join
			LOCATION l
		on 
			(d.LOCATION_ID = l.LOCAL_CODE)
where 
	JOB_NAME = '대리' 
	AND 
	LOCAL_NAME like '%ASIA%';
    
-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)

select
	EMP_NAME,
    
