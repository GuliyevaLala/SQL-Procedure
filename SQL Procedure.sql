CREATE DATABASE BookStore

use BookStore

create table Authors(
	Id int primary key identity,
	Name nvarchar(55) not null,
	Surname nvarchar(75) not null
)

Create Table Books(
	Id int primary key identity,
	Name nvarchar(100) check(LEN(Name)>=2),
	AuthorId int constraint FK_AuthorID foreign key (AuthorId) references Authors(Id),
	PageCount int check(PageCount>=10)
)

insert into Authors
values ('Honore de ','Balzac'),
('Franz','Kafka'),
('Fyodor','Dostoevsky'),
('Debbie','Macbomber'),
('Anton','Chekhov'),
('Albert','Camus'),
('George','Owell'),
('Ernest ','Hemingway')

Insert into Books
values ('The Lily of the Valley',1,406),
('The Metamorphosis',2,102),
('Anna Karenina',3,800),
('The Shop on Blossom Street',4,400),
('Ward No.6',5,368),
('The Stranger',6,123),
('Nineteen EightyFour',7,328),
('The Sun Also Rises',8,260)

insert into Books
values('To Kill a Mockingbird',7,281),
('Animal Farm',7,112),
('Sakhalin Island',5,210),
('The House of Dead',3,368),
('Eugine Grandet',1,256),
('Morning Comes Softly',4,300),
('Nausea',6,253)

Select book.id,book.Name,book.PageCount,(author.Name + ' ' + author.Surname) as AuthorFullName from Books book
join Authors author
on book.AuthorId=author.Id

create view vw_showall
as 
Select book.id,book.Name,book.PageCount,(author.Name + ' ' + author.Surname) as AuthorFullName from Books book
join Authors author
on book.AuthorId=author.Id


Select * from vw_showall


Create procedure usp_showDetails
@Name nvarchar(85),
@AuthorFullName nvarchar(140)
as
Select * from vw_showall where Name=@Name and AuthorFullName=@AuthorFullName

exec usp_showDetails 'The Metamorphosis','Franz Kafka'

exec usp_showDetails 'The Stranger','Albert Camus'




Create procedure usp_SearchNameFullName
@Name nvarchar(85),
@AuthorFullName nvarchar(140)
as
Select * from vw_showall where Name like'%'+@Name+'%' and AuthorFullName like'%'+@AuthorFullName+'%'


exec usp_SearchNameFullName'The Stranger','Albert Camus'
exec usp_SearchNameFullName 'Animal Farm','George Owell'




Create procedure usp_DeleteInfo
@Name nvarchar(50)
as
Delete from Books
where Name=@Name

exec usp_DeleteInfo 'Nausea'
exec usp_DeleteInfo 'Eugine Grandet'

create procedure usp_update
@Id int,
@Name nvarchar(40)
as 
update Books
set Name=@Name
where Id=@Id

exec usp_update 5,'Sakhalin Island'

SELECT first-name, MAX(salary)
FROM department d LEFT OUTER JOIN employee e ON (d.department_id = e.department_id)
GROUP BY department_id;

SELECT first-name, MAX(salary)
FROM department d LEFT OUTER JOIN employee e ON (d.department_id = e.department_id)
GROUP BY department_id;

--SELECT MAX(Total) FROM (SELECT COUNT(*) AS Total FROM Books GROUP BY name) AS Results

--SELECT COUNT(PageCount) FROM Books ORDER BY COUNT(PageCount) DESC 


select * from vw_showall
order by PageCount desc