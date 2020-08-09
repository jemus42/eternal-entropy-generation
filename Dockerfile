FROM rocker/shiny-verse:latest

# Install dependencies to utilize caching on rebuilds
RUN install2.r shinythemes dplyr glue

# Add the directory to the container
ADD . /entropy

# Expose the shiny server port
EXPOSE 3838
