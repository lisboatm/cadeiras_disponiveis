# Cadeiras Disponíveis

Este repositório contém a solução para o problena cadeiras disponíveis. O objetivo do desafio é identificar as cadeiras disponíveis consecutivas em filas de cadeiras, organizando-as por "left" e "right" em cada fila.

## Descrição do Desafio

Você recebeu uma tabela com as informações sobre as cadeiras de um auditório ou sala. Cada fila é representada pela coluna `queue`, e as cadeiras são identificadas pelo `id`. A coluna `available` indica se a cadeira está disponível (`TRUE`) ou não (`FALSE`).

O desafio é identificar quais cadeiras consecutivas estão disponíveis em cada fila, agrupando-as como pares de "left" (primeira cadeira disponível) e "right" (última cadeira disponível) dentro de cada fila. A saída deve exibir a fila (`queue`), a cadeira "left" e a cadeira "right" correspondente.

## Tabela de Entrada

A tabela de entrada contém três colunas:

- `id` (numeric): Identificador único da cadeira.
- `queue` (numeric): Identificador da fila.
- `available` (boolean): Indica se a cadeira está disponível ou não.

Exemplo de dados na tabela:

| id | queue | available |
|----|-------|-----------|
| 1  | 1     | FALSE     |
| 2  | 1     | FALSE     |
| 3  | 1     | TRUE      |
| 4  | 1     | FALSE     |
| 5  | 1     | FALSE     |
| 6  | 1     | FALSE     |
| 7  | 1     | TRUE      |
| 8  | 1     | TRUE      |
| 9  | 2     | TRUE      |
| 10 | 2     | FALSE     |
| ... | ...   | ...       |

## Saída Esperada

A saída esperada deve exibir o número da fila (`queue`), a primeira cadeira disponível consecutiva como "left_chair", e a última cadeira disponível consecutiva como "right_chair". O formato esperado para a saída é:

| queue | left_chair | right_chair |
|-------|------------|-------------|
| 1     | 7          | 8           |
| 2     | 11         | 12          |
| 2     | 14         | 15          |
| 3     | 21         | 22          |
| 4     | 28         | 29          |

## Lógica do Código

### 1. **Organização dos Dados**

A consulta SQL organiza os dados das cadeiras de cada fila, considerando as cadeiras disponíveis (com `available = TRUE`), e armazena as cadeiras consecutivas disponíveis como pares de "left" e "right" dentro de cada fila.

### 2. **Identificação de Cadeiras Consecutivas Disponíveis**

O código utiliza uma CTE (Common Table Expression) chamada `ConsecutiveChairs` para identificar cadeiras consecutivas disponíveis dentro de cada fila. Ele percorre as cadeiras de cada fila, verificando quais cadeiras estão consecutivamente disponíveis e as agrupa como pares de "left" e "right".

### 3. **Filtragem e Agrupamento**

Após identificar as cadeiras consecutivas, a consulta final filtra os resultados e organiza a saída, garantindo que os resultados estejam ordenados por `queue` (fila) e `left_chair` (cadeira esquerda).

### 4. **Saída Final**

A consulta retorna a tabela com o número da fila (`queue`), a cadeira "left" (primeira cadeira disponível) e a cadeira "right" (última cadeira disponível consecutiva).

## Como Executar

1. **Conexão com o Banco de Dados**

Conecte-se ao banco de dados PostgreSQL onde a tabela `chairs` está localizada.

2. **Execução da Consulta**

Execute a consulta SQL contida no código para obter a saída desejada com a lista de cadeiras consecutivas disponíveis para cada fila.

## Exemplo de Consulta SQL

```sql
WITH ConsecutiveChairs AS (
    SELECT
        queue,
        id AS chair_id,
        LEAD(id) OVER (PARTITION BY queue ORDER BY id) AS next_chair_id
    FROM chairs
    WHERE available = TRUE
)
SELECT
    queue,
    chair_id AS left_chair,
    next_chair_id AS right_chair
FROM ConsecutiveChairs
WHERE chair_id + 1 = next_chair_id
ORDER BY queue, left_chair;
```

## Contribuições

Este repositório é aberto para contribuições. Se você encontrar algum erro ou quiser sugerir melhorias, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
