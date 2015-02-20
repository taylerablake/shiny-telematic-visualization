# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#



shinyServer(function(input, output) {
  
  
  
  observe({
    set.seed(7)
    if(input$algorithm == "kmeans" & input$normalize == "TRUE"){
    pred<-  kmeans(scale(processed.dat[,c(input$featureDisplay_x, input$featureDisplay_y)]), 
                          centers = input$k)$cluster
    }else{
      if(input$algorithm == "kmeans"){
        pred<-  kmeans((processed.dat[,c(input$featureDisplay_x, input$featureDisplay_y)]), 
                       centers = input$k)$cluster
      }else{
        if(input$normalize == "TRUE"){
          pred <- cutree(hclust(dist(scale(processed.dat[,c(input$featureDisplay_x, input$featureDisplay_y)]))), input$k)
        }else{
            pred <- cutree(hclust(dist(processed.dat[,c(input$featureDisplay_x, input$featureDisplay_y)])), input$k)
        }
     }
    }
    output$ScatterPlot <- renderPlot({
            ggplot(processed.dat, aes_string(x = input$featureDisplay_x, 
                                  y = input$featureDisplay_y)) + 
              geom_point(size = 4, color = pred) + 
              labs(x = names(feature.list)[feature.list == input$featureDisplay_x],
                   y = names(feature.list)[feature.list == input$featureDisplay_y]) +
              fte_theme() + 
              scale_color_brewer(name = "", palette = "Set1") 
            
            })
    

    
  })
  
  observe({

    trip.dat <- read.csv(paste0("2/",input$fileName, ".csv"))
    output$tripPath <- renderPlot({
      ggplot(trip.dat, aes(x = x, 
                            y = y, 
                            )) + 
        geom_point(size = 4, color = "#7A99AC") + 
        labs(x = "x",
             y = "y") +
        fte_theme() 
    })          
    
  })
  
})