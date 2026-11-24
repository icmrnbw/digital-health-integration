> **Машинный перевод, требуется проверка человеком.** Эта страница автоматически переведена с английского языка с помощью искусственного интеллекта и пока не проверена редактором. При любых расхождениях приоритет имеет оригинальная англоязычная версия.

Blood Recipient History Observation фиксирует одну часть анамнеза, собранного у реципиента перед переливанием крови: трансфузионный или акушерский анамнез. `code` указывает, какой именно, а значение берётся из соответствующего ValueSet. [Blood Transfusion Assessment Observation](StructureDefinition-blood-transfusion-assessment-observation.html) для единицы крови перечисляет использованный анамнез в `derivedFrom`. Профиль основан на [UZ Core Observation](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-observation.html), поэтому для чтения и поиска используйте конечную точку Observation. Субъект - реципиент, [UZ Core Patient](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-patient.html). Как профиль сочетается с профилями UZ Core в работе службы крови, от регистрации донора до трансфузии, описано на странице [Blood Service](blood-service.html).

### Обязательные элементы данных и элементы Must Support

Перечисленные ниже элементы должны присутствовать всегда (обязательные) или должны поддерживаться, когда данные доступны ([Must Support](https://dhp.uz/fhir/core/ru/must-support.html)) - не все они являются обязательными, но ваша система должна заполнять каждый элемент Must Support, когда у неё есть соответствующие данные, и обрабатывать его при получении. Это удобочитаемая сводка; [формальные представления](#profile) ниже дают точные кардинальности, типы и терминологические связки.

#### Каждое Blood Recipient History Observation должно иметь

Каждое Blood Recipient History Observation должно содержать status, code - *трансфузионный анамнез* или *акушерский анамнез* - и subject - [Patient](https://dhp.uz/fhir/core/ru/StructureDefinition-uz-core-patient.html)-реципиента (1..1). Компонентов нет.

#### Каждое Blood Recipient History Observation должно поддерживать

- категорию анамнеза (`valueCodeableConcept`) из ValueSet, соответствующего коду;
- причину отсутствия значения (`dataAbsentReason`);
- Encounter и исполнителя - медицинского работника, собравшего анамнез;
- время сбора анамнеза (`effective[x]`);
- остальные элементы Must Support, унаследованные от UZ Core Observation.

| `code` | `valueCodeableConcept` из |
|---|---|
| `bldcomp-0001-00003` (трансфузионный анамнез) | [Категория трансфузионного анамнеза](ValueSet-blood-transfusion-history-vs.html) |
| `bldcomp-0001-00004` (акушерский анамнез) | [Категория акушерского анамнеза реципиента](ValueSet-blood-recipient-obstetric-history-vs.html) |

Если анамнез неприменим, например акушерский анамнез у мужчины, передайте `dataAbsentReason` `not-applicable` вместо значения. Если его не удалось выяснить, передайте `unknown`.

### Построение JSON шаг за шагом

Примеры ниже показывают трансфузионный анамнез и неприменимый акушерский анамнез. Скопируйте один из них и адаптируйте - каждое показанное значение проходит валидацию по этому профилю. Полные эталонные экземпляры: [трансфузионный анамнез](Observation-example-blood-recipient-transfusion-history.html) и [акушерский анамнез](Observation-example-blood-recipient-obstetric-history.html).

#### Трансфузионный анамнез

Коды взяты из [кодов оценки перед переливанием крови](CodeSystem-blood-transfusion-assessment-cs.html) и [категорий трансфузионного анамнеза](CodeSystem-blood-transfusion-history-cs.html):

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00003",
        "display": "Transfuzion anamnez"
      }
    ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  "valueCodeableConcept": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-history-cs",
        "code": "bldcomp-0003-00001",
        "display": "Avval qon quyilmagan"
      }
    ]
  }
}
```

#### Неприменимый акушерский анамнез

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00004",
        "display": "Akusherlik anamnezi"
      }
    ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  "dataAbsentReason": {
    "coding": [ { "system": "http://terminology.hl7.org/CodeSystem/data-absent-reason", "code": "not-applicable" } ]
  }
}
```

Примеры API-вызовов см. в разделе [Быстрый старт](#quick-start) внизу этой страницы.
