NS_EFK ?= efk-ns
NS_TICK ?= tick-ns
NS_DASH ?= kube-system

create_helm:
	kubectl -n kube-system create serviceaccount tiller
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
	helm init --service-account tiller --upgrade

delete_helm:
	kubectl -n kube-system delete deployment tiller-deploy
	kubectl delete clusterrolebinding tiller
	kubectl -n kube-system delete serviceaccount tiller
	helm reset

create_efk:
	kubectl create ns ${NS_EFK}
	helm install --name elasticsearch --namespace ${NS_EFK} -f elasticsearch/values.yaml stable/elasticsearch
	helm install --name kibana --namespace ${NS_EFK} -f kibana/values.yaml stable/kibana
	helm install --name fluentd-elasticsearch --namespace ${NS_EFK} -f fluentd-elasticsearch/values.yaml stable/fluentd-elasticsearch

delete_efk:
	helm delete --purge elasticsearch
	helm delete --purge kibana
	helm delete --purge fluentd-elasticsearch
	kubectl delete ns ${NS_EFK}

create_tick:
	kubectl create ns ${NS_TICK}
	helm install --name influxdb --namespace ${NS_TICK} -f influxdb/values.yaml stable/influxdb
	helm install --name kapacitor --namespace ${NS_TICK} -f kapacitor/values.yaml stable/kapacitor
	helm install --name chronograf --namespace ${NS_TICK} -f chronograf/values.yaml stable/chronograf
	helm install --name telegraf --namespace ${NS_TICK} -f telegraf/values.yaml stable/telegraf

delete_tick:
	helm delete --purge influxdb
	helm delete --purge kapacitor
	helm delete --purge chronograf
	helm delete --purge telegraf
	kubectl delete ns ${NS_TICK}

create_dashboard:
	kubectl create ns ${NS_DASH}
	helm install --name k8s-dashboard --namespace ${NS_DASH} -f kubernetes-dashboard/values.yaml stable/kubernetes-dashboard

delete_dashboard:
	helm delete --purge k8s-dashboard
	kubectl delete ns ${NS_DASH}
