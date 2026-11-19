# Análise de Indicadores Operacionais e Manutenção (SQL & BI)

Projeto demonstrativo focado em **Engenharia de Produção, Confiabilidade Operacional e Análise de Dados**, estruturando consultas SQL para monitoramento de paradas de máquina (*downtime*), cálculo de **MTTR** e acompanhamento de planos de ação **5W2H**.

---

## 🎯 Contexto e Problema

Sem o registro estruturado de ordens de serviço e histórico de falhas, equipes operacionais atuam apenas de forma reativa, dificultando a identificação de equipamentos gargalo e o direcionamento de manutenções preventivas.

## 🚀 Solução Implementada

O script `analise_manutencao.sql` modela uma base relacional de ativos e ordens de manutenção e disponibiliza consultas prontas para consumo em **Power BI** ou **Excel**:

* **Análise de Downtime & Custos:** Consolidação de horas paradas e gastos com peças por ativo e linha de produção.
* **Cálculo de MTTR (*Mean Time To Repair*):** Tempo médio de reparo em intervenções corretivas para avaliar agilidade de atendimento.
* **Mix de Manutenção:** Comparativo percentual entre intervenções preventivas, preditivas e corretivas.
* **Rastreabilidade de Causa Raiz (5W2H):** Extração direta das principais causas de falha vinculadas às ações corretivas propostas.

## 🛠️ Tecnologias Utilizadas

* **SQL** (DDL, DML, `JOIN`, `GROUP BY`, Window Functions `OVER()`)
* **Indicadores Industriais & Qualidade:** MTTR, Downtime, Manutenção Preventiva/Preditiva, 5W2H
* **Integração BI:** Estrutura pronta para conexão via Power BI / Power Query
