FROM nginx:alpine
# copy the public folder to the server html root
COPY public /usr/share/nginx/html

# RUN apk update
# RUN apk add git
# COPY package.json /app/docsy/userguide/
# WORKDIR /app/docsy/userguide/
# RUN npm install --production=false
# RUN git config --global --add safe.directory /app/docsy

# CMD ["serve", "--cleanDestinationDir", "--themesDir", "../..", "--baseURL",  "http://localhost:1313/", "--buildDrafts", "--buildFuture", "--disableFastRender", "--ignoreCache", "--watch"]
