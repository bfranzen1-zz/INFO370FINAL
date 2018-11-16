## Description
The overarching purpose of this research project is to establish if Facebook users have a propensity to be show a greater interest in posts that contain fake news than those that are factually correct, based on the popularity of specific news sources and articles. This is an important undertaking because Facebook, and social media, in general, have a large impact on how people digest information on a daily basis. Additionally, nearly a quarter of the world’s population uses Facebook and understanding who spreads misinformation and how they do it is vital to ensuring the truth comes forward.  

Fake news spreads like a wildfire on social media. These days, news and information that you see on social media is more and more likely to be false. Due to the sheer number of fake news that is seen on social media, it seems like fake news is more popular than truthful news and may even be spread more rapidly. Reports even say that “it took the truth about six times as long as falsehood to reach 1,500 people”, and our assumption is that the reason for this is that people are generally more drawn towards fake news, rather than reliable news.1

What frightens us, and causes us to be determined to research this topic, is that because “well-publicized fake news sites have the potential to distort individual and collective memories in disturbing ways,” they are being used to simply attract as much attention as possible, as quickly as possible, in order to create undesirable outcomes.2 As our collective memories are becoming more and more influenced by social media, the propensity that fake news has to alter our collective memory [see the Mandela Effect](http://theconversation.com/the-mandela-effect-and-how-your-mind-is-playing-tricks-on-you-89544) can potentially shape how people think about think about the future.(nature) An example of this can be seen in 2017, when members of President Donald Trump’s administration alluded to a ‘Bowling Green Massacre’ and terror attacks in Sweden and Atlanta, Georgia, that actually had never even happened. Even though they were quickly corrected, these fictitious terrorist attacks were later cited to justify a *travel ban on the citizens of seven countries “of concern”*.2

Facebook currently is making strides in their attempts to combat fake news in order to remain a reliable source of information. Some of these improvements include improvements in ranking, that analyze whether or not actually reading an article makes people significantly less likely to share it, which would indicate that they were misled in some way. As well as an easier reporting system, that makes it easier to report false news3. While these news systems that are being put in place may help slow the spread of false information, they do not assist in either preventing or erasing it, as even if a post is consistently reported as fake news, then it **only** “might show up lower in your feed”.3 For this reason, we are seeking to answer the question of _whether or not fake news garners more attention than news that is reliable on facebook_, as this would allow us to see whether or not it is more likely to show up on your news feed, be it high or low on the list. 

### Hypothesis
Null hypothesis - Popular news has the same truthfulness as reliable news.
Alternative hypothesis - More reliable news is less popular.
Alternative hypothesis - More popular news is more reliable.

### Chosen Datasets
The main dataset that we’ll be using is titled [“Fact-Checking Facebook Politics Page”](https://www.kaggle.com/mrisdal/fact-checking-facebook-politics-pages) and was retrieved from Kaggle. This dataset contains variables that will allow us to adequately address our hypothesis, including a wide range of articles posted on facebook that are either mainstream, right leaning, or left leaning. It also includes the number of comments, shares, and reactions that the post received which will assist tremendously in answering our question of whether or not reliable news and fake news have the same amount of popularity. We may have to alter, or rather update, the dataset, however, due to there not being a consistency as to **when** the data was collected for each post. This is important to recognize, as the feedback the online posts receive are frequently changing, so there needs to be some sort of consistency as to when these variables are recorded. To remedy this, we will likely use a web scraping method to collect the most recent data.

Another important aspect to note about the data set, is the variable “Truth Rating”, and how it was determined. This data set was curated by BuzzFeed, a well known “news” website. They determined the truth rating for each of the posted articles, and these ratings range from “entirely true” all the way down to “no factual content”. While BuzzFeed is an established source of an information, it is important to note that we are unaware of the processes in which the dataset creators went through in order to arrive at their conclusions in terms of the validity of each of the articles. 

In addition to the dataset from kaggle, we will also be implementing web scraping methods to collect more data that may be pertinent to our analysis. This will likely include scraping websites that act as a hub of verified news installations that contain false information, as well as facebook itself to find even more relevant information.

### Statistical/Machine Learning Methods
For statistical analysis we plan on using Ordinal Logistic Regression because of its ability to model relationships between a set of independent variables and an ordinal dependent variable. Our dependent variable is the “truth” rating of a given article which has been determined by BuzzFeed. We will use exploratory data analysis and either forward or backward selecting to determine our set of independent variables. As for machine learning methods, we plan on using some sort of regression model. This may include K Nearest Neighbors or something that involves the ability to do ordinal regression. We will use cross validation and a grid search to both enhance the accuracy of our model and ensure we are using the best variables. 

### Target Audience
Our main target audiences would be Facebook and other social media users.

What will the Audience learn?
Ideally, our audience will gain some insights into who may be spreading fake news on Facebook. Also,  they may learn how users have reacted or how popular these sources could be. They should be able to answer the question “Is there anyone source I can trust on Facebook?” or “What sources should I avoid?” Most of all our audience should come away with a sense of responsibility, curiosity, and drive to make sure that the information they consume is truthful to the best of their knowledge. 

## Technical 

### Format of final resource?
The format of our final response will likely be a polished html report generated using jupyter notebook. None of the code input will be shown. The report will contain sections like an abstract, methods, algorithms, results, discussion, etc.

### Data challenges?
There is a column in our dataset that has a large number of null values which could present issues for us. Additionally, we have some concerns over how detailed a couple of the columns are. Specifically, the reaction column neglects to mention the type or specific reactions the post received. This could produce inaccuracies in the sense that certain reactions hold more weight or resemble different emotional reactions to content. For example, if a post has 20 likes and 100 angry faces, one could assume that a majority of the reactions are negative. Additionally, the rating column which determines the truthfulness of the post may not be as accurate as we need it to be. This is primarily because the process for how it was fact-checked is only provided by one organization (BuzzFeed) which introduces the possibility of bias. Also, how they went about fact-checking is unclear making it hard to determine how accurate or in-depth their investigation was. 

### New technical skills needed?
We anticipate that most of our research will not require new technical skills but rather we will likely need to learn new models or approaches to predicting and analyzing our data to ensure we produce the most accurate outcomes. 

### Modeling approach for analysis?
It appears that we will be most likely to develop a classification model, with the given dataset. The selection of model is generated due to the nature of the response variable (categorical, separated into different categories that ranges from 1-5). As for the machine learning part, we are most likely to develop a KNN model. We are still in the process of exploring possible models that would fit our data well.

### Major challenges?
One of the challenges that we encountered would be only a few of the attributes in the dataset would make significant contribution to our model. We originally anticipate to answer the question: whether fake news would receive more attention than the true news, we would have to be clear on the definition of “attention”. In our dataset, popularity could be defined or parameterized using the number of likes, comments and shares. Other than that, we are also planning to use sentiment analysis (with combination of package nltk) to see whether there association between emotion of posts and their popularity, or “attention”. Further, we could perform latent dirichlet allocation to choose the top picks of words. However, we understand that the package nltk is not completely natural and there could be bias in the selection. 










#### References
1 Fox, M. (2018, March 8). Want something to go viral? Make it fake news. Retrieved November 14, 2018, from https://www.nbcnews.com/health/health-news/fake-news-lies-spread-faster-social-media-truth-does-n854896

2 Spinney, L. (2017, March 07). How Facebook, fake news and friends are warping your memory. Retrieved November 14, 2018, from https://www.nature.com/news/how-facebook-fake-news-and-friends-are-warping-your-memory-1.21596

3 Mosseri, A. (2017, April 7). Working to Stop Misinformation and False News. Retrieved November 14, 2018, from https://www.facebook.com/facebookmedia/blog/working-to-stop-misinformation-and-false-news  



