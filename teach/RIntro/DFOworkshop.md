---
output: 
  html_document: 
    keep_md: yes
    fig_caption:  yes
    toc: true
    toc_float: true
    
---



# Basic R


```r
soln=FALSE
```

## Data import
Our first job today is to use a package to import the data we will be using throughout the workshop. If you have sucessfully installed the library *readxl*, we can use it to read in the .xlsx file. 



### Where’s my file??

To do the import we need the *path* where the file is located. There are at least three ways to find a file in R:

1. use **file.choose()** to get an interactive menu, 
2. type the actual path to the file (e.g., "/Users/Kim/Documents/mydata.xlsx") if you know it, 
3. use **setwd()** to change the current directory to the location of the file



#### Try it  now: {-} 
Import the data file using the function  **read_excel()** from the *readxl* library, and handle the path location of the file using one of the methods above.


```r
# load the library
library(readxl)

# import the xlsx file
ham <- read_excel("ind dates flat all parameters Hamilton only FOR Kim.xlsx")
```

### Did the import work??

Once you have read in the data, it is critically import to check that the import worked properly. Difficulties that can arise from incorrectly formatted files can then be resolved. Problems can include: numeric data being read in as character data, column names being read in as the the first row of data, missing values being coded as something other than NA.

There are a number of commands to look at the dataset or a portion of it. Here are four quick methods to check data import: 

1. type the name of the variable or use **View()**, 
2. **colnames()**, 
3. **head()** or **tail()**, 
4. **str()**




#### Try it now: {-} 
Use **colnames()** to see the names of the columns in ham, **tail()** to see the last rows of ham, and **str()** to see information about data type etc.


```r
#View(ham)

# Look at the first 5 column names of the dataframe ham
colnames(ham)[1:5]
```

```
## [1] "waterbody"       "area_group"      "Latitude"        "Longtitude"     
## [5] "Station_Acronym"
```

```r
# Looks at the last 5 rows
tail(ham, n=5)
```

```
## # A tibble: 5 × 109
##   waterbody        area_group Latitude Longtitude Station_Acronym report_Stn
##   <chr>            <chr>         <dbl>      <dbl> <chr>           <chr>     
## 1 Hamilton Harbour west           43.3      -79.9 HHCarolsP       CP        
## 2 Hamilton Harbour west           43.3      -79.9 HHRHYC          RHYC      
## 3 Hamilton Harbour west           43.3      -79.9 HHRHYC out      RHYC out  
## 4 Hamilton Harbour wind           43.3      -79.8 HH4_PHYTO       WSTP      
## 5 Hamilton Harbour west           43.3      -79.9 HHBayfront-West BFW       
## # … with 103 more variables: SamplingDate <dttm>, season <dbl>, year <dbl>,
## #   Julian_Day <dbl>, Julian_Week <dbl>, Month <dbl>, Station_depth <dbl>,
## #   `water level` <dbl>, Ammonia_ECCC1m <dbl>, DIC_ECCC1m <dbl>,
## #   DOC_ECCC1m <dbl>, POC_ECCC1m <dbl>, Chl_ECCC1m <dbl>,
## #   `Chl Cor_ECCC1m` <dbl>, NO2_NO3_ECCC1m <dbl>, PON_ECCC1m <dbl>,
## #   `TKN dissolved_ECCC1m` <dbl>, SRP_ECCC1m <dbl>, TP_ECCC1m <dbl>,
## #   `TP dissolved_ECCC1m` <dbl>, Chl_a_uncorrected <dbl>, Secchi <dbl>, …
```

```r
# get a summary regarding the first 5 columns
str(ham, list.len=5)
```

```
## tibble [742 × 109] (S3: tbl_df/tbl/data.frame)
##  $ waterbody                  : chr [1:742] "Hamilton Harbour" "Hamilton Harbour" "Hamilton Harbour" "Hamilton Harbour" ...
##  $ area_group                 : chr [1:742] "deep" "NE" "deep" "west" ...
##  $ Latitude                   : num [1:742] 43.3 43.3 43.3 43.3 43.3 ...
##  $ Longtitude                 : num [1:742] -79.9 -79.8 -79.8 -79.9 -79.9 ...
##  $ Station_Acronym            : chr [1:742] "HH908" "HH6" "HH258" "HHBayfront" ...
##   [list output truncated]
```


## Data in R

### Data types

The **str()** function above gave us information regarding the *type* of data in each column of our imported dataframe. There are 4 main data types we will be using today: numeric, character, factor and logical.

- ***numeric*** data are numbers (e.g., 3, 10.5, 1E8)
- ***character*** data sometimes called "strings" are words or alphanumeric codes, indicated with double quotation marks (e.g. "k", "R is exciting", "FALSE", "11.5")
- ***factor*** data are a special case of character variables, and are used when there are a limited number of unique character strings. This data type is used to represent categorical data (e.g., "male" and "female")
- ***logical*** data are sometimes called "boolean". This is data with only two values: TRUE or FALSE.

Sometimes after data import we will need to convert the data from one type to another. For example, if we wanted to do an analysis that compared data from different stations we would want to convert the column *Station_Acronym* from data type character to data type factor. This is easy to do using the function **as.factor()**, and accessing just that column (see below)


### Data structures

You’ll notice that the data are structured in columns. This is a *dataframe*, one of the most used data structures in R. Data structures are sets of variables organized in a particular way. In R there are 4 primary data structures we will use repeatedly: vectors, matrices, dataframes and lists. 

***Vectors*** are one-dimensional ordered sets composed of a single data type. Data types include integers, real numbers, and strings (character variables). For example, a single column of the imported data is a vector.

***Matrices*** are two-dimensional ordered sets composed of a single data type (e.g., all numeric) equivalent to the concept of matrix in linear algebra. For example, a set of correlation coefficients for different parameters is a matrix.

***Dataframes*** are one to multi-dimensional sets with a row-column structure, and can be composed of different data types (although all data in a single column must be of the same type). In addition, each column in a data frame may be given a label or name to identify it. Dataframes are equivalent to a flat file database, similar to spreadsheets (e.g., like a single excel spreadsheet). For example, our inputted dataset is a dataframe.

***Lists*** are compound objects of associated data. Like dataframes, they need not contain only a single data type, but can include strings (character variables), numeric variables, and even such things as matrices and data frames. In contrast to dataframes, list items do not have a row-column structure, and items need not be the same length; some can be a single value, and others a matrix. You can think of a list as a named box to put related objects into. For example, the R output of a linear regression is a list.


### Selecting portions of a dataframe

To start our examination and analysis of this data, we need to be able to select items of interest. Dataframes are indexed by rows and columns. To grab

- the item from the 5th row and 2nd column: type *mydata[5,2]*
- one column you can type either: *mydata[,2]*, which grabs everything in column 2, or if you know the name of the column you can use that as: *mydata\$Population* or *mydata[,"Population"]*
- to get rows 2 to 5 you can enter: *mydata[2:5,2]*. You can also combine this with the column name which may be easier to read, as *mydata$Population[2:5]*.

#### Try it now: {-}
Select just the first 5 rows and first 3 columns of the dataframe you read into R.


```r
# access a subsection of a dataframe (first 5 rows, and first 3 columns)
ham[1:5,1:3]
```

```
## # A tibble: 5 × 3
##   waterbody        area_group Latitude
##   <chr>            <chr>         <dbl>
## 1 Hamilton Harbour deep           43.3
## 2 Hamilton Harbour NE             43.3
## 3 Hamilton Harbour deep           43.3
## 4 Hamilton Harbour west           43.3
## 5 Hamilton Harbour deep           43.3
```

#### Try it now: {-}
Access the Station_Acronym column of the data. Remember, we can also just grab a single column, using the column name to identify it as *mydata$thiscolumn* or *mydata[,"thiscolumn"]*.

Next use the as.factor() function to convert this data to factor instead of character. We'll also use the **levels()** function to see how that worked


```r
#select by column and print the first 6 rows
head(ham$Station_Acronym)
```

```
## [1] "HH908"      "HH6"        "HH258"      "HHBayfront" "HH908"     
## [6] "HH9031"
```

```r
#create a new variable that saves same data converted to factor

fac_Station_Acronym=as.factor(ham$Station_Acronym)

# see the levels of the new factor variable
levels(fac_Station_Acronym)
```

```
##  [1] "CCIW dock"       "HH17"            "HH1B"            "HH2"            
##  [5] "HH2000"          "HH2001"          "HH2002"          "HH2003"         
##  [9] "HH2004"          "HH258"           "HH2B"            "HH39"           
## [13] "HH4_PHYTO"       "HH6"             "HH8"             "HH9031"         
## [17] "HH9033"          "HH908"           "HH917"           "HHBayfront"     
## [21] "HHBayfront-West" "HHBFouter"       "HHBURSTP"        "HHCarolsP"      
## [25] "HHRHYC"          "HHRHYC out"      "HHWC"
```


We can also create new data subsets by using the **c()** or **c**ombine function. 

#### Try it now: {-}
Let's access the first 5 rows, the first 3 columns and columns 9-10, and save the result to a new variable ' ham_sub'


```r
# save a subsection of a dataframe
ham_sub=ham[1:5,c(1:3, 9:10)]
ham_sub
```

```
## # A tibble: 5 × 5
##   waterbody        area_group Latitude  year Julian_Day
##   <chr>            <chr>         <dbl> <dbl>      <dbl>
## 1 Hamilton Harbour deep           43.3  2016        131
## 2 Hamilton Harbour NE             43.3  2021        174
## 3 Hamilton Harbour deep           43.3  2021        174
## 4 Hamilton Harbour west           43.3  2022        174
## 5 Hamilton Harbour deep           43.3  2022        174
```

#### Try it now: {-}
Our subsetted data is not ordered by year or group, so let's use the **order()** function to rearrange


```r
# save a subsection of a dataframe
ham_sub=ham_sub[order(ham_sub$area_group,ham_sub$year),]
ham_sub
```

```
## # A tibble: 5 × 5
##   waterbody        area_group Latitude  year Julian_Day
##   <chr>            <chr>         <dbl> <dbl>      <dbl>
## 1 Hamilton Harbour deep           43.3  2016        131
## 2 Hamilton Harbour deep           43.3  2021        174
## 3 Hamilton Harbour deep           43.3  2022        174
## 4 Hamilton Harbour NE             43.3  2021        174
## 5 Hamilton Harbour west           43.3  2022        174
```




### Using conditional statements to access data
We can also use conditional statements to access portions of the data. Conditional statements evaluate to TRUE or FALSE. The "==" symbol is used to determine if a variable is equal to some value, while "!=" evaluates is something is not equal. As you might expect we can also use greater than (">") or less than ("<") conditionals.



#### Try it now: {-}
First check out how the conditional statement produces a logic vector of TRUE and FALSE by entering *ham\$Station_Acronym=="HH6"*. 

Then we can use this logical vector to subset the calanoid vector to choose only rows where the Station_Acronym is "HH6" (i.e., only the TRUE items will be included)

Enter *ham\$calanoid[ham\$Station_Acronym=="HH6"]* and examine the data.


```r
# create a logical vector using a conditional, and look at the first 6 items
head(ham$Station_Acronym=="HH6")
```

```
## [1] FALSE  TRUE FALSE FALSE FALSE FALSE
```

```r
# by condition... using head() to show the first 6 items
head(ham$calanoid[ham$Station_Acronym=="HH6"])
```

```
## [1] 84.094200542 13.196863744 64.145098250 58.389201770 25.256348256
## [6]  0.006374018
```

Of course, this gives us all of the sampling dates for this station. Let's assume we only want data from 2016. In that case we can combine our conditional statements using "&" for AND and "|" for OR. 

#### Try it now: {-}

Use an "&" symbol to indicate that we want the selected data to be from station "HH6" and to be from the 2016. 


```r
ham$calanoid[ham$Station_Acronym=="HH6" & ham$year==2016]
```

```
##  [1]  64.145098  25.256348  70.721192 142.447448  89.268307  70.066000
##  [7]  32.332505  78.560037   7.974158 120.229185  91.171246  19.286071
## [13] 104.393878
```





Table: Calanoid data for 2016 at station HH6

|   calanoid| julian|
|----------:|------:|
|  64.145098|    145|
|  25.256348|    131|
|  70.721192|    160|
| 142.447448|    188|
|  89.268306|    201|
|  70.066000|    215|
|  32.332505|    174|
|  78.560037|    258|
|   7.974158|    228|
| 120.229185|    242|
|  91.171246|    270|
|  19.286071|    286|
| 104.393878|    299|

#### Try it now: {-}
Now, can you do this on your own? Access the calanoid data at station "HH6" for 2014


```
##  [1]  3.7525745  4.4195122  4.4719882 49.3636318  7.1764905  0.8381301
##  [7]  3.7054878  6.7292412  4.0907797  5.7956002  1.0151220  5.4204413
```





## Functions in R

Next, let's figure out how to complete some simple calculations with these values, like finding the mean and standard deviation. 

We have already used some functions in R. R contains thousands of functions, and more are being added everyday. 



If you are trying to find a function that does something you need to do, you can search the help mean either by using ??”keyword phrase” to get R to search function descriptions, our just by using the find function in the help menu.

#### Try it now:{-}
Got to the help menu and search for "mean". Read through some of the  information. How do we use this function?

You should see that the function **mean()** works on a vector of numeric data.

#### Try it now: {-}
Use these tools to find a function that calculates standard deviation. 

If the internal help menu lets you down you can also try a search at http://www.rseek.org/

#### Try it now: {-}
Once you have found the function name, use it and the **mean()** to get the mean and standard deviation of calanoid density at station HH6 in 2014.


```
## [1] 8.064917
```

```
## [1] 13.14886
```

### Summarizing data 

Other functions can help with quick data summaries. for example, the **table()** function can be used to take a quick look at the number of samples for each station. 

#### Try it now: {-}
Use this function on the Station_Acronym column of the data


```r
table(ham$Station_Acronym)
```

I've formatted the output, but you should see something roughly like this:



|Station Name    | No. of samples|
|:---------------|--------------:|
|CCIW dock       |              3|
|HH17            |             13|
|HH1B            |             22|
|HH2             |              1|
|HH2000          |              1|
|HH2001          |              1|
|HH2002          |              1|
|HH2003          |              1|
|HH2004          |              1|
|HH258           |            172|
|HH2B            |             21|
|HH39            |              1|
|HH4_PHYTO       |             22|
|HH6             |            136|
|HH8             |             38|
|HH9031          |             22|
|HH9033          |             22|
|HH908           |             96|
|HH917           |             22|
|HHBayfront      |             22|
|HHBayfront-West |             22|
|HHBFouter       |              3|
|HHBURSTP        |             22|
|HHCarolsP       |             22|
|HHRHYC          |             21|
|HHRHYC out      |             21|
|HHWC            |             13|

The **summary()** function can also give information about a vector. 

#### Try it now: {-}
Use the summary function on the "Chl_a_uncorrected" data for site HH258


```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   3.060   9.508  12.600  15.004  19.253  70.020      25
```


## Plotting data

A quick check of data can also be done with simple plots. for example, let's see what the Chl_a_uncorrected data by julian day looks like using the **plot()** function. 


```r
plot(y=ham$Chl_a_uncorrected,x=ham$Julian_Day)
```

![](DFOworkshop_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

#### Try it now: {-}
Create this plot

Of course, this is the data from every station. Let's just plot data from station HH258, and colour code by sampling year


```r
#create a data subset
sub2_ham=ham[ham$Station_Acronym=="HH258",]

# plot the data using the formula notation
plot(sub2_ham$Chl_a_uncorrected~sub2_ham$Julian_Day, col=sub2_ham$year)
```

![](DFOworkshop_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

#### Try it now: {-}
Create this plot

Kind of hard to read... I think I want to group the data by decade, and let's pimp the plot a little.  We also need axis labels, a nicer symbol and a legend. 

Wow! That's a lot of things to do. Time to start saving our code using the Editor (or Source) window.


## The Editor(Source) window

Previously you could have completed all of these commands in the Console window where R would execute them immediately. Now we're going to have a bunch of commands, some of which we may want to tweek (e.g., colours). This time, let's save our code in the Editor or Source window so that it is easy to change and rerun.

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/rstudio-panes-labeled.jpeg)

We'll create a new file using the drop down menus. Click *File* then *New File*, and then *R Script*. A blank document will appear in the Editor window is found in the top left of the default R Studio. 

#### Try it now: {-}
Create a new file, copy the following code, paste it into the new file and then save it using the drop down menu or cntrl-s or command-s. Now, this code is available to run now or in the future! 

Run the code by selecting it and hitting *Run* in the menu or command-enter (Mac) or cntrl-R (Windows)


```r
# create a new "decade" factor variable
sub2_ham$decade <- cut(sub2_ham$year, breaks=c(2000,2010,2020,2030), labels=c(2000, 2010, 2020))

# plot the data using the formula notation and data= option
# plot the data with colour by decade and indicate symbol type
# set the axis labels and text size
# create plot with only two axis lines "l" option, and vertical tick labels
plot(Chl_a_uncorrected~Julian_Day, data=sub2_ham,
     col=sub2_ham$decade, pch=16, 
     xlab="Chla", ylab="Julian Day", cex.lab=1.6,
     bty="l", las=1)

# add an informative legend
legend("topright", legend=levels(sub2_ham$decade), pch=16, col=1:3, bty="n")
```

![](DFOworkshop_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

Notice that I've created and used a *factor* variable by using the **cut()** function. I'll use this to control the colour of the data from each decade.

I'm also using some of the formatting possibilities in the **plot()** function. There's LOTS of options: take a look at *?plot.default* and *?par* to get some ideas. For example, symbol shape is controlled by the *pch* option in the plot command.

Let's try one more. Let's quickly visualize the number of calanoid samples from each area_group by date. Again we will use a factor variable to control appearance.


```r
# change area_group to factor
ham$area_group=as.factor(ham$area_group)

#plot calanoid data by date
plot(calanoid~SamplingDate, data=ham, col=area_group)
legend("topleft", legend=levels(ham$area_group), bty="n",
       pch=1,col=c(1:length(levels(ham$area_group))))
```

![](DFOworkshop_files/figure-html/unnamed-chunk-26-1.png)<!-- -->

#### Try it now: {-}
Create this plot

This is too cluttered, so I am going to summarize the data by year and area, and then plot that. I'm going to plot the data from each area individually starting with the first one, and then adding subsequent areas to the same plot using the **lines()** function.

Copy the code below to your editor window, and run it.



```r
# summarize data by year
samps=as.data.frame(table(ham[,c("year","area_group")]))
samps$year=as.numeric(as.character(samps$year))

# plot the "deep" data only
# set axis limits
# plot both lines and points in black
# add a plot title
plot(Freq~year,data=samps[samps$area_group=="deep",], bty="L",
     xlim=c(min(samps$year), max(samps$year)),
     ylim=c(min(samps$Freq), max(samps$Freq)),
     col="black", type="b", 
     main="Calanoid samples per year by area group")

# add each of the other area groups
lines(Freq~year,data=samps[samps$area_group=="NE",],
      col="red", type="b")
lines(Freq~year,data=samps[samps$area_group=="west",],
      col="blue", type="b")
lines(Freq~year,data=samps[samps$area_group=="wind",],
      col="green", type="b")

legend("topleft", legend=levels(ham$area_group), lty=1,bty="n",
       pch=1,col=c("black", "red", "blue", "green"))
```

![](DFOworkshop_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

#### Try it now: {-}
Can you modify you code so that the colours used are different? Here's a list of colours in R [https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/](https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/)


## Other ways of plotting

At this point, the plotting is getting a bit  more complex, so you may want to use another library called *ggplot2* to do some of your plotting. 

We won't use this today, since this library of functions has a non-intuitive command structure, but is quick for plotting multiple sets of data on the same plot with a legend.

In addition there are other plotting packages available such as *lattice* and *plotly*.


```r
# similar plot using ggplot
library(ggplot2)
ggplot(samps, aes(x = year, y = Freq, 
    group = area_group, colour = area_group)) + geom_line()
```

![](DFOworkshop_files/figure-html/unnamed-chunk-28-1.png)<!-- -->


## T-test and boxplot

Finally, let's create a box plot.


```r
year_sub=ham[(ham$year==2019),]


boxplot(calanoid~area_group, data=year_sub)
```

![](DFOworkshop_files/figure-html/unnamed-chunk-29-1.png)<!-- -->


Also note, that we can easily complete statistical tests other than regression in R. For example, here's a t-test comparing calanoid data at "deep" and "NE" sites.


```r
t.test(calanoid~area_group, 
   data=year_sub[(year_sub$area_group=="deep"| year_sub$area_group=="NE"),])
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  calanoid by area_group
## t = -1.5146, df = 15.19, p-value = 0.1504
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -19.198594   3.237734
## sample estimates:
## mean in group deep   mean in group NE 
##            8.47007           16.45050
```

Fanastic! You now have the basics of importing, manipulating, and plotting in R.
