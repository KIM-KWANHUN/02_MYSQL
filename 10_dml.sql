-- DML(Date Manipulation Language) 약자
-- Manipulation : 조작
-- 테이블의 값을 삽입, 수정, 삭제하는 SQL 의 한 부분을 의미한다.

-- 삽입 (INSERT)
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.

-- tbl_menu 테이블에 값을 삽입
insert into tbl_menu values (null, '바나나해장국', 8500, 4,'Y');
-- not null 제약조건이 붙은 컬럼은 반드시 값을 넣어주어야 한다.
-- insert into tbl_menu values (null, '바나나해장국', null, 4,'Y');
select * from tbl_menu;

-- 설명
describe tbl_menu;
-- dml 동작 확인용 select 구문
select * from tbl_menu;

-- 컬럼을 명시하게 되면, insert 시 데이터 입력 순서를 바꿔도 상관없다.
insert into tbl_menu
(orderable_status, menu_name, menu_code, menu_price, category_code)
values ('Y', '파인애플탕', null, 5500, 4);

select * from tbl_menu;

-- insert 시 auto_incremet 가 있는 컬럼이나, null 값을 허용하는 컬럼은
-- 데이터를 집어넣지 않아도 된다.
insert into tbl_menu
(orderable_status, menu_name, menu_price, category_code)
values ('Y', '초콜렛밥', 1000, 4);

select * from tbl_menu;

-- 여러 개의 행 동시 추가
insert into tbl_menu values (null, '참치맛아이스크림', 1600, 12, 'Y'), (null, '해장국맛아이스크림', 1900, 12, 'Y'), (null, '멸치맛아이스크림', 1200, 12, 'Y');

select * from tbl_menu;

-- UPDATE
-- 테이블에 기록 된 컬럼들의 값을 수정하는 구문이다.
-- 테이블에 행 갯수에는 영향이 없다.
select menu_code, category_code from tbl_menu where menu_name = '파인애플탕';

-- update, delete -> 조건을 항상 달아야한다. 아니면 모든 데이터가 변경되거나 삭제되서 곤란해짐

update tbl_menu set category_code = 7 where menu_code = 25;

select * from tbl_menu;

-- subquery 를 사용해서 update
-- 주의점. update 나 delete 시에 자기 자신의 테이블의 데이터를
-- 사용하게 되면 1093 error 발생

-- 문제 1. 메뉴의 이름이 파인애플탕인 메뉴의 카테고리코드를 6으로 수정하시오.
-- where menu_name = '파인애플탕' x
-- where menu_code 를 통해 파인애플탕 추론하기
update tbl_menu set category_code = 6 where menu_code = (select menu_code from tbl_menu where menu_name = '파인애플'); 
-- 위에꺼는 1093 에러가떳다 밑에는 문제해결
update tbl_menu set category_code = 6 where menu_code = (select cte.menu_code from (select menu_code from tbl_menu where menu_name = '파인애플탕')cte);

-- delete
-- 테이블의 행을 삭제하는 구문이다.
-- 테이블의 행의 갯수가 줄어든다.

select * from tbl_menu;
-- limit
delete from tbl_menu order by menu_price asc limit 2;

select * from tbl_menu;

-- where 사용으로 단일 행 삭제
delete from tbl_menu where menu_code = 22;

select * from tbl_menu;

delete from tbl_menu;

select * from tbl_menu;

-- replace
-- insert 시 primary key 또는 unique key 가 충돌이 발생한다면
-- replace 를 통해 중복 된 데이터를 덮어쓸 수 있다.

insert into tbl_menu values(15,'소주', 6000, 10, 'Y');
replace into tbl_menu values(15,'소주', 7000, 10, 'Y');
select * from tbl_menu;


