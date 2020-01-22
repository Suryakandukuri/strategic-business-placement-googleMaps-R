setwd("E:/WorkspaceTheory/CBA_5/Term-1/Data_Collection/Assignment/Assignment-DC-5-Group_Google_maps")



library("RCurl")
library("jsonlite")
library("plotGoogleMaps")#||install.packages("plotGoogleMaps"); library(plotGoogleMaps)  
library("geosphere")#||install.packages("geosphere"); library(geosphere) 

#key = "AIzaSyBAqhOKSQtlgOzG_Oci06RZsavFc7wD_AY"
#key = "AIzaSyCVTYyiw6R4CbrKDeyMXrmu7mNirY8ncjU"
key = "AIzaSyDwK_wvnhWpG-bCCP2Mc_HE9hawnw9ucSQ"

# # malls search
# url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=malls+in+hyderabad&types=shopping_mall&location=17.3700,78.4800&radius=50000&key=",key)
# doc <- getURL(url)
# x <- jsonlite::fromJSON(doc) # Coverts the JSON data in list and data frame
# str(x)
# # write.table(x$results,"clipboard",)
# malls = x$results$geometry$location
# head(malls)
# # write.table(malls,"clipboard",)

# # hospitals
# url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=hospitals+in+hyderabad&types=hospital&location=17.3700,78.4800&radius=50000&key=",key)
# doc <- getURL(url)
# x <- jsonlite::fromJSON(doc)
# hospitals = x$results$geometry$location
# head(hospitals)

# casino search in Delhi
# url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=casino+in+Delhi&types=casino&location=28.6100,77.2300&radius=500000&key=",key)
# # url = paste0("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.6100,77.2300&radius=500000&types=casino&name=casino&key=",key)
# # url = paste0("https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJLbZ-NFv9DDkRzk0gTkm3wlI&radius=500000&types=casino&key=",key)
# doc <- getURL(url)
# x <- jsonlite::fromJSON(doc) # Coverts the JSON data in list and data frame
# str(x)
# # write.table(x$results,"clipboard",)
# casino = x$results$geometry$location
# head(casino)

# # casino search in Gurgaon
# url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=casino+in+Gurgaon&types=casino&location=28.4700,77.0300&radius=500000&key=",key)
# doc <- getURL(url)
# x <- jsonlite::fromJSON(doc) # Coverts the JSON data in list and data frame
# str(x)
# # write.table(x$results,"clipboard",)
# casinog = x$results$geometry$location
# head(casinog)
# # write.table(casino,"clipboard",)

# https://en.wikipedia.org/wiki/Delhi
# Union Territory = 1,484.0 km2 (573.0 sq mi)
# radius = 38.5227 km - Taking this as an approx estimation to make a circle around Delhi


# liquor_store
url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=liquor+in+Delhi&types=liquor_store&location=28.6100,77.2300&radius=385227&key=",key)
doc <- getURL(url)
x <- jsonlite::fromJSON(doc)
liquor_store = x$results$geometry$location
# head(liquor_store)


# bar
url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=bar+in+Delhi&types=bar&location=28.6100,77.2300&radius=385227&key=",key)
doc <- getURL(url)
x <- jsonlite::fromJSON(doc)
bar = x$results$geometry$location
# head(bar)

# atm
url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=atm+in+Delhi&types=atm&location=28.6100,77.2300&radius=385227&key=",key)
doc <- getURL(url)
x <- jsonlite::fromJSON(doc)
atm = x$results$geometry$location
#  head(atm)
# write.csv(atm,"Delhi_placesatm.csv", row.names = F)

# bank
url = paste0("https://maps.googleapis.com/maps/api/place/radarsearch/json?&query=bank+in+Delhi&types=bank&location=28.6100,77.2300&radius=385227&key=",key)
doc <- getURL(url)
x <- jsonlite::fromJSON(doc)
bank = x$results$geometry$location
#  head(bank)
# write.csv(bank,"Delhi_placesbank.csv", row.names = F)

bankatm_data = rbind(bank,atm)
# write.csv(bankatm_data,"Delhi_placesbankatm_data.csv", row.names = F)

bankatm <- unique(bankatm_data)
# write.csv(bankatm,"Delhi_placesunique.csv", row.names = F)


# casino$type = "Casino"
liquor_store$type = "Liquor Store"
bar$type = "Bar"
bankatm$type = "BANK/ATM"

# data = rbind(casino,liquor_store,bar)
data = rbind(liquor_store,bar,bankatm)
data_LSB = rbind(liquor_store,bar)

# write.table(data,"clipboard",)
dim(data)

write.csv(data,"Delhi_places.csv", row.names = F)

###################################################################
###################################################################
###################################################################

#Single Plot Below
sampleplotreq <- liquor_store #Cluster_K9_Complete Delhi with Bars
sampleplotreq <- bar #Cluster_K9_Complete Delhi with Bars
sampleplotreq <- bankatm #Cluster_K9_Complete Delhi with Bars
sampleplotreq <- data #Used this for slide 5 - Result Slides
sampleplotreq <- data_LSB

# let's plot the malls and do clustering based on distance matrix
sample = sampleplotreq
coordinates(sample) <-~ lng +lat # Create cordinates
proj4string(sample) = CRS('+proj=longlat +datum=WGS84') # Add Projections
m<-mcGoogleMaps(sample, zcol = "type", mapTypeId='ROADMAP') # Plot on Google maps
# m<-mcGoogleMaps(sample, zcol = "type", mapTypeId='HYBRID') # Plot on Google maps
# m<-mcGoogleMaps(sample, zcol = "type", mapTypeId='TERRAIN') # Plot on Google maps
# m<-mcGoogleMaps(sample, zcol = "type", mapTypeId='SATELLITE') # Plot on Google maps
              
#  m<-ellipseGoogleMaps(sample, zcol = "type",mapTypeId='ROADMAP') # Plot on Google maps
#  m<-bubbleGoogleMaps(sample, zcol = "type", mapTypeId='SATELLITE') # Plot on Google maps



# Get the coordinates
p2 = sampleplotreq[,1:2]

# calculate distances
dist_mat = matrix(0,nrow(p2),nrow(p2))

for (i in 1:nrow(p2)){
  for (j in 1:nrow(p2)){
    dist_mat[i,j] = distCosine(p2[i,],p2[j,], r=6378173)/1000    
  }
}

class(dist_mat)
dist_mat[1:10,1:10]
write.table(dist_mat[1:10,1:10],"Distance Matrix of Complete Delhi with Liquor Stores only.txt")
write.table(dist_mat[1:10,1:10],"Distance Matrix of Complete Delhi with Bars only.txt")
write.table(dist_mat[1:10,1:10],"Distance Matrix of Complete Delhi with ATMBank only.txt")

# Create clusters based in distances
fit <- hclust(as.dist(dist_mat), method="ward")
plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="single") # This will show single distances of the proxis from center
# plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="complete")
# plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="average")
# plot(fit) # display dendogram
# 
# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="mcquitty")
# plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="ward.D")
# plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="ward.D2")
# plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="centroid")
# plot(fit) # display dendogram

# rm("fit") 
# fit <- hclust(as.dist(dist_mat), method="median")
# plot(fit) # display dendogram



k=18
groups <- cutree(fit, k) # cut tree into 18 clusters
# draw dendogram with red borders around the 18 clusters
rect.hclust(fit, k, border="blue")
text(150, 600,"Dendogram of the proxy entities Liquor Stores", col = "blue")
text(150, 600,"Dendogram of the proxy entities Bars", col = "blue")
text(150, 600,"Dendogram of the proxy entities ATM/Bank", col = "blue")


sample$group = groups # Assign cluster groups

# Plot stores with clustor as label
# m <- mcGoogleMaps(sample, mapTypeId='ROADMAP', zcol="group")
m <- mcGoogleMaps(sample, mapTypeId='ROADMAP', zcol="group", layerName="Liquor Stores")
m <- mcGoogleMaps(sample, mapTypeId='ROADMAP', zcol="group", layerName="Bars")
m <- mcGoogleMaps(sample, mapTypeId='ROADMAP', zcol="group", layerName="ATM/Bank")


#########################################################
#########################################################
#########################################################

sample = data
sample = rbind(liquor_store,bar)
coordinates(sample) <-~ lng +lat # Create cordinates
proj4string(sample) = CRS('+proj=longlat +datum=WGS84') # Add Projections

m<-mcGoogleMaps(sample,zcol = "type", mapTypeId='ROADMAP') # Plot on Google maps
