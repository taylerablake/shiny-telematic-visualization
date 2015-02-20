# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyUI(navbarPage("",
                   tabPanel("Kmeans Clustering",
                            
                            # Application title
                            titlePanel("Classification Telematics Data"),
                            
                            # Sidebar with a slider input for number of bins
                            sidebarLayout(
                                sidebarPanel(
                                  sliderInput("k",
                                              "number of clusters",
                                              min = 1,
                                              max = 8,
                                              value = 2), 
                                  selectInput("algorithm", 
                                              label = h3("Clustering Algorithm"), 
                                              choices = c("kmeans","Hierarchical cluster"),
                                              selected = "kmeans"),
                                  selectInput("normalize", 
                                              label = h3("Normalize Data"), 
                                              choices = c("TRUE","FALSE"),
                                              selected = "TRUE"),
                                  
                                  selectInput("featureDisplay_y", 
                                                      label = h3("Y-Axis Feature"), 
                                                      choices = feature.list,
                                                      selected = feature.list[2]),
                                  selectInput("featureDisplay_x", 
                                            label = h3("X-Axis Feature"), 
                                            choices = feature.list,
                                            selected = feature.list[1])
                              ),
                              
                              # Display KNN results
                              mainPanel(
                                plotOutput("ScatterPlot"),
                                includeMarkdown("AppDescription.Rmd")
                                
                              )
                            )
                            
                   ),
                   tabPanel("Visualize Drive Pattern",
                            sidebarPanel(                           
                               selectInput("fileName", 
                                                    label = h3("File"), 
                                                    choices = file.list,
                                                    selected = file.list[1])),

                              
                            mainPanel(
                            
                                     plotOutput("tripPath"),
                                     includeMarkdown("tripInformation.Rmd")
                            
                            
                            
                   )
                   )

))