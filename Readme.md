# COVID Portfolio Project

This project analyzes global COVID-19 data using SQL and provides insights for visualization in Tableau. It includes SQL scripts for data exploration, aggregation, and preparation for dashboards, as well as datasets and Tableau-ready tables.

## Project Structure

```
Covid Portofolio Project Script 1.sql
Tableau Script 1.sql
dataset/
    CovidDeaths.xlsx
    CovidVaccinations.xlsx
Tableau Table/
    Tableau Table 1.xlsx
    Tableau Table 2.xlsx
    Tableau Table 3.xlsx
    Tableau Table 4.xlsx
```

## Contents

- **Covid Portofolio Project Script 1.sql**  
  Main SQL script for data exploration, cleaning, aggregation, and view creation. Queries include:
  - Global and country-level case/death statistics
  - Infection and death rates by population
  - Rolling vaccination counts
  - Temporary tables and views for further analysis

- **Tableau Script 1.sql**  
  SQL queries tailored for Tableau dashboards, focusing on:
  - Aggregated case and death counts
  - Highest infection rates by country
  - Data grouped for visualization

- **dataset/**  
  - `CovidDeaths.xlsx`: Raw COVID-19 deaths data  
  - `CovidVaccinations.xlsx`: Raw COVID-19 vaccinations data

- **Tableau Table/**  
  Pre-processed Excel tables for direct Tableau import.

## Usage

1. **Data Preparation**  
   - Import the Excel datasets from the [`dataset`](dataset) folder into your SQL database.

2. **SQL Analysis**  
   - Run the queries in [`Covid Portofolio Project Script 1.sql`](Covid Portofolio Project Script 1.sql) for data exploration and to create views/tables for visualization.
   - Use [`Tableau Script 1.sql`](Tableau Script 1.sql) to generate summary tables for Tableau.

3. **Visualization**  
   - Use the processed tables in `Tableau Table/` or connect Tableau directly to your SQL views/tables for dashboard creation.

## Requirements

- Microsoft SQL Server 2019
- SQL Server Management Studion 2021 (SSMS)
- Tableau Desktop (for visualization)
- Excel (for dataset handling)

## License

This project is for educational and portfolio purposes.

---

**Author:**  
[Tay Zar Naung]  
[22.8.2025]