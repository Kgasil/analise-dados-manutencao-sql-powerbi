-- ============================================================================
-- Projeto: Análise de Indicadores de Manutenção & Confiabilidade (KPIs)
-- Autor: Kaio Gabriel da Silva
-- Descrição: Estruturação de base operacional, carga de dados fictícios e
--            queries analíticas para cálculo de Downtime, MTTR, MTBF e 5W2H.
-- ============================================================================

-- 1. Criação das Tabelas
CREATE TABLE equipamentos (
    id_equipamento INT PRIMARY KEY,
    codigo_ativo VARCHAR(20) NOT NULL,
    nome_equipamento VARCHAR(100) NOT NULL,
    linha_producao VARCHAR(50) NOT NULL,
    criticidade VARCHAR(20) NOT NULL
);

CREATE TABLE ordens_manutencao (
    id_os INT PRIMARY KEY,
    id_equipamento INT NOT NULL,
    tipo_manutencao VARCHAR(30) NOT NULL, -- 'Preventiva', 'Corretiva', 'Preditiva'
    data_abertura TIMESTAMP NOT NULL,
    data_conclusao TIMESTAMP NOT NULL,
    tempo_parada_horas DECIMAL(10, 2) NOT NULL,
    custo_pecas DECIMAL(10, 2) NOT NULL,
    causa_raiz VARCHAR(150),
    acao_5w2h VARCHAR(255),
    FOREIGN KEY (id_equipamento) REFERENCES equipamentos(id_equipamento)
);

-- 2. Inserção de Dados Demonstrativos (Fictícios)
INSERT INTO equipamentos VALUES
(1, 'AT-101', 'Misturador Industrial A1', 'Linha Química 01', 'Alta'),
(2, 'AT-102', 'Envase Automático B2', 'Linha Química 01', 'Alta'),
(3, 'AT-201', 'Compressor de Ar Central', 'Utilidades', 'Crítica'),
(4, 'AT-202', 'Esteira Transportadora C1', 'Embalagem', 'Média');

INSERT INTO ordens_manutencao VALUES
(1001, 1, 'Corretiva',  '2026-10-02 08:00:00', '2026-10-02 12:30:00', 4.50, 1250.00, 'Desgaste de selo mecânico', 'Substituição preventiva trimestral do selo'),
(1002, 2, 'Preventiva', '2026-10-05 14:00:00', '2026-10-05 16:00:00', 2.00,  320.00, 'Lubrificação e ajuste de sensor', 'Manter cronograma quinzenal de inspeção'),
(1003, 3, 'Corretiva',  '2026-10-10 06:15:00', '2026-10-10 13:45:00', 7.50, 3400.00, 'Superaquecimento por obstrução de filtro', 'Instalar alerta de diferencial de pressão'),
(1004, 1, 'Corretiva',  '2026-10-18 09:30:00', '2026-10-18 12:30:00', 3.00,  890.00, 'Falha no acoplamento do motor', 'Alinhamento a laser na próxima parada'),
(1005, 4, 'Preditiva',  '2026-10-22 10:00:00', '2026-10-22 11:30:00', 1.50,  150.00, 'Análise de vibração em rolamento', 'Troca programada do rolamento em 30 dias'),
(1006, 2, 'Corretiva',  '2026-10-27 15:00:00', '2026-10-27 19:00:00', 4.00,  980.00, 'Travamento de válvula pneumática', 'Revisão da rede de ar comprimido');

-- ============================================================================
-- 3. Queries Analíticas (KPIs para Dashboard Power BI / Excel)
-- ============================================================================

-- Query A: Tempo Total de Parada (Downtime) e Custo por Equipamento
SELECT 
    e.codigo_ativo,
    e.nome_equipamento,
    e.linha_producao,
    COUNT(o.id_os) AS total_intervencoes,
    SUM(o.tempo_parada_horas) AS horas_paradas_total,
    SUM(o.custo_pecas) AS custo_total_pecas
FROM equipamentos e
LEFT JOIN ordens_manutencao o ON e.id_equipamento = o.id_equipamento
GROUP BY e.codigo_ativo, e.nome_equipamento, e.linha_producao
ORDER BY horas_paradas_total DESC;

-- Query B: MTTR (Mean Time To Repair - Tempo Médio de Reparo em Corretivas)
SELECT 
    e.codigo_ativo,
    e.nome_equipamento,
    COUNT(o.id_os) AS qtd_falhas_corretivas,
    ROUND(AVG(o.tempo_parada_horas), 2) AS mttr_horas
FROM equipamentos e
INNER JOIN ordens_manutencao o ON e.id_equipamento = o.id_equipamento
WHERE o.tipo_manutencao = 'Corretiva'
GROUP BY e.codigo_ativo, e.nome_equipamento
ORDER BY mttr_horas DESC;

-- Query C: Proporção Preventiva vs. Corretiva (Eficiência do Planejamento)
SELECT 
    tipo_manutencao,
    COUNT(*) AS quantidade_os,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentual_os,
    SUM(tempo_parada_horas) AS total_horas
FROM ordens_manutencao
GROUP BY tipo_manutencao;

-- Query D: Ranking de Causas Raiz e Planos de Ação (Suporte 5W2H)
SELECT 
    e.linha_producao,
    e.nome_equipamento,
    o.causa_raiz,
    o.acao_5w2h,
    o.tempo_parada_horas,
    o.custo_pecas
FROM ordens_manutencao o
INNER JOIN equipamentos e ON o.id_equipamento = e.id_equipamento
WHERE o.tipo_manutencao = 'Corretiva'
ORDER BY o.tempo_parada_horas DESC;
