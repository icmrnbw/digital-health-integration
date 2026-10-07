# Form 066 DMED → DHP verification (newman)

Checks the form 066 document Bundle that DMED lev sent to the DHP playground, for one hospitalization,
against integration-066 v1.9. QA plan: see the "Form 066 DMED → DHP integration: QA plan" doc in this project.

## Run

    npm i -g newman
    newman run form-066-dhp-qa.postman_collection.json \
      -e dhp-playground.postman_environment.json \
      --env-var token_url=<SSO token URL> --env-var client_id=<id> --env-var client_secret=<secret> \
      --env-var hospitalization_id=<DMED hospitalization_id> \
      --env-var "dmed_form_json=$(cat <dmed form 066 JSON for that hospitalization>.json)" \
      -r cli,junit

Optional variables: `access_token` (skip the token call), `previous_composition_id` (after a re-save, D3),
`search_count` (default 100 document Bundles scanned), `skip_validate`, `expect_standalone_resources`.

## Rebuild after editing the checks

    node src/build.js .            # re-reads src/*.test.js and src/conceptmaps.json
    python3 src/parse_cm.py <DMEDForm066*EnumCM.fsh> > src/conceptmaps.json   # refresh ConceptMaps

ConceptMaps come from icmrnbw/digital-health-integration branch feature/066-dmed-enum-conceptmaps.

## Self-test (no network)

    node src/mock-dhp.js 8099 selftest/bundle-appB.json &
    newman run form-066-dhp-qa.postman_collection.json --env-var fhir_base=http://127.0.0.1:8099/fhir \
      --env-var hospitalization_id=MRN-066-2026-0001 --env-var "dmed_form_json=$(cat selftest/dmed-fixture-matching-appB.json)"

Result on 2026-10-07: 71/74 pass. The 3 failures are contradictions inside the doc's Appendix B example
(admitSource vs has_direction, reAdmission set on false, death Conditions in a discharged case).
