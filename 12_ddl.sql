-- DDL (Data Definition Language)
-- 데이터를 정의하는 언어
-- 데이터베이스의 스키마를 정의하거나 수정하는데 사용하는 SQL 의 부분이다.

-- CREATE
-- 테이블을 생성하기 위한 구문
-- IF NOT EXISTS <- 만약 존재하지 않는다면?
-- 위에 구문을 적용하면 기존에 존재하는 테이블이 있더라도 에러가 발생하지 않는다.

-- 테이블 컬럼 설정의 표현식
-- column_name data_type(length) -- 반드시 넣어야 하는 표현식 [NOT NULL] [DEFAULT VALUE] [AUTO_INCREMENT] -- column_constraint; 컬럼의 제약조건

-- tb1 테이블 생성

create table if not exists tb1 (
	pk int primary key,
    fk int,
    col1 varchar(255), -- 데이터베이스에 문자열은 sptring 이 아니고 varchar ()는 길이 지정
	check(col1 in ('Y','N')) -- in은 y,n 만 들어가게 한다.
    
) 	engine = innodb;
-- engine = innodb
-- 해당하는 테이블을 innodb 라는 저장 엔진으로 만든다는 의미를 가지고 있다.
-- MySQL 에서 가장 많이 사용하는 엔진으로서
-- 데이터의 무결성, 안정성, 동시성 제어를 하는 것에 적합하다.

describe tb1; -- 설명해줘 라는 뜻

-- 만든 테이블에 값 insert 테스트
-- insert into tb1 values (null, 10, 'Y'); PK 컬럼은 null 을 허용하지 않음
-- insert into tb1 values (1, null, 'G'); col1 컬럼은 'Y','N' 값 외에 허용하지 않음
insert into tb1 values (1, 10, 'Y');

select
	*
from
	tb1;
    
create table if not exists tb2 (
	pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
	check(col1 in ('Y','N'))
) 	engine = innodb;

-- 잘 못 생성한 테이블 삭제 하는 구문 drop
drop table tb2;

describe tb2;

-- auto_increment
-- insert 시에 pk 라고 하는 컬럼에 자동으로 번호를 발생시킨다.
-- 중복되지 않는 값을 발생시킨다.

insert into tb2 value (null, 10, 'Y');
insert into tb2 value (null, 20, 'Y');

select
	*
from
	tb2;
    
-- alter
-- 테이블에 추가 / 변경 / 수정 / 삭제 하는 모든 것은 alter 명령어를 사용해서 적용할 수 있다.

-- List<MemberDTO> member
-- member.add(멤버객체)

-- 열 추가 -> 컬럼을 추가
alter table tb2
add col2 int not null;

-- 열 삭제 -> 컬럼 삭제
alter table tb2
drop column col2;

-- 열 이름 변경 및 데이터 타입 변경
-- alter table 변경할테이블 change 기존컬럼명 바꿀컬럼명 컬럼정의(데이터 타입, 제약조건)
-- tb2 의 fk 컬럼을 change_fk 로 변경, 제약조건을 not null 바꿔야됨
alter table tb2
change column fk change_fk int not null;

-- 열의 제약 조건 추가 및 삭제
-- alter table 테이블명 drop 제약조건

alter table tb2
drop primary key;

-- auto_increment 가 걸려있는 컬럼은 primary key 제거가 되지 않는다.
-- 따라서 auto_increment 속성을 modify 로 제거한다.
-- modify 는 컬럼의 정의를 바꾸는 것이다.

alter table tb2
modify pk int;

-- auto_increment 제거 후 primary key 삭제
alter table tb2
drop primary key;

-- tb3 생성
create table if not exists tb3 (
	pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
	check(col1 in ('Y','N'))
) 	engine = innodb;

-- tb3 삭제
-- if exists 로 만약에 존재한다면 삭제하겠다는 뜻으로 안전한 식으로 만들 수 있다.
drop table if exists tb3;

-- tb4, tb5 생성
create table if not exists tb4 (
	pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
	check(col1 in ('Y','N'))
) 	engine = innodb;

create table if not exists tb5 (
	pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
	check(col1 in ('Y','N'))
) 	engine = innodb;

-- 나열연산자 , 을 이용해 동시에 두개 테이블 삭제
drop table if exists tb4, tb5;

-- truncate // delete
-- delete 구문을 작성을 하면
-- where 조건절로 행을 삭제
-- 조건 없이 delete 를 하면 전체 행 삭제
-- truncate 구문은 행마다 하나씩 지워주는게 아닌 
-- 테이블을 drop 후 재생성을 해주는 초기화의 개념을 가지고 있다.

-- delete 는 우리가 제어판에서 하나 씩 삭제 한다라고 하면
-- truncate 는 pc 초기화의 느낌이다.
describe tb2;

-- tb6 생성
create table if not exists tb6 (
	pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
	check(col1 in ('Y','N'))
) 	engine = innodb;

-- 초기화 확인용 더미네이터
insert into tb6 values (null, 10, 'Y');
insert into tb6 values (null, 20, 'Y');
insert into tb6 values (null, 30, 'Y');
insert into tb6 values (null, 40, 'Y');

select
	*
from
	tb6;
    
-- 테이블 초기화
truncate table tb6;

select
	*
from 
	tb6;

-- truncate 가 데이터를 수정하는 dml 이 아니냐 라고 할 수 있는데
-- 이 친구는 table drop 하고 create 하기 때문에 테이블 구조를 변경 한 것이다.


