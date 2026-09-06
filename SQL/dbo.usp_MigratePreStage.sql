-- ====================================================================
-- Migrates all data from the PreStage tables into the target tables 
-- within a single transaction. If any load fails, the entire migration 
-- is rolled back and the SQL error is returned.
-- =====================================================================
-- EXEC dbo.usp_MigratePreStage
CREATE OR ALTER PROCEDURE dbo.usp_MigratePreStage
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        ------------------------------------------------------------
        -- Categories
        ------------------------------------------------------------
        INSERT INTO dbo.Categories
        (
            CategoryID,
            CategoryName
        )
        SELECT
            CAST(category_id AS INT),
            category_name
        FROM prestage_categories;


        ------------------------------------------------------------
        -- Customers
        ------------------------------------------------------------
        INSERT INTO dbo.Customers
        (
            CustomerID,
            City,
            SignUpDate
        )
        SELECT
            CAST(customer_id AS INT),
            city,
            CAST(signup_date AS DATE)
        FROM prestage_customers;


        ------------------------------------------------------------
        -- Stores
        ------------------------------------------------------------
        INSERT INTO dbo.Stores
        (
            StoreID,
            City
        )
        SELECT
            CAST(store_id AS INT),
            city
        FROM prestage_stores;


        ------------------------------------------------------------
        -- Suppliers
        ------------------------------------------------------------
        INSERT INTO dbo.Suppliers
        (
            SupplierID,
            Country
        )
        SELECT
            CAST(supplier_id AS INT),
            country
        FROM prestage_suppliers;


        ------------------------------------------------------------
        -- Promotions
        ------------------------------------------------------------
        INSERT INTO dbo.Promotions
        (
            PromotionID,
            Discount
        )
        SELECT
            CAST(promotion_id AS INT),
            CAST(discount AS INT)
        FROM prestage_promotions;


        ------------------------------------------------------------
        -- Employees
        ------------------------------------------------------------
        INSERT INTO dbo.Employees
        (
            EmployeeID,
            StoreID,
            Salary
        )
        SELECT
            CAST(employee_id AS INT),
            CAST(store_id AS INT),
            CAST(salary AS DECIMAL(18,2))
        FROM prestage_employees;


        ------------------------------------------------------------
        -- Products
        ------------------------------------------------------------
        INSERT INTO dbo.Products
        (
            ProductID,
            CategoryID,
            SupplierID,
            Price
        )
        SELECT
            CAST(product_id AS INT),
            CAST(category_id AS INT),
            CAST(supplier_id AS INT),
            CAST(price AS DECIMAL(18,2))
        FROM prestage_products;


        ------------------------------------------------------------
        -- Orders
        ------------------------------------------------------------
        INSERT INTO dbo.Orders
        (
            OrderID,
            CustomerID,
            StoreID,
            OrderDate,
            PromotionID
        )
        SELECT
            CAST(order_id AS INT),
            CAST(customer_id AS INT),
            CAST(store_id AS INT),
            CAST(order_date AS DATE),
            CAST(promotion_id AS INT)
        FROM prestage_orders;


        ------------------------------------------------------------
        -- Order Items
        ------------------------------------------------------------
        INSERT INTO dbo.OrderItems
        (
            OrderItemID,
            OrderID,
            ProductID,
            Qty,
            Price
        )
        SELECT
            CAST(order_item_id AS INT),
            CAST(order_id AS INT),
            CAST(product_id AS INT),
            CAST(qty AS INT),
            CAST(price AS DECIMAL(18,2))
        FROM prestage_order_items;


        ------------------------------------------------------------
        -- Payments
        ------------------------------------------------------------
        INSERT INTO dbo.Payments
        (
            PaymentID,
            OrderID,
            Amount
        )
        SELECT
            CAST(payment_id AS INT),
            CAST(order_id AS INT),
            CAST(amount AS DECIMAL(18,2))
        FROM prestage_payments;


        ------------------------------------------------------------
        -- Shipments
        ------------------------------------------------------------
        INSERT INTO dbo.Shipments
        (
            ShipmentID,
            OrderID,
            Status
        )
        SELECT
            CAST(shipment_id AS INT),
            CAST(order_id AS INT),
            status
        FROM prestage_shipments;


        ------------------------------------------------------------
        -- Returns
        ------------------------------------------------------------
        INSERT INTO dbo.Returns
        (
            ReturnID,
            OrderItemID,
            Refund
        )
        SELECT
            CAST(return_id AS INT),
            CAST(order_item_id AS INT),
            CAST(refund AS DECIMAL(18,2))
        FROM prestage_returns;


        ------------------------------------------------------------
        -- If everything succeeded
        ------------------------------------------------------------
        COMMIT TRANSACTION;

        SELECT
            'Migration completed successfully.' AS Message;

    END TRY

    BEGIN CATCH

        ------------------------------------------------------------
        -- Roll back everything if anything failed
        ------------------------------------------------------------
        IF XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;


        ------------------------------------------------------------
        -- Return error details
        ------------------------------------------------------------
        SELECT
            ERROR_NUMBER()    AS ErrorNumber,
            ERROR_SEVERITY()  AS ErrorSeverity,
            ERROR_STATE()     AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE()      AS ErrorLine,
            ERROR_MESSAGE()   AS ErrorMessage;

    END CATCH;

END;
GO