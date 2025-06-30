# main_script1.R




# Make sure working directory is the same as the script location (implicitly handled in GitHub Actions)
# Print working directory
cat("Working directory:", getwd(), "\n")

# Set up and confirm output folder
output_dir <- file.path(getwd(), "outputs/script1")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
cat("Created directory:", output_dir, "\n")

# Confirm contents before saving
print("Files in 'outputs' before saving:")
print(list.files("outputs", recursive = TRUE))

# Save dummy test file just to verify
writeLines("test", file.path(output_dir, "test.txt"))




# Load the helper script
source("RD_and_DT_Algorithm_copy.R")  # Ensure this file is in the same directory

lambda <- 2


results_25 <- data.frame(
  Run = integer(),
  N_t = integer(),
  Length = numeric(),
  Cost = numeric(),
  NumDisambigs = integer()
)


for (i in 1:100) {
  set.seed(400+i)
  obs_gen_para <- c(gamma = 0.3, d = 5, noPoints = 50, no_c = 25, no_o = 25)
  result <- DT_Alg_M(obs_gen_para, kei = 10, lambda)
  
  results_25[i, ] <- list(
    Run = i,
    N_t = 25,
    Length = result$Length_total,
    Cost = result$Cost_total,
    NumDisambigs = length(result$Disambiguate_state)
  )
}

saveRDS(results_25, file.path(output_dir, "data_50_4_1.rds"))






results_50 <- data.frame(
  Run = integer(),
  N_t = integer(),
  Length = numeric(),
  Cost = numeric(),
  NumDisambigs = integer()
)


for (i in 1:100) {
  set.seed(400+i)
  obs_gen_para <- c(gamma = 0.3, d = 5, noPoints = 75, no_c = 25, no_o = 50)
  result <- DT_Alg_M(obs_gen_para, kei = 10, lambda)
  
  results_50[i, ] <- list(
    Run = i,
    N_t = 50,
    Length = result$Length_total,
    Cost = result$Cost_total,
    NumDisambigs = length(result$Disambiguate_state)
  )
}

saveRDS(results_50, file.path(output_dir, "data_50_4_2.rds"))






results_75 <- data.frame(
  Run = integer(),
  N_t = integer(),
  Length = numeric(),
  Cost = numeric(),
  NumDisambigs = integer()
)


for (i in 1:100) {
  set.seed(400+i)
  obs_gen_para <- c(gamma = 0.3, d = 5, noPoints = 100, no_c = 25, no_o = 75)
  result <- DT_Alg_M(obs_gen_para, kei = 10, lambda)
  
  results_75[i, ] <- list(
    Run = i,
    N_t = 75,
    Length = result$Length_total,
    Cost = result$Cost_total,
    NumDisambigs = length(result$Disambiguate_state)
  )
}

saveRDS(results_75, file.path(output_dir, "data_50_4_3.rds"))







results_100 <- data.frame(
  Run = integer(),
  N_t = integer(),
  Length = numeric(),
  Cost = numeric(),
  NumDisambigs = integer()
)


for (i in 1:100) {
  set.seed(400+i)
  obs_gen_para <- c(gamma = 0.3, d = 5, noPoints = 125, no_c = 25, no_o = 100)
  result <- DT_Alg_M(obs_gen_para, kei = 10, lambda)
  
  results_100[i, ] <- list(
    Run = i,
    N_t = 100,
    Length = result$Length_total,
    Cost = result$Cost_total,
    NumDisambigs = length(result$Disambiguate_state)
  )
}

saveRDS(results_100, file.path(output_dir, "data_50_4_4.rds"))







results_125 <- data.frame(
  Run = integer(),
  N_t = integer(),
  Length = numeric(),
  Cost = numeric(),
  NumDisambigs = integer()
)


for (i in 1:100) {
  set.seed(400+i)
  obs_gen_para <- c(gamma = 0.3, d = 5, noPoints = 150, no_c = 25, no_o = 125)
  result <- DT_Alg_M(obs_gen_para, kei = 10, lambda)
  
  results_125[i, ] <- list(
    Run = i,
    N_t = 125,
    Length = result$Length_total,
    Cost = result$Cost_total,
    NumDisambigs = length(result$Disambiguate_state)
  )
}

saveRDS(results_125, file.path(output_dir, "data_50_4_5.rds"))







# Combine all results into one table
results <- results_25

# Format output
results_out <- data.frame(
  Index = paste0('"', 1:nrow(results), '"'),  # Quoted index
  results[, c("N_t", "Length", "Cost", "NumDisambigs")]  # Make sure column names match
)

# Define the custom header (space-separated, quoted)
header <- '"n_t" "length" "cost" "number of disambiguations"'

# Define output path
txt_path <- file.path(output_dir, "results_ACS4_clutter.txt")

# Write header manually
writeLines(header, txt_path)

# Append data
write.table(
  results_out,
  file = txt_path,
  append = TRUE,
  row.names = FALSE,
  col.names = FALSE,
  quote = FALSE,
  sep = " "
)

cat("✅ Text results saved to:", txt_path, "\n")
