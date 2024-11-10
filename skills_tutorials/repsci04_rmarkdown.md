# R markdown

Many of you have been using pure R markdown extensively already with `.Rmd` files. If you haven't, try it out now.

* Work through Chapter 27 of R for Data Science: https://r4ds.had.co.nz/r-markdown.html
* The key features of R markdown are code chunks (delineated by code fences), and chunk options.
* R markdown is more or less being superseded by [Quarto](https://r4ds.hadley.nz/quarto) (which is almost the same but with some tweaks). There is a ton of R markdown out there, so you need to know about it. Such is the price of innovation.

On the other hand, if you've been sticking to pure R markdown up to now, try using your R markdown skills within a `.R` file instead (see [repsci03_r2markdown.md](repsci03_r2markdown.md)).



## Github markdown from Rmarkdown

To output GitHub markdown, include the following at the beginning of the `.Rmd` file:
```r
---
output: github_document
---
```
Then, in RStudio do:
* *File > Knit Document*

or just click the *Compile notebook* icon, or do *Ctrl-Shift-K*.



This will produce a `.md` file and a folder of figures (as well as a `.html` file). Push all that to GitHub and view the `.md` file in a web browser at the GitHub site. Does everything display well on the website? I usually find a few little bugs or typos that I have to fix. After making the changes in my local repo, I do a git amend

```bash
git commit --amend
```

and then push to GitHub again with a force overwrite

```bash
git push --force
```
