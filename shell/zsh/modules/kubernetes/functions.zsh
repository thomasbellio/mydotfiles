get_secret_values() {
	kubectl get secrets -o yaml  $1 > $2
	cat $2
}


