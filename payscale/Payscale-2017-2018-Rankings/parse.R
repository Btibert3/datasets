options(stringsAsFactors = FALSE)

## the libraries
library(jsonlite)
library(stringr)
library(dplyr)

## the data
PATH = "~/github/datasets/payscale/Payscale-2017-2018-Rankings/bestcolleges-20172018.json"
x = fromJSON(PATH)
names(x) = tolower(gsub(" ", "_", names(x)))
names(x) = str_replace_all(names(x), "%", "pct")
names(x)

## build a dataframe
df = data.frame(unitid = x$ipeds_id,
                rank = x$rank,
                name = x$school_name,
                name_friendly = x$friendly_name,
                early_career_median_pay = x$early_career_median_pay,
                # career_median_pay = x$career_median_pay,
                pct_high_job_meaning = x$pct_high_job_meaning,
                state = x$state,
                sector = x$school_sector,
                type = x$school_type,
                div1_football = x$division_1_football_classifications,
                div1_basketball = x$division_1_basketball_classifications,
                pct_male = x$pct_male,
                pct_female = x$pct_female,
                ug_enroll = x$undergraduate_enrollment,
                pct_stem = x$pct_stem,
                pct_pell= x$pct_pell,
                pct_who_recommend_school = x$pct_who_recommend_school,
                zipcode = x$zip_code,
                imageurl = x$imageurl,
                url = x$url, stringsAsFactors = FALSE)

## fix column types
VARS = vars(unitid:rank, 
            early_career_median_pay:pct_high_job_meaning, 
            pct_male:pct_who_recommend_school)
df = df %>% mutate_at(VARS, as.numeric)

## remove the empty column
df = df %>% select(-pct_who_recommend_school)


## save output
saveRDS(df, "payscale-1718.rds")  
