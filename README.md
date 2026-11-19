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

<a id="english-version"></a>

# Operational & Maintenance KPI Analysis (SQL & BI)

Demonstrative project focused on **Industrial Engineering**, **Operational Reliability**, and **Data Analysis**, structuring SQL queries for machine downtime monitoring, **MTTR** calculation, and **5W2H** action plan tracking[cite: 7].

## 🎯 Context & Problem

Without structured work order logging and failure history, operational teams tend to act reactively, making it harder to identify bottleneck assets and prioritize preventive maintenance[cite: 7].

## 🚀 Implemented Solution

The `analise_manutencao.sql` script models a relational database for assets and maintenance work orders and provides analytical queries ready for **Power BI** or **Excel**[cite: 7]:

* **Downtime & Cost Analysis:** Consolidates downtime hours and spare parts costs by asset and production line[cite: 7].
* **MTTR Calculation (*Mean Time To Repair*):** Measures average repair time in corrective interventions to evaluate response speed[cite: 7].
* **Maintenance Mix:** Compares percentages across preventive, predictive, and corrective maintenance[cite: 7].
* **Root Cause Traceability (5W2H):** Extracts key failure causes linked to proposed corrective actions[cite: 7].
* **Data Cleaning & Joining (`limpeza_e_cruzamento.py`):** Sanitizes text and asset codes, removes duplicates and invalid records, joins work orders with asset master data, and summarizes downtime and costs[cite: 7].

## 🛠️ Technologies Used

* **SQL (DDL, DML, `JOIN`, `GROUP BY`, Window Functions `OVER()`)**[cite: 7]
* **Industrial & Quality Metrics:** MTTR, Downtime, Preventive/Predictive Maintenance, 5W2H[cite: 7]
* **BI Integration:** Ready for **Power BI / Power Query** consumption[cite: 7]
