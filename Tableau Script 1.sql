select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_death, sum(convert(int, new_deaths)) / sum(new_cases) * 100 as DeathPercentage  
from PortfolioProject..CovidDeaths
where continent is not null;


select location, sum(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is null
and location not in ('World', 'European Union', 'International')
group by location
order by TotalDeathCount desc;


-- Looking at Countries with Highest Infection Rate compared to Population
select location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases)/population * 100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by location, population
order by PercentPopulationInfected desc;


-- Looking at Countries with Highest Infection Rate compared to Population
select location, population, date, MAX(total_cases) as HighestInfectionCount, MAX(total_cases)/population * 100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by location, population, date
order by PercentPopulationInfected desc;