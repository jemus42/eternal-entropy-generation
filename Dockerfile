FROM rocker/shiny-verse:4.0.2

# Install dependencies to utilize caching on rebuilds
RUN install2.r shiny shinythemes shinyjs

# Add the directory to the container
# ADD . /srv/shiny-server
# RUN chown -R shiny:shiny /srv/shiny-server

# Expose the shiny server port
EXPOSE 3838
