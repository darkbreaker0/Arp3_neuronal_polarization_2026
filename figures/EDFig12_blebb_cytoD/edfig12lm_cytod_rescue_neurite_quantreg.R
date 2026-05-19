<!--
================================================================================
edfig12lm_cytod_rescue_neurite_quantreg.R — ED Fig 12l/m
================================================================================

What this file does: CytoD rescue neurite-length quantile regression for ED Fig 12l/m.

Manuscript panel(s): ED Fig 12l/m
Source Data sheet(s): ED Fig 12l, 12m

Original source on G:\: G:/Figure S12_blebbistatin_CytoD/Fig. S12l/cytoD_KOvWT_series_ExtFig. lm/stats/neurite_length_cytoD.R
CytoD rescue neurite-length quantile regression for ED Fig 12l/m.

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
exp_files <- c('C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WTvKO_cytoDseries\\stats\\2015Nov_cytoDseries_KOvWT_expt2.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WTvKO_cytoDseries\\stats\\2015Dec_cytoDseries_KOvWT_expt3.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WTvKO_cytoDseries\\stats\\2015Nov_cytoDseries_KOvWT_expt4.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\WTvKO_cytoDseries\\stats\\2015Nov_cytoDseries_KOvWT_expt1cut.xlsx')

# load all data files into one dataframe
df <- data.frame()
for (fname in exp_files) {
    exp_df <- data.frame()
    for (phenotype in c('WT', 'KO')) {
        for (concentration in c('DMSO', '3nM', '30nM', '1uM')) {
            for (time in c('24', '48')) {
                sheet <- paste(phenotype, '_cytoD_', concentration, '_', time, 'hr', sep='')
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
options(repr.plot.width=9,
        repr.plot.height=3,
        repr.plot.res=300,
        repr.plot.quality=100)
ggplot(df2, aes(C(phenotype:concentration), Length.of.longest.neurite)) +
  geom_violin() +
  # to include box plot too  
  #  geom_boxplot(width=.1) +
  # to include median line  
  stat_summary(fun.y="median", geom="point", size=2) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# make a dataframe with only 48hr cells included
df3 <- df[which(df$time=='48'),]

#plot violin plot for 48hr only
options(repr.plot.width=9,
        repr.plot.height=3,
        repr.plot.res=300,
        repr.plot.quality=100)
ggplot(df3, aes(C(phenotype:concentration), Length.of.longest.neurite)) +
  geom_violin() +
  # to include box plot too  
  #  geom_boxplot(width=.1) +
  # to include median line  
  stat_summary(fun.y="median", geom="point", size=2) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# regression of WT data
# the filename corresponds to the experiment
m24wt <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '24' & df$phenotype == 'WT',])
summary(m24wt)
print('Exact p-values:')
summ <- summary(m24wt, se='boot')
summ$coefficients[,4]

m48wt <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '48' & df$phenotype == 'WT',])
summary(m48wt)
print('Exact p-values:')
summ <- summary(m48wt, se='boot')
summ$coefficients

m24ko <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '24' & df$phenotype == 'KO',])
summary(m24ko)
print('Exact p-values:')
summ <- summary(m24ko, se='boot')
summ$coefficients

m48ko <- rq(Length.of.longest.neurite ~ C(phenotype:concentration) + fname, data = df[df$time == '48' & df$phenotype == 'KO',])
summary(m48ko)
print('Exact p-values:')
summ <- summary(m48ko, se='boot')
summ$coefficients

