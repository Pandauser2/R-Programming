 con <- url("http://biostat.jhsph.edu/~jleek/contact.html")

htmlCode <- readLines(con)
close(con)
# reading lines 
> htmlCode[1]
[1] "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
> htmlCode[10]
[1] "<meta name=\"Distribution\" content=\"Global\" />"
> nchar(htmlCode[c(10,40)])
[1] 45  2
> nchar(htmlCode[c(10,20,30,100)])
[1] 45 31  7 25

# parsing with XML
> library(XML)

#Parsing the content as text
> library(httr)
> html2 <- GET("http://biostat.jhsph.edu/~jleek/contact.html")
> cont <- content(html2, as="text")
> parsedHtml <- htmlParse(cont, asText=TRUE)
