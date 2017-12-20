library(shiny)
library(plotly)
#library(Rblpapi)
#library(tseries)
#library(urca)
#source("\\Anne\\DEV\\Cointegration_Heatmap_Main.r")
#source("\\Anne\\DEV\\Cointegration_Heatmap_Function.r")
#source("\\Anne\\DEV\\Cointegration_Heatmap_Table.r")


ui <- fluidPage(
  titlePanel(title=tags$img(img(src = "www.rstudio.com"))),
  
  sidebarLayout(
    
    sidebarPanel(
     # helpText("Cointegration Heatmap"),
      fileInput("file", "upload the file"),
      tags$hr(),
      
     # checkboxInput(inputId = 'header',label='Header',value=FALSE),
      #checkboxInput(inputId = "stringAsFactors", label= "stringAsFactors",FALSE),
      #br(),
     # radioButtons(inputId ='sep',label= 'Separator', choices = c(Comma=',',Semicolon=';',Tab='\t',Space=''), selected=','),
      
      
      dateInput("date1", "Date Start:", value = "2014-01-02"),
      
      dateInput("date2", "Date End:", value = Sys.Date()-1),
      
     # numericInput("obs", "Window", 126, min = 1, max = 1000),
      
      selectInput("log", "Include log in regression?",
                  c("log" = "log",
                    "no log" = "nolog" )),
      
      numericInput("hl", "Half-life", 2, min = 1, max = 3),
      
      actionButton("do", "Heatmap")
      
    ),
    
    mainPanel(
      titlePanel("Cointegration Heatmap"),
      uiOutput("tb")
    )
    
    
  ))


server <- function(input,output)  {
  
  data <- reactive ({
    file1 <- input$file
    if(is.null(file1)){return()}
    # read.csv(file=file1$datapath, header=TRUE, sep=',')
    
    read.table(file=file1$datapath, sep=',', header = FALSE, stringsAsFactors = FALSE)
  })
  
  startD <- reactive({input$date1})
  
  endD <- reactive({input$date2}) 
  
  wdw <- reactive({input$obs})
  
  hl <- reactive({input$hl})
  
  log <- reactive({input$log})
  
  matriz <-  reactive({ 
    
    tickers <- data()
    sD <- startD()
    eD <- endD()
    wD <- wdw()
    hl <- hl()
    log <-log()
    
    
    myMatrix <- cor(mtcars)
    #myMatrix <- inicioCoint(tickers,sD,eD,wD,hl,log)
    
    return(myMatrix) })
  
  output$filedf <- renderTable ({
    if(is.null(data())){return()}
    if(input$do==0){return()}
    input$file 
  })
  
  output$plotlyHM <- renderPlotly({
    
    
    if(input$do==0){return()}
    if(is.null(data())){return()}
    
    
    myMatrix <- matriz()
    
    
    p <- plot_ly(z = myMatrix,
                 x = rownames(myMatrix),
                 y = rownames(myMatrix),
                 #colors=interval.cols2,
                 colors = colorRamp(c("blue","orange","red","black")),
                 zmin = 0.00,
                 zmax = 1.00,
                 type = "heatmap", source = "heatplot",
                 width = 850,
                 height = 800,
                 showscale = TRUE
    )
    layout(p, 
           autosize = FALSE,
           margin = list(l = 250, r = 50, b = 250, t = 50, pad = 4),
           font = list(size = 12),
           xaxis = list(title = "", side = 'top', autorange = "reversed"), 
      
           yaxis = list(title = "")
           
           
           
           
    )
  })
  
  
  output$table <- renderTable ({  #data in table form
    if(input$do==0){return()}
    if(is.null(data())){return()}
    
    input$do
    data()
    
  })
  
  
  output$datatable <- renderDataTable ({  #data in table form
    if(input$do==0){return()}
    if(is.null(data())){return()}
    
    s <- event_data("plotly_click", source ="heatplot")
    if (length(s)) {
      
      sD <- startD()
      eD <- endD()
      wD <- wdw()
      hl <- hl()
      log <-log()
      
      tabela <- cointegracaoPair(s[["x"]],s[["y"]],sD,eD,wD,hl,log)  
      return(tabela)
      
      
    }
    else
    {
      plotly_empty()
    }
    
    
  })
  
  output$tb <- renderUI({
    if(is.null(data()))
      h5("Input a CSV file")
    else
      tabsetPanel(tabPanel("About File",tableOutput("filedf")),tabPanel("Data - Export Pairs",tableOutput("table")),tabPanel("Heatmap",plotlyOutput("plotlyHM"),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),dataTableOutput("datatable")))
  })
  
}


shinyApp(ui, server)
