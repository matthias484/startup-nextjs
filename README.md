# Kubernetes Deployment der Next.js-Anwendung

Für dieses Projekt habe ich die Konfigurationsdatei `deployment.yml` erstellt, die alle benötigten Kubernetes-Ressourcen definiert: **Deployment**, **Service** und **Horizontal Pod Autoscaler (HPA)**.

Das Docker-Image `mwerkl/startup-nextjs:latest` wurde frisch erstellt und auf DockerHub hochgeladen, um es im Kubernetes-Cluster zu verwenden.

### Strategien und Implementierung

#### Zero-Downtime Deployment
Um sicherzustellen, dass es während der Bereitstellung zu keiner Ausfallzeit kommt, habe ich eine **Rolling Update**-Strategie verwendet. Dadurch werden alte Pods schrittweise durch neue ersetzt, sodass die Anwendung während des gesamten Prozesses weiterhin verfügbar bleibt.

#### Zugriff auf die Anwendung
Die Anwendung wird durch einen **LoadBalancer Service** bereitgestellt, der Anfragen auf **Port 8080** weiterleitet. Dadurch kann ich die Erreichbarkeit der Anwendung überprüfen, indem ich sie über `localhost:8080` im Browser aufrufe.

#### Automatische Skalierung
Um die Last dynamisch zu bewältigen, habe ich den **Horizontal Pod Autoscaler (HPA)** eingesetzt. Dieser sorgt dafür, dass die Anzahl der Pods erhöht wird, wenn die CPU-Auslastung einen Schwellenwert von **70%** überschreitet, um so auf steigende Anforderungen reagieren zu können.

#### Überwachung der Anwendung
Um die Stabilität und Verfügbarkeit der Anwendung sicherzustellen, habe ich sowohl **Liveness**- als auch **Readiness-Probes** implementiert:
- Die **Liveness Probe** überwacht, ob der Container ordnungsgemäß ausgeführt wird. Sollte der Container nicht mehr reagieren, wird er neu gestartet.
- Die **Readiness Probe** stellt sicher, dass der Container erst dann Traffic empfängt, wenn er vollständig initialisiert und bereit dafür ist. Beide Probes verweisen in diesem Fall auf die `/about`-Seite, um die Funktionstüchtigkeit der Anwendung zu testen.
