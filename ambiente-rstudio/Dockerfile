FROM rocker/rstudio:4.0.0

ENV DISABLE_AUTH true

RUN apt-get install -y libxml2-dev libz-dev

RUN install2.r -s -d TRUE --error \
               mlbench \
               caret \
               plumber
