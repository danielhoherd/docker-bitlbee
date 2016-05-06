.PHONY: build
build:
	docker build --no-cache=true -t ${USER}/bitlbee .

.PHONY: run
run:
	docker run --restart=always -d -h bitlbee -p 29493:6667 --name bitlbee -v ${HOME}/.bitlbee:/var/lib/bitlbee -v ${HOME}/.bitlbee/etc:/etc/bitlbee ${USER}/bitlbee

.PHONY: debug
debug:
	docker run -it --rm -h bitlbee -p 29493:6667 --name bitlbee-debug -v ${HOME}/.bitlbee:/var/lib/bitlbee -v ${HOME}/.bitlbee/etc:/etc/bitlbee ${USER}/bitlbee
