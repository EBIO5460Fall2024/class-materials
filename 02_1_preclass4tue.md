### Week 2: Preclass homework for Tuesday

For the duration of the semester, you should complete these homework assignments before class. In class, we will generally build on the pre-class work or you will share your work with a small group. This weekend is Labor Day and I hope you enjoy the long weekend. That leaves a little less time for this assignment than usual. For Tuesday, please at least watch the video lecture in (2) and try to get through as many of the problems in (3) as you can. You need to learn the Git skills to submit the assignment but you could leave that until last.



#### 1. **Skill of the week:** version control using Git.

Once you have received an email from me (sometime Friday), take control of your repo (see [git02_your_repo.md](skills_tutorials/git02_your_repo.md)). In [git03_basics.md](skills_tutorials/git03_basics.md) learn the basics of how Git works, how to make a repository, add files to it, track changes, and backtrack to a previous state.



#### 2. Watch the video lecture on "Selection structures"

* [01_7_slides_selection_structures.pdf](01_7_slides_selection_structures.pdf)
* [01_7_video_selection_structures.md](01_7_video_selection_structures.md)



#### 3. Programming problems on selection structures

This is a problem-set assignment. You should submit only one file of R code. The filename should be `coding_assignment1.R` (or `.Rmd` if you prefer) but you can add any prefixes to the filename that work with your file naming scheme. **Push your file to your GitHub repository**. To push, you first commit to your local repository, then do

```bash
git push
```

I suggest you follow the class coding style [ebio5460_r_style_guide.md](skills_tutorials/ebio5460_r_style_guide.md) but if you have a strong style preference from long experience I won't mind.

You must not use any R packages for these problems!



##### Single selection structure

```R
if ( condition ) {
    expression
}
```

##### Question 1

What goes wrong with the following code and why? (Provide your answer as a comment). Fix the code.

```R
student_grade <- 75
if ( student_grade < 60 )
    print("Failed")
    print("You need to take the course again")
```

##### Question 2

Why doesn't the following code work as intended?  (Provide your answer as a comment). Fix the code while retaining the single selection structures. You can find the data file in the [`data` folder](/data) in the class-materials repository.

```R
grades <- read.csv("grades.csv")
class_grades <- grades$class1
if ( mean(class_grades) < 60 ) {
    adj <- 60 - mean(class_grades)         #calculate adjustment
    class_grades <- class_grades + adj     #adjust the original grades
    message <- "Mean for raw grades was a fail: grades adjusted"
}
if ( mean(class_grades) >= 60 ) {
    message <- "Average grade was a pass: no adjustment made"
}
print(message)
print(class_grades)    #Should now be adjusted if necessary
```

Hint: sketch the flowchart for two, stacked, `if` single selection structures. Can you see the problem with the logic of the sequence structure? Try running the code line by line and by partial line. Or perhaps try working through the logic in your head (or on paper) line by line.



##### Double selection structure

```R
if ( condition1 ) {
    expression1
} else {
    expression2
}
```

##### Question 3

Fix the code in (Q2)  using a double selection structure. Which option works best, stacked single selection structures or a double selection structure, and why? (Provide your answer as a comment).

##### Question 4

Where should I put braces and indents? Modify the following code to produce the patterns shown in tables (a) and (b) depending on the input. You may not make any changes other than indentation or inserting braces. Your answer should be clear, readable code with good style. Hint: you have to decide when to stack or nest the selection structures.

```R
pattern <- NULL
if ( y == 2 )
if ( x == 1 )
pattern <- c(pattern,"@")
else
pattern <- c(pattern,"#")
pattern <- c(pattern,"$")
pattern <- c(pattern,"&")
print(pattern,quote=FALSE)
```

You will also need to add assignment statements for `y` and `x` before this code so you can vary the input values of `y` and `x`, e.g.

```R
y <- 3
x <- 1
```

Your answer will require separate code for each of table (a) and table (b).

| Table (a)       | Case 1       | Case 2       | Case 3       |
| --------------- | ------------ | ------------ | ------------ |
| With input:     | y = 3, x = 1 | y = 2, x = 3 | y = 2, x = 1 |
| Pattern output: | `&`          | `# $ &`      | `@ $ &`      |

A single algorithm should produce all of the patterns in table (a) by changing only the input values of y and x. 

| Table (b)       | Case 1       | Case 2       | Case 3       |
| --------------- | ------------ | ------------ | ------------ |
| With input:     | y = 3, x = 1 | y = 2, x = 3 | y = 2, x = 1 |
| Pattern output: | `# $ &`      | `&`          | `@ &`        |

A single algorithm should produce all of the patterns in table (b) by changing only the input values of y and x.

