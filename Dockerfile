FROM rjnawara/mba-next:latest

LABEL description="This is an image to setup a dev environment for mbadiamond"


# bundle install and then bundle exec unicorn_rails -c config/unicorn.conf

# RUN bundle install

# You could also run script/server but then you can't generate PDFs. 

CMD ["/bin/bash"]
