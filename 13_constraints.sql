-- constraints (제약 조건)
-- 테이블에 데이터가 입력 되거나 변경될 때 규칙을 정의한다.
-- ** 데이터의 무결성 **!!

-- not null
-- null 값 즉 비어있는 값을 허용하지 않는다 라는 제약조건

drop table if exists user_notnull;
create table if not exists user_notnull(
	user_no int not null,
    user_id varchar(30) not null, -- not null 없으면 안되는것을 의미함
    user_pwd varchar(40) not null,
    user_name varchar(30) not null,
    gender varchar(3),
    phone varchar(30) not null,
    email varchar(50)
)engine=innodb;

describe user_notnull;

insert into user_notnull
values
(1, 'user01', 'pass01', '김관훈', '남', '010-3656-7112', 'rhksgns4@gmail.com'),
(2, 'user02', 'pass02', '김관순', '여', '010-3656-7113', 'rhksgns5@gmail.com');

select
	*
from
	user_notnull;

insert into user_notnull
values
(1, 'user01', null, '김관훈', '남', '010-3656-7112', 'rhksgns4@gmail.com'), -- notnull 이 붙은 애들은 null을 넣지못하고 반드시 값을 넣어줘야 한다.
(2, 'user02', 'pass02', '김관순', '여', '010-3656-7113', 'rhksgns5@gmail.com');

-- unique 제약 조건
-- 중복 된 값을 허용하지 않는 제약조건

drop table if exists user_unique;
create table if not exists user_unique(
	user_no int not null unique, -- null값을 허용하지 않으면서, 유일한 값 unique
    user_id varchar(30) not null , 
    user_pwd varchar(40) not null,
    user_name varchar(30) not null,
    gender varchar(3),
    phone varchar(30) not null,
    email varchar(50),
    unique(phone) -- unique() 소가로 안에도 넣을수 있다.
)engine=innodb;

describe user_unique;

-- email, phone, user_no unique로 설정해놧음
insert into user_unique
values
(1, 'user01', 'pass01', '김관훈', '남', '010-3656-7112', 'rhksgns4@gmail.com'),
(2, 'user02', 'pass02', '김관순', '여', '010-3656-7112', 'rhksgns5@gmail.com');
-- unique 제약 조건 에러 발생 (전화번호 중복됨)
-- 아이디 같은것이 unique 에 많이 쓰임 **유일한값**

-- **primary key란?**
-- **매우중요** 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미한다.
-- 하나의 정보를 특정하기 위한 유일한 값 중복되지 않고 만약 메뉴코드라고하면 중복되지 않으니 primary key
-- 테이블에 대한 식별자 역활 -> 한 행을 식별할 수 있는 값을 의미한다.
-- not null + unique = primary key
-- 한 테이블 당 한개만 설정 가능함
-- 한 개 컬럼에 설정 할 수 있고, 여러 개의 컬럼을 묶어서 설정할 수 있다.
-- 복합키 (여러 개의 pk)

drop table if exists user_pk;
create table if not exists user_pk(
	-- user_no int primary key, -- 이런 식으로도 제약조건 설정가능
    user_no int,
    user_id varchar(30) not null , 
    user_pwd varchar(40) not null,
    user_name varchar(30) not null,
    gender varchar(3),
    phone varchar(30) not null,
    email varchar(50),
    primary key(user_no)
)engine=innodb;

describe user_pk;

-- primary key 와 연관된 키워드 
-- **foreign key (외래키)
-- 참조(연관) 된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- foreign key 제약조건에 의해 테이블 간의 관계가 형성이 될 수 있다.

-- 부모테이블, 자식테이블
-- 부모테이블 생성
drop table if exists user_grade;
create table if not exists user_grade(
	-- user_no int primary key, -- 이런 식으로도 제약조건 설정가능
    grade_code int primary key,
    grade_name varchar(30) not null 
)engine=innodb;

insert into user_grade
value(10, '일반회원'),
	 (20, '우수회원'),
	 (30, '특별회원');
     
select
	*
from
	user_grade;
    
-- 자식테이블 생성    
drop table if exists user_fk1;
create table if not exists user_fk1(
	-- user_no int primary key, -- 이런 식으로도 제약조건 설정가능
    user_no int primary key,
    user_id varchar(30) not null , 
    user_pwd varchar(40) not null,
    user_name varchar(30) not null,
    gender varchar(3),
    phone varchar(30) not null,
    email varchar(50),
    grade_no int, 
    foreign key(grade_no) -- 외래키
    references user_grade (grade_code) -- 레퍼런스 테이블(참조할 명)
)engine=innodb;

insert into user_fk1
values
(1, 'user01', 'pass01', '김관훈', '남', '010-3656-7112', 'rhksgns4@gmail.com',10),
(2, 'user02', 'pass02', '김관순', '여', '010-3656-7113', 'rhksgns5@gmail.com',20);

select
	*
from
	user_fk1;
insert into user_fk1
values
-- error 1062 : 참조하고 있는 테이블(부모 테이블)에는 존재하지 않는 값을 집어 넣을때
-- 발생하는 에러 => foreign key 제약조건 위반
(3, 'user02', 'pass02', '김관순', '여', '010-3656-7113', 'rhksgns5@gmail.com',25);

describe user_fk1;


-- check 제약조건
-- 조건을 위반할 시 허용하지 않는 제약조건

drop table if exists user_check;

-- 술을 파는 사이트, 미성년자 들어오면 안된다.
-- 성별은 2가지 값을 받을 것이다. 남 or 여
-- 나이는 19 미만일경우 술을 팔지 않는다.
create table if not exists user_check(
    user_no int auto_increment primary key,
    user_name varchar(30) not null,
    gender varchar(3) check(gender in ('남','여')), 
    age int check(age >= 19)
)engine=innodb;

insert into use_check
values
(null, '홍길동', '남', 25);

describe user_check;

-- default
-- nullable 한 컬럼에 비어있는 값 대신 우리가 설정한 기본값 적용

drop table if exists tbl_country;
create table if not exists tbl_country(
    country_code int auto_increment primary key,
    country_name varchar(255) default '한국',
    population varchar(255) default '0',
    add_time datetime default(current_time()),
    add_day date default(current_date())
)engine=innodb;

insert into tbl_country
values
(null, default, default, default, default);

select
	*
from
	tbl_country;
