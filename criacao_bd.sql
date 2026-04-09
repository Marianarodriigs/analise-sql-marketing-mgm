/* PASSO 1: Criação da base do banco de dados para simulação de onde os dados estão sendo extraidos 
para a contagem das converções.
*/

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    data_cadastro DATE,
    plano_atual VARCHAR(50) /* Ex: 'Premium', 'Standard' */
);


CREATE TABLE indicacoes (
    id_indicado INT PRIMARY KEY,
    id_indicador INT,
    nome_amigo_indicado VARCHAR(100),
    data_indicacao DATE,
    status_venda VARCHAR(50), -- 'Concluída', 'Pendente', 'Cancelada'
    FOREIGN KEY (id_indicador) REFERENCES clientes(id_cliente)
);
