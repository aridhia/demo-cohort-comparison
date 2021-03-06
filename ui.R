##################
####### UI #######
##################


# Body -----------------------

body <- dashboardBody(
  
  #tags$head(
  #  tags$style(
  #    HTML(
  #      "
  #      .inner {
  #      min-height:130px;
  #      }
  #      "
  #    )
  #  )
  #),
  
  navbarPage("Cohort Comparison", id = "navbar",
             
    # First Tab - Population Profile --------------------------------
    tabPanel("Population Profile", 
      fluidPage(
        column(6,
          
          # Column showing 1st cohort
          box(title = uiOutput("cohort1_summary"), collapsible = TRUE, width = 12,
            column(6,
              ggvisOutput("barplot1"),
              dateRangeInput("date1", "Choose Date of Inclusion: ", start = as.Date("2016-01-01")) 
              ),
            column(6,
              ggvisOutput("density1"),
              densityFilterUI("density_cohort1")     
            )
          ),
          tabBox(width = 12,
            tabPanel(title = "Demographics",
              fluidRow(
                column(6,
                  ggvisOutput("sex_cohort1")
                ),
                column(6,
                  ggvisOutput("age_cohort1")
                )
              )
            ),
            tabPanel(title = "Gene Panels",
              uiOutput("cohort1_measures"),
              fluidRow(
                column(4,
                  selectInput("cross_var11", "Select First SNP", choices = cross_var_choices, selected = cross_var_choices[1], width = "100%"),
                  selectInput("cross_var12", "Select Second SNP", choices = cross_var_choices, selected = cross_var_choices[2], width = "100%")
                ),
                column(8,
                  ggvisOutput("cross_tab1")
                )
              )
            ),
            tabPanel(title = "Vital Signs",
              fluidRow(
                column(6,
                  ggvisOutput("bp_density1")
                ),
                column(6,
                  ggvisOutput("resp_box1")
                )
              )
            ),
            tabPanel(title = "Treatments",
              fluidRow(
                column(6,
                  ggvisOutput("treatment_bars1")
                ),
                column(6,
                  ggvisOutput("treatment_points1")
                )
              )
            )
          ),
          column(4, offset = 4,
            actionButton("report", h4("View Report"), width = "100%", icon = icon("file-pdf-o", "fa-3x"))
          )
        ),
        
        # Column showing 2nd cohort
        column(6,
          box(title = uiOutput("cohort2_summary"), collapsible = TRUE, width = 12,
            column(6,
              ggvisOutput("barplot2"),
              dateRangeInput("date2", "Choose Date of Inclusion: ", start = as.Date("2016-01-01"))
            ),
            column(6,
              ggvisOutput("density2"),
              densityFilterUI("density_cohort2")
            )
          ),
          tabBox(width = 12,
            tabPanel(title = "Demographics",
              fluidRow(
                column(6,
                  ggvisOutput("sex_cohort2")
                ),
                column(6,
                  ggvisOutput("age_cohort2")
                )
              )
            ),
            tabPanel(title = "Gene Panels",
              uiOutput("cohort2_measures"),
              fluidRow(
                column(4,
                  selectInput("cross_var21", "Select First SNP", choices = cross_var_choices, selected = cross_var_choices[1], width = "100%"),
                  selectInput("cross_var22", "Select Second SNP", choices = cross_var_choices, selected = cross_var_choices[2], width = "100%")
                ),
                column(8,
                  ggvisOutput("cross_tab2")
                )
              )
            ),
            tabPanel(title = "Vital Signs",
              fluidRow(
                column(6,
                  ggvisOutput("bp_density2")
                ),
                column(6,
                  ggvisOutput("resp_box2")
                )
              )
            ),
            tabPanel(title = "Treatments",
              fluidRow(
                column(6,
                  ggvisOutput("treatment_bars2")
                ),
                column(6,
                  ggvisOutput("treatment_points2")
                )
              )
            )
          )
        )
      )
    ),
    
    # Second tab - Participant List Table ---------------------------------------
      tabPanel("Participant List",
               radioButtons(
                 inputId = "filter_choice",
                 label = "Choose column to add filter:",
                 choices = c("Gender", "Race", "Age", "Treatment", "Hospital"),
                 selected = c("Gender")
               ),
               participantListUI("pl")
    ),
    
    # Third tab - Report generation ------------------------------------------
    tabPanel("Report",
      uiOutput("pdf")
    ),
    
    # Fourth tab - Help ----------------------------------------------------
    tabPanel("Help",
             documentation_tab()
             )
  )
  
)


header <- dashboardHeader(disable = TRUE)
sidebar <- dashboardSidebar(disable = TRUE)

ui <- dashboardPage(header, sidebar, body)
