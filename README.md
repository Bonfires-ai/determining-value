# Determining Value in the Space of Ideas

Version 2 of a whitepaper by Carlos A. Vera (Bonfires.ai). The current draft is [`main.pdf`](main.pdf).

## What it is about

Most of what a group knows is worked out in conversation and stays there. The paper proposes a protocol under which
that discourse becomes something of value to the people who took part in it and to their community.

- **The unit** is the *construction* of Fluid Construction Grammar: a pairing of a form, a meaning and an effect.
  The protocol requires that applying one to a text be deterministic, so a use can be re-executed by anyone.
- **A Bonfire** is a community with a grammar. Membership is free, and members whose contributions become
  constructions earn stake.
- **Adoption** starts from need. A Bonfire that cannot read something looks it up in the grammars others have
  published, tries the constructions that read it, and adopts those that go on working.
- **Worth is breadth.** A construction is paid according to how many independent Bonfires have adopted it and still
  hold it, with nothing below a threshold.
- **Stake** answers the one question that cannot be computed: whether several Bonfires are really one party.

## Status

This is a draft specification with an argument. It is a proposal, and it is open for criticism.

- Constructions, their teaching and a tally of their use inside one group are built, in
  [memory-kernel](https://github.com/Bonfires-ai/memory-kernel). The network of Bonfires and nodes is proposed here
  and is not built.
- The security statement is a proposition with its assumptions and limits listed, not a proof.
- Section 11 of the paper lists the open problems. Several are basic: the shape of the reward, how a judged
  challenge is decided, whether the engine is deterministic across machines, and whether breadth can be bought.
- `claims.csv` records, for every claim that cites a source, what was opened and whether it supports the sentence.
  No row has yet been checked by a person.

## Building

```bash
make        # builds main.pdf, checks for undefined references, and runs the lint
```

The build uses `latexmk` when it is on your `PATH`, and otherwise [`tectonic`](https://tectonic-typesetting.github.io/)
(from your `PATH`, or a binary placed at `.tools/tectonic`). `make lint` enforces the page limit, the fixed
vocabulary, and that every bibliography entry says how it was verified.

## Contributing

Criticism of the mechanism is the most useful contribution. See [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Licence

The text and figures are licensed under [Creative Commons Attribution 4.0 International](LICENSE). You may share
and adapt them with attribution.

## Citing

> Carlos A. Vera. *Determining Value in the Space of Ideas*, version 2. Draft, 2026.
> https://github.com/Bonfires-ai/determining-value
