for site in `seq 1 5` ; do
	docker start unicorn$site
done
