import unittest
from limpeza_e_cruzamento import (
    csv_ordens_bruto, csv_ativos_bruto, limpar_ordens,
    limpar_ativos, cruzar_e_resumir, normalizar_codigo,
)


class TestLimpeza(unittest.TestCase):
    def test_normalizacao(self):
        self.assertEqual(normalizar_codigo(" eq_01 "), "EQ-01")

    def test_amostra_demonstrativa(self):
        ordens = limpar_ordens(csv_ordens_bruto)
        self.assertEqual(len(ordens), 2)
        self.assertAlmostEqual(sum(o["horas_paradas"] for o in ordens), 6.5)
        self.assertAlmostEqual(sum(o["custo_pecas"] for o in ordens), 1150.5)
        resultado = cruzar_e_resumir(ordens, limpar_ativos(csv_ativos_bruto))
        self.assertEqual(resultado[0]["linha_producao"], "Linha A")
        self.assertEqual(resultado[1]["linha_producao"], "Linha B")

    def test_numeros_invalidos(self):
        base = "codigo_ativo,tipo_manutencao,horas_paradas,custo_pecas\nEQ-01,Corretiva,nan,10\nEQ-02,Corretiva,1,inf\n"
        self.assertEqual(limpar_ordens(base), [])

    def test_ativo_sem_cadastro(self):
        resultado = cruzar_e_resumir([{"codigo_ativo": "EQ-99"}], {})
        self.assertEqual(resultado[0]["linha_producao"], "Sem cadastro")


if __name__ == "__main__":
    unittest.main()
