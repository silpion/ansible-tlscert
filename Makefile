ENVFILE = envvars-vagrant
LOGFILE = /tmp/ansible-tlscert-test.log
SOURCECOMMAND = source `pwd`/$(ENVFILE)
IDEMPOTENCEAPPENDIX = tee $(LOGFILE) | (grep 'changed=0.*failed=0' && rm $(LOGFILE)) || (cat $(LOGFILE) && false)

default:
	exit 0

syntax:
	ansible-playbook --inventory-file tests/hosts --syntax-check tests/playbook.yml

clean:
	- $(SOURCECOMMAND) && vagrant destroy -f #This error prone is
	- rm $(LOGFILE)

provision: clean
	$(SOURCECOMMAND) && vagrant up

idempotence: provision
	$(SOURCECOMMAND) && vagrant provision | $(IDEMPOTENCEAPPENDIX)

checkmode: idempotence
	# This should have '| $(IDEMPOTENCEAPPENDIX)' as suffix
	# Currently this can not be implemented because ansible-util always generates a changed event for task 'Install Epel' in checkmode
	$(SOURCECOMMAND) && ANSIBLE_TLSCERT_VAGRANT_ANSIBLE_CHECKMODE=1 vagrant provision

test: syntax checkmode
	make clean
