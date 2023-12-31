USE [zayed_chatbot_database]
GO
/****** Object:  Table [dbo].[zayed_university_app_log]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zayed_university_app_log](
	[id] [char](32) NOT NULL,
	[user_email] [nvarchar](254) NOT NULL,
	[user_ip] [nvarchar](39) NOT NULL,
	[event_question] [nvarchar](1000) NOT NULL,
	[event_answer] [nvarchar](4000) NOT NULL,
	[user_datetime] [datetime2](7) NOT NULL,
	[intent] [nvarchar](100) NOT NULL,
	[event_type_id_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[monthly_engaged_users_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[monthly_engaged_users_view]
AS
Select  user_email , count(*) as event_counts
from dbo.zayed_university_app_log
where event_type_id_id = 1 and user_datetime >= CONVERT(DateTime, DATEDIFF(MONTH, 0, GETDATE()))
group by user_email,event_type_id_id having COUNT(event_type_id_id)> 1;
GO
/****** Object:  View [dbo].[monthly_reset_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[monthly_reset_count]
AS
select user_email,user_datetime
from dbo.zayed_university_app_log
WHERE MONTH(user_datetime)=MONTH(getdate()) and event_type_id_id=7 
GROUP BY user_email,user_datetime
GO
/****** Object:  Table [dbo].[zayed_university_app_eventtype]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zayed_university_app_eventtype](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[livechat_monthwise]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[livechat_monthwise]
AS
SELECT    
		  dateadd(MONTH, datediff(MONTH, 0, zayed_university_app_log.user_datetime), 0) as month,
          COUNT(*) AS 'counts'
FROM     dbo.zayed_university_app_log
INNER JOIN 
    dbo.zayed_university_app_eventtype
ON
     zayed_university_app_log.event_type_id_id = zayed_university_app_eventtype.id
where zayed_university_app_log.event_type_id_id = 6
GROUP BY dateadd(MONTH, datediff(MONTH, 0, zayed_university_app_log.user_datetime), 0)
GO
/****** Object:  View [dbo].[monthly_no_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--20

CREATE VIEW [dbo].[monthly_no_count]
AS
select user_email,user_datetime
from dbo.zayed_university_app_log
WHERE MONTH(user_datetime)=MONTH(getdate()) and event_type_id_id=5 
GROUP BY user_email,user_datetime
GO
/****** Object:  View [dbo].[monthly_wrong_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--19
CREATE VIEW [dbo].[monthly_wrong_count]
AS
select user_email,user_datetime
from dbo.zayed_university_app_log
WHERE MONTH(user_datetime)=MONTH(getdate()) and event_type_id_id=3 
GROUP BY user_email,user_datetime
GO
/****** Object:  View [dbo].[monthly_right_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--18
CREATE VIEW [dbo].[monthly_right_count]
AS
select user_email,user_datetime
from dbo.zayed_university_app_log
WHERE MONTH(user_datetime)=MONTH(getdate()) and event_type_id_id=4 
GROUP BY user_email,user_datetime
GO
/****** Object:  View [dbo].[daily_no_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--17
CREATE VIEW [dbo].[daily_no_count]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=5 
GROUP BY user_email, event_type_id_id
GO
/****** Object:  View [dbo].[daily_right_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--16
CREATE VIEW [dbo].[daily_right_count]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=4 
GROUP BY user_email, event_type_id_id
GO
/****** Object:  View [dbo].[daily_wrong_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--15
CREATE VIEW [dbo].[daily_wrong_count]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=3 
GROUP BY user_email, event_type_id_id
GO
/****** Object:  View [dbo].[daily_livechat_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--14
CREATE VIEW [dbo].[daily_livechat_count]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=6 
GROUP BY user_email, event_type_id_id
GO
/****** Object:  View [dbo].[daily_reset_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
--13
CREATE VIEW [dbo].[daily_reset_count]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=7 
GROUP BY user_email, event_type_id_id
GO
/****** Object:  View [dbo].[daily_new_users_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--11
create VIEW [dbo].[daily_new_users_view]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=1 
GROUP BY user_email, event_type_id_id
HAVING count(event_type_id_id)=1
GO
/****** Object:  View [dbo].[busy_period_count]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--1
CREATE  VIEW [dbo].[busy_period_count]
AS
SELECT intent,dateadd(hour, datediff(hour, 0, user_datetime), 0) as TimeStampHour, Count(intent) as intent_counts
FROM dbo.zayed_university_app_log
GROUP BY intent,dateadd(hour, datediff(hour, 0, user_datetime), 0)
order by TimeStampHour desc OFFSET 0 ROWS;
GO
/****** Object:  View [dbo].[busy_period_count_monthly]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--2
CREATE  VIEW [dbo].[busy_period_count_monthly]
AS
SELECT intent,dateadd(Month, datediff(Month, 0, user_datetime), 0) as TimeStampHour, Count(intent) as intent_counts
FROM dbo.zayed_university_app_log
GROUP BY intent,dateadd(Month, datediff(Month, 0, user_datetime), 0)

order by TimeStampHour desc OFFSET 0 ROWS;
GO
/****** Object:  View [dbo].[livechat_daywise]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--3
CREATE VIEW [dbo].[livechat_daywise]
AS
SELECT    dateadd(DAY, datediff(DAY, 0, zayed_university_app_log.user_datetime), 0) as day,
          COUNT(*) AS 'counts'
FROM     dbo.zayed_university_app_log
INNER JOIN 
    dbo.zayed_university_app_eventtype
ON
     zayed_university_app_log.event_type_id_id = zayed_university_app_eventtype.id
where zayed_university_app_log.event_type_id_id = 6
GROUP BY dateadd(DAY, datediff(DAY, 0, zayed_university_app_log.user_datetime), 0)
GO
/****** Object:  View [dbo].[reset_daywise]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--4
CREATE VIEW [dbo].[reset_daywise]
AS
SELECT    
		  dateadd(DAY, datediff(DAY, 0, zayed_university_app_log.user_datetime), 0) as day,
          COUNT(*) AS 'counts'
FROM     dbo.zayed_university_app_log
INNER JOIN 
    dbo.zayed_university_app_eventtype
ON
     zayed_university_app_log.event_type_id_id = zayed_university_app_eventtype.id
where zayed_university_app_log.event_type_id_id = 7
GROUP BY dateadd(DAY, datediff(DAY, 0, zayed_university_app_log.user_datetime), 0)
GO
/****** Object:  View [dbo].[monthly_new_users_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[monthly_new_users_view]
AS
select distinct(user_email),user_datetime
from dbo.zayed_university_app_log
WHERE MONTH(user_datetime)=MONTH(getdate()) and event_type_id_id=1 
GROUP BY user_email,user_datetime
Having count(event_type_id_id)<=1
GO
/****** Object:  View [dbo].[total_ans_cnt_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--6
CREATE VIEW [dbo].[total_ans_cnt_view]
WITH SCHEMABINDING
AS
SELECT 
	zayed_university_app_eventtype.description,
	--COUNT(zayed_university_app_log.event_type_id_id) AS counts,
	COUNT_BIG(*) AS counts
FROM 
    dbo.zayed_university_app_log 
INNER JOIN 
    dbo.zayed_university_app_eventtype  
ON
     zayed_university_app_log.event_type_id_id = zayed_university_app_eventtype.id
WHERE  zayed_university_app_log.event_type_id_id IN (3, 4, 5)
GROUP BY 
	zayed_university_app_eventtype.description;
GO
/****** Object:  View [dbo].[repeated_bot_users_day_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--7
CREATE VIEW [dbo].[repeated_bot_users_day_view]
AS
SELECT Distinct user_email, count(event_type_id_id)  as ev_count, dateadd(hour, datediff(hour, 0, user_datetime), 0) as datewise
from dbo.zayed_university_app_log
where event_type_id_id IN(3,4,5) 
group by user_email, dateadd(hour, datediff(hour, 0, user_datetime), 0)
order by datewise desc OFFSET 0 ROWS;
GO
/****** Object:  View [dbo].[repeated_bot_users_monthly_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--8
CREATE VIEW [dbo].[repeated_bot_users_monthly_view]
AS
SELECT Distinct user_email, count(event_type_id_id)  as ev_count,  dateadd(MONTH, datediff(MONTH, 0, zayed_university_app_log.user_datetime), 0) as month
from dbo.zayed_university_app_log
where event_type_id_id IN(1,3,4,5,7,10003) 
group by user_email,  dateadd(MONTH, datediff(MONTH, 0, zayed_university_app_log.user_datetime), 0)
order by month desc OFFSET 0 ROWS;
GO
/****** Object:  View [dbo].[monthly_eng_users_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[monthly_eng_users_view]
AS
select distinct(user_email)
from dbo.zayed_university_app_log
WHERE MONTH(user_datetime)=MONTH(getdate()) and event_type_id_id=1 
GROUP BY user_email
Having count(event_type_id_id)>1
GO
/****** Object:  View [dbo].[daily_eng_users_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[daily_eng_users_view]
AS
select distinct user_email,event_type_id_id, count(event_type_id_id) as count_ev
from dbo.zayed_university_app_log
WHERE user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=1 
GROUP BY user_email, event_type_id_id
HAVING count(event_type_id_id)>1
GO
/****** Object:  View [dbo].[new_users_view]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[new_users_view]
AS
select user_email,description,user_datetime,COUNT(DISTINCT user_email) AS count 
from dbo.zayed_university_app_log
INNER JOIN 
    dbo.zayed_university_app_eventtype
ON
    zayed_university_app_log.event_type_id_id = zayed_university_app_eventtype.id
where user_datetime > CAST(GETDATE() AS DATE)
  AND user_datetime < CAST(GETDATE()+1 AS DATE) and event_type_id_id=1
GROUP BY user_email,description, user_datetime



GO
/****** Object:  Table [dbo].[auth_group]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [auth_group_name_a6ea08ec_uniq] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group_permissions]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_permission]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[content_type_id] [int] NOT NULL,
	[codename] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[password] [nvarchar](128) NOT NULL,
	[last_login] [datetime2](7) NULL,
	[is_superuser] [bit] NOT NULL,
	[username] [nvarchar](150) NOT NULL,
	[first_name] [nvarchar](150) NOT NULL,
	[last_name] [nvarchar](150) NOT NULL,
	[email] [nvarchar](254) NOT NULL,
	[is_staff] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[date_joined] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [auth_user_username_6821ab7c_uniq] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_groups]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_groups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_user_permissions]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_user_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_admin_log]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_admin_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[action_time] [datetime2](7) NOT NULL,
	[object_id] [nvarchar](max) NULL,
	[object_repr] [nvarchar](200) NOT NULL,
	[action_flag] [smallint] NOT NULL,
	[change_message] [nvarchar](max) NOT NULL,
	[content_type_id] [int] NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_content_type]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_content_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[app_label] [nvarchar](100) NOT NULL,
	[model] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_migrations]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_migrations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[app] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[applied] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_session]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_session](
	[session_key] [nvarchar](40) NOT NULL,
	[session_data] [nvarchar](max) NOT NULL,
	[expire_date] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[session_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_app_department]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_app_department](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[department] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_app_departmentadminuser]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_app_departmentadminuser](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[department_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
	[usertype_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_app_report]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_app_report](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[report_name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_app_report_assigned_to]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_app_report_assigned_to](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[report_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_app_usertype]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_app_usertype](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[usertype] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zayed_university_app_acronyms]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zayed_university_app_acronyms](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[short_form] [nvarchar](50) NOT NULL,
	[long_form] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zayed_university_app_mastertable]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zayed_university_app_mastertable](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[question] [nvarchar](1000) NOT NULL,
	[answer] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zayed_university_app_qa_category]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zayed_university_app_qa_category](
	[id] [char](32) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[parent_id] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zayed_university_app_tag_qa]    Script Date: 11/12/2023 12:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zayed_university_app_tag_qa](
	[tag] [char](32) NOT NULL,
	[question] [nvarchar](1000) NOT NULL,
	[answer] [nvarchar](1000) NOT NULL,
	[keywords] [nvarchar](max) NOT NULL,
	[category] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[auth_group_permissions]  WITH CHECK ADD  CONSTRAINT [auth_group_permissions_group_id_b120cbf9_fk_auth_group_id] FOREIGN KEY([group_id])
REFERENCES [dbo].[auth_group] ([id])
GO
ALTER TABLE [dbo].[auth_group_permissions] CHECK CONSTRAINT [auth_group_permissions_group_id_b120cbf9_fk_auth_group_id]
GO
ALTER TABLE [dbo].[auth_group_permissions]  WITH CHECK ADD  CONSTRAINT [auth_group_permissions_permission_id_84c5c92e_fk_auth_permission_id] FOREIGN KEY([permission_id])
REFERENCES [dbo].[auth_permission] ([id])
GO
ALTER TABLE [dbo].[auth_group_permissions] CHECK CONSTRAINT [auth_group_permissions_permission_id_84c5c92e_fk_auth_permission_id]
GO
ALTER TABLE [dbo].[auth_permission]  WITH CHECK ADD  CONSTRAINT [auth_permission_content_type_id_2f476e4b_fk_django_content_type_id] FOREIGN KEY([content_type_id])
REFERENCES [dbo].[django_content_type] ([id])
GO
ALTER TABLE [dbo].[auth_permission] CHECK CONSTRAINT [auth_permission_content_type_id_2f476e4b_fk_django_content_type_id]
GO
ALTER TABLE [dbo].[auth_user_groups]  WITH CHECK ADD  CONSTRAINT [auth_user_groups_group_id_97559544_fk_auth_group_id] FOREIGN KEY([group_id])
REFERENCES [dbo].[auth_group] ([id])
GO
ALTER TABLE [dbo].[auth_user_groups] CHECK CONSTRAINT [auth_user_groups_group_id_97559544_fk_auth_group_id]
GO
ALTER TABLE [dbo].[auth_user_groups]  WITH CHECK ADD  CONSTRAINT [auth_user_groups_user_id_6a12ed8b_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[auth_user_groups] CHECK CONSTRAINT [auth_user_groups_user_id_6a12ed8b_fk_auth_user_id]
GO
ALTER TABLE [dbo].[auth_user_user_permissions]  WITH CHECK ADD  CONSTRAINT [auth_user_user_permissions_permission_id_1fbb5f2c_fk_auth_permission_id] FOREIGN KEY([permission_id])
REFERENCES [dbo].[auth_permission] ([id])
GO
ALTER TABLE [dbo].[auth_user_user_permissions] CHECK CONSTRAINT [auth_user_user_permissions_permission_id_1fbb5f2c_fk_auth_permission_id]
GO
ALTER TABLE [dbo].[auth_user_user_permissions]  WITH CHECK ADD  CONSTRAINT [auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[auth_user_user_permissions] CHECK CONSTRAINT [auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id]
GO
ALTER TABLE [dbo].[django_admin_log]  WITH CHECK ADD  CONSTRAINT [django_admin_log_content_type_id_c4bce8eb_fk_django_content_type_id] FOREIGN KEY([content_type_id])
REFERENCES [dbo].[django_content_type] ([id])
GO
ALTER TABLE [dbo].[django_admin_log] CHECK CONSTRAINT [django_admin_log_content_type_id_c4bce8eb_fk_django_content_type_id]
GO
ALTER TABLE [dbo].[django_admin_log]  WITH CHECK ADD  CONSTRAINT [django_admin_log_user_id_c564eba6_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[django_admin_log] CHECK CONSTRAINT [django_admin_log_user_id_c564eba6_fk_auth_user_id]
GO
ALTER TABLE [dbo].[report_app_departmentadminuser]  WITH CHECK ADD  CONSTRAINT [report_app_departmentadminuser_department_id_e9066033_fk_report_app_department_id] FOREIGN KEY([department_id])
REFERENCES [dbo].[report_app_department] ([id])
GO
ALTER TABLE [dbo].[report_app_departmentadminuser] CHECK CONSTRAINT [report_app_departmentadminuser_department_id_e9066033_fk_report_app_department_id]
GO
ALTER TABLE [dbo].[report_app_departmentadminuser]  WITH CHECK ADD  CONSTRAINT [report_app_departmentadminuser_user_id_57b82771_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[report_app_departmentadminuser] CHECK CONSTRAINT [report_app_departmentadminuser_user_id_57b82771_fk_auth_user_id]
GO
ALTER TABLE [dbo].[report_app_departmentadminuser]  WITH CHECK ADD  CONSTRAINT [report_app_departmentadminuser_usertype_id_e3c4a9d4_fk_report_app_usertype_id] FOREIGN KEY([usertype_id])
REFERENCES [dbo].[report_app_usertype] ([id])
GO
ALTER TABLE [dbo].[report_app_departmentadminuser] CHECK CONSTRAINT [report_app_departmentadminuser_usertype_id_e3c4a9d4_fk_report_app_usertype_id]
GO
ALTER TABLE [dbo].[report_app_report_assigned_to]  WITH CHECK ADD  CONSTRAINT [report_app_report_assigned_to_report_id_40015eaf_fk_report_app_report_id] FOREIGN KEY([report_id])
REFERENCES [dbo].[report_app_report] ([id])
GO
ALTER TABLE [dbo].[report_app_report_assigned_to] CHECK CONSTRAINT [report_app_report_assigned_to_report_id_40015eaf_fk_report_app_report_id]
GO
ALTER TABLE [dbo].[report_app_report_assigned_to]  WITH CHECK ADD  CONSTRAINT [report_app_report_assigned_to_user_id_84711952_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[report_app_report_assigned_to] CHECK CONSTRAINT [report_app_report_assigned_to_user_id_84711952_fk_auth_user_id]
GO
ALTER TABLE [dbo].[zayed_university_app_log]  WITH CHECK ADD  CONSTRAINT [zayed_university_app_log_event_type_id_id_9b30887d_fk_zayed_university_app_eventtype_id] FOREIGN KEY([event_type_id_id])
REFERENCES [dbo].[zayed_university_app_eventtype] ([id])
GO
ALTER TABLE [dbo].[zayed_university_app_log] CHECK CONSTRAINT [zayed_university_app_log_event_type_id_id_9b30887d_fk_zayed_university_app_eventtype_id]
GO
ALTER TABLE [dbo].[django_admin_log]  WITH CHECK ADD  CONSTRAINT [django_admin_log_action_flag_a8637d59_check] CHECK  (([action_flag]>=(0)))
GO
ALTER TABLE [dbo].[django_admin_log] CHECK CONSTRAINT [django_admin_log_action_flag_a8637d59_check]
GO
