select
*
from
tb_class,
tb_class_professor,
tb_department,
tb_grade,
tb_professor,
tb_student;

-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다.
select
DEPARTMENT_NAME as 학과명,
CATEGORY as 계열
from
tb_department;

-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
select
DEPARTMENT_NAME,
CAPACITY
from
tb_department;

-- 3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이
-- 들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서
-- 찾아 내도록 하자)

select
d.DEPARTMENT_NAME,
s.STUDENT_NAME,
s.STUDENT_SSN,
s.ABSENCE_YN

from
tb_department d
join
tb_student s
on
(d.DEPARTMENT_NO = s.DEPARTMENT_NO)
where
STUDENT_SSN like '_______2______' and ABSENCE_YN like 'Y';

-- 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 그 대상자들의
-- 학번이 다음과 같을 때 대상자들을 찾는 적 SQL 구문을 작성하시오.
-- A513079, A513090, A513091, A513110, A513119
select
STUDENT_NO,
STUDENT_NAME
from
tb_student
where
STUDENT_NO IN('A513079', 'A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
select
DEPARTMENT_NAME,
CATEGORY,
CAPACITY
from
tb_department
where
CAPACITY >= 20 AND CAPACITY <= 30;

-- 6. 춘기술대학교는총장을제외하고모든교수들이소속학과를가지고있다. 
-- 그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
select
PROFESSOR_NAME,
DEPARTMENT_NO
from
tb_professor
where
DEPARTMENT_NO is null;

-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
-- 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
select
DEPARTMENT_NO,
STUDENT_NAME
from
tb_student
where
DEPARTMENT_NO is not null;

-- 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
-- 과목들은 어떤 과목인지 과목번호를 조회해보시오.
select
PREATTENDING_CLASS_NO,
CLASS_NAME
from
tb_class
where
PREATTENDING_CLASS_NO is not null;

-- 9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
select distinct
CATEGORY
from
tb_department;

-- 10. 19학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외하고, 재학중인
-- 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
select
STUDENT_NO,
STUDENT_NAME,
STUDENT_SSN,
ENTRANCE_DATE
ABSENCE_YN
from
tb_student
where
ENTRANCE_DATE like '%9%' or ABSENCE_YN is null;

-- 1.영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.
select
d.DEPARTMENT_NO as 학번, 
s.STUDENT_NO,
s.STUDENT_NAME,
s.ENTRANCE_DATE
from
tb_department d
join
tb_student s
on 
(d.DEPARTMENT_NO = s.DEPARTMENT_NO)
order by ENTRANCE_DATE;
-- 2.춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다. 
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자.
select
PROFESSOR_NAME as 이름,
PROFESSOR_SSN as 주민번호
from
tb_professor
where
PROFESSOR_NAME not like '___';
-- 3.춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. 
-- (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 계산한다.)
-- 힌트 : floor, datediff, curdate, str_to_date, concat
-- 주민번호에서 년도 추출, 19앞에 붙여서 ex) 1993 만들기
-- 이후 현재 년도와 1993 간의 날짜 차이 구해서 365로 나누기
select
PROFESSOR_NAME as 교수이름,
FLOOR(DATEDIFF(CURDATE(), STR_TO_DATE(CONCAT('19', 
SUBSTRING(PROFESSOR_SSN, 1, 6)), '%Y%m%d')) / 365) as 나이
from
tb_professor
where
SUBSTRING(PROFESSOR_SSN, 8, 1) = 1
order by
PROFESSOR_SSN desc;
-- floor 정수로 반환
-- DATEDIFF

-- 4.교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오.
-- 출력 헤더는’이름’ 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)

select
SUBSTRING(PROFESSOR_NAME, 2) as 이름
from
tb_professor;

-- 5.춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?
-- 이때, 만 19살이 되는 해에 입학하면 재수를 하지 않은 것으로 간주한다.
-- FLOOR(DATEDIFF(CURDATE(), STR_TO_DATE(CONCAT('19', 
-- SUBSTRING(PROFESSOR_SSN, 1, 6)), '%Y%m%d')) / 365) as 나이
select
STUDENT_NO,
STUDENT_NAME
from
tb_student
where
FLOOR(DATEDIFF(CURDATE(), STR_TO_DATE(CONCAT('19', substring(STUDENT_SSN,1,6)), '%Y%m%d');

-- 6.2020년 크리스마스는 무슨 요일이었는가?
SELECT
 DAYNAME('2020-12-25') as 요일 ;
 
 -- 7.STR_TO_DATE('99/10/11', '%y/%m/%d') STR_TO_DATE('49/10/11', '%y/%m/%d')은 각각 몇 년 몇 월 몇 일을 의미할까? 
 select
 STR_TO_DATE('99/10/11', '%y/%m/%d') a,
 STR_TO_DATE('49/10/11', '%y/%m/%d') b,
 STR_TO_DATE('70/10/11', '%y/%m/%d') c,
 STR_TO_DATE('69/10/11', '%y/%m/%d') d;
 
-- 8.학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 
-- 단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
-- ROUND: 반올림값 반환
select
s.STUDENT_NO as 번호,
s.STUDENT_NAME as 이름,
round(avg(point),1) as 평점
from
tb_grade g
join
tb_student s
on
(s.STUDENT_NO = g.STUDENT_NO)
where
s.STUDENT_NO = 'A517178' AND s.STUDENT_NAME = '한아름';

-- 9.학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
-- count() 함수 : 특정 열 또는 행의 수를 반환하는 데 사용
-- 주로 특정 조건을 충족하는 행의 수를 세는 데 사용한다.
select
d.DEPARTMENT_NO AS 학과번호,
count(*) AS 학생수
from
tb_department d
join
tb_student s
on
d.DEPARTMENT_NO = s.DEPARTMENT_NO
group by
s.DEPARTMENT_NO;

-- 10.지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오.
select
COACH_PROFESSOR_NO,
count(*)
from
tb_student
group by
COACH_PROFESSOR_NO
having
COACH_PROFESSOR_NO is null;

-- 11.학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 
-- 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
select
substring(TERM_NO,1,4) as 년도,
round(AVG(POINT),1)  as 년도별평점
from
tb_grade
where
STUDENT_NO = 'A112113'
group by
substring(TERM_NO,1,4);

-- 12.학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
select
DEPARTMENT_NO as '학과번호',
count(case when ABSENCE_YN = 'Y' THEN 1
else null end) as '휴학생의 수'
from
tb_student
group by
DEPARTMENT_NO;

-- 13. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다.
-- 어떤 SQL 문장을 사용하면 가능하겠는가?
select
STUDENT_NAME as 이름,
count(*) as '동명이인 수'
from
tb_student
group by
STUDENT_NAME
having
count(STUDENT_NAME) > 1;





