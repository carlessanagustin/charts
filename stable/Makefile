NS_EFK ?= kube-system
NS_TICK ?= kube-system
NS_DASH ?= kube-system

create_helm:
	kubectl -n kube-system create serviceaccount tiller
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
	helm init --service-account tiller
	helm upgrade

delete_helm:
	kubectl -n kube-system delete deployment tiller-deploy
	kubectl delete clusterrolebinding tiller
	kubectl -n kube-system delete serviceaccount tiller

create_efk:
	helm install --name elasticsearch ${NS_EFK} -f elasticsearch/values.yaml stable/elasticsearch
	helm install --name kibana ${NS_EFK} -f kibana/values.yaml stable/kibana
	helm install --name fluentd-elasticsearch ${NS_EFK} -f fluentd-elasticsearch/values.yaml stable/fluentd-elasticsearch

delete_efk:
	helm delete --name elasticsearch ${NS_EFK}
	helm delete --name kibana ${NS_EFK}
	helm delete --name fluentd-elasticsearch ${NS_EFK}

create_tick:
	helm install --name influxdb ${NS_TICK} -f influxdb/values.yaml stable/influxdb
	helm install --name kapacitor ${NS_TICK} -f kapacitor/values.yaml stable/kapacitor
	helm install --name chronograf ${NS_TICK} -f chronograf/values.yaml stable/chronograf
	helm install --name telegraf ${NS_TICK} -f telegraf/values.yaml stable/telegraf

delete_tick:
	helm delete --name influxdb ${NS_TICK}
	helm delete --name kapacitor ${NS_TICK}
	helm delete --name chronograf ${NS_TICK}
	helm delete --name telegraf ${NS_TICK}

create_dashboard:
	helm install --name kubernetes-dashboard ${NS_DASH} -f kubernetes-dashboard/values.yaml stable/kubernetes-dashboard

delete_dashboard:
	helm delete --name kubernetes-dashboard ${NS_DASH}
