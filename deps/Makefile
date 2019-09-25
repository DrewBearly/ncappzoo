GREEN = '\033[1;32m'
YELLOW = '\033[1;33m'
NOCOLOR = '\033[0m'
OPEN_MODEL_ZOO = omz
APP_NAME = ncappzoo

PIP = pip3 --version
OPENCV = python3 -c "import cv2"

.PHONY: install-deps
install-deps: deps

.PHONY: install-reqs
install-reqs: deps

.PHONY: install
install: deps

.PHONY: deps
deps:
	@echo $(YELLOW)'\n'${APP_NAME}": Installing requirements and downloading dependencies...\n"$(NOCOLOR)
	@echo "\n Checking pip3..."
	@if $(shell) ${PIP} 2> /dev/null; \
	then \
		echo " - pip3 already installed.\n"; \
	else \
		echo $(YELLOW)"Installing pip3 from apt... "$(NOCOLOR); \
		sudo apt-get install python3-pip; \
	fi; \

	@echo "\n Checking OpenCV"
	@if [ -z "$(INTEL_OPENVINO_DIR)" ] ; \
	then \
		echo "Please initiate the Intel OpenVINO environment by going to the installation directory for openvino and running the setupvars.sh file in the bin folder." ; \
		exit 1 ; \
	fi;
	@if $(shell) ${OPENCV} 2> /dev/null; \
	then \
		echo " - OpenCV already installed.\n"; ]
	else \
		echo " - Intel optimized version of OpenCV not found. Please set your PATH and PYTHONPATH variables to point to your installation of OpenCV.\n"
		exit 1; \
	fi;


.PHONY: help
help:
	@echo "\nPossible Make targets"
	@echo $(YELLOW)"  make help "$(NOCOLOR)"- shows this message"
	@echo $(YELLOW)"  make all "$(NOCOLOR)"- Makes all targets"
	@echo $(YELLOW)"  make clean "$(NOCOLOR)"- Removes all temp files from all directories"
	@echo $(YELLOW)"  make compile_model "$(NOCOLOR)"- Runs compile on all caffe/tensorflow models"