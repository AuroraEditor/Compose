# Setting up the Compose API

When we created the Compose API we tried making the docker setup also easy to understand just like the API codebase.

#### 1. Start Compose with Docker

Make sure you have the following applications installed before proceeding:

* [Git](https://git-scm.com/)
* [Docker](https://www.docker.com/)

If you have the above mentioned applications installed proceed with the following steps.

Run this script:

```bash
git clone git@github.com:AuroraEditor/Compose.git
cd compose/Back-End
docker compose --env-file .env up -d
```

Then open your browser on port `8080` and log in to `Compose` using:

- username: `admin`
- password: `admin`

#### 2. Secure the exposed connection to Docker

We added SSL encryption for you, without having you needing to struggle on setting it up. We know how difficult it is to setup SSL on a docker... It took days to figure out :(

To setup SSL for your domain is very easy if you follow the following steps:

* Go to `data\nginx\app.conf` and change all domains that are `example.com` with your domain.
* Next edit `init-letsencrypt.sh` and replace the `example.com` with your domain. Don't forget to add your email and change the `staging` value to `1` when you are ready to make a producation call.
* When all domains are changed to your domain all you need to do is run `init-letsencrypt.sh`, the below bash code will run you through the steps to do that.

```bash
cd compose/Back-End # If you're not already in the compose back-end directory
chmod +x init-letsencrypt.sh
sudo ./init-letsencrypt.sh
docker compose restart
```

If all steps are followed correctly it should be working correctly and you should have a secure web call. If you still have issues setting up the API don't hesitate to contact `nanashili@auroraeditor.com`.
