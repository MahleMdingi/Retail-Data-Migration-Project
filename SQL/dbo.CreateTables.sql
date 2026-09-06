-- ===============================================================
-- Creates the target database tables and their primary and 
-- foreign key constraints. The procedure is rerunnable and only 
-- creates tables that do not already exist.
-- ===============================================================
CREATE OR ALTER PROCEDURE dbo.CreateTables
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Categories
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Categories', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Categories
        (
            CategoryID   INT,
            CategoryName VARCHAR(100),

            CONSTRAINT PK_Categories_CategoryID
                PRIMARY KEY (CategoryID)
        );
    END;


    ------------------------------------------------------------
    -- Customers
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Customers', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Customers
        (
            CustomerID INT,
            City       VARCHAR(100),
            SignUpDate DATE,

            CONSTRAINT PK_Customers_CustomerID
                PRIMARY KEY (CustomerID)
        );
    END;


    ------------------------------------------------------------
    -- Stores
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Stores', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Stores
        (
            StoreID INT,
            City    VARCHAR(100),

            CONSTRAINT PK_Stores_StoreID
                PRIMARY KEY (StoreID)
        );
    END;


    ------------------------------------------------------------
    -- Suppliers
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Suppliers', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Suppliers
        (
            SupplierID INT,
            Country    VARCHAR(100),

            CONSTRAINT PK_Suppliers_SupplierID
                PRIMARY KEY (SupplierID)
        );
    END;


    ------------------------------------------------------------
    -- Employees
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Employees', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Employees
        (
            EmployeeID INT,
            StoreID    INT,
            Salary     DECIMAL(18,2),

            CONSTRAINT PK_Employees_EmployeeID
                PRIMARY KEY (EmployeeID),

            CONSTRAINT FK_Employees_Stores_StoreID
                FOREIGN KEY (StoreID)
                REFERENCES dbo.Stores(StoreID)
        );
    END;


    ------------------------------------------------------------
    -- Products
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Products', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Products
        (
            ProductID  INT,
            CategoryID INT,
            SupplierID INT,
            Price      DECIMAL(18,2),

            CONSTRAINT PK_Products_ProductID
                PRIMARY KEY (ProductID),

            CONSTRAINT FK_Products_Categories_CategoryID
                FOREIGN KEY (CategoryID)
                REFERENCES dbo.Categories(CategoryID),

            CONSTRAINT FK_Products_Suppliers_SupplierID
                FOREIGN KEY (SupplierID)
                REFERENCES dbo.Suppliers(SupplierID)
        );
    END;


    ------------------------------------------------------------
    -- Promotions
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Promotions', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Promotions
        (
            PromotionID INT,
            Discount    INT,

            CONSTRAINT PK_Promotions_PromotionID
                PRIMARY KEY (PromotionID)
        );
    END;


    ------------------------------------------------------------
    -- Orders
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Orders', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Orders
        (
            OrderID     INT,
            CustomerID  INT,
            StoreID     INT,
            OrderDate   DATE,
            PromotionID INT,

            CONSTRAINT PK_Orders_OrderID
                PRIMARY KEY (OrderID),

            CONSTRAINT FK_Orders_Customers_CustomerID
                FOREIGN KEY (CustomerID)
                REFERENCES dbo.Customers(CustomerID),

            CONSTRAINT FK_Orders_Stores_StoreID
                FOREIGN KEY (StoreID)
                REFERENCES dbo.Stores(StoreID),

            CONSTRAINT FK_Orders_Promotions_PromotionID
                FOREIGN KEY (PromotionID)
                REFERENCES dbo.Promotions(PromotionID)
        );
    END;


    ------------------------------------------------------------
    -- OrderItems
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.OrderItems', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.OrderItems
        (
            OrderItemID INT,
            OrderID     INT,
            ProductID   INT,
            Qty         INT,
            Price       DECIMAL(18,2),

            CONSTRAINT PK_OrderItems_OrderItemID
                PRIMARY KEY (OrderItemID),

            CONSTRAINT FK_OrderItems_Orders_OrderID
                FOREIGN KEY (OrderID)
                REFERENCES dbo.Orders(OrderID),

            CONSTRAINT FK_OrderItems_Products_ProductID
                FOREIGN KEY (ProductID)
                REFERENCES dbo.Products(ProductID)
        );
    END;


    ------------------------------------------------------------
    -- Payments
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Payments', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Payments
        (
            PaymentID INT,
            OrderID   INT,
            Amount    DECIMAL(18,2),

            CONSTRAINT PK_Payments_PaymentID
                PRIMARY KEY (PaymentID),

            CONSTRAINT FK_Payments_Orders_OrderID
                FOREIGN KEY (OrderID)
                REFERENCES dbo.Orders(OrderID)
        );
    END;


    ------------------------------------------------------------
    -- Shipments
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Shipments', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Shipments
        (
            ShipmentID INT,
            OrderID    INT,
            Status     VARCHAR(50),

            CONSTRAINT PK_Shipments_ShipmentID
                PRIMARY KEY (ShipmentID),

            CONSTRAINT FK_Shipments_Orders_OrderID
                FOREIGN KEY (OrderID)
                REFERENCES dbo.Orders(OrderID)
        );
    END;


    ------------------------------------------------------------
    -- Returns
    ------------------------------------------------------------
    IF OBJECT_ID('dbo.Returns', 'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Returns
        (
            ReturnID    INT,
            OrderItemID INT,
            Refund      DECIMAL(18,2),

            CONSTRAINT PK_Returns_ReturnID
                PRIMARY KEY (ReturnID),

            CONSTRAINT FK_Returns_OrderItems_OrderItemID
                FOREIGN KEY (OrderItemID)
                REFERENCES dbo.OrderItems(OrderItemID)
        );
    END;

END;
GO