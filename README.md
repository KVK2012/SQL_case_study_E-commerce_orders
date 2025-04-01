🧾 Project Overview
This project explores a transactional Orders dataset using SQL-style analytical queries. The goal is to derive meaningful business insights related to revenue, profitability, customer behavior, and sales performance over time.

📦 Dataset Info
The dataset includes order-level details such as:

  -Order Date, Ship Mode, Segment, Region, City, State

  -Product details: Category, Sub-Category, Product Id

  -Price components: Cost Price, List Price, Discount, Quantity

Derived metrics:

  -sale_price = List Price × Quantity × (1 - Discount%)

  -profit = sale_price - (Cost Price × Quantity)
