USE [zayed_chatbot_database]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_dept_reptd_usr_cnt]    Script Date: 13/12/2023 12:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--2
CREATE FUNCTION [dbo].[fn_dept_reptd_usr_cnt] (@deptname varchar(50))
RETURNS TABLE
AS
RETURN
SELECT Distinct user_email, count(event_type_id_id)  as ev_count, dateadd(hour, datediff(hour, 0, user_datetime), 0) as datewise
from dbo.zayed_university_app_log
where event_type_id_id IN(2,3,4,5,6,7,10003) and  intent = @deptname 
group by user_email, dateadd(hour, datediff(hour, 0, user_datetime), 0)
order by datewise desc OFFSET 0 ROWS;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_deptwise_ans_data]    Script Date: 13/12/2023 12:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--==================================================
--Functions - 
--==============================================
--1
CREATE FUNCTION [dbo].[fn_deptwise_ans_data] (@deptname varchar(50))

RETURNS TABLE

AS

RETURN

SELECT    zayed_university_app_eventtype.description,
          --DATEPART(DAY, user_datetime) AS 'Day',
		    dateadd(DAY, datediff(DAY, 0, zayed_university_app_log.user_datetime), 0) as day,
          COUNT(*) AS 'counts'
FROM     dbo.zayed_university_app_log
INNER JOIN 
    dbo.zayed_university_app_eventtype
ON
     zayed_university_app_log.event_type_id_id = zayed_university_app_eventtype.id
where zayed_university_app_log.event_type_id_id IN (3, 4, 5) and intent= @deptname
GROUP BY zayed_university_app_eventtype.description,  dateadd(DAY, datediff(DAY, 0, zayed_university_app_log.user_datetime), 0)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_deptwise_busy_period_cnt]    Script Date: 13/12/2023 12:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--3
CREATE FUNCTION [dbo].[fn_deptwise_busy_period_cnt] (@deptname varchar(50))
RETURNS TABLE
AS
RETURN
SELECT intent,dateadd(hour, datediff(hour, 0, user_datetime), 0) as TimeStampHour, Count(intent) as intent_counts
FROM dbo.zayed_university_app_log
where intent=@deptname
GROUP BY intent,dateadd(hour, datediff(hour, 0, user_datetime), 0)
order by TimeStampHour desc OFFSET 0 ROWS ;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_deptwise_new_usr_cnt]    Script Date: 13/12/2023 12:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--4
CREATE FUNCTION [dbo].[fn_deptwise_new_usr_cnt] (@deptname varchar(50))
RETURNS TABLE
AS
RETURN
SELECT Distinct user_email
from dbo.zayed_university_app_log
where event_type_id_id IN(1) and  intent= @deptname 
GO
