library(shiny)
library(plotly)
#library(Rblpapi)
#library(tseries)
#library(urca)
#source("\\\\Sp-desen-0077\\svc_difusao\\Anne\\DEV\\Cointegration_Heatmap_Main.r")
#source("\\\\Sp-desen-0077\\svc_difusao\\Anne\\DEV\\Cointegration_Heatmap_Function.r")
#source("\\\\Sp-desen-0077\\svc_difusao\\Anne\\DEV\\Cointegration_Heatmap_Table.r")


ui <- fluidPage(
  titlePanel(title=tags$img(img(src="data:image/png;base64,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"))),
  
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
      h5("Carregue um arquivo CSV")
    else
      tabsetPanel(tabPanel("About File",tableOutput("filedf")),tabPanel("Data - Export Pairs",tableOutput("table")),tabPanel("Heatmap",plotlyOutput("plotlyHM"),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),dataTableOutput("datatable")))
  })
  
}


shinyApp(ui, server)