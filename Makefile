all: prepare

prepare:
	mkdir -p $(MALICIOUS_DIR)

antivirus: prepare
	./antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL_SECS)

restore: prepare
	./restore.sh $(DIR) $(MALICIOUS_DIR)
