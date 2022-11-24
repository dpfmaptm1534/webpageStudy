use aidev;

create table tb_board(
b_idx int auto_increment primary key,
b_userid varchar(20) not null,
b_name varchar(20) not null,
b_title varchar(100) not null,
b_content text not null,
b_hit int default 0,
b_regdate datetime default now(),
b_like int default 0
);

create table tb_reply(
	re_idx int auto_increment primary key,
    re_userid varchar(20) not null,
    re_name varchar(20) not null,
    re_content varchar(2000) not null,
    re_regdate datetime default now(),
    re_boardidx int,
    foreign key (re_boardidx) references tb_board(b_idx) on update cascade
);
select * from tb_board where b_regdate >= (select date_sub(now(),interval 3 day)) and b_idx=2 ;
select * from tb_board where b_regdate >= (select date_sub(now(),interval 3 day)) and b_idx=2;
select b_idx from tb_board where b_regdate >= (select date_sub(now(),interval 3 day)) and b_idx=25;
select * from tb_board ;
select count(*) as cnt  from tb_board;
select * from tb_member;
select * from tb_reply;
select count(*)as cnt from tb_reply where re_boardidx=6;
delete from tb_reply where re_idx ='5' and re_userid='apple';
select * from tb_reply where re_boardidx=6;
create table tb_like(
	l_idx int auto_increment primary key,
    l_boardidx int,
    l_userid varchar(20) not null,
    foreign key(l_boardidx,l_userid) references tb_board(b_idx,b_userid) on update cascade,
);


과제1.아래 로직페이지를 서블릿으로 작성
info_ok.jsp
write_ok.jsp

2.view.jsp 
조회수 증가: view.jsp 입장시 hit에 +1 update 사용
좋아요: 좋아요 버튼을 만들고 클릭시 b_like +1하는데 (Ajax를 이용);

select * from tb_board order by b_idx desc;
select * from tb_board order by b_idx desc LIMIT 0, 10;

show variables like'%max_connection%';
show variables like 'wait_timeout';
show status like '%CONNECT%';

