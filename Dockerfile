FROM rocker/shiny-verse:latest

# Install dependencies to utilize caching on rebuilds
RUN install2.r shinythemes shinyjs kableExtra

# Add the directory to the container
ADD .

# Expose the shiny server port
EXPOSE 3838
