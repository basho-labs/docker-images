FROM basho/erlang:alpine-3.4
# overlay: greeting.Dockerfile 
COPY ./greeting.sh /tmp/greeting.sh
RUN chmod a+x /tmp/greeting.sh

CMD ["/tmp/greeting.sh"]
