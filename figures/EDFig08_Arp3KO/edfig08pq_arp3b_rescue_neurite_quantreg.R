<!--
================================================================================
edfig08pq_arp3b_rescue_neurite_quantreg.R — ED Fig 8p/q
================================================================================

What this file does: Arp3b rescue quantile regression for ED Fig 8p/q.

Manuscript panel(s): ED Fig 8p/q
Source Data sheet(s): ED Fig 8p, 8q

Original source on G:\: G:/Figure S8_Arp3KO/Fig. S8p/Arp3bEGFP_rescue_ExtFig. 8pq/stats/neurite_length_Arp3b.R
Arp3b rescue quantile regression for ED Fig 8p/q.

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
exp_files <- c('C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Arp3b_KOvWT_transfections\\Arp3b_June2016_expt1.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Arp3b_KOvWT_transfections\\Arp3b_June2016_expt2.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Arp3b_KOvWT_transfections\\Arp3b_June2016_expt3.xlsx',
               'C:\\Users\\charlotte.STRUBI\\Documents\\DZNE_documents\\Data\\Quantifications\\Arp3b_KOvWT_transfections\\Arp3b_June2016_expt4.xlsx')

# load all data files into one dataframe
df <- data.frame()
for (fname in exp_files) {
    exp_df <- data.frame()
    for (phenotype in c('WT', 'KO')) {
        for (DNA in c('AcGFP', 'Arp3EGFP', 'Arp3bEGFP')) {
            sheet <- paste(phenotype, '_', DNA, sep='')
            message(fname, ' ', sheet)
            
            sheet_df <- read.xlsx2(fname, sheetName=sheet)
            sheet_df$sheet <- sheet
            sheet_df$fname <- fname
            sheet_df$phenotype <- phenotype
            sheet_df$DNA <- DNA
            
            sheet_df <- sheet_df[sheet_df$Stage. != '',]

            exp_df <- rbind(exp_df, sheet_df[c('Image', 'Stage.', 'Length.of.longest.neurite', 'GFP.positive', 'phenotype', 'DNA')])
        }
    }

    exp_df$fname <- fname
    df <- rbind(df, exp_df)
}


# make a dataframe with only GFP positive cells included
df2 <- df[which(df$GFP.positive=='Yes'),]

# convert data into correct numerical format and censor some uncensored stage 1 cells
df2$Length.of.longest.neurite <- as.numeric(as.character(df2$Length.of.longest.neurite))
df2$Length.of.longest.neurite[df2$Stage. == 1] <- 15.5

# set reference levels
df2$phenotype <- relevel(as.factor(df2$phenotype), ref='WT')
df2$DNA <- relevel(as.factor(df2$DNA), ref='AcGFP')
df2$GFP.positive <- as.factor(df2$GFP.positive)

#Turn 'DNA' column into a character vector
df2$DNA <- as.character(df2$DNA)
df2$DNA <- factor(df2$DNA, levels=unique(df2$DNA))

options(repr.plot.width=9,
        repr.plot.height=3,
        repr.plot.res=300,
        repr.plot.quality=100)
ggplot(df2, aes(C(phenotype:DNA), Length.of.longest.neurite)) +
  geom_violin() +
  # to include box plot too  
  #  geom_boxplot(width=.1) +
  # to include median line  
  stat_summary(fun.y="median", geom="point", size=2) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# regression of WT data
# the filename corresponds to the experiment
wt <- rq(Length.of.longest.neurite ~ C(DNA) + fname, data = df2[df2$phenotype == 'WT',])
summary(wt)
print('Exact p-values:')
summ <- summary(wt, se='boot')
summ$coefficients[,4]

ko <- rq(Length.of.longest.neurite ~ C(DNA) + fname, data = df2[df2$phenotype == 'KO',])
summary(ko)
print('Exact p-values:')
summ <- summary(ko, se='boot')
summ$coefficients[,4]


