define GO_BINARY
$(GOPATH)/src/$(1):
	@mkdir -p $(GOPATH)/src/$(1)
	@rmdir $(GOPATH)/src/$(1)
	@ln -s $(PLIOS_ROOT)/$(1) $(GOPATH)/src/github.com/pliOS/pliOS/$(1)

$(3): go_binary/$(1)

go_binary/$(1):
	@echo "===> Building $(1)"
	@go get github.com/pliOS/pliOS/$(1)
	@go build -o $(PLIOS_OUT)/$(2) github.com/pliOS/pliOS/$(1)
endef
