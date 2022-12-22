library(RVCompare)
library(ggplot2)
setwd ("/home/lufanta/Desktop/2022/BH/proiektua/CSV")
csv_data <- read.csv("REPETIZIOAK")

csv_data

X_A <- csv_data$EDA1
X_B <- csv_data$SIMULATED1


if (length(X_A) != length(X_B))
{
  stop("length(X_A) != length(X_B)")
}

n <- length(X_A)


# SCATTER
pdf("scatter.pdf")
plot(c(rnorm(length(X_A), mean = 1, sd = 0.2), rnorm(length(X_B), mean = 5, sd = 0.2)),  c(X_A,X_B), xlim = c(0,7), xlab = "X_A                                        X_B")
dev.off()



# HISTOGRAM

nbins = 20

dataHist <- data.frame(
  value=c(X_A,X_B),
  type=c(rep("Name X_A", length(X_A)), rep("Name X_B",  length(X_B)))
)

fig <- ggplot(data=dataHist, aes(x=value, fill=type)) +
  geom_histogram(alpha=0.65, position = 'identity', bins = nbins) +
  scale_fill_manual(values=c("#1f77b4", "#ff7f0e")) +
  ggplot2::xlab('score') +
  ggplot2::ylab('count') +
  ggplot2::theme_minimal() +
  labs(fill="")

ggsave("histogram.pdf", plot=fig,  width = 4, height = 2, device="pdf")


# BOXPLOT
pdf("boxplot.pdf")
boxplot(X_A, X_B, names = c("X_A", "X_B"))
dev.off()



# SIGN TEST (FOR PROBABILITY OF "X_A" > "X_B" or "X_B" > "X_A")

# Measure the number of 'non ties'
n_without_ties <- sum(sign(X_A - X_B) != 0)

# Measure the number of success
n_success <- sum(sign(X_A - X_B) == 1)

binom.test(n_success, n_without_ties, alternative = "two.sided")


# CUMULATIVE DIFFERENCE PLOT

is_minimization <- FALSE
cumulative_difference_plot(X_A, X_B,
                           isMinimizationProblem = is_minimization,
                           labelA = "EDA", labelB = "SIMULATED", ignoreMinimumLengthCheck = TRUE)
11










