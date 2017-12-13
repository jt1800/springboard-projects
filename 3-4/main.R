#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("readr")
library("tidyr")
library("dplyr")
library("readr")

ref <- read.csv("refine_original.csv")

ref$company <- sub("^a.*", "akzo",ref$company,ignore.case = TRUE)
ref$company <- sub("^p.*", "philips",ref$company,ignore.case = TRUE)
ref$company <- sub("^f.*", "philips",ref$company,ignore.case = TRUE)
ref$company <- sub("^v.*", "van houten",ref$company,ignore.case = TRUE)
ref$company <- sub("^u.*", "unilever",ref$company,ignore.case = TRUE)

ref <- ref %>% separate(Product.code...number, c("product_code","product_number"), sep="-") %>%
  mutate(full_address=paste(address,city,country,sep=",")) %>%
  mutate(product_category=c(p="Smartphone",v="TV",x="Laptop",q="Tablet")[product_code])

for(i in 1:nrow(ref)){
  ref$company_philips[i] = as.numeric(ref$company[i] == "philips")
  ref$company_akzo[i] = as.numeric(ref$company[i] == "akzo")
  ref$company_van_houten[i] = as.numeric(ref$company[i] == "van houten")
  ref$company_unilever[i] = as.numeric(ref$company[i] == "unilever")
  
  ref$product_smartphone[i] = as.numeric(ref$product_category[i] == "Smartphone")
  ref$product_tv[i] = as.numeric(ref$product_category[i] == "Tv")
  ref$product_laptop[i] = as.numeric(ref$product_category[i] == "Laptop")
  ref$product_tablet[i] = as.numeric(ref$product_category[i] == "Tablet")
}

write.csv(ref, file="refine_clean.csv")
