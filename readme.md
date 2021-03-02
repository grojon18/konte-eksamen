# Oppgave 2 - guide til eksamen

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





