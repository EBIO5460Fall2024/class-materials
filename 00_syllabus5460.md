### Data Science for Biological Research

#### EBIO 5460-002, Fall 2024

**Instructor**: Dr Brett Melbourne\
**Pronouns:** he, him, his\
**email:** [brett.melbourne\@colorado.edu](mailto:brett.melbourne@colorado.edu)\
**Office:** Ramaley N336 but mostly Zoom\
**Office hours:** Any time by appointment\
**Contacting me:** For content or coding questions try [Piazza](https://piazza.com/colorado/fall2024/ebio5460002/home) first, otherwise email me\
**Class meeting times:** Tuesday & Thursday 3:30-4:45 PM\
**Location:** Ramaley N183\
**Zoom details:**

-   Meeting ID: 914 8550 8155 (log in with CU account)



#### Course description

What is data science? The National Science Foundation defines data science as

> ... the science of planning for, acquisition, management, analysis of, and inference from data.

It further notes that

> Data science is inherently interdisciplinary. Working with data requires the mastery of a variety of skills and concepts, including many traditionally associated with the fields of statistics, computer science, and mathematics.

This is the philosophy of the course, applying an interdisciplinary approach to learning from data in biological research. We will take at least part of the working definition of data science to be a focus on algorithms and workflows to learn from data.


#### Topics

Skills:
- Version control using Git
- Project management and collaboration using GitHub
- Structured programming and debugging in R
- Manipulating data with tidyverse tools
- Visualization with ggplot
- Reproducible workflows
- Producing reports using markdown and knitr

Concepts, models, algorithms, computation:
- Frequentist, likelihood, Bayesian, information theoretic, predictionist
- Multilevel linear models, esp. generalized linear mixed models (GLMMs)
- Fitting mechanistic ecological models
- Stochastic simulation
- Bootstrap and other randomization approaches
- Cross validation
- Visualization theory
- Experimental and study design
- Introduction to machine learning


#### Where is it pitched?

This is a practical class. We are scientists of both biology and data. We need to learn from our data, so we need to use data science tools. Our aim is to understand the concepts, theory, and algorithms behind the main categories of data science tools and in particular be able to place an algorithm within a wider context, to understand connections among them, and to identify strengths and weaknesses in application. For example, how is a bootstrap related to a Bayesian posterior? How is k-fold cross validation related to AIC? How should I approach figuring out what mechanisms drive a species' response to climate change versus predicting how it will respond in 10 years? For that conceptual understanding and mastery we need some data science theory. I will develop an intuitive understanding of the foundational algorithms and concepts mostly through stochastic simulation and coding plus a bit of basic math. You will code and apply these algorithms to your own datasets. From this foundation you should be able to go deeper through self study.

#### Prerequisites

This is not a rank beginners class! You should have taken at least an introductory-level statistical modeling class covering linear models, preferably up to the level of Generalized Linear Models (GLM, e.g. logistic regression). An example of such a class is EBIO 4410/5410 "Biological Statistics". You needn't have R or coding experience, although it will be advantageous. If you're unsure if this class is for you, reach out to me.

#### The ultimate learning goal

You will be confident to use the skills and concepts above to plan for, acquire, manage, analyze, infer or predict from, and report about datasets of any size in your area of biological research.

#### Learning format

I'm envisioning a collaborative learning atmosphere. By this I don't mean only learning among yourselves from "knowledge" passed down from me to you. While data science and scientists doing data science have been around for decades before it came to be called "data science" it is also rapidly developing. We will explore some of these cutting-edge areas. The class is a hybrid of flipped and in-class lectures. I'll assign reading and video lectures or tutorials, some that I will produce, and some from others. In class we will largely focus on doing data science with real data. There will be few worksheets or rote labs. We will apply algorithms to our own data, including an individual project. We'll often create simulated data too.

Hands on coding will often be done in small groups: collaboration is encouraged both in and out of class. I expect each person has different experience in different areas. I hope that we can create an environment that is relaxed and nonjudgmental so that we will all feel comfortable participating and also that all contributions are valued. I also hope that we can create an environment of respect for each other's learning processes and ideas.

We'll be using Piazza for class  discussion. The system is highly catered to getting you help fast and  efficiently from classmates and myself. Rather than emailing  me questions, I encourage you to post your questions on Piazza and to answer other student's questions. Find our class page at: https://piazza.com/colorado/fall2024/ebio5460002/home.

#### Computing

You'll need access to computing. If you have a reasonably modern laptop, that's perfect. If you don't have access to computing please let me know as soon as possible. I can provide access to some great alternative compute resources.

#### R computing environment

Please upgrade to the latest versions of R and R Studio.

#### Texts

This class is a mash up and I will sample from several texts. You don't need to purchase any of these texts. Most of it is available free to you but not all of the textbook material can be posted publicly. Relevant sections will be posted to the class Google Drive folder.

The texts I will draw most heavily from and will be most useful are:

1)  McElreath, R (2020). *Statistical Rethinking: A Bayesian Course with Examples in R and Stan 2nd Ed.* CRC. Unfortunately it is not an open source text but the [book website](https://xcelab.net/rm/statistical-rethinking/) has links to video and R code that we'll make good use of. If you decide to purchase only one text, get this one. **No ebook version.**

2)  Gelman A & Hill J (2007) *Data Analysis Using Regression and Multilevel/Hierarchical Models.* Cambridge. Most of the examples are not from the natural sciences but it is excellent. We will use some of the chapters. Unfortunately this text is not open source but has a [website](http://www.stat.columbia.edu/~gelman/arm/) with data and R code. There is also an update to parts of this text just out: Gelman A, Hill J, Vehtari A (2021) *Regression and other stories.* Cambridge. We might use parts of this new version.

3)  James G, Witten D, Hastie T, Tibshirani R (2021). *An Introduction to Statistical Learning: With Applications in R, Second edition.* Springer, New York. You can download the pdf from the [book website](https://www.statlearning.com/) or through the library (see below). 

4)  Grolemund G & Wickham H (2017). *R for Data Science.* O'Reilly. This book is open source and can be accessed [here](http://r4ds.had.co.nz/).

5)  Wickham H (2016). *ggplot2: Elegant Graphics for Data Analysis, 2nd Ed.* Springer. Available online through the library (see below).

A text heavily influencing this course is Efron B & Hastie T (2016) *Computer Age Statistical Inference: Algorithms, Evidence, and Data Science.* Cambridge. This text is aimed at masters or first-year PhD students in statistics and data science. After completing this course, you might find this a useful book with a friendly level of math.

To find Springer texts through the CU library, do a Chinook search (you must be on the campus network or via VPN, not the guest wifi), follow the link to the ebook version (where you can download the full color pdf). You'll notice that there is also a Springer offer available through the library to buy a paperback version for $25. Beware: the special offer printed version is not in color (which is an issue for graphing data!).

#### Grading

Github portfolio of code commits, reading summaries, participation **50%** Individual assignment **50%**

#### Assignments

The individual assignment will be to use a multi-level Bayesian approach to analyze a dataset that you provide. It can be from your research, or from your lab, or from the literature (e.g. a reanalysis where the original study used older methods).

#### Exams

There will not be an exam. This material is not suited to exams.

#### GitHub

Almost everything will be on Github rather than Canvas. I have set up a GitHub organization that is restricted to our class (i.e. not public). Bookmark this URL: https://github.com/EBIO5460Fall2024.

All of your work will be submitted here (via a Git commit and push).

#### Your fieldwork

I realize that as graduate students you may have fieldwork or other research to complete during the semester. Please see me early on so we can talk about how we can work around your fieldwork.

#### My commitments

I possibly will need to travel for short periods for talks or fieldwork. If that happens I will endeavor to give the class via Zoom at the usual time. If I'm sometimes unable to attend the scheduled class time I will provide materials for these classes and you should show up and participate as usual.

#### Classroom behavior

Students and faculty are responsible for maintaining an appropriate learning environment in all instructional settings, whether in person, remote, or online. Failure to adhere to such behavioral standards may be subject to discipline. Professional courtesy and sensitivity are especially important with respect to individuals and topics dealing with race, color, national origin, sex, pregnancy, age, disability, creed, religion, sexual orientation, gender identity, gender expression, veteran status, marital status, political affiliation, or political philosophy. For more information, see the [classroom behavior policy](https://www.colorado.edu/policies/student-classroom-and-course-related-behavior), the [Student Code of Conduct](https://www.colorado.edu/sccr/media/230), and the [Office of Institutional Equity and Compliance](https://www.colorado.edu/oiec/).

#### Accommodation for disabilities, temporary medical conditions, and medical isolation

If you qualify for accommodations because of a disability, please submit your accommodation letter from Disability Services to your faculty member in a timely manner so that your needs can be addressed.  Disability Services determines accommodations based on documented disabilities in the academic environment.  Information on requesting accommodations is located on the [Disability Services website](https://www.colorado.edu/disabilityservices/). Contact Disability Services at 303-492-8671 or DSinfo@colorado.edu for further assistance.  If you have a temporary medical condition, see [Temporary Medical Conditions](https://www.colorado.edu/disabilityservices/students/temporary-medical-conditions) on the Disability Services website.

If you have a temporary illness, injury or required medical isolation for which you require adjustment, email me and we will work something out.

#### Preferred student names and pronouns

CU Boulder recognizes that students' legal information doesn't always align with how they identify. Students may update their preferred names and pronouns via the student portal; those preferred names and pronouns are listed on instructors' class rosters. In the absence of such updates, the name that appears on the class roster is the student's legal name. I will gladly honor your request to address you by an alternate name or gender pronoun.

#### Honor code

All students enrolled in a University of Colorado Boulder course are responsible for knowing and adhering to the [Honor Code](https://www.colorado.edu/sccr/media/229). Violations of the Honor Code may include but are not limited to: plagiarism (including use of paper writing services or technology [such as essay bots]), cheating, fabrication, lying, bribery, threat, unauthorized access to academic materials, clicker fraud, submitting the same or similar work in more than one course without permission from all course instructors involved, and aiding academic dishonesty. Understanding the course's syllabus is a vital part in adhering to the Honor Code.

All incidents of academic misconduct will be reported to Student Conduct & Conflict Resolution: StudentConduct@colorado.edu. Students found responsible for violating the Honor Code will be assigned resolution outcomes from the Student Conduct & Conflict Resolution as well as be subject to academic sanctions from the faculty member. Visit [Honor Code](https://www.colorado.edu/sccr/media/229) for more information on the academic integrity policy.


#### Sexual misconduct, discrimination, harassment and/or related retaliation

CU Boulder is committed to fostering an inclusive and welcoming learning, working, and living environment. University policy prohibits [protected-class](https://www.colorado.edu/oiec/policies/discrimination-harassment-policy/protected-class-definitions) discrimination and harassment, sexual misconduct (harassment, exploitation, and assault), intimate partner abuse (dating or domestic violence), stalking, and related retaliation by or against members of our community on- and off-campus. The Office of Institutional Equity and Compliance (OIEC) addresses these concerns, and individuals who have been subjected to misconduct can contact OIEC at 303-492-2127 or email [CUreport@colorado.edu](mailto:CUreport@colorado.edu). Information about university policies, [reporting options](https://www.colorado.edu/oiec/reporting-resolutions/making-report), and [support resources](https://www.colorado.edu/oiec/support-resources) including confidential services can be found on the [OIEC website](http://www.colorado.edu/institutionalequity/).

Please know that faculty and graduate instructors must inform OIEC when they are made aware of incidents related to these policies regardless of when or where something occurred. This is to ensure that individuals impacted receive outreach from OIEC about resolution options and support resources. To learn more about reporting and support for a variety of concerns, visit the[ ](https://www.colorado.edu/dontignoreit/)[Don’t Ignore It](https://www.colorado.edu/dontignoreit/) page.


#### Religious accommodations

Campus policy requires faculty to provide reasonable accommodations for students who, because of religious obligations, have conflicts with scheduled exams, assignments or required attendance. Please communicate the need for a religious accommodation in a timely manner. In this class, in most cases you should have sufficient time to complete the assignments and submit them on time, or early if appropriate. If this does not work for your situation, please notify me at least two weeks in advance of the conflict to request special accommodation. See the [campus policy regarding religious observances](http://www.colorado.edu/policies/observance-religious-holidays-and-absences-classes-andor-exams) for full details.

#### Mental health and wellness

The University of Colorado Boulder is committed to the well-being of all students. If you are struggling with personal stressors, mental health or substance use concerns that are impacting academic or daily life, please contact [Counseling and Psychiatric Services (CAPS)](https://www.colorado.edu/counseling/) located in C4C or call (303) 492-2277, 24/7. Free and unlimited telehealth is also available through [Academic Live Care](https://www.colorado.edu/health/academiclivecare). The [Academic Live Care](https://www.colorado.edu/health/academiclivecare) site also provides information about additional wellness services on campus that are available to students.

