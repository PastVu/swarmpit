#/bin/bash
set -ex
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add swarmpit.db-data=true $NODE_ID
docker node update --label-add swarmpit.influx-data=true $NODE_ID

case $1 in

	local)
	docker stack deploy -c swarmpit.yml -c local.yml swarmpit
	;;

	*)
	echo DOMAIN:
	read DOMAIN
	export DOMAIN
	docker stack deploy -c swarmpit.yml -c traefik.yml swarmpit
	;;

esac

