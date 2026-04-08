
/*
Projeto: Análise de Conversão e Performance de Indicações (MGM)
Objetivo: Identificar a taxa de conversão de leads indicados e o perfil dos indicadores.
PASSO 1: Selecionamos os clientes que indicaram (Referrers) e os amigos que foram indicados (Leads).
*/

SELECT c.nome AS cliente_indicador,
    COUNT(i.id_indicado) AS total_indicacoes_feitas,
    
    --Aqui contamos apenas as indicações que viraram conversão
    SUM(CASE WHEN i.status_venda = 'Concluída' THEN 1 ELSE 0 END) AS indicacoes_convertidas,
    
    -- E então calculamos a Taxa de Conversão de cada cliente
    ROUND(
        (SUM(CASE WHEN i.status_venda = 'Concluída' THEN 1 ELSE 0 END) * 100.0) / 
        NULLIF(COUNT(i.id_indicado), 0), 2
    ) AS percentual_conversao_percent

FROM clientes c
LEFT JOIN indicacoes i ON c.id_cliente = i.id_indicador
GROUP BY c.nome
HAVING COUNT(i.id_indicado) > 0
ORDER BY indicacoes_convertidas DESC;

/*
Com essa query, conseguimos identificar nossos "Super Promotores".
Clientes com alta taxa de conversão devem receber benefícios exclusivos do programa para continuarem engajados (além de zerar a conta).

Obs: 
Eu usei o NULLIF para evitar o erro de divisão por zero. Como estou calculando uma taxa (divisão), se um cliente não tiver nenhuma indicação,
o divisor seria zero e o banco de dados travaria. O NULLIF transforma esse zero em vazio (Nulo), fazendo com que o cálculo ignore esse erro 
e o script continue rodando.
*/
