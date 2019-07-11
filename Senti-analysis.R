require(stringr)
require(tm)
require(SnowballC)
require(twitteR)
require(syuzhet)
consumer_key <- '.....'
consumer_secret <- '.....'
access_token <- '.....'
access_secret <- '......'
setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)
tweets<-userTimeline("realDonaldTrump", n=20)
tweets
n.tweets <- length(tweets)
tweets.df <- twListToDF(tweets)
head(tweets.df)
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("http.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
head(tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)
head(tweets.df2)
word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df)
head(emotion.df2)
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.negative <- word.df[sent.value <= min(sent.value)]
most.positive
most.negative
sent.value
positive.tweets <- word.df[sent.value > 0]
negative.tweets <- word.df[sent.value < 0]
head(positive.tweets)
head(negative.tweets)
neutral.tweets <- word.df[sent.value == 0]
head(neutral.tweets)
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)
category_senti2 <- cbind(tweets,category_senti)
head(category_senti2)
table(category_senti)
category_senti
