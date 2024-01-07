<!--begin.rcode
set.seed(79)


samples <- replicate(1000, runif(40))


sample_means <- apply(samples, 2, mean)


library(ggplot2)
ggplot(data.frame(x = sample_means), aes(sample = x)) +
  geom_qq() +
  geom_qq_line() +
  labs(title = "Normality Plot of Sample Means",
       x = "Theoretical Quantiles",
       y = "Sample Quantiles")
end.rcode-->

<p>You can also embed plots, for example:</p>

<!--begin.rcode fig.width=7, fig.height=6
set.seed(79) 

sample_means <- numeric(10000)
for (i in 1:10000) {
  sample <- rexp(n = 40, rate = 4)
  sample_mean <- mean(sample)
  sample_means[i] <- sample_mean
}
end.rcode-->

<!--begin.rcode
lower_limits <- numeric(10000)
upper_limits <- numeric(10000)
for (i in 1:10000) {
  ci <- t.test(x = sample_means[i], n = 40, conf.level = 0.95)$conf.int
  lower_limits[i] <- ci[1]
  upper_limits[i] <- ci[2]
}

mean_theoretical <- 1/4 
prop_containing_theoretical <- mean(lower_limits <= mean_theoretical & upper_limits >= mean_theoretical)
end.rcode-->

<!--begin.rcode

data(iris)


setosa <- subset(iris, Species == "setosa")
versicolor <- subset(iris, Species == "versicolor")
virginica <- subset(iris, Species == "virginica")


calculate_ci <- function(x) {
  n <- length(x)
  x_bar <- mean(x)
  s <- sd(x)
  t <- qt(0.975, df = n-1)
  se <- s / sqrt(n)
  lower <- x_bar - t * se
  upper <- x_bar + t * se
  ci <- c(lower, upper)
  return(ci)
}


setosa_ci <- calculate_ci(setosa$Petal.Length)
versicolor_ci <- calculate_ci(versicolor$Petal.Length)
virginica_ci <- calculate_ci(virginica$Petal.Length)


cat("Setosa confidence interval for Petal.Length:", setosa_ci[1], "-", setosa_ci[2], "\n")
cat("Versicolor confidence interval for Petal.Length:", versicolor_ci[1], "-", versicolor_ci[2], "\n")
cat("Virginica confidence interval for Petal.Length:", virginica_ci[1], "-", virginica_ci[2], "\n")
end.rcode-->

<!--begin.rcode
data(iris)


setosa <- subset(iris, Species == "setosa")


t.test(setosa$Sepal.Width, mu = 3.38, alternative = "two.sided", conf.level = 0.95)
end.rcode-->

</body>
</html>
