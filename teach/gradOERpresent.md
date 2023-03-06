
---
title: OER authorship as a project-based graduate course
author:
  - Kim Cuddington\inst{1}
  - Debora Andrade-Pereira\inst{1}
  - Eddie Wu\inst{1}
  - Zitao He\inst{2}
institute:
  - \inst{1}Department of Biology, University of Waterloo
  - \inst{2}Department of Applied Math, University of Waterloo
date: 08/03/23 
output: 
  beamer_presentation:
    theme: Singapore
header-includes:
 - \definecolor{darkred}{rgb}{0,0.8,0}
---

###
**Intro**

1. brief review course-based research/projects for undergraduate and graduate classes
  
**Project description**

2. OER creation as a course-based project

3. Our project: OER creation in a biology grad course
  
**What we learned**

4. Lessons so far

**Inspiration** 

Trust, T., Maloy, R. W., & Edwards, S. (2022). College student engagement in OER design projects _Active Learning in Higher Education_

# Course-based research 

### Course-based research: undergraduate
- **main feature: whole classes of students address a research question of interest to scientists/community members (Auchincloss et al. 2014).**
- allow scaling of mentor-based research experiences to large program enrollments (e.g., biology) 
- greater engagement of students through real-world meaningful outcomes (see Dolan 2016). 
-   students' work is iterative: fail, trouble-shoot/problem-solve, and repeat 
-   will require a range of related skills (e.g., collecting data, defending arguments, and collaboration)
- examples 

https://taylorinstitute.ucalgary.ca/sites/default/files/Resources/Course-Design/CURE-Examples-2019.pdf

https://serc.carleton.edu/curenet/collection.html


### Course-based research or projects: graduate
- not much documentation at the graduate level, more examples of OER course projects
- e.g.

Jacobsen, M., McDermott, M., Brown, B., Eaton, S. E., & Simmons, M. (2018). Graduate students' research-based learning experiences in an online Master of Education program

Zapata, G. C. (2020). Sprinting to the finish line: The benefits and challenges of book sprints in OER faculty-graduate student collaborations.

### How does a project-based course differ from a typical graduate course in biology
- typically two types of courses: 
	- reading or literature review (reception/analysis of content)
	- techniques (e.g., stats) (application of skills)

- project-based course will require both these elements, and in addition:
	- **selection of content**
	- other skills not specific to the course (e.g., use of public repository)

# BIOL 652 OER project

###  Using OER creation as a course-project
- Shifting students’ roles from consumers to curators and creators of OERs (Trust et al. 2022)
	- increased motivation, 
	- improved attitudes about learning, 
	- aided the achievement of course learning objectives, and 
	- supported the development of other valuable skills

###  Ebook OER creation 
- survey of 5 courses (55 students) in Trust et al. (2022)
	- a majority of students (76%) reported a positive impact of OER design project on attitude and motivation
	- none reported a negative impact
	- across design projects, largest reported for ebook (100% of students)

### BIOL 652 project: Create an OER resource on structured population modelling
- the first author (instructor) proposed a course project of creating an OER resource 
	- could benefit other biology graduate students and early career professionals anywhere on the globe,
	- would be a permanent record of scholarship, 
	- might provide incentive for students to more thoroughly engage with the material.


### BIOL 652 Course design

**Relevance**
- professional development: students are producing public educational products that can be used by others, rather than simply receiving information


**Iteration**
- opportunity for formative comments from instructor and peers: 
 
present outline $\to$ incorporate input in draft of online text $\to$ final round of revision 

**Ownership**
- project lead on each section: provides outline, divides material among other students, and gives feedback 

**Exemplar**
- the instructor completed assignments at the same time as the students: examples of coding and pedagogical techniques

### Specific output

- an online e-text (see draft at https://www.ecotheory.ca/teach/BIOL652.html)

![](OERfrontpage.png)


### Specific output
- embedded R code and examples
![](duckweed_code.png)

### Connecting Theory, Research, and Application
  
![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/steps.jpg){width=80%}

\note{

In our educational material, we are developing sections dedicated to illustrating how a recent publication has applied population ecology theory to tackle ecological problems such as biological invasions or extinction riskgot 

  

These sections are composed by a short description of the publication, an illustration of the concerned organism, codes using published population data and equations to create models, and plots providing model projections for that given population

}

### Applying Theory to Understand Big Problems

  * The case of invasive hippos in Colombia

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/example1.jpg)

\note{

One of our examples describes how an exponential growth of invasive hippo populations in South America is threatening aquatic systems due to the overload of organic matter they bring. 

}

### Improving Learning Through Case Studies

* The case of invasive lionfish in Mexico

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/example2.jpg){ width=90%}



\note{Everything you want


Another example focused on invasive lion fish, which threatens the biodiversity of invaded areas, shows that the number of lion fish living at the same time controls the population sizes for this species, which has implications for management actions

  

Reading recent publications and developing a section in our educational material where we summarize methods and main findings can help improve our learning in the following ways:

  

- Better understand concepts and equations by applying models to real-world data

- Recognize the importance of ecological theory to understand and manage current problems (extinction risk, biological invasions, etc.)

- Become familiar with relevant literature

}
# Lessons

### Perceived difficulties: Jan 2023 - Now
- Overwhelmed by multiple skills/requirements
	- the course topic, population modelling, requires programming, mathematical and statistical skills in addition to conceptual and quantitative content
	- combining all this with an additional task of formatting materials for OER presentation
- completing assignments which involve teaching others requires reading and summarizing far more literature than an ordinary course with curated materials.


### Perceived benefits: Jan 2023 - Now
-  the curation of the OER materials using versioning on github,  and markdown format for open access, is an important additional training component 
	-  directly relates to needed skills in open science and file versioning

-  the development of additional teaching skills, such as the need to identify with learners that are less familiar with the topics in order to simplify and organize the materials
-  permanent record!

### Coding skills developed from the OER experience

#### Graphic skills

* Graphs and figures are provided in many section for demonstrating some important concepts.

* The process of re-creating the graphs through code deepens the understanding of the material.

* Better formatting and visualization for the audience.

![](Rplot01.jpeg){width=43%} ![](arrow.png){width=10% align="center"} ![](Rplot02.jpeg){width=43%}

### Coding skills developed from the OER experience

#### Skills in markdown, Rmarkdown, latex and github 

* Compile the .md file into different formats for demonstration and presentation.

* Different sections of each module are usually divided among the authors. 
* Version control is necessary and important.

* Bibliography and citation using RMarkdown and BibTex file.

# Summary
- benefits:
	- developing professional skills related to teaching, literature review, and open science practices, beyond the stated learning objective of developing mastery in population modelling
	- permanent public resource
- difficulties: 
	- workload cost associated with these benefits


### Would I do this again? Instructor

#### Yes! But....
- I would include a smaller section of material

- I would scaffold by:
	1. providing an example set of OER materials that are appropriate for course(for example, relevant intro material) $\to$ learn material, critique design
	1. second set of partially completed materials that students populate $\to$ learn material, practice coding, writing materials and design
	3. have the students complete the final portion of the material with no template

### Would I do this again? Students


### Literature cited


Jacobsen, M., McDermott, M., Brown, B., Eaton, S. E., & Simmons, M. (2018). Graduate students' research-based learning experiences in an online Master of Education program. _Journal of University Teaching & Learning Practice_, _15_(4), 4. [https://ro.uow.edu.au/jutlp/vol15/iss4/4/](https://ro.uow.edu.au/jutlp/vol15/iss4/4/)

Trust, T., Maloy, R. W., & Edwards, S. (2022). College student engagement in OER design projects: Impacts on attitudes, motivation, and learning. _Active Learning in Higher Education_, 14697874221081454. 
[https://doi.org/10.1177/14697874221081454](https://doi.org/10.1177/14697874221081454)

Zapata, G. C. (2020). Sprinting to the finish line: The benefits and challenges of book sprints in OER faculty-graduate student collaborations. _International Review of Research in Open and Distributed Learning_, _21_(2), 1-17. [https://doi.org/10.19173/irrodl.v21i2.4607](https://doi.org/10.19173/irrodl.v21i2.4607)



