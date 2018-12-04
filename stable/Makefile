include beta.mk

NS_ING ?= ingress
NS_METRICS ?= metrics
NS_DASH ?= dashboard


create_metrics:
	kubectl create ns ${NS_METRICS}
	helm install --name metrics --namespace ${NS_METRICS} --version v2.0.4 -f metrics-server/values.yaml stable/metrics-server

delete_metrics:
	helm delete --purge metrics
	kubectl delete ns ${NS_METRICS}

get_metrics:
	kubectl -n ${NS_METRICS} get all -o wide


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
	helm init --service-account tiller --upgrade
	helm repo update

delete_helm:
	kubectl -n kube-system delete deployment tiller-deploy
	kubectl delete clusterrolebinding tiller
	kubectl -n kube-system delete serviceaccount tiller
	-helm reset -f


create_dashboard:
	kubectl create ns ${NS_DASH}
	helm install --name k8s-dashboard --namespace ${NS_DASH} --version v1.10.0 -f kubernetes-dashboard/values.yaml stable/kubernetes-dashboard

delete_dashboard:
	helm delete --purge k8s-dashboard
	kubectl delete ns ${NS_DASH}

get_dashboard:
	kubectl -n ${NS_DASH} get deploy,rs,pod,secret,sa -o wide

token_dashboard:
	kubectl -n dashboard get secret -o=jsonpath='{.items[1].data.token}' | base64 -d && echo

