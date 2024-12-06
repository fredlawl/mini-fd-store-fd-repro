SERVICE_NAME := test-unit
SYSTEMD_PATH := /etc/systemd/system
UNIT_FILE := $(SYSTEMD_PATH)/$(SERVICE_NAME).service

.PHONY: swap
swap:
ifeq ($(shell readlink -f $(UNIT_FILE)), $(PWD)/$(SERVICE_NAME).service.swap)
	-ln -fs $(PWD)/$(SERVICE_NAME).service $(UNIT_FILE)
else
	-ln -fs $(PWD)/$(SERVICE_NAME).service.swap $(UNIT_FILE)
endif
	@echo "changed to: $(shell readlink -f $(UNIT_FILE))"
	systemctl daemon-reload

.PHONY: start
start: install /opt/tests/do_test.py
	-systemctl enable --now $(SERVICE_NAME).service

.PHONY: stop
stop:
	-systemctl stop $(SERVICE_NAME).service

.PHONY: uninstall
uninstall: stop
	-rm $(UNIT_FILE)
	-systemctl daemon-reload
	-rm /opt/tests/do_test.py

.PHONY:
install: $(UNIT_FILE) /opt/tests/do_test.py

$(UNIT_FILE): $(SERVICE_NAME).service
	-ln -fs $(PWD)/$(SERVICE_NAME).service $@

/opt/tests/do_test.py:
	mkdir -p /opt/tests
	cp $(PWD)/do_test.py /opt/tests
