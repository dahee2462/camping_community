use mysql;
select * from user; -- 유저 목록 조회
create user 'cteam'@'localhost' identified by 'ezen'; -- 로컬호스트 유저 생성
create user 'cteam'@'%' identified by 'ezen'; -- % 유저 생성
grant all privileges on campingweb.* to 'cteam'@'localhost'; -- campingweb 권한 부여 -> localhost
grant all privileges on campingweb.* to 'cteam'@'%'; -- campingweb 권한 부여 %-> 외부
FLUSH PRIVILEGES; -- 권한 적용
