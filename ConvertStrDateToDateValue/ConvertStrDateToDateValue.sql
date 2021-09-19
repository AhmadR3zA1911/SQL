
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<https://github.com/AhmadR3zA1911>
-- Create date: <20210506, ,>
-- Description:	<تبدیل تاریخ های متنی به نوع تاریخی عددی , ,>
-- Convert Text Date to Date
-- =============================================
CREATE FUNCTION [dbo].[ConvertStringDateToDateTime]
(
	@strDate nvarchar(50)
)
RETURNS datetime
AS
BEGIN
	Declare @temp nvarchar (50) ,@StrDateFix nvarchar (50)

			--Check Gregorian  Format
		IF exists (Select top 1 value from string_split (@strdate,',') where value in ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday'))
			BEGIN 
				SELECT @temp= CONVERT(datetime,SUBSTRING(REPLACE(@strDate,', ',','),(CHARINDEX(',',REPLACE(@strDate,', ',','),1))+1,len(@strDate)), 106)
				return @temp
			END
		
		ELSE
			BEGIN 
				Declare @strMname nvarchar(10),@Dname nvarchar(2) , @Yname nvarchar(4) , @Mname nvarchar(2) 
				sET @StrDateFix=REPLACE(@strdate,' ,',',')

				Select @temp=tb.value from (select value , ROW_NUMBER() over(order by value) as rw from string_split(@StrDateFix,',') ) as tb where tb.rw=1
				Select @Yname=tb.value  from (select value , ROW_NUMBER() over(order by value) as rw from string_split(@temp,' ') ) as tb where tb.rw=1
				Select @Dname= tb.value from (select value , ROW_NUMBER() over(order by value) as rw from string_split(@temp,' ') ) as tb where tb.rw=2
				Select @strMname=tb.value from (select value , ROW_NUMBER() over(order by value) as rw from string_split(@temp,' ') ) as tb where tb.rw=3

				--Replace Month Name with Month number
				if @strMname=N'ژانویه'
					set @Mname='01'
				else if (@strMname=N'فوریه')
					set @Mname='02'
				else if (@strMname=N'مارچ')
					set @Mname='03'
				else if (@strMname=N'آوریل')
					set @Mname='04'
				else if (@strMname=N'مه')
					set @Mname='05'
				else if (@strMname=N'ژوئن')
					set @Mname='06'
				else if (@strMname=N'ژوئیه')
					set @Mname='07'
				else if (@strMname=N'اوت')
					set @Mname='08'
				else if (@strMname=N'سپتامبر')
					set @Mname='09'
				else if (@strMname=N'اکتبر') or @strMname= N'اُكتبر'
					set @Mname='10'
				else if (@strMname=N'نوامبر')
					set @Mname='11'
				else if (@strMname=N'دسامبر')
					set @Mname='12'
		
				set @temp=CONVERT (datetime, @Yname+'-'+@Mname+'-'+@Dname)
			END

	
	RETURN @temp

END
GO

