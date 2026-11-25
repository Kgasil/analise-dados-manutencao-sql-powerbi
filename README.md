# Análise de Indicadores Operacionais e Manutenção (SQL & BI)

Projeto demonstrativo focado em **Engenharia de Produção, Confiabilidade Operacional e Análise de Dados**, estruturando consultas SQL para monitoramento de paradas de máquina (*downtime*), cálculo de **MTTR** e acompanhamento de planos de ação **5W2H**.
> 🌐 *English version available below:* [Jump to English Version](#english-version)
---

## 🎯 Contexto e Problema

Sem o registro estruturado de ordens de serviço e histórico de falhas, equipes operacionais atuam apenas de forma reativa, dificultando a identificação de equipamentos gargalo e o direcionamento de manutenções preventivas.

## 🚀 Solução Implementada

O script `analise_manutencao.sql` modela uma base relacional de ativos e ordens de manutenção e disponibiliza consultas prontas para consumo em **Power BI** ou **Excel**:

* **Análise de Downtime & Custos:** Consolidação de horas paradas e gastos com peças por ativo e linha de produção.
* **Cálculo de MTTR (*Mean Time To Repair*):** Tempo médio de reparo em intervenções corretivas para avaliar agilidade de atendimento.
* **Mix de Manutenção:** Comparativo percentual entre intervenções preventivas, preditivas e corretivas.
* **Rastreabilidade de Causa Raiz (5W2H):** Extração direta das principais causas de falha vinculadas às ações corretivas propostas.
* **Limpeza e Cruzamento de Dados (`limpeza_e_cruzamento.py`):** Higieniza textos e códigos de ativos, remove duplicidades e registros inválidos, cruza ordens de manutenção com o cadastro de ativos e consolida horas paradas e custos.

## 🛠️ Tecnologias Utilizadas

* **SQL** (DDL, DML, `JOIN`, `GROUP BY`, Window Functions `OVER()`)
* **Indicadores Industriais & Qualidade:** MTTR, Downtime, Manutenção Preventiva/Preditiva, 5W2H
* **Integração BI:** Estrutura pronta para conexão via Power BI / Power Query
---

## Reprodução e escopo

Execute `analise_manutencao.sql` em uma base de teste vazia (SQLite moderno ou banco compatível, adaptando o dialeto se necessário). Execute `python limpeza_e_cruzamento.py` com Python 3.9+ para visualizar os dados fictícios embutidos. O Python usa somente a biblioteca padrão e uma amostra diferente da base SQL. O MTTR é estimado pelas horas de parada corretiva. Não há arquivo PBIX nem cálculo de MTBF no repositório.

---

<a id="english-version"></a>

# Operational & Maintenance KPI Analysis (SQL & BI)

Demonstrative project focused on **Industrial Engineering**, **Operational Reliability**, and **Data Analysis**, structuring SQL queries for machine downtime monitoring, **MTTR** calculation, and **5W2H** action plan tracking.

## 🎯 Context & Problem

Without structured work order logging and failure history, operational teams tend to act reactively, making it harder to identify bottleneck assets and prioritize preventive maintenance.

## 🚀 Implemented Solution

The `analise_manutencao.sql` script models a relational database for assets and maintenance work orders and provides analytical queries ready for **Power BI** or **Excel**:

* **Downtime & Cost Analysis:** Consolidates downtime hours and spare parts costs by asset and production line.
* **MTTR Calculation (*Mean Time To Repair*):** Measures average repair time in corrective interventions to evaluate response speed.
* **Maintenance Mix:** Compares percentages across preventive, predictive, and corrective maintenance.
* **Root Cause Traceability (5W2H):** Extracts key failure causes linked to proposed corrective actions.
* **Data Cleaning & Joining (`limpeza_e_cruzamento.py`):** Sanitizes text and asset codes, removes duplicates and invalid records, joins work orders with asset master data, and summarizes downtime and costs.

## 🛠️ Technologies Used

* **SQL (DDL, DML, `JOIN`, `GROUP BY`, Window Functions `OVER()`)**
* **Industrial & Quality Metrics:** MTTR, Downtime, Preventive/Predictive Maintenance, 5W2H
* **BI Integration:** Ready for **Power BI / Power Query** consumption

## Reproduction and scope

Run the SQL file on a fresh test database (modern SQLite or a compatible engine). Run `python limpeza_e_cruzamento.py` with Python 3.9+ for a separate embedded synthetic dataset. No external Python libraries are needed. MTTR is estimated from corrective downtime; no PBIX dashboard or MTBF calculation is included.

---

## Testes automatizados / Automated tests

Execute na pasta do projeto / Run from the repository folder:

```bash
python -m unittest -v test_limpeza
```

Os testes verificam a limpeza dos dados fictícios, deduplicação, totais e valores inválidos. / Tests cover synthetic data cleansing, deduplication, totals and invalid values.
