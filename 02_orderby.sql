-- order by
-- order by 절은 select 절과 함께 사용을 하며
-- 결과 집합을 특정 열이나, 열들의 값에 따라서 정렬하는데 사용된다.

-- tbl_menu 테이블에서 메뉴코드, 메뉴이름, 메뉴가격을 조회를 해줘
-- 근데, 메뉴가격 오름차순으로 정리해서 보여줘

select -- 조회
	menu_code,
    menu_name,
    menu_price

from -- 어디서
	tbl_menu

order by -- 정렬의 기준
	menu_price asc; -- asc : 오름차순 정렬, desc : 내림차순 정렬 어떤값을 정렬할것인지 명시해야함

-- tbl_menu 테이블에서 메뉴코드, 메뉴이름, 메뉴가격을 조회할것 메뉴가격은 내림차순, 메뉴 이름은 오름차순으로 정렬

select 
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by -- 정렬
	menu_price desc,
    menu_name asc;
-- 먼저 작성한 menu_price을 기준으로 정렬을 하되,
-- menu_price 가 동일한 경우 후순위로 작성한 menu_name 으로 정렬을 한다.

select
	menu_code,
    menu_price,
    menu_code  * menu_price as 연산의결과 -- 변수
from
	tbl_menu
order by
-- as : 컬럼에 별칭을 지어두면 마치 별칭을 컬럼처럼 사용할 수 있다.
	연산의결과 desc;

-- field() : 첫번째 인자를 기준으로 일치하는 다른 인자의 위치를 반환 

select field('a', 'b', 'c', 'a');

-- tbl_menu 테이블에서 메뉴이름과 판매상태를 조회하는데 판매 상태가 Y 인 친구들이 
-- 먼저 정렬이 되게 조회해줘 
select
	menu_name,
    orderable_status
from
	tbl_menu
order by
	-- 오름차순, 내림차순을 작성 안 하면 기본값은 asc(오름차순) 이다.
	field(orderable_status, 'Y', 'N');

-- null 값이 존재하는 컬럼에 대한 정렬 

select
	*
from
	tbl_category;
    
-- 오름차순 시 null 값이 처음으로 오게 된다. 
select -- 조회
	*
from -- 어디서 ref_category_code
	tbl_category
order by
	ref_category_code asc; -- 오름차순

-- null 값이 있는경우 null이 항상 먼저 오거나 내림차순으로 하면 가장 나중에 출력됨.

-- is null 오름차순 정렬 시 null 값만 가장 orderable_status뒤로 빼고 오름차순을 해준다.
select -- 조회
	* -- (all)
from -- 어디서
	tbl_category
order by -- 정렬 is null(null을 가장 뒤로 보냄) 및 asc(오름차순) 으로
	ref_category_code is null asc;
