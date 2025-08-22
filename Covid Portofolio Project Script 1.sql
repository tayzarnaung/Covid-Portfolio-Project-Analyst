select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4;

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4;

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_death, sum(convert(int, new_deaths)) / sum(new_cases) * 100 as DeathPercentage  
from PortfolioProject..CovidDeaths
where continent is not null;


select location, sum(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is null
and location not in ('World', 'European Union', 'International')
group by location
order by TotalDeathCount desc;


select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2;

-- Looking at total_cases & total_deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2;

-- Looking at total_cases & population
select location, date, total_cases, population, (total_cases/population) * 100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
order by 1,2;


-- Looking at Countries with Highest Infection Rate compared to Population
select location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases)/population * 100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by location, population
order by PercentPopulationInfected desc;


-- Showing Countries with Highest Death Count per Population
select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc;

-- Showing continents with the highest death count per population
select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by continent
order by TotalDeathCount desc;

-- Global Numbers
select  date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) * 100 as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by date
order by 1, 2;

-- 1. Looking at Population & Vaccinatioins
select dea.continent, dea.location, dea.date,  dea.population, vac.new_vaccinations,
	sum(convert(int, vac.new_vaccinations)) over(partition by dea.location order by dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea. date = vac.date
where dea.continent is not null
order by 2,3;

-- 1.1 Using CTE for Looking at Population & Vaccinatioins
with PopVsVac ( Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(convert(int, vac.new_vaccinations)) over(partition by dea.location order by dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea. date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/Population) * 100 as Vaccine_Percent
from PopVsVac
order by location, date;

-- 1.2 Using Temp Tabe for Looking at Population & Vaccinatioins
drop table if exists #PercentPopulationVaccinated;
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date,  dea.population, vac.new_vaccinations,
	sum(convert(int, vac.new_vaccinations)) over(partition by dea.location order by dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea. date = vac.date
where dea.continent is not null
order by 2,3;

select *, (RollingPeopleVaccinated/Population) * 100 as VaccinePercent
from #PercentPopulationVaccinated;

-- Creating View to store data for later visualizations
DROP VIEW if exists PercentPopulationVaccinated_View;

USE PortfolioProject; -- database
GO
CREATE VIEW PercentPopulationVaccinated AS
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM
    PortfolioProject..CovidDeaths dea
JOIN
    PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE
    dea.continent IS NOT NULL;


SELECT TOP (1000) [continent]
      ,[location]
      ,[date]
      ,[population]
      ,[new_vaccinations]
      ,[RollingPeopleVaccinated]
  FROM [PortfolioProject].[dbo].[PercentPopulationVaccinated]