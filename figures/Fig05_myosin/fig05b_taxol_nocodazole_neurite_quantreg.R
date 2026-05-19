<!--
================================================================================
fig05b_taxol_nocodazole_neurite_quantreg.R — Fig 5b
================================================================================

What this file does: Quantile regression on Taxol/Nocodazole vs WT/KO.

Manuscript panel(s): Fig 5b
Source Data sheet(s): Fig 5b

Original source on G:\: G:/Figure 5_myosin/Fig. 5b/Taxol_Noc_WTvKO_series/neurite_length_Noc_taxol.R
Quantile regression on Taxol/Nocodazole vs WT/KO.

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

# list of data files
exp_files <- c('C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Taxol_Noc_WTvKO_series\\2016March_tax_Noc_KOvWT_expt1.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Taxol_Noc_WTvKO_series\\2016March_tax_Noc_KOvWT_expt2.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Taxol_Noc_WTvKO_series\\2016March_tax_Noc_KOvWT_expt3.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Taxol_Noc_WTvKO_series\\2016March_tax_Noc_KOvWT_expt4.xlsx')

# load all data files into one dataframe
df <- data.frame()
for (fname in exp_files) {
    exp_df <- data.frame()
    for (phenotype in c('WT', 'KO')) {
        for (concentration in c('DMSO', 'noc_75nM', 'taxol_0.2nM', 'taxol_1nM', 'taxol_5nM')) {
            for (time in c('24', '48')) {
                sheet <- paste(phenotype, '_', concentration, '_', time, 'hr', sep='')
                message(fname, ' ', sheet)

                sheet_df <- read.xlsx2(fname, sheetName=sheet)
                sheet_df$sheet <- sheet
                sheet_df$fname <- fname
                sheet_df$phenotype <- phenotype
                sheet_df$concentration <- concentration
                sheet_df$time <- time

                sheet_df <- sheet_df[sheet_df$Stage. != '',]

                exp_df <- rbind(exp_df, sheet_df[c('Image', 'Stage.', 'Length.of.longest.neurite', 'phenotype', 'concentration', 'time')])
            }
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
df$time <- as.factor(df$time)
df$fname <- as.factor(df$fname)
df$concentration <- relevel(as.factor(df$concentration), ref='DMSO')

#Turn 'concentration' column into a character vector
df$concentration <- as.character(df$concentration)
df$concentration <- factor(df$concentration, levels=unique(df$concentration))

# make a dataframe with only 24hr cells included
df2 <- df[which(df$time=='24'),]

# plot violin plot for 24hr only 
options(repr.plot.width=20,
        repr.plot.height=3,
        repr.plot.res=300,
        repr.plot.quality=100)
ggplot(df2, aes(C(phenotype:concentration), Length.of.longest.neurite)) +
  geom_violin(width=1.6, adjust=2) +
  # to include box plot too  
  #  geom_boxplot(width=.1) +
  # to include median line  
  stat_summary(fun.y="median", geom="point", size=1.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# make a dataframe with only 48hr cells included
df3 <- df[which(df$time=='48'),]

#plot violin plot for 48hr only
options(repr.plot.width=20,
        repr.plot.height=3,
        repr.plot.res=300,
        repr.plot.quality=100)
ggplot(df3, aes(C(phenotype:concentration), Length.of.longest.neurite)) +
  geom_violin(width=1.6, adjust=2) +
  # to include box plot too  
  #  geom_boxplot(width=.1) +
  # to include median line  
  stat_summary(fun.y="median", geom="point", size=1.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# regression of WT data
# the filename corresponds to the experiment
m24wt <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '24' & df$phenotype == 'WT',])
summary(m24wt)
print('Exact p-values:')
summ <- summary(m24wt)
summ$coefficients[,4]

m48wt <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '48' & df$phenotype == 'WT',])
summary(m48wt)
print('Exact p-values:')
summ <- summary(m48wt)
summ$coefficients[,4]

m24ko <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '24' & df$phenotype == 'KO',])
summary(m24ko)
print('Exact p-values:')
summ <- summary(m24ko)
summ$coefficients[,4]

m48ko <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '48' & df$phenotype == 'KO',])
summary(m48ko)
print('Exact p-values:')
summ <- summary(m48ko)
summ$coefficients[,4]

