# CI/CD

CI/CD is setup using Jenkins

The project provides two pipelines for dynamic and static pages

When Web server is unavailable, traffic redirects to Static page

## Construction plan CI/CD

1. User create, add and push commit to GitHub

2. GitHub triggers Jenkins job  

3. Jenkins server executes job on agent

4. Build image

5. Agent pushes image to docker hub

6. Agent stops container in prod / Agent starts container with latest image

![Tux, the Linux mascot](../website/Docker/dynamic_page/images/dynamic_page.drawio.svg)

![Tux, the Linux mascot](../website/Docker/dynamic_page/images/static_page.drawio.svg)
