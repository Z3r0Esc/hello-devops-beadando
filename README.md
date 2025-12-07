# Hello DevOps – Beadandó projekt

Ez a projekt a GDE „DevOps - Code to Production” tárgy beadandójához készült.  
Célja egy egyszerű alkalmazáson keresztül bemutatni a fő DevOps lépéseket:

- kódkészítés  
- verziókövetés (trunk-based development)  
- buildelés  
- konténerizálás (Docker)  
- CI pipeline + free registry (GitHub Actions + GitHub Container Registry)

---

## 1. Alkalmazás – „Hello DevOps” API

**Technológia:** Node.js + Express

Az alkalmazás egyetlen HTTP végpontot biztosít:
```
GET http://localhost:8080
```

**Válasz:**
Hello DevOps! Ez a beadando HTTP valasza.


### Futtatás lokálisan

```bash
npm install
npm start
```

## 2. Buildelés
A build parancs:

```bash
npm run build
```
A build jelenleg csak egy ellenőrző lépés, mivel nincs transzpilálás vagy minimizálás.

## 3. Git használat – Trunk-based development
A fejlesztés Git alapon történt, trunk-based módszert követve.

A repository-ban:
- main branch → ez a trunk
- legalább egy feature branch:
    - feature/uj-uzenet
- több commit értelmes commitüzenetekkel (pl. "Init: Hello DevOps app", "Feature: uj uzenet hozzaadasa")
- a feature branch Pull Request-tel került visszamerge-lésre a main-re

Publikus repository link:
https://github.com/Z3r0Esc/hello-devops-beadando

## 4. Dockerizálás
A projekt tartalmaz egy működő Dockerfile-t, amely:
- Node 20-alpine image-re épül
- telepíti a függőségeket
- futtatja az alkalmazást induláskor
- a 8080-as portot használja

Docker image buildelése:
```bash
docker build -t hello-devops:v1 .
```
Konténer futtatása:
```bash
docker run --rm -p 8080:8080 hello-devops:v1
```
Ezután a konténerben futó app elérhető:

http://localhost:8080

## 5. CI Pipeline + Free Registry (3.2 – Kötelezően választott rész)
A projekt tartalmaz egy önálló CI pipeline-t GitHub Actions segítségével.

A pipeline a következő lépéseket végzi:

- kód checkout
- Node.js környezet konfigurálása
- npm install
- npm run build
- Docker image build
- Docker image push a GitHub Container Registry-be (GHCR)

Workflow fájl:
```bash
.github/workflows/ci.yml
```

Registry: GitHub Container Registry (GHCR)
A pipeline az alábbi image-et tölti fel:

```bash
ghcr.io/z3r0esc/hello-devops:latest
```
Image lehúzása
```bash
docker pull ghcr.io/z3r0esc/hello-devops:latest
```
Image futtatása registryből
```bash
docker run --rm -p 8082:8080 ghcr.io/z3r0esc/hello-devops:latest
```
Ezután a konténerben futó app elérhető:

http://localhost:8082

GHCR package link:
https://github.com/Z3r0Esc?tab=packages

## 6. Fájlstruktúra
```
hello-devops/
│
├── index.js
├── package.json
├── Dockerfile
├── .github/
│   └── workflows/
│       └── ci.yml
└── README.md
```
## 7. Összegzés
Ez a projekt sikeresen demonstrálja a DevOps beadandó minden szükséges elemét:

- működő, HTTP-n elérhető alkalmazás
- dokumentált buildelés
- trunk-based Git workflow
- Docker konténerizálás
- CI pipeline + Docker registry publikálás

A projekt így remélem teljesíti a tárgy beadandójának követelményeit.