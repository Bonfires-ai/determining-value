# Contributing

Thank you for reading the paper critically. There are three ways to help.

## 1. Attack the mechanism

Open an issue that describes a way to be paid without doing the work, or a rule that contradicts another. The most
useful reports say:

- who the attacker is and what they control (Bonfires, nodes, stake);
- what they do, step by step;
- what they earn and what it costs them;
- which rule or assumption of the paper you think should have stopped it.

Section 9 lists the attacks already considered and Section 11 the problems already known to be open. A report that
sharpens one of those is as welcome as a new one.

## 2. Check a source

`claims.csv` has one row for each claim that rests on a source: the claim, the source, what was opened, and whether
it supports the sentence. No row has been checked by a person. To check one, read the primary source, then open a
pull request that sets `human_verified` to your GitHub handle and the date, or an issue if the source does not say
what the paper says it does.

## 3. Change the text

Pull requests are welcome. Run `make` before you open one; it must end with `lint: clean`.

The paper follows a few rules, and the lint enforces some of them:

- **Short and linear.** Each section has one job. The page limit is 15.
- **Words before symbols.** Every rule is stated in plain words before any formula, and a formula appears only
  where it defines a rule.
- **Examples are thought experiments** and are labelled so. No real community, customer or person is an example.
- **No marketing language,** no product claims, no token sale, no supply figures. Issuance is specified elsewhere;
  the text says "the epoch budget".
- **Every status is explicit:** built, proposed, or untested.
- **A source is cited only after its primary text has been opened.** Each entry in `refs.bib` carries a `verified`
  field saying what was opened, and each new claim gets a row in `claims.csv`.
- **Fixed vocabulary and symbols.** They are listed in the comment at the top of `main.tex`. Use those words and no
  synonyms.
- **Open questions are written as open.** Do not state a requirement, such as determinism of the engine, as an
  observed fact.

A change to the mechanism itself should start as an issue, so that it can be argued before it is written.

## Licence of contributions

By contributing you agree that your contribution is licensed under the same licence as the paper, CC BY 4.0.
