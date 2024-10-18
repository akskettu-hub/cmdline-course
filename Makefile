BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
NO_MD_BOOKS=$(BOOKS:%=data/%.no_md.txt)
PARSEDBOOKS=$(BOOKS:%=results/%.parsed.txt))

all: $(FREQLISTS) $(SENTEDBOOKS) $(PARSEDBOOKS) results/all.freq.txt results/all.sent.txt

clean:
	rm -f results/* data/*no_md.txt 

%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< > $@

results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< > $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< > $@

data/all.no_md.txt: $(NO_MD_BOOKS)
	cat $^ > $@

no_md: $(NO_MD_BOOKS)

results/%.parsed.txt: results/%.sent.txt
	python3 src/parse.py $< $@
