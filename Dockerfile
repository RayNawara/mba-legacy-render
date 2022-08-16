FROM rjnawara/mba-next:latest

LABEL description="This is an image to setup a dev environment for mbadiamond"

RUN git clone https://RayNawara:$GITHUB_PAT@github.com/MBA-Ventures-LLC/mba-legacy.git /mba-orig
# bundle install and then bundle exec unicorn_rails -c config/unicorn.conf
RUN pwd
WORKDIR /mba-orig
# RUN bundle install && bundle exec unicorn_rails -c config/unicorn.conf

# You could also run script/server but then you can't generate PDFs. 

CMD ["/bin/bash"]
