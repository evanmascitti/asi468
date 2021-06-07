#DATA_OBJECTS = notdir($(wildcard ./data-raw/*.R))
DATA_OBJECTS = $(notdir $(wildcard ./data-raw/*.R) )

all: data

data: $(patsubst %.R,./data/%.rda,$(DATA_OBJECTS))
# seems to works fine
# data: $(wildcard data-raw/*.R) $(shell find ./data-raw -name "*.csv" -type f)
#	@echo -e Updated prerequisite files are $?
#	Rscript $(filter %.R,$?)

# not quite working
#data/%.rda: data-raw/%.R $(shell find ./data-raw -name "*.csv" -type f)
#	@echo -e Updated prerequisite files are $?
#	$ifeq($?,, Rscript $(filter %.R,$?)


data/%.rda: data-raw/%.R $(shell find ./data-raw -name "*.csv" -type f)
	@echo -e Updated prerequisite files are $?
	Rscript $<

#install: data
#	Rscript -e 'devtools::install()'

data_check:
	@echo -e data-raw prep files are $(DATA_OBJECTS)
	@echo -e data objects are $(patsubst %.R,./data/%.rda,$(DATA_OBJECTS))

