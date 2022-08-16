# this is our first build stage, it will not persist in the final image
FROM ubuntu as intermediate

WORKDIR /
# add credentials on build
ARG GITHUB_PAT
# install git
RUN apt-get update
RUN apt-get install -y git

RUN mkdir /root/.ssh/
RUN --mount=type=secret,id=id_rsa,dst=/etc/secrets/id_rsa cp /etc/secrets/id_rsa /root/.ssh/

# make sure your domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone https://RayNawara:$GITHUB_PAT@github.com/MBA-Ventures-LLC/mba-legacy.git 
WORKDIR /mba-legacy
RUN git submodule update --init --recursive

FROM rjnawara/mba-next:latest

WORKDIR /mba-orig

LABEL description="This is an image to setup a dev environment for mbadiamond"

# copy the repository form the previous image
COPY --from=intermediate /mba-legacy/ /mba-orig/

RUN cp config/database.yml.rails2 config/database.yml
# bundle install and then bundle exec unicorn_rails -c config/unicorn.conf
RUN bundle install
RUN bundle exec unicorn_rails -c config/unicorn.conf

# You could also run script/server but then you can't generate PDFs. 

CMD ["/bin/bash"]
