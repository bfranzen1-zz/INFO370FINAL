#info 370 final project
library(readr)
library(dplyr)
library(ggplot2)
library(MASS)

setwd("~/Desktop/INFO370FINAL")
#original_df<- read_csv("~/Desktop/info_370_final/facebook-fact-check.csv")
#View(original_df)

#df_update<-read_csv("~/Desktop/INFO370FINAL/facebook_with_reactions.csv")
df_update<-read_csv("./facebook_with_reactions.csv")

df<-df_update %>% select(Category,Page,`Date Published`,`Post Type`,Rating,
                         share_count,reaction_count,comment_count,
                         status_message,link_name,status_type,status_published,
                         num_reactions,num_comments,num_shares,num_loves,
                         num_likes,num_wows,num_hahas,num_sads,num_angrys)

#how do we deal with NA values? found in many cells, can't just omit them
#checking: sum(is.na(df_numeric$share_count))

#select only the numerical cols for now
df_numeric<-df %>% select(share_count,reaction_count,comment_count,
                          num_reactions,num_comments,num_shares,num_loves,
                          num_likes,num_wows,num_hahas,num_sads,num_angrys)

reaction_numeric<-matrix(0,nrow=nrow(df))
for(i in 1:nrow(df)){
  if(df$Rating[i]=="no factual content"){
    reaction_numeric[i]=1
  }
  if(df$Rating[i]=="mostly false"){
    reaction_numeric[i]=0
  }
  if(df$Rating[i]=="mixture of true and false"){
    reaction_numeric[i]=2
  }
  if(df$Rating[i]=="mostly true"){
    reaction_numeric[i]=3
  }
}

df_numeric=cbind(df_numeric,reaction_numeric)
df_numeric=na.omit(df_numeric)
############################done with df

df_numeric %>% group_by(reaction_numeric) %>% summarize(n())
df %>% group_by(`Post Type`) %>% summarize(n())
df %>% group_by(`Post Type`) %>% summarize(n())

p<-ggplot(df_numeric, aes(x=factor(reaction_numeric)))+
  labs(x="Reaction",y="Counts")+
  geom_bar(stat="count", width=0.7, fill="steelblue")+
  theme_minimal() #barplot of reaction

p<-ggplot(df_update, aes(x=factor(Page)))+
  theme(text=element_text(size=0.1))+
  labs(x="Page",y="Counts")+
  geom_bar(stat="count", width=0.7, fill="steelblue")+
  theme_minimal() #barplot of page

p<-ggplot(df_update, aes(x=factor(status_type)))+
  theme(text=element_text(size=0.1))+
  labs(x="Page",y="Counts")+
  geom_bar(stat="count", width=0.7, fill="steelblue")+
  theme_minimal() #barplot of status type

#histogram
library(gridExtra)
p1<-ggplot(data=df,aes(df$num_shares)) + geom_histogram(fill="steelblue")
p2<-ggplot(data=df,aes(df$num_angrys)) + geom_histogram(fill="steelblue")
p3<-ggplot(data=df,aes(df$num_likes)) + geom_histogram(fill="steelblue")
p4<-ggplot(data=df,aes(df$num_comments)) + geom_histogram(fill="steelblue")
grid.arrange(p1,p2,p3,p4,nrow=2)

#correlation graph
library(ggcorrplot)
cormat<-round(cor(df_numeric),2)
ggcorrplot(cormat)

########experiment with ols

df_numeric$reaction_numeric=as.factor(df_numeric$reaction_numeric)

null=polr(reaction_numeric~1,data=df_numeric)
full=polr(reaction_numeric~., data=df_numeric)

#could use backward/forward
step(full, data=df_numeric, direction="backward")

#best model based on AIC =3280
best_model=polr(formula = reaction_numeric ~ share_count + num_reactions + 
       num_comments + num_shares + num_loves + num_likes, data = df_numeric)
library(glm.predict)

#get predictions
polr.predict(best_model)
y_pred=predict(best_model,data=df_numeric)

accur=0
for(i in 1:length(y_pred)){
  if(df_numeric$reaction_numeric[i]==y_pred[i]){
    accur=accur+1
  }
}
accur/length(y_pred) #0.75


