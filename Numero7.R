library(tidyverse)
library(ggplot2)
library(dplyr)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggpubr)
library("gridExtra")

theme_set(theme_bw())

dividemile <- function(l) {
  # turn in to character string in scientific notation
  l <-l /1000
  parse(text=l)
} 

multiplyten <- function(l) {
  # turn in to character string in scientific notation
  l <-l *10
  parse(text=l)
} 

multiplyhundred <- function(l) {
  # turn in to character string in scientific notation
  l <-l *100
  parse(text=l)
} 

data_t7_CPM_error1_frontier_obj <- read.delim("C:\\Users\\Alexandro\\Google Drive\\UNIRIO\\AULAS\\2021-2\\Metodologia Cient?fica II\\Trabalho Final\\Trabalho\\Trabalho Final - Dados\\data_t7_CPM_error1_frontier_obj.txt");
data_t7_Margarine_error1_frontier_obj <- read.delim("C:\\Users\\Alexandro\\Google Drive\\UNIRIO\\AULAS\\2021-2\\Metodologia Cient?fica II\\Trabalho Final\\Trabalho\\Trabalho Final - Dados\\data_t7_Margarine_error1_frontier_obj.txt");
data_t7_nsga_150k_c50_2x_error1_frontier_obj <- read.delim("C:\\Users\\Alexandro\\Google Drive\\UNIRIO\\AULAS\\2021-2\\Metodologia Cient?fica II\\Trabalho Final\\Trabalho\\Trabalho Final - Dados\\data_t7_nsga_150k_c50_2x_error1_frontier_obj.txt");
data_t7_nsga_150k_c50_2x_noerror_frontier_obj <- read.delim("C:\\Users\\Alexandro\\Google Drive\\UNIRIO\\AULAS\\2021-2\\Metodologia Cient?fica II\\Trabalho Final\\Trabalho\\Trabalho Final - Dados\\data_t7_nsga_150k_c50_2x_noerror_frontier_obj.txt");
data_t7_SecondHalf_error1_frontier_obj <- read.delim("C:\\Users\\Alexandro\\Google Drive\\UNIRIO\\AULAS\\2021-2\\Metodologia Cient?fica II\\Trabalho Final\\Trabalho\\Trabalho Final - Dados\\data_t7_SecondHalf_error1_frontier_obj.txt");


data  <- bind_rows(data_t7_CPM_error1_frontier_obj,
                   data_t7_Margarine_error1_frontier_obj,
                   data_t7_nsga_150k_c50_2x_error1_frontier_obj,
                   data_t7_nsga_150k_c50_2x_noerror_frontier_obj,
                   data_t7_SecondHalf_error1_frontier_obj);

data_ACAD <- filter(data, inst == "ACAD")

data_PARM <- filter(data, inst == "PARM")

ggplot_acad_1 <- ggplot(data_ACAD, aes(x=mks, y=cst)) + 
  geom_point(pch=1)+
  theme_test() +
  scale_y_continuous(labels=dividemile) +
  geom_smooth() + 
  labs(title="ACAD", y="Cost(1000$)", x="Makespan(days)") + theme(plot.title = element_text(hjust = 0.97, vjust = -9.5, size = 8, face = "bold")) + theme(axis.title.x = element_text(margin = margin(t = 1), size = 7.5),
                                                                                                                                                          axis.title.y = element_text(margin = margin(r = 1), size = 7.5)) + theme(axis.text.y= element_text(angle = 90, vjust = 1, hjust = 0.5, size = 7))

ggplot_acad_2 <- ggplot(data_ACAD, aes(x=noh, y=mks)) +
  geom_point(pch=2) +
  theme_test() +
  scale_y_continuous(breaks = seq(120, 160, 20)) +
  scale_x_continuous(labels=multiplyten, limits = c(0, 40)) +
  geom_smooth() + 
  labs(title="ACAD", y="Makespan(days)", x="Overtime(hours)") + theme(plot.title = element_text(hjust = 0.97, vjust = -9.5, size = 8, face = "bold")) + theme(axis.title.x = element_text(margin = margin(t = 1), size = 7.5),
                                                                                                                                                              axis.title.y = element_text(margin = margin(r = 1), size = 7.5)) + theme(axis.text.y= element_text(angle = 90, vjust = 1, hjust = 0.5, size = 7))

ggplot_acad_3 <- ggplot(data_ACAD, aes(x=noh, y=cst)) +
  geom_point(pch=2) +
  theme_test() +
  scale_y_continuous(labels=dividemile) +
  scale_x_continuous(labels=multiplyten, limits = c(0, 40)) +
  geom_smooth() + 
  labs(title="ACAD", y="Cost(1000$)", x="Overtime(hours)") + theme(plot.title = element_text(hjust = 0.97, vjust = -9.5, size = 8, face = "bold")) + theme(axis.title.x = element_text(margin = margin(t = 1), size = 7.5),
                                                                                                                                                           axis.title.y = element_text(margin = margin(r = 1), size = 7.5)) + theme(axis.text.y= element_text(angle = 90, vjust = 1, hjust = 0.5, size = 7))

ggplot_parm_1 <- ggplot(data_PARM, aes(x=mks, y=cst)) +
  geom_point(pch=2) +
  theme_test() +
  scale_y_continuous(labels=dividemile) +
  scale_x_continuous(breaks = seq(300, 4200,20)) +
  scale_y_continuous(labels=dividemile, breaks = seq(210000, 250000, by=20000)) + 
  geom_smooth() + 
  labs(title="PARM", y="Cost(1000$)", x="Makespan(days)") + theme(plot.title = element_text(hjust = 0.97, vjust = -9.5, size = 8, face = "bold")) + theme(axis.title.x = element_text(margin = margin(t = 1), size = 7.5),
                                                                                                                                                          axis.title.y = element_text(margin = margin(r = 1), size = 7.5))+ theme(axis.text.y= element_text(angle = 90, vjust = 1, hjust = 0.5, size = 7))

ggplot_parm_2 <- ggplot(data_PARM, aes(x=noh, y=mks)) +
  geom_point(pch=2) +
  theme_test() +
  scale_x_continuous(labels=multiplyten,limits = c(0, 100), breaks = seq(0, 100, by=20)) +
  scale_y_continuous(limits = c(300, 420), breaks = seq(300, 420, by=40)) +
  geom_smooth() + 
  labs(title="PARM", y="Makespan(days)", x="Overtime(hours)") + theme(plot.title = element_text(hjust = 0.97, vjust = -9.5, size = 8, face = "bold")) + theme(axis.title.x = element_text(margin = margin(t = 1), size = 7.5),
                                                                                                                                                              axis.title.y = element_text(margin = margin(r = 1), size = 7.5)) + theme(axis.text.y= element_text(angle = 90, vjust = 1, hjust = 0.5, size = 7))

ggplot_parm_3 <- ggplot(data_PARM, aes(x=noh, y=cst)) +
  geom_point(pch=2) +
  theme_test() +
  scale_y_continuous(labels=dividemile, breaks = seq(210000, 250000, by=20000)) +  
  scale_x_continuous(labels=multiplyten,limits = c(0, 100), breaks = seq(0, 100, by=20)) +
  geom_smooth() + 
  labs(title="PARM", y="Cost(1000$)", x="Overtime(hours)") + theme(plot.title = element_text(hjust = 0.97, vjust = -9.5, size = 8, face = "bold")) + theme(axis.title.x = element_text(margin = margin(t = 1), size = 7.5),
                                                                                                                                                           axis.title.y = element_text(margin = margin(r = 1), size = 7.5)) + theme(axis.text.y= element_text(angle = 90, vjust = 1, hjust = 0.5, size = 7))

figure <- grid.arrange(ggplot_acad_1, ggplot_acad_2, ggplot_acad_3, 
                       ggplot_parm_1, ggplot_parm_2, ggplot_parm_3,
                       ncol = 3, nrow = 2)

figure
