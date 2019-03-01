install.packages("tidyverse", dependencies=TRUE)
      install.packages("vars", dependencies=TRUE)
      install.packages("stargazer", dependencies=TRUE)
      install.packages("timeSeries", dependencies=TRUE)
      install.packages("tseries", dependencies=TRUE)
      install.packages("dlnm", dependencies=TRUE)
      install.packages("orcutt", dependencies=TRUE)
      install.packages("dplyr", dependencies=TRUE)
      install.packages("ggplot2", dependencies=TRUE)
      install.packages("psych", dependencies=TRUE)
      install.packages("RColorBrewer", dependencies=TRUE)
      install.packages("Hmisc", dependencies =TRUE)
      install.packages("foreign", dependencies=TRUE)
      install.packages("zoo", dependencies=TRUE)
      install.packages("astsa", dependencies=TRUE)
      install.packages("TSA", dependencies=TRUE)
      install.packages("party", dependencies=TRUE)
      install.packages("animation", dependencies=TRUE)
      install.packages("googleVis", dependencies=TRUE)
      install.packages("sandwich", dependencies=TRUE)
      install.packages("lmtest", dependencies=TRUE)
      install.packages("dynlm", dependencies=TRUE)
      install.packages("quadprog", dependencies=TRUE)
      install.packages("car", dependencies=TRUE)
      install.packages("swirl")
      install.packages("readxl", dependencies=TRUE)
      install.packages("scatterplot3d", dependencies=TRUE)
      install.packages("rgl", dependencies=TRUE)
      install.packages("haven", dependencies=TRUE)

install.packages(c("devtools","mvtnorm","loo","coda"), repos="https://cloud.r-project.org/",dependencies=TRUE)
library(devtools)
install_github("rmcelreath/rethinking")


remove.packages("rstan")
if (file.exists(".RData")) file.remove(".RData")

install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)

detectCores(all.tests = FALSE, logical = TRUE)

pkgbuild::has_build_tools(debug = TRUE)

dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, ifelse(.Platform$OS.type == "windows", "Makevars.win", "Makevars"))
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native",
    if( grepl("^darwin", R.version$os)) "CXX14FLAGS += -arch x86_64 -ftemplate-depth-256" else 
      if (.Platform$OS.type == "windows") "CXX11FLAGS=-O3 -march=native -mtune=native" else
        "CXX14FLAGS += -fPIC",
    file = M, sep = "\n", append = TRUE)

M <- file.path(Sys.getenv("HOME"), ".R", ifelse(.Platform$OS.type == "windows", "Makevars.win", "Makevars"))
file.edit(M)

rstan_options(auto_write = TRUE)

schools_dat <- list(J = 8, 
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))

fit <- stan(file = '8schools.stan', data = schools_dat)

print(fit)
plot(fit)
pairs(fit, pars = c("mu", "tau", "lp__"))

la <- extract(fit, permuted = TRUE) # return a list of arrays 
mu <- la$mu 

### return an array of three dimensions: iterations, chains, parameters 
a <- extract(fit, permuted = FALSE) 

### use S3 functions on stanfit objects
a2 <- as.array(fit)
m <- as.matrix(fit)
d <- as.data.frame(fit)


options(mc.cores = parallel::detectCores())

