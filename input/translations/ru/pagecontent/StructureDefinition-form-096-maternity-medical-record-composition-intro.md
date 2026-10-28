См. [маппинг полей формы 096](form-096-mapping.html) и [полный пример документа](Bundle-example-form-096-maternity-medical-record.html).

> Machine-translated supporting documentation; clinical coding and canonical URIs are unchanged.

Все клинические разделы необязательны (0..1); при отсутствии факта в источнике раздел или ресурс пропускается.
Не подставлять нули, отрицательные утверждения, компоненты Апгар или оценку на пятой минуте. Апгар DMED — сумма на первой минуте (LOINC 9272-6).
Composition.author и обязательные метаданные FHIR/Core сохраняются. Необязательность клинической секции не отменяет авторство.
Использовать точные канонические Coding.system с подтверждённым определением. Наличие CodeSystem в открытом PR не заменяет согласование и развёртывание.
При отсутствии машинного кода допустим достоверный исходный текст в разрешённом поле; похожий международный код не подставляется по догадке.
Исход рождения: LOINC 63893-2 со SNOMED CT 281050002 Livebirth или 237364002 Stillbirth. Смерть после живорождения — отдельный факт.
Если период гибели известен, добавить Condition того же ребёнка: 237361005 до родов либо 237362003 во время родов.
При известной смерти без точной даты использовать Patient.deceasedBoolean=true; deceasedDateTime — только при наличии даты.
Анамнестические количества не рассчитываются из текущих родов; отсутствующие в DMED анамнестические показатели пропускаются.
Общие факты родов в 096 и 097 сохраняют субъектом мать и её госпитализацию и используют стабильные идентификаторы исходных фактов.
Снимок в документе исторический. Сам POST документа не обеспечивает обновление самостоятельного мастер-Encounter.

Use UZ Core Encounter for the maternal hospitalization shared with Form 066; discharge disposition and custodian are optional. Pelvimetry is represented by six separate maternal Observations; diagonal conjugate uses SNOMED CT 249011002. The anatomical meaning of C. vera must not be silently narrowed. Эпидемиологический анамнез — необязательная открытая секция без фиксированного кодированного дискриминатора.

If a source author is identified but the position or role is unavailable, Composition.author may reference UZCorePractitioner directly. Do not invent a PractitionerRole or profession.
