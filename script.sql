USE [library]
GO
/****** Object:  Table [dbo].[books]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[books](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[author] [nvarchar](50) NULL,
	[bookname] [nvarchar](50) NULL,
	[imagedata] [varbinary](max) NULL,
 CONSTRAINT [PK_books] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dropdownSearch]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dropdownSearch](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[items] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[img_save]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[img_save](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[author] [nvarchar](100) NULL,
	[bookname] [nvarchar](100) NULL,
	[size] [int] NULL,
	[imageData] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[readers]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[readers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username_] [nvarchar](50) NULL,
	[password_] [nvarchar](50) NULL,
 CONSTRAINT [PK_readers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[records]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[records](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[bookId] [int] NULL,
	[day_] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[workers]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[workers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username_] [nvarchar](50) NULL,
	[password_] [nvarchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[records]  WITH CHECK ADD  CONSTRAINT [FK_records_books] FOREIGN KEY([bookId])
REFERENCES [dbo].[books] ([id])
GO
ALTER TABLE [dbo].[records] CHECK CONSTRAINT [FK_records_books]
GO
ALTER TABLE [dbo].[records]  WITH CHECK ADD  CONSTRAINT [FK_records_readers] FOREIGN KEY([userId])
REFERENCES [dbo].[readers] ([id])
GO
ALTER TABLE [dbo].[records] CHECK CONSTRAINT [FK_records_readers]
GO
/****** Object:  StoredProcedure [dbo].[check_log_in]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[check_log_in]
@username nvarchar(50),
@password nvarchar(50)
as
begin
	declare @checkInfo int
	if exists(select * from workers where username_ = @username and password_ = @password)
	begin 
		set @checkInfo = 1
	end
	else if exists(select * from readers where username_ = @username and password_ = @password)
		set @checkInfo = 2
	else 
	begin
		set @checkInfo = 0
	end
	return @checkInfo 
end
GO
/****** Object:  StoredProcedure [dbo].[deleteBook]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteBook]
@bookId int
as
begin
delete from books where id = @bookId
end
GO
/****** Object:  StoredProcedure [dbo].[deleteBookFromBooks]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[deleteBookFromBooks]
@id int
as 
begin 
if not exists(select * from records where bookId = @id)
begin
	delete from books where id = @id
end
end


select * from records
GO
/****** Object:  StoredProcedure [dbo].[deleteRecords]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[deleteRecords]
@user_id int,
@book_id int
as
begin
delete from records where userId = userId and bookId = @book_id
end
GO
/****** Object:  StoredProcedure [dbo].[find_user_id]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[find_user_id]
@username nvarchar(50)
as
begin
	declare @checkInfo int
	if exists(select * from workers where username_ = @username )
	begin 
		select id from workers where username_ = @username
	end
	else if exists(select * from readers where username_ = @username)
	    select id from readers where username_ = @username
end
GO
/****** Object:  StoredProcedure [dbo].[getAllBooks]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[getAllBooks]
as
begin
select id,author , bookname from books
end
GO
/****** Object:  StoredProcedure [dbo].[getBookDetails]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getBookDetails]
@id int
as 
begin 
select author , bookname , imagedata from books where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[getBooksWithId]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[getBooksWithId]
@id int
as
begin 
select bookId,b.bookname as book , r.day_ as date from records r left join 
books b on r.bookId = b.id where r.userId = @id
end
GO
/****** Object:  StoredProcedure [dbo].[getDrData]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getDrData]
as
begin
select * from dropdownSearch
end
GO
/****** Object:  StoredProcedure [dbo].[insert_book]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insert_book]
@author nvarchar(50),
@book_name nvarchar(50),
@description_ nvarchar(50),
@image nvarchar(50)
as
begin 
insert into books(author,book_name,description_ , image_) values(@author,@book_name,@description_,@image)
end
GO
/****** Object:  StoredProcedure [dbo].[insertRecord]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertRecord]
@userId int,
@bookId int
as
begin 
insert into records(userId , bookId , day_) values(@userId , @bookId , GETDATE())
end
GO
/****** Object:  StoredProcedure [dbo].[select_image]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[select_image] 
@id int =0
as
select imageData from books where id=@id
GO
/****** Object:  StoredProcedure [dbo].[selectBookForUpdate]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectBookForUpdate]
@id int
as
begin
select author , bookname , imagedata from books where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[selectForAuthor]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectForAuthor]
@author nvarchar(50)
as
begin
select id , imagedata from books where author = @author
end
GO
/****** Object:  StoredProcedure [dbo].[selectForBookName]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[selectForBookName]
@name nvarchar(50)
as
begin
select id , imagedata from books where bookname = @name
end
GO
/****** Object:  StoredProcedure [dbo].[spUploadImage]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spUploadImage] 
@author nvarchar(100)='',
@bookname nvarchar(100)='',
@imageData varbinary(max)
as
insert into books(author,bookname,imageData)
values (@author,@bookname,@imageData)
GO
/****** Object:  StoredProcedure [dbo].[updateBook]    Script Date: 1/24/2023 11:15:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateBook]
@id int,
@author nvarchar(50),
@bookName nvarchar(50),
@image varbinary(max)
as
begin
update books set author = @author , bookname = @bookName , imagedata = @image where id = @id
end
select * from books
GO
