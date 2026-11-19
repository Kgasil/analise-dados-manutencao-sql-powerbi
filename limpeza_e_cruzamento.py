import csv
import io
import re

# Base 1: simula ordens de serviço brutas com ruídos (espaços, duplicatas e valores inválidos)
csv_ordens_bruto = """codigo_ativo,tipo_manutencao,horas_paradas,custo_pecas
  eq-01 , Corretiva , 4.5 , 850.00
EQ-01,corretiva,4.5,850.00
eq-02, Preventiva , 2.0 , 300.50
eq-03 , Preditiva , -1.0 , 400.00
eq-04, Corretiva ,  , 1200.00
EQ-02,PREVENTIVA,2.0,300.50
"""

# Base 2: simula cadastro de ativos com formatação inconsistente
csv_ativos_bruto = """codigo_ativo,linha_producao,criticidade
 eq-01 , Linha A , Alta
eq_02, linha b , Média
EQ-03,Linha A,Baixa
eq-04, Linha C , Alta
"""


def normalizar_codigo(codigo: str) -> str:
    """Padroniza códigos de ativo (ex.: ' eq_01 ' -> 'EQ-01')."""
    limpo = re.sub(r"[^A-Za-z0-9]", "-", (codigo or "").strip().upper())
    return re.sub(r"-+", "-", limpo).strip("-")


def limpar_ordens(texto_csv: str) -> list[dict]:
    leitor = csv.DictReader(io.StringIO(texto_csv.strip()))
    vistos = set()
    limpos = []

    for linha in leitor:
        cod = normalizar_codigo(linha.get("codigo_ativo", ""))
        tipo = (linha.get("tipo_manutencao") or "").strip().capitalize()

        try:
            horas = float((linha.get("horas_paradas") or "").strip().replace(",", "."))
            custo = float((linha.get("custo_pecas") or "").strip().replace(",", "."))
        except ValueError:
            # Ignora linhas com valores ausentes ou inválidos
            continue

        if not cod or horas < 0 or custo < 0:
            continue

        chave_duplicidade = (cod, tipo, horas, custo)
        if chave_duplicidade in vistos:
            continue
        vistos.add(chave_duplicidade)

        limpos.append({
            "codigo_ativo": cod,
            "tipo_manutencao": tipo,
            "horas_paradas": horas,
            "custo_pecas": custo,
        })

    return limpos


def limpar_ativos(texto_csv: str) -> dict[str, dict]:
    leitor = csv.DictReader(io.StringIO(texto_csv.strip()))
    ativos = {}

    for linha in leitor:
        cod = normalizar_codigo(linha.get("codigo_ativo", ""))
        if not cod:
            continue
        ativos[cod] = {
            "linha_producao": (linha.get("linha_producao") or "Não informada").strip().title(),
            "criticidade": (linha.get("criticidade") or "Não informada").strip().capitalize(),
        }

    return ativos


def cruzar_e_resumir(ordens: list[dict], ativos: dict[str, dict]) -> list[dict]:
    consolidado = []
    for ordem in ordens:
        ativo_info = ativos.get(
            ordem["codigo_ativo"],
            {"linha_producao": "Sem cadastro", "criticidade": "Sem cadastro"},
        )
        consolidado.append({
            **ordem,
            **ativo_info,
        })
    return consolidado


if __name__ == "__main__":
    ordens_limpas = limpar_ordens(csv_ordens_bruto)
    ativos_limpos = limpar_ativos(csv_ativos_bruto)
    resultado = cruzar_e_resumir(ordens_limpas, ativos_limpos)

    print("=== BASE TRATADA E CRUZADA ===")
    for item in resultado:
        print(item)

    total_horas = sum(r["horas_paradas"] for r in resultado)
    total_custo = sum(r["custo_pecas"] for r in resultado)
    print(f"\nRegistros válidos após limpeza e deduplicação: {len(resultado)}")
    print(f"Total de horas paradas: {total_horas:.1f}h | Custo total de peças: R$ {total_custo:.2f}")
