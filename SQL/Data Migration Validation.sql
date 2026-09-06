SELECT 'Categories' AS TableName,
       (SELECT COUNT(*) FROM prestage_categories) AS PreStageCount,
       (SELECT COUNT(*) FROM dbo.Categories) AS TargetCount

UNION ALL

SELECT 'Customers',
       (SELECT COUNT(*) FROM prestage_customers),
       (SELECT COUNT(*) FROM dbo.Customers)

UNION ALL

SELECT 'Employees',
       (SELECT COUNT(*) FROM prestage_employees),
       (SELECT COUNT(*) FROM dbo.Employees)

UNION ALL

SELECT 'OrderItems',
       (SELECT COUNT(*) FROM prestage_order_items),
       (SELECT COUNT(*) FROM dbo.OrderItems)

UNION ALL

SELECT 'Orders',
       (SELECT COUNT(*) FROM prestage_orders),
       (SELECT COUNT(*) FROM dbo.Orders)

UNION ALL

SELECT 'Payments',
       (SELECT COUNT(*) FROM prestage_payments),
       (SELECT COUNT(*) FROM dbo.Payments)

UNION ALL

SELECT 'Products',
       (SELECT COUNT(*) FROM prestage_products),
       (SELECT COUNT(*) FROM dbo.Products)

UNION ALL

SELECT 'Promotions',
       (SELECT COUNT(*) FROM prestage_promotions),
       (SELECT COUNT(*) FROM dbo.Promotions)

UNION ALL

SELECT 'Returns',
       (SELECT COUNT(*) FROM prestage_returns),
       (SELECT COUNT(*) FROM dbo.Returns)

UNION ALL

SELECT 'Shipments',
       (SELECT COUNT(*) FROM prestage_shipments),
       (SELECT COUNT(*) FROM dbo.Shipments)

UNION ALL

SELECT 'Stores',
       (SELECT COUNT(*) FROM prestage_stores),
       (SELECT COUNT(*) FROM dbo.Stores)

UNION ALL

SELECT 'Suppliers',
       (SELECT COUNT(*) FROM prestage_suppliers),
       (SELECT COUNT(*) FROM dbo.Suppliers);