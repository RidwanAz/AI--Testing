# AUTOMATING DEPLOYMENT OF AN E-CORMMERCE WEBSITE

![project -scenario](./images/project-scenario.PNG)

## STEPS

![steps](./images/step1.PNG)

Use the jenkins-script.sh to install jenkins on ubuntu

![steps](./images/step2.PNG) 

Use this for creating the webhook : `http://13.40.219.176:8080/github-webhook/`

![steps](./images/step3.PNG)

![steps](./images/step4.PNG)

For testing our webhook, let us use the Jenkinsfile below
```
pipeline {
    agent any

  stages {
    stage("Initial cleanup"){
      steps {
        dir("${WORKSPACE}") {
          deleteDir()
        }
      }
    }
    
    stage('Build') {
      steps {
        script {
          sh 'echo "Building Stage"'
        }
      }
    }

    stage('Test') {
      steps {
        script {
          sh 'echo "Testing Stage"'
        }
      }
    }

    stage('Package') {
      steps {
        script {
          sh 'echo "Packaging Stage"'
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          sh 'echo "Deploying Stage"'
        }
      }
    }

    stage("Clean up workspace after build") {
          steps {
            cleanWs()
            }
    }
  }
}
```

![webhook testing](./images/webhook-testing.PNG)

![steps](./images/step5.PNG)

Update the Jenkinsfile with the below snippet

```
pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'your-docker-image-name'
        DOCKERFILE_PATH = 'Dockerfile' // Path to your Dockerfile
    }
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your/repository.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE} -f ${DOCKERFILE_PATH} ."
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to a registry (e.g., Docker Hub)
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }
    }
}
```

- Replace 'your-docker-image-name' with the name of your Docker image.

- Set DOCKERFILE_PATH to the path of your Dockerfile relative to the repository root.

- Replace 'https://github.com/your/repository.git' with the URL of your Git repository.

- Ensure that Jenkins has permission to access your Docker registry (e.g., Docker Hub) if you're pushing the image there.

You may need to configure Jenkins credentials to access your Git repository and Docker registry.
Once you have the pipeline defined, you can create a new Jenkins pipeline job and paste this script into the Pipeline section. Then, Jenkins will automatically execute this pipeline whenever a new build is triggered.