# Structuring Analytic Flow #
## Part one: The Goal ##

There are a lot of different ways to get to a fully reproducible output summary in data science. Your needs determine the nuances of the structure of your approach. However, we operate under the overall princple of lossless data analysis.

There are, at minimum, two relevant documents generated in an analysis of this type: the source code and the output (cleaned and formatted for human readability). I'm going to walk you through how I use source code and output in structured analysis (and why I think it is a preferred method).

## Part two: The Coding Environment ##

This document is written using a markdown extension for the text editor Atom, offered by Github.
![Atom](atom.png)

I prefer Atom as a general text editor because of the ease of git integration, low barrier to transition, range of support for tasks I personally spend a lot of time working on, helpful community, and because I generally like the look and feel of it. Atom is fairly intuitive.

It is important to distinguish between a text editor like Atom, Vim, Sublime, Emacs, or VS code; an IDE, which is designed to compile, run and debug code from a single environment (though plugins allow many of the same functions of an IDE in a text editor), and a notebook format like Jupyter. These are different tools, but there is significant overlap in their fundtionality.

I would caution against dedicating to a single tool. I use Atom, Rstudio and Jupyter Labs at different times, dependant on the desired product. Because the core tools I use for statistics - R and python - are programming languages, the front-ends are interchangeable in many ways, though each has a feature set that fits a task. I'm going ot focus on markdown in Rstudio for analytic flow, but it is worth pointing out that Jupyter labs can run R, python, and many other languges, Rstudio can execute python code, and Atom is practically limitless with its plugin library.

At a minimum, I would recommend installing the following:
-   [R ](https://www.r-project.org/)
-   [The Anaconda distribution of Python ](https://www.anaconda.com/download/)
-   [Rstudio](https://www.rstudio.com/)
-   [Atom](https://atom.io/) or another text editor
-   Jupyter Labs by executing ```conda install -c conda-forge jupyterlab```
in a terminal window **after** installing Anaconda. Anaconda also takes the chore out of installing necessary data science libraries such as pandas, NumPy, and SciPy.

Note that Anaconda comes packaged with the Spyder IDE, which is popular as an Rstudio-like python development environment (another good option is PyCharm, available free with a .edu email address), as well as Jupyter. On a purely personal level, I don't use PyCharm or Spyder because they feel a bit too much like Rstudio to me, but a little off so that I don't quite know where everyting is.

If you install Atom I would recommend the Hydrogen package as well, which serves as a pipe to the Jupyter kernel. The same company makes a jupyter front-end called nteract that has some advantages over jupyter, such as ease of folding code chunk for output summaries. Furthermore, Jupyter has rolled out Jupyter labs, an update to the popular notebook format.

I've used a lot of names and acronyms so far. It is not unreasonable to ask why it is worth going through all this if you just need, e.g. a table of descriptive statistics. My answer is that doing the heavy lift of setting up a organized, reproducible analytic flow in the beginning makes up for itself immeasurably in efficiency going forward. And, really, all we are doing  is loading two coding languages - R and Python - on your computer, and layering on top a few programs that make interacting wth those languages relatively easy. Perhaps this is more intuitive to me because I learned R using Emacs and the plugin ESS, which is notoriously esoteric and obscure.

Let's take a few moments to recap what is available between these different front ends. I work most in Rstudio. Rstudio is great for marking down an analysis and rendering the formatted output to either html or pdf. If I am doing something special in python such as a matplotlib figure, depending on the preferred output format I would use nteract if I just wanted a quick code-folded pdf, Jupyter labs if I wanted a notebook I could share with full code and html or pdf output, or most likely Atom using hydrogen and Pweave. Pweave renders a markdown document that is pandoc-converted to PDF or html using hte command line. This might be unfamiliar to those who are used to Rstudio and the knit button, but it is not much more difficult, only a few extra keystrokes. Learning as I did with Emacs using Sweave for R, this workflow is fairly intuitive.

Since (I assume) most people will focus on R for analysis, I'll restrain the rest of this guide to that language, but it is worth knowing just how many great options you have at present.

## Part three: Analytic flow with R ##

I like to break up my analysis into discrete steps, and focus on one part of the problem at a time. The first step of my analytic flow is usually carried out with colleagues, and consists of defining specific hypotheses or exploratory aims. For the purposes of traditional analysis, we will assume specific hypotheses.

So, in Rstudio, I will initialize a git repository (see previous posts) for a project, and open up an R project file in that folder. I am a very big fan of R projects. These project files make starting and stopping analysis a breeze and a are a great tool for synchronization andenvironment-maintenance. In that working directory, I will open a new markdown document. This will be an index document. The header, or yaml-header, is where you specify the output format, and this needs to be set to PDF, HTML, .docx, or all of the aove, depending on your needs. In this document, I will additionally run an initial code chunk that defines my global environment and loads packages I need for the project.
Here is an example of a yaml-header:
```
---
title: "Analysis"
author: "Andrew Dismukes"
date: "November 19, 2017"
output:
  html_document:
    collapsed: no
    theme: journal
    highlight: tango
    toc: true
    toc_float: true
    toc_depth: 2
    css: style/css/BaseCSS.css
editor_options:
  chunk_output_type: console
---
```
This creates the html document  ```Analysis``` in html format written by me, on a given date, using journal styling, with some css overwritten by my own BaseCSS style sheet.

My first code chunk would look something like this:

```

```{r setup, include=FALSE}
knitr::opts_chunk$set(
                      echo=TRUE,
                      warning=FALSE,
                      include = TRUE,
                      message=FALSE,
                      cache=TRUE,
                      fig.width=8,
                      fig.height=6)
library(tidyverse)
library(psych)
library(nlme)
library(xtable)
```
Which sets global options for the knitr (the tool that converts the R markdown document to regular markdown) package. These options can be changed locally in code chunks but I prefer to have a set of global preferences set.

The next thing I will do is create a separate .R or .Rmd file which I usually name ```datawrangling```. The purpose of this file is  only to load in an perform initial data manipulations such as cleaning, recoding, variables, and subsetting dataframes. So long as this file is saved in the same working directory as the main Analysis .Rmd file, it can be called to and executed with the following code for a .R document:

```
```{r load data, include = FALSE}
source('data/datasets.R')
```
or:
```
```{r, child="datawrangling.Rmd"}
```

for a .Rmd file.

I will perform all data manipulations i this file. Next, I will create a specific document to test each hypothesis using the exact same method: create a separate file, run the code necessary for hypothesis testing in that file, and load it into the main document using the ```code``` or ```child``` calls. In this way, I am never working on more than one small piece of the analysis at any one point in time, but the complete picture can be tied together by knitting the main analysis document. If the analysis is exploratory I will usually create child documents that represent graphical output: ```graphing.Rmd``` followed by tables of descriptives: ```descriptives.Rmd```. I will often keep the sequential analysis open in adjacent tabs in Rstudio: Analysis-> datawrangling -> hypothesis1 -> hypothesis2 and so on, in order to move between the chunks.

In evolving from Sweave and latex in Emacs to knitr on long markdown documents in Rstudio to segmented markdown documents, I have found this flow to be the most efficient for analyzing a dataset and navigating across wha toften turns into quite extensive series of code.

I hope this helps - this has been an evolved process for me and perhaps others with similar goals can find some helpful hints.
