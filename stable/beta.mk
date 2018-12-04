NS_EFK ?= efk
NS_TICK ?= tick


create_efk:
	kubectl create ns ${NS_EFK}
	helm install --name elasticsearch --namespace ${NS_EFK} --version v1.13.3 -f elasticsearch/values.yaml stable/elasticsearch
	helm install --name kibana --namespace ${NS_EFK} --version v0.18.0 -f kibana/values.yaml stable/kibana
	helm install --name fluentd-elasticsearch --namespace ${NS_EFK} --version v1.1.0 -f fluentd-elasticsearch/values.yaml stable/fluentd-elasticsearch

delete_efk:
	helm delete --purge elasticsearch
	kubectl delete pvc -l release=elasticsearch,component=data
	helm delete --purge kibana
	helm delete --purge fluentd-elasticsearch
	kubectl delete ns ${NS_EFK}

get_efk:
	kubectl -n ${NS_EFK} get ingress,services,pod,daemonsets,deployments,statefulsets,replicasets,replicationcontrollers,cronjobs,jobs -o wide

get_efk_vol:
	kubectl -n ${NS_EFK} get endpoints,persistentvolumeclaims,storageclasses,persistentvolumes -o wide

get_efk_conf:
	kubectl -n ${NS_EFK} get configmaps,serviceaccounts -o wide


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

