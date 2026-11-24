> **Машинный перевод, требуется проверка человеком.** Эта страница автоматически переведена с английского языка с помощью искусственного интеллекта и пока не проверена редактором. При любых расхождениях приоритет имеет оригинальная англоязычная версия.

Blood Transfusion Assessment Observation фиксирует пробы на совместимость между реципиентом и одной единицей крови: совместимость по ABO, совместимость по Rh-Hr и биологическую пробу в начале переливания, каждую в своём компоненте. Записывайте одно Observation на единицу и указывайте в `focus` её [BiologicallyDerivedProduct](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-biologically-derived-product.html), если она известна. Анамнез реципиента передаётся в [Blood Recipient History Observation](StructureDefinition-blood-recipient-history-observation.html), а предварительная группа крови ABO - в [UZ Core Observation](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-observation.html) с кодом LOINC `883-9`; оценка перечисляет их в `derivedFrom`. Профиль основан на [UZ Core Observation](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-observation.html), поэтому для чтения и поиска используйте конечную точку Observation. Субъект - реципиент, [UZ Core Patient](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-patient.html); запись может ссылаться на [Encounter](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-encounter.html) переливания и на медицинского работника, который провёл пробы. Как профиль сочетается с профилями UZ Core в работе службы крови, от регистрации донора до трансфузии, описано на странице [Blood Service](blood-service.html).

### Обязательные элементы данных и элементы Must Support

Перечисленные ниже элементы должны присутствовать всегда (обязательные) или должны поддерживаться, когда данные доступны ([Must Support](https://dhp.uz/fhir/core/ru/must-support.html)) - не все они являются обязательными, но ваша система должна заполнять каждый элемент Must Support, когда у неё есть соответствующие данные, и обрабатывать его при получении. Это удобочитаемая сводка; [формальные представления](#profile) ниже дают точные кардинальности, типы и терминологические связки.

#### Каждое Blood Transfusion Assessment Observation должно иметь

Каждое Blood Transfusion Assessment Observation должно содержать status, code - всегда SNOMED CT `252314007` *Blood transfusion test* - и subject - [Patient](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-patient.html)-реципиента (1..1). Элемента `value` нет: результаты проб передаются в компонентах.

#### Каждое Blood Transfusion Assessment Observation должно поддерживать

- бизнес-идентификатор оценки;
- проверяемую единицу крови (`focus`);
- Encounter переливания и исполнителя - медицинского работника, его роль или организацию, ответственных за пробы;
- время проведения проб (`effective[x]`) и время выдачи результата (`issued`);
- результаты совместимости по ABO и по Rh-Hr, каждый в своём компоненте;
- результат биологической пробы в своём компоненте;
- остальные элементы Must Support, унаследованные от UZ Core Observation, включая `derivedFrom`.

### Построение JSON шаг за шагом

Примеры ниже идут от наименьшего экземпляра, который примет сервер, до полной оценки. Скопируйте один из них и адаптируйте - каждое показанное значение проходит валидацию по этому профилю. Полный эталонный экземпляр: [оценка единицы эритроцитов](Observation-example-blood-transfusion-assessment.html).

#### Минимальное наблюдение, которое следует отправлять

Обязательны три элемента: `status`, `code`, указывающий, что это проба на переливание крови, и `subject` ([Patient](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-patient.html)-реципиент). Добавьте также `effectiveDateTime` проб: результат без времени нельзя соотнести с переливанием.

```json
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [ { "system": "http://snomed.info/sct", "code": "252314007", "display": "Blood transfusion test" } ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:30:00+05:00"
}
```

`subject` - обычный `Reference`, поэтому цель указывается непосредственно в `reference`.

#### Полная оценка

Каждая проба передаётся в своём срезе `component`. Каждый срез необязателен и встречается не более одного раза; `code` выбирает срез, а `valueCodeableConcept` должен быть из ValueSet этого среза:

| Срез | `code` | `valueCodeableConcept` из |
|---|---|---|
| `aboCompatibility` | `bldcomp-0001-00001` | [Результат совместимости крови](ValueSet-blood-compatibility-result-vs.html) (SNOMED CT) |
| `rhHrCompatibility` | `bldcomp-0001-00002` | [Результат совместимости крови](ValueSet-blood-compatibility-result-vs.html) (SNOMED CT) |
| `biologicalTest` | `bldcomp-0001-00006` | [Положительный / отрицательный результат](ValueSet-positive-negative-result-vs.html) (SNOMED CT) |

Коды компонентов взяты из [кодов оценки перед переливанием крови](CodeSystem-blood-transfusion-assessment-cs.html):

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [ { "system": "http://snomed.info/sct", "code": "252314007", "display": "Blood transfusion test" } ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "encounter": { "reference": "Encounter/example-transfusion-assessment-encounter" },
  "focus": [ { "reference": "BiologicallyDerivedProduct/example-blood-component-product" } ],
  "effectiveDateTime": "2026-11-11T10:30:00+05:00",
  "issued": "2026-11-11T10:35:00+05:00",
  "performer": [ { "reference": "Practitioner/example-transfusion-assessment-practitioner" } ],
  "derivedFrom": [
    { "reference": "Observation/example-blood-recipient-transfusion-history" },
    { "reference": "Observation/example-blood-recipient-blood-group" }
  ],
  "component": [
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00001",
            "display": "ABO bo‘yicha moslik"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "250405008", "display": "Blood compatible" } ]
      }
    },
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00002",
            "display": "Rh-Hr bo‘yicha moslik"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "250405008", "display": "Blood compatible" } ]
      }
    },
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00006",
            "display": "Biologik sinama"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "260385009", "display": "Negative" } ]
      }
    }
  ]
}
```

Примеры API-вызовов см. в разделе [Быстрый старт](#quick-start) внизу этой страницы.
