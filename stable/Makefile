NS_EFK ?= efk-ns
NS_TICK ?= tick-ns
NS_DASH ?= dashboard
NS_ING ?= ingress

create_efk:
	kubectl create ns ${NS_EFK}
	helm install --name elasticsearch --namespace ${NS_EFK} --version v1.13.3 -f elasticsearch/values.yaml stable/elasticsearch
	helm install --name kibana --namespace ${NS_EFK} --version v0.18.0 -f kibana/values.yaml stable/kibana
	helm install --name fluentd-elasticsearch --namespace ${NS_EFK} --version v1.1.0 -f fluentd-elasticsearch/values.yaml stable/fluentd-elasticsearch

delete_efk:
	helm delete --purge elasticsearch
	helm delete --purge kibana
	helm delete --purge fluentd-elasticsearch
	kubectl delete ns ${NS_EFK}

get_efk:
	kubectl -n ${NS_EFK} get all -o wide
	# ds,deploy,pods,svc,sa

create_tick:
	kubectl create ns ${NS_TICK}
	helm install --name influxdb --namespace ${NS_TICK} --version v0.12.1 -f influxdb/values.yaml stable/influxdb
	helm install --name kapacitor --namespace ${NS_TICK} --version v1.1.0 -f kapacitor/values.yaml stable/kapacitor
	helm install --name chronograf --namespace ${NS_TICK} --version v0.4.5 -f chronograf/values.yaml stable/chronograf
	helm install --name telegraf --namespace ${NS_TICK} --version v0.3.3 -f telegraf/values.yaml stable/telegraf

delete_tick:
	helm delete --purge influxdb
	helm delete --purge kapacitor
	helm delete --purge chronograf
	helm delete --purge telegraf
	kubectl delete ns ${NS_TICK}

get_tick:
	kubectl -n ${NS_TICK} get all -o wide

create_dashboard:
	kubectl create ns ${NS_DASH}
	helm install --name k8s-dashboard --namespace ${NS_DASH} -f kubernetes-dashboard/values.yaml stable/kubernetes-dashboard

delete_dashboard:
	helm delete --purge k8s-dashboard
	kubectl delete ns ${NS_DASH}

get_dashboard:
	kubectl -n ${NS_DASH} get all -o wide

create_ingress:
	kubectl create ns ${NS_ING}
	helm install --name ingress --namespace ${NS_ING} --version v0.31.0 -f nginx-ingress/values.yaml stable/nginx-ingress

delete_ingress:
	helm delete --purge ingress
	kubectl delete ns ${NS_ING}

get_ingress:
	kubectl -n ${NS_ING} get all -o wide


create_helm:
	kubectl -n kube-system create serviceaccount tiller
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
	helm init --service-account tiller
	helm repo update

delete_helm:
	kubectl -n kube-system delete deployment tiller-deploy
	kubectl delete clusterrolebinding tiller
	kubectl -n kube-system delete serviceaccount tiller
	helm reset
