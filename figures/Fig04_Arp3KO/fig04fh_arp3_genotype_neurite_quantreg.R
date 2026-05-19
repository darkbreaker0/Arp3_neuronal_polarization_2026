<!--
================================================================================
fig04fh_arp3_genotype_neurite_quantreg.R — Fig 4f/h
================================================================================

What this file does: Quantile regression with rq() + bootstrap p-values across WT/het/KO.

Manuscript panel(s): Fig 4f/h
Source Data sheet(s): Fig 4f, 4h

Original source on G:\: G:/Figure 4_Arp3KO/WT_het_KO/stats/neurite_length_KOhetWT.R
Quantile regression with rq() + bootstrap p-values across WT/het/KO.

Header added 2026-05-08. For deeper
annotation see CONTRIBUTORS.md and code_organization_plan.md. The file's
analysis logic below this header is bit-faithful to the G:\ original; only
comments above this point have been added.
================================================================================
-->
# load packages
require(xlsx)
require(ggplot2)
require(GGally)
require(quantreg)

# list of KO data files
exp_files <- c('C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Jun25_KO.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug14_KO1.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug14_KO2.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug28_KO1.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug28_KO2.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2014Dec_hippo_KO.xlsx')

# load all KO data files into a dataframe
df <- data.frame()
for (fname in exp_files) {
    exp_df <- data.frame()
    for (phenotype in c('KO')) {
        for (time in c('7hr', '24hr', '48hr')) {
            sheet <- paste(phenotype, '_', time, sep='')
            message(fname, ' ', sheet)
            
            sheet_df <- read.xlsx2(fname, sheetName=sheet)
            sheet_df$sheet <- sheet
            sheet_df$fname <- fname
            sheet_df$phenotype <- phenotype
            sheet_df$time <- time
            
            sheet_df <- sheet_df[sheet_df$Stage. != '',]

            exp_df <- rbind(exp_df, sheet_df[c('Image', 'Stage.', 'Length.of.longest.neurite', 'phenotype', 'time')])
        }
    }

    exp_df$fname <- fname
    df <- rbind(df, exp_df)
}

# list of WT data files
exp_files <- c('C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Jun25_WT.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug28_WT.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2014Dec_hippo_WT.xlsx')

# load all WT data files into the existing dataframe
for (fname in exp_files) {
  exp_df <- data.frame()
  for (phenotype in c('WT')) {
    for (time in c('7hr', '24hr', '48hr')) {
      sheet <- paste(phenotype, '_', time, sep='')
      message(fname, ' ', sheet)
      
      sheet_df <- read.xlsx2(fname, sheetName=sheet)
      sheet_df$sheet <- sheet
      sheet_df$fname <- fname
      sheet_df$phenotype <- phenotype
      sheet_df$time <- time
      
      sheet_df <- sheet_df[sheet_df$Stage. != '',]
      
      exp_df <- rbind(exp_df, sheet_df[c('Image', 'Stage.', 'Length.of.longest.neurite', 'phenotype', 'time')])
    }
  }
  
  exp_df$fname <- fname
  df <- rbind(df, exp_df)
}

# list of het data files
exp_files <- c('C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug14_het.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2013Aug28_het.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WT_het_KO\\Arp3_quant_2014Dec_hippo_het.xlsx')

# load all het data files into the existing dataframe
for (fname in exp_files) {
  exp_df <- data.frame()
  for (phenotype in c('het')) {
    for (time in c('7hr', '24hr', '48hr')) {
      sheet <- paste(phenotype, '_', time, sep='')
      message(fname, ' ', sheet)
      
      sheet_df <- read.xlsx2(fname, sheetName=sheet)
      sheet_df$sheet <- sheet
      sheet_df$fname <- fname
      sheet_df$phenotype <- phenotype
      sheet_df$time <- time
      
      sheet_df <- sheet_df[sheet_df$Stage. != '',]
      
      exp_df <- rbind(exp_df, sheet_df[c('Image', 'Stage.', 'Length.of.longest.neurite', 'phenotype', 'time')])
    }
  }
  
  exp_df$fname <- fname
  df <- rbind(df, exp_df)
}


# convert data into correct numerical format and censor some uncensored stage 1 cells
df$Length.of.longest.neurite <- as.numeric(as.character(df$Length.of.longest.neurite))
df$Length.of.longest.neurite[df$Stage. == 1] <- 15.5

# set reference levels
df$phenotype <- relevel(as.factor(df$phenotype), ref='WT')
df$time <- relevel(as.factor(df$time), ref='7hr')

options(repr.plot.width=9,
        repr.plot.height=3,
        repr.plot.res=300,
        repr.plot.quality=100)
ggplot(df, aes(C(time:phenotype), Length.of.longest.neurite)) +
  geom_violin() +
  # to include box plot too  
  #  geom_boxplot(width=.1) +
  # to include median line  
  stat_summary(fun.y="median", geom="point", size=2) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# regression of WT data
# the filename corresponds to the experiment
wt <- rq(Length.of.longest.neurite ~ C(phenotype:time), data = df[df$phenotype == 'WT',])
summary(wt)
print('Exact p-values:')
summ <- summary(wt, se='boot')
summ$coefficients[,4]

ko <- rq(Length.of.longest.neurite ~ C(phenotype:time), data = df[df$phenotype == 'KO',])
summary(ko)
print('Exact p-values:')
summ <- summary(ko, se='boot')
summ$coefficients[,4]

het <- rq(Length.of.longest.neurite ~ C(phenotype:time), data = df[df$phenotype == 'het',])
summary(het)
print('Exact p-values:')
summ <- summary(het, se='boot')
summ$coefficients[,4]

seven <- rq(Length.of.longest.neurite ~ C(phenotype:time), data = df[df$time == '7hr',])
summary(seven)
print('Exact p-values:')
summ <- summary(seven, se='boot')
summ$coefficients[,4]

twentyfour <- rq(Length.of.longest.neurite ~ C(phenotype:time), data = df[df$time == '24hr',])
summary(twentyfour)
print('Exact p-values:')
summ <- summary(twentyfour, se='boot')
summ$coefficients[,4]

fortyeight <- rq(Length.of.longest.neurite ~ C(phenotype:time), data = df[df$time == '48hr',])
summary(fortyeight)
print('Exact p-values:')
summ <- summary(fortyeight, se='boot')
summ$coefficients[,4]


