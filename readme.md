# Oppgave 2 og 3 - guide til eksamen

## Oppgave 2

### 1 Opprette prosjekt
[Opprett et nytt Google Cloud-prosjekt](https://cloud.google.com). (Husk å enable billing i prosjektet.)

### 2 Opprette service account
#### Via GUI:
* Gå til `IAM & Admin` -> `Service Accounts`, klikk på `Create Service Account`. 
* Gi Service Accounten din et navn og klikk `Create`.
* Når du blir spurt om å gi rolle, velg `Storage Admin`.
* Klikk på `Done` og du vil bli sendt til oversikten over service accounts.

#### Via terminal:
Hent nåværende Google Cloud prosjekt ID:
 ```
  PROJECT_ID="$(gcloud config get-value project -q)"
  ```
Gi navn:
```
  SVCACCT_NAME=travisci-deployer
```
Opprett service brukeren:
```
  gcloud iam service-accounts create "${SVCACCT_NAME?}"
```
Gi Storage Admin-rettigheter:
```
  gcloud projects add-iam-policy-binding "${PROJECT_ID?}" \
    --member="serviceAccount:${SVCACCT_EMAIL?}" \
    --role="roles/storage.admin"
```

### 3 Tilegne nøkkel til service account
Åpne service accounten du har opprettet. Klikk deretter på `keys`-taben. Lag en ny nøkkel ved å klikke på 
`Add new` og velg json-format. Det gjør at json-filen lastes ned automatisk. Kopier filen inn i rot-prosjektet og endre navn
til `google-key.json`. Ikke push opp denne til Git. !!!. Krypter filen med kommandoen `travis encrypt-file google-key.json --add`
### 4 Opprette bucket - tilegne miljø variabler
Disse stegene avhenger om du er på Windows eller Mac. Nedenfor finner du guide til begge OS.

PC:

Sette navn til bucket:

`set bucket-name=YOUR_BUCKET_NAME`

Sette prosjektet sin ID:

`set project-id=YOUR_PROJECT_ID`

Bind miljø-variablene mot Terraform-variablene:

`set TF_VAR_bucket=%bucket-name%`

`set TF_VAR_project_id=%project-id%`

Kjør (viktig å stå i /init):

`terraform init`

`terraform apply`

Og med det er en bucket opprettet i Google Cloud!

MAC:

Sette navn til bucket:

`export bucket-name=YOUR_BUCKET_NAME`

Sette prosjektet sin ID:

`export project-id=YOUR_PROJECT_ID`

Bind miljøvariabler mot Terraform-variablene:

`export TF_VAR_bucket=$bucket-name`

`export TF_VAR_project_id=$project-id`

Kjør med `terraform run` og `terraform apply`. Bucket opprettes i Google Cloud.

## Oppgave 3

* For oppgave 3 må du i Google Cloud GUI (API & Services -> dashboard) enable API'er. De nødvendige er `Container Registry`, `Cloud Storage`, `Cloud Run` og `Compute Engine`.

* Deretter legge til følgende roller til Service brukeren `Service Account User`, `Service Account Admin`, `Compute Admin`. Husk også storage admin fra oppgave 2.

* I `.travis.yml` bytt `GCP_PROJECT_ID` til egen ID.

* Bytt ut `bucket` til eget navn i `backend.tf`

* Kjør kommandoen `travis env set TF_ENV_machine_type f1-micro --public` i terminalen.

Til sist:

```GIT
  git add . , git commit -m "din commit melding", git push origin master
```
NB: Husk å ikke pushe opp google-key.json!

* Disclaimer: Jeg kjører Travis på Windows-maskin. Travis sliter med å kjøre den encryptede filen pga Windows. Fikk dessverre ikke tid til
å teste ut dette i eget Linux-miljø. Forsøkte å logge inn med `--pro` og kjøre kommandoen `travis encrypt-file google-key.json --pro` til ingen nytte.
Mener at dette vil fungere på MAC/Linux.





