pipeline{

	agent any

	tools {
	    gradle 'Gradle_8.0'
	    maven 'Maven_3.9.0'
	    jdk 'JDK17'
	}

	environment {
		ACR_CREDENTIALS=credentials('KAKASHI_AZURE_ACR')
		ACR_APP_URL = "gradlecanvacr.azurecr.io"
		ACR_APP = "gradlecanvacr"
		APPLICATION_NAME = "redis-web-counter"
		COMMIT_HASH = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
		NAME_SPACE = "redis-namespace"
        //BRANCH = "${env.GIT_BRANCH}"
        //TAG = "${env.BRANCH}.${env.BUILD_NUMBER}".drop(15)
        //DEV_TAG = "${env.BRANCH}.${env.BUILD_NUMBER}".drop(7)
        //#VERSION = "${env.TAG}"
	}

	stages {

//         stage('Gradle build image') {
//         	steps {
//         	    sh 'echo $PWD'
//         		// sh 'cd ..'
//         		// sh 'echo $PWD'
//         		sh './gradlew clean'
//         		sh './gradlew build'
//         	}
//         }

        stage('Gradle build image') {
            steps {
                sh 'echo $PWD'
                // sh 'cd ..'
                // sh 'echo $PWD'
                sh 'mvn clean'
                sh "mvn package -DskipTests=true"
                archive 'target/*.jar'
            }
        }

        stage('Docker build image') {
            steps {
                sh 'docker build -t $ACR_APP_URL/$APPLICATION_NAME:$COMMIT_HASH .'
        	}
        }

		stage('Docker Hub Login') {
			steps {
			    // Using ACR to store Image
				sh 'docker login $ACR_APP_URL -u $ACR_CREDENTIALS_USR -p $ACR_CREDENTIALS_PSW'
				// Using DockerHub to store Image
				// sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
			}
		}

		stage('Docker Image Push') {
			steps {
				sh 'docker push $ACR_APP_URL/$APPLICATION_NAME:$COMMIT_HASH'
			}
		}

		stage('Gradle K8S Deploy') {
		    steps{
		        script {
		            //withKubeConfig([credentialsId: 'AZURE_AKS', serverUrl: '']) {
                        sh ('kubectl apply -f aks_deployment/aks-namespace.yml')
                        //sh ('kubectl apply -f aks_deployment/aks-service-deployment.yml')
                        //sh ('kubectl apply -f aks_deployment/aks-application-deployment.yml')
                        //sh ('kubectl set image deployment/gradle-demo-app gradle-demo-container=$ACR_APP_URL/$APPLICATION_NAME:$COMMIT_HASH --namespace $NAME_SPACE')
                    //}
                }
            }
        }
	}

	post {
		always {
			sh 'docker image prune -f --filter="dangling=true"'
			sh 'docker rmi -f $ACR_APP_URL/$APPLICATION_NAME:$COMMIT_HASH'
			sh 'docker images'
			sh 'docker ps ' // Check merge
		}
	}


}
