FROM rjnawara/mba-next:latest

LABEL description="This is an image to setup a dev environment for mbadiamond"

ARG GITHUB_PAT
ARG BUNDLE_GITHUB__COM

RUN git clone https://RayNawara:$GITHUB_PAT@github.com/MBA-Ventures-LLC/mba-legacy.git /mba-orig && git submodule update --init --recursive

RUN cp config/database.yml.rails2 config/database.yml
# bundle install and then bundle exec unicorn_rails -c config/unicorn.conf
RUN pwd
WORKDIR /mba-orig
RUN bundle install && bundle exec unicorn_rails -c config/unicorn.conf

# You could also run script/server but then you can't generate PDFs. 

CMD ["/bin/bash"]
