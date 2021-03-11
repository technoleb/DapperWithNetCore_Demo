USE [DBTest]
GO
/****** Object:  Table [dbo].[members]    Script Date: 2021-03-11 12:45:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[members](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Contact] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_members] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddMember]    Script Date: 2021-03-11 12:45:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddMember]
    @id INT,
    @Name NVARCHAR(50),
    @Contact NVARCHAR(50),
    @Address NVARCHAR(50),
    @retVal INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO members
    (
        [Name],
        Contact,
        [Address],
        RegDate
    )
    VALUES
    (@Name, @Contact, @Address, GETDATE());
    IF @@ROWCOUNT > 0
    BEGIN
        SET @retVal = 200;
    END;
    ELSE
    BEGIN
        SET @retVal = 500;
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteMember]    Script Date: 2021-03-11 12:45:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteMember]
    @id INT,
    @retVal INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE members
    WHERE Id = @id;
    IF @@ROWCOUNT > 0
    BEGIN
        SET @retVal = 200;
    END;
    ELSE
    BEGIN
        SET @retVal = 500;
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateMember]    Script Date: 2021-03-11 12:45:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateMember]
    @id INT,
    @Name NVARCHAR(50),
    @Contact NVARCHAR(50),
    @Address NVARCHAR(50),
    @retVal INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE members
    SET [Name] = @Name,
        Contact = @Contact,
        [Address] = @Address
    WHERE Id = @id;
    IF @@ROWCOUNT > 0
    BEGIN
        SET @retVal = 200;
    END;
    ELSE
    BEGIN
        SET @retVal = 500;
    END;
END;
GO
