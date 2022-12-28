
wasmbyhand : subdirs web

web : webserver.go
	go build webserver.go

subdirs : */
	@for d in $^ ; do \
		(cd $$d; wat2wasm *wat) \
	done
