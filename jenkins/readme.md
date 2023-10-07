

docker run --rm -u root -p 8080:8080 -v jenkins-data:/var/jenkins_home -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME":/home jenkinsci/blueocean


docker run -p 8081:8080 -p 50000:50000  -v /var/run/docker.sock:/var/run/docker.sock -v ./jenkins_home:/var/jenkins_home jenkins/jenkins:lts


docker run -p 8081:8080 -p 50000:50000 --rm --group-add $(stat -c '%g' /var/run/docker.sock) -v /var/run/docker.sock:/var/run/docker.sock -v ./jenkins_home:/var/jenkins_home sogis/jenkins:lts

macOS leicht anderes stat:
docker run -p 8081:8080 -p 50000:50000 --rm --group-add $(stat -f '%g' /var/run/docker.sock) -v /var/run/docker.sock:/var/run/docker.sock -v ./jenkins_home:/var/jenkins_home sogis/jenkins:lts




```
Jenkins.instance.getItemByFullName("fubar1")
        .getBuildByNumber(5)
        .finish(hudson.model.Result.ABORTED, 
                new java.io.IOException("Aborting build")
); 
```


Vielleicht habe ich es verstanden: 

Unter macOS hat _/var/run/docker.sock_ folgende Berechtigungen:

```
lrwxr-xr-x  1 root  daemon  37 Oct  7 15:37 /var/run/docker.sock -> /Users/stefan/.docker/run/docker.sock
```

Weil die Gruppe (`daemon`) keine Schreibrechte hat, kann man im Jenkins-Container auch nicht den Jenkins-Benutzer der Gruppe `daemon` zuweisen und gut ist. Das reicht nicht. Ich kann mir vorstellen, dass das unter Linus schon geht.