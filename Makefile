
GREEN = '\033[1;32m'
YELLOW = '\033[1;33m'
NOCOLOR = '\033[0m'
OPEN_MODEL_ZOO = omz

TOPTARGETS := all clean compile_model

SUBDIRS := $(wildcard */.)
INSTALL_PARAM := "yes"
EXIT_PARAM := "no"

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	@if [ "$(MAKECMDGOALS)" != "clean" ] || [ "$(MAKECMDGOALS)" = "all" ] || [ -z $(MAKECMDGOALS) ]; \
	then \
		$(MAKE) -C ${OPEN_MODEL_ZOO} INSTALL=${INSTALL_PARAM} EXIT_ON_REQ_NOT_MET=${EXIT_PARAM}; \
	fi; \
	$(eval INSTALL_PARAM = "no")
	@$(MAKE) -C $@ $(MAKECMDGOALS) INSTALL=${INSTALL_PARAM} EXIT_ON_REQ_NOT_MET=${EXIT_PARAM}; \
	echo $(GREEN)"\nAppZoo: "$(YELLOW)"Finished: making "$@ $(MAKECMDGOALS)"\n"$(NOCOLOR)

.PHONY: $(TOPTARGETS) $(SUBDIRS)

.PHONY: install_reqs
install_reqs:
	@echo ${YELLOW}"Checking Software Dependencies...\n"${NOCOLOR}
	@if [ -e /opt/intel/openvino/bin/setupvars.sh ] || [ "${InferenceEngine_DIR}" != "" ]; \
	then \
		echo "OpenVINO is installed."; \
	else \
		echo ${YELLOW}"The Intel Distribution of OpenVINO is not installed, or you have not added the open source OpenVINO \n Deep Learning Development Toolkit libraries \
		to your path. Go to https://software.intel.com/en-us/openvino-toolkit to install" ${NOCOLOR}; \
		exit 1; \
	fi;
	@if [ -z ${INTEL_OPENVINO_DIR} ] || [ "${InferenceEngine_DIR}" = "" ]; \
	then \
		echo ${YELLOW}"OpenVINO environment variables are not set - please source the setupvars.sh script located in your OpenVINO install directory \n	or add the environment variables to your shell's configuration file."${NOCOLOR}; \
	fi;

	@if [ ! command -v python3 2>/dev/null ]; \
	then \
		echo ${YELLOW}"Python 3 is not installed or the Python 3 interpreter is not in your shell's path. Install this through your package manager to continue."; \
		exit 1; \
	fi;

	@if [ ! command -v pip3 2>/dev/null ]; \
	then \
		echo ${YELLOW}"Pip for Python 3 is not installed or the package is not in your system PATH. Install this through your package manager to continue or adjsut your path."; \
		exit 1;\
	fi;

	@if [ ! command -v git 2>/dev/null ]; \
	then \
		echo ${YELLOW}"Git is not installed. Install this through your package manager to continue."; \
		exit 1;\
	fi;

.PHONY: help
help:
	@echo "\nPossible Make targets"
	@echo $(YELLOW)"  make help "$(NOCOLOR)"- shows this message"
	@echo $(YELLOW)"  make all "$(NOCOLOR)"- Makes all targets"
	@echo $(YELLOW)"  make clean "$(NOCOLOR)"- Removes all temp files from all directories"
	@echo $(YELLOW)"  make compile_model "$(NOCOLOR)"- Runs compile on all caffe/tensorflow models"

