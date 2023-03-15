# CI/CD

This CI/CD was created on Jenkins

## Construction plan CI/CD

1. User create, add and push commit to GitHub

2. GitHub triggers Jenkins job  

3. Jenkins server executes job on agent

4. Build image

5. Agent pushes image to docker hub

6. Agent stops container in prod / Agent starts container with latest image

