# Build the whitepaper: `make`.
#
# Uses latexmk when it is on PATH; otherwise tectonic, from PATH or from a git-ignored .tools/ directory here.
#
#   make        rebuild main.pdf (always: main.pdf is tracked, so file times cannot be trusted), check the log, lint
#   make pdf    rebuild main.pdf only
#   make check  fail unless main.log exists and reports no undefined reference or citation
#   make lint   fail on a page count outside MINPAGES..MAXPAGES, a bibliography entry without a `verified` field,
#               banned wording, or a word the fixed vocabulary replaces. Comment lines are not linted; a line ending
#               in "% lint: allow" is exempt from the banned-wording check.
#   make clean  remove build by-products (keeps main.pdf)

TECTONIC := $(or $(shell command -v tectonic 2>/dev/null),$(abspath $(CURDIR)/.tools/tectonic))
LATEXMK  := $(shell command -v latexmk 2>/dev/null)

MINPAGES := 9
MAXPAGES := 15
BANNED   := sybil-?proof|\bguarantee|\bprevents\b|\bsolves\b|\\begin\{theorem\}|revolutionary|seamless|cutting-edge|game-chang|\bunlock|TODO|TBD|\[call\]|\[decided\]|\[found\]|Crypto Mondays|Genesis|\bNFT\b|mint\.bonfires
REPLACED := adopter|adopters|staker|stakers
# Wording of the mechanism the uptake rewrite superseded: none of it may remain.
STALE    := own nodes?|its own user|per node per epoch|three parties|independent nodes?|joins? by (staking|locking)|price of a grammar|\bpaid uses?
# The retired symbol b, matched with case (Bonfire B is a name in the figures).
STALESYM := \$$b\$$
# Terms of the current mechanism: each must appear somewhere. Separated by ";".
REQUIRED := signals its grammar;lookup;adoption;breadth;governing stake;stakeholder;n_0

.PHONY: all pdf check lint clean
.DEFAULT_GOAL := all

all:
	@$(MAKE) --no-print-directory pdf
	@$(MAKE) --no-print-directory check
	@$(MAKE) --no-print-directory lint

pdf:
	rm -f main.log
ifneq ($(LATEXMK),)
	$(LATEXMK) -g -pdf -interaction=nonstopmode -halt-on-error main.tex
else
	@test -x "$(TECTONIC)" || { echo "neither latexmk on PATH nor $(TECTONIC) found" >&2; exit 2; }
	"$(TECTONIC)" --keep-logs main.tex
endif

check:
	@test -f main.log || { echo "main.log is missing: build first (make pdf)" >&2; exit 1; }
	@if grep -E "undefined (reference|citation)|Citation .* undefined|Reference .* undefined|There were undefined" main.log; then \
	  echo "main.log reports undefined references or citations" >&2; exit 1; \
	else echo "main.log: no undefined references or citations"; fi

lint:
	@fail=0; \
	pages=$$(sed -nE 's/.*Output written on main\.[a-z]+ \(([0-9]+) page.*/\1/p' main.log 2>/dev/null | tail -1); \
	if [ -z "$$pages" ]; then echo "lint: no page count in main.log (build first)" >&2; fail=1; \
	elif [ "$$pages" -lt $(MINPAGES) ] || [ "$$pages" -gt $(MAXPAGES) ]; then \
	  echo "lint: $$pages pages, want $(MINPAGES) to $(MAXPAGES)" >&2; fail=1; \
	else echo "lint: $$pages pages"; fi; \
	unv=$$(awk '/^@/ { if (key != "" && !v) print key; key=$$0; v=0 } /verified[ \t]*=/ { v=1 } END { if (key != "" && !v) print key }' refs.bib); \
	if [ -n "$$unv" ]; then echo "lint: entry without verified field:" >&2; echo "$$unv" >&2; fail=1; fi; \
	hits=$$(grep -rniE '$(BANNED)' main.tex sections figures | grep -vE ':[0-9]+:[[:space:]]*%' | grep -v '% lint: allow'); \
	if [ -n "$$hits" ]; then echo "lint: banned wording:" >&2; printf '%s\n' "$$hits" >&2; fail=1; fi; \
	words=$$(grep -rnwiE '$(REPLACED)' sections | grep -vE ':[0-9]+:[[:space:]]*%'); \
	if [ -n "$$words" ]; then echo "lint: use reader or backer:" >&2; printf '%s\n' "$$words" >&2; fail=1; fi; \
	stale=$$( { grep -rniE '$(STALE)' main.tex sections figures; grep -rnE '$(STALESYM)' main.tex sections figures; } | grep -vE ':[0-9]+:[[:space:]]*%'); \
	if [ -n "$$stale" ]; then echo "lint: wording of the superseded mechanism:" >&2; printf '%s\n' "$$stale" >&2; fail=1; fi; \
	missing=$$(printf '%s\n' '$(REQUIRED)' | tr ';' '\n' | while IFS= read -r term; do \
	  grep -rhvE '^[[:space:]]*%' main.tex sections | grep -qiF -- "$$term" || echo "lint: missing term: $$term"; done); \
	if [ -n "$$missing" ]; then printf '%s\n' "$$missing" >&2; fail=1; fi; \
	if [ $$fail -eq 0 ]; then echo "lint: clean"; else exit 1; fi

clean:
	rm -f main.aux main.log main.bbl main.blg main.out main.toc main.fls main.fdb_latexmk main.synctex.gz
