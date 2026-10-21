# Form 111 terminology compatibility

Local concepts are identified by their canonical CodeSystem URL and code. The existing meanings in PR 69 at `9b1440ea58c41739dabfb0794d3a5bc5c5c40037` are retained. Removing a local concept in favour of a standard equivalent must never shift the remaining local numbers.

## Standard mappings

| Explicit source field/token | Standard target | Legacy local concept retained |
|---|---|---|
| `family_sexual_history.patient_bad_habits`: `smoking` | SNOMED CT `77176002` | `form111-patient-bad-habit-cs#chr-0020-00009` |
| `fetal_presentation`: `cephalic` | SNOMED CT `1209182005` | `form111-fetal-presentation-cs#chr-0015-00002` |
| `pregnancy_progress[].pregnancy_complications`: `anemia` | SNOMED CT `271737000` | `form111-pregnancy-complication-factor-cs#chr-0022-00002` |

The ValueSets accept the standard targets and the legacy local concepts. A selected risk factor remains an Observation; a diagnosis requires its own clinical confirmation.

References: [SNOMED International anemia terminology](https://docs.snomed.org/snomed-ct-specifications/snomed-ct-release-file-specification/reference-set-release-file-specification/5.2-reference-set-types/5.2.2.1-language-reference-set), [HL7 smoking terminology example](https://hl7.org.au/fhir/core/2.1.0-draft/Observation-smokingstatus-current-smoker.json.html), [NCBI terminology cross-reference for cephalic fetal presentation](https://www.ncbi.nlm.nih.gov/medgen/453352).

Combined `alcoholism_drug_addiction` and `smoking_alcoholism_drug_addiction` selections retain their single local target. Do not assert every individual factor from a combined selection. Gestosis retains its local concept until a clinical owner confirms an exact standard equivalent. Laboratory test codes remain local until the source establishes the analyte, specimen and method required by a proposed LOINC code.

## Result types

- Fetal movement (`LOINC 57088-7`) and the hospitalization flag (`chr-0035-00019`) use native `Observation.valueBoolean`.
- Birth-preparation fields contain a source activity date in `valueDateTime`. Gestational weeks are separate `valueQuantity` observations. Do not invent an activity frequency from the number of pregnancy weeks.
- `form111-previous-pregnancy-outcome-vs` contains only `386639001` (termination) and `3950001` (birth), matching the two explicit DMED tokens. An independent clinical history may contain more detail; the coarse token alone does not establish miscarriage subtype.
- `form111-previous-delivery-term-vs` contains only preterm and term. There is no implemented reserved post-term concept in this set.
- Perinatal risk level/score use `chr-0027-00005`/`chr-0027-00006`. The old General Observation duplicates `chr-0035-00023`/`chr-0035-00022` retain their meanings, are marked deprecated and are excluded from the current General Observation ValueSet.

## Automated check

After the IG build, run:

```sh
node scripts/check-form111-contract.cjs
# Optionally check JSON examples in the source integration document as well:
node scripts/check-form111-contract.cjs /absolute/path/to/integration-111.md
```

The check protects all 172 original local code identities, rejects duplicate codes/canonicals, resolves local codings and ConceptMap targets and checks the source-specific result types and combined-answer mappings. CI runs it after SUSHI.

Before integrating another branch, compare complete `system + code` pairs against this registry. Reusing an international code in another form is expected; assigning a different meaning to an existing local pair is a conflict. The 21 October 2026 audit found no Form 111 code collisions in main or in the other 18 open PRs. PR 120 is an alternative implementation with 44 conflicting local primary labels and must be aligned with this contract before combining the branches.
