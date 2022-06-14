FROM alpine

VOLUME ["/oauth", "/cache"]

RUN apk add --no-cache duplicity py3-requests py3-requests-oauthlib

# for whatever reason it is impossible to simply change the path for duplicity
RUN ln -s /oauth/duplicity-oauth.json /root/.duplicity_onedrive_oauthtoken.json

COPY backup.sh /bin/

CMD /bin/backup.sh