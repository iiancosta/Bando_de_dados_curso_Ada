# PostgreSQL_curso_Ada
Nesse documento apresento meus aprendizados no módulo de Banco de Dados da trilha digital da Ada Tech.

## Documentação

A documentação do PostgreSQL é uma fonte abrangente e detalhada de informações sobre o sistema de gerenciamento de banco de dados PostgreSQL. Ela fornece orientações, referências e explicações detalhadas sobre todos os aspectos do PostgreSQL, desde a instalação até o uso avançado.

A documentação do PostgreSQL é altamente reconhecida por sua precisão, clareza e abrangência. É uma fonte valiosa de informações tanto para iniciantes quanto para usuários avançados, oferecendo detalhes técnicos, exemplos de uso e explicações conceituais.

Além disso, a documentação é frequentemente atualizada para acompanhar as versões mais recentes do PostgreSQL, garantindo que os usuários tenham acesso a informações atualizadas e precisas.

[Documentação do PostgreSQL](https://www.postgresql.org/docs/)

## Tipos de Dados no PostegreSQL
O PostgreSQL possui uma ampla variedade de tipos de dados, oferecendo suporte a muitos tipos diferentes para atender a diversas necessidades de armazenamento de dados. Em termos gerais, o PostgreSQL possui mais de 30 tipos de dados, que incluem:

| Categoria               | Exemplos de Tipos de Dados                           |
|-------------------------|------------------------------------------------------|
| **Numéricos**           | `INTEGER`, `BIGINT`, `SMALLINT`, `NUMERIC`, `REAL`, `DOUBLE PRECISION` |
| **Texto**               | `CHARACTER`, `VARCHAR`, `TEXT`                       |
| **Data e Hora**        | `DATE`, `TIME`, `TIMESTAMP`, `INTERVAL`              |
| **Booleanos**           | `BOOLEAN`                                            |
| **Binários**            | `BYTEA`                                              |
| **Geoespaciais**        | `POINT`, `LINESTRING`, `POLYGON`                     |
| **Arrays**              | `ARRAY`                                              |
| **Compostos**           | `RECORD`, `ROW`, `JSON`, `JSONB`                     |
| **Enumeração**          | `ENUM`                                               |
| **UUID**                | `UUID`                                               |
| **Rede**                | `CIDR`, `INET`                                       |

Cada tipo tem suas próprias características, limitações e usos específicos, permitindo aos usuários armazenar e manipular diferentes tipos de dados de forma eficaz e precisa.

## Entidades 

Em PostgreSQL, assim como em outros sistemas de gerenciamento de banco de dados relacionais, as "entidades" referem-se aos objetos que representam estruturas de dados dentro do banco. As entidades podem ser tabelas, vistas, índices, sequências, funções, entre outros elementos que compõem o esquema do banco de dados.

As tabelas são as entidades mais comuns e fundamentais. Elas consistem em linhas e colunas, onde cada linha representa uma instância de dados e cada coluna representa um atributo desse conjunto de dados. No PostgreSQL, você pode criar tabelas usando a linguagem SQL, por exemplo:

```sql
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INTEGER
);
```

Nesse exemplo, criamos uma tabela chamada `usuarios` com três colunas: `id`, `nome` e `idade`. O `id` é uma chave primária que será automaticamente preenchida por uma sequência (devido ao tipo `SERIAL`), garantindo unicidade para cada registro.

Além das tabelas, as visões (views) são entidades virtuais que representam conjuntos de dados baseados em consultas SQL. Elas não armazenam dados diretamente, mas oferecem uma maneira conveniente de visualizar dados de várias tabelas ou consultas complexas como se fossem tabelas regulares.

As sequências (sequences) são usadas tipicamente para gerar valores de chave primária ou valores sequenciais.

No PostgreSQL, cada entidade possui suas próprias características e propriedades, e elas interagem umas com as outras para formar a estrutura do banco de dados, permitindo a organização e manipulação dos dados de maneira eficiente e estruturada.

## Modelagem de Relacionamentos

Claro, a modelagem de relacionamentos no PostgreSQL, assim como em outros bancos de dados relacionais, envolve a maneira como você organiza as tabelas e define as relações entre elas para representar eficientemente os dados do seu domínio.

Existem diferentes tipos de relacionamentos que podem ser modelados:

1. **Relacionamento Um para Um (1:1)**:
   - É quando uma linha em uma tabela está associada a apenas uma linha em outra tabela e vice-versa. Por exemplo, imagine uma tabela de `pessoas` e uma tabela de `documentos`. Cada pessoa pode ter apenas um número de identidade (um passaporte), e cada número de identidade está associado a apenas uma pessoa.

2. **Relacionamento Um para Muitos (1:N)**:
   - Este é um dos relacionamentos mais comuns. Uma linha em uma tabela está associada a várias linhas em outra tabela. Por exemplo, em um banco de dados de um blog, um autor pode ter escrito muitos artigos, mas cada artigo pertence a apenas um autor.

3. **Relacionamento Muitos para Muitos (N:M)**:
   - Quando várias linhas em uma tabela podem se relacionar com várias linhas em outra tabela. Para representar isso no PostgreSQL, geralmente é necessário criar uma tabela intermediária, também conhecida como tabela de junção ou tabela associativa. Por exemplo, em um sistema de escola, onde os alunos podem estar matriculados em várias disciplinas e cada disciplina tem vários alunos.

Para criar esses relacionamentos no PostgreSQL, você utiliza as chaves estrangeiras (`FOREIGN KEY`) para estabelecer as conexões entre as tabelas. Por exemplo:

```sql
CREATE TABLE autor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE artigo (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200),
    conteudo TEXT,
    autor_id INTEGER REFERENCES autor(id)
);
```

Neste exemplo, a tabela `artigo` tem uma coluna `autor_id` que é uma chave estrangeira referenciando a coluna `id` na tabela `autor`. Isso estabelece um relacionamento Um para Muitos entre os autores e os artigos, onde um autor pode ter vários artigos.

Uma modelagem cuidadosa dos relacionamentos é essencial para garantir a integridade dos dados, a eficiência das consultas e a organização lógica do banco de dados no PostgreSQL.

## Normalização de dados

A normalização de dados no PostgreSQL, assim como em outros bancos de dados relacionais, é um processo de organização das tabelas e estruturação dos dados para minimizar a redundância, reduzir anomalias de atualização e garantir a consistência dos dados.

Existem várias formas normais (1NF, 2NF, 3NF, BCNF, entre outras) que ajudam a guiar esse processo. Aqui estão algumas práticas comuns para normalização de dados:

1. **Primeira Forma Normal (1NF)**:
   - Garante que cada coluna contenha apenas valores atômicos e não repetidos. Isso evita a duplicação de dados. Por exemplo, evitando listas separadas por vírgulas em uma única coluna.

2. **Segunda Forma Normal (2NF)**:
   - Todos os atributos não-chave são totalmente dependentes da chave primária. Isso significa que não deve haver dependências parciais de uma chave composta. Se necessário, isso pode envolver a separação de tabelas ou ajustes nas chaves primárias.
    - Exemplo: vamos supor que temos uma tabela de `Pedidos` que contém informações sobre pedidos de clientes. Esta tabela possui detalhes tanto sobre o pedido quanto sobre os produtos em cada pedido.

**Tabela Pedidos:**

| Pedido_ID | Cliente_ID | Nome_Cliente | Produto_ID | Nome_Produto | Quantidade |
|-----------|------------|--------------|------------|--------------|------------|
| 1         | 101        | John         | 501        | Laptop       | 2          |
| 1         | 101        | John         | 502        | Mouse        | 1          |
| 2         | 102        | Emily        | 503        | Teclado      | 1          |

Neste exemplo, a tabela não está em 2NF porque os atributos `Nome_Cliente` e `Nome_Produto` são dependentes da chave `Pedido_ID` e `Cliente_ID`, não da chave completa, que seria `(Pedido_ID, Produto_ID)`.

Para alcançar a 2NF, podemos dividir a tabela em duas:

**Tabela Pedidos:**

| Pedido_ID | Cliente_ID |
|-----------|------------|
| 1         | 101        |
| 2         | 102        |

**Tabela Detalhes_Pedidos:**

| Pedido_ID | Produto_ID | Quantidade |
|-----------|------------|------------|
| 1         | 501        | 2          |
| 1         | 502        | 1          |
| 2         | 503        | 1          |


3. **Terceira Forma Normal (3NF)**:
   - Elimina dependências transitivas, ou seja, atributos que não são dependentes diretamente da chave primária devem ser movidos para outra tabela. Isso reduz a redundância e evita problemas de atualização.
   - Exemplo: vamos estender o exemplo anterior e adicionar informações sobre os produtos, como seus preços.

**Tabela Produtos:**

| Produto_ID | Nome_Produto | Preco |
|------------|--------------|-------|
| 501        | Laptop       | 1200  |
| 502        | Mouse        | 20    |
| 503        | Teclado      | 50    |

Neste caso, a tabela `Detalhes_Pedidos` ainda não está em 3NF porque o atributo `Preco` é transitivamente dependente da chave `Pedido_ID`, não apenas diretamente do `Produto_ID`.

Para atingir a 3NF, podemos separar as informações de preço na tabela de `Produtos`, removendo essa dependência transitiva:

**Tabela Produtos:**

| Produto_ID | Nome_Produto |
|------------|--------------|
| 501        | Laptop       |
| 502        | Mouse        |
| 503        | Teclado      |

**Tabela Precos_Produtos:**

| Produto_ID | Preco |
|------------|-------|
| 501        | 1200  |
| 502        | 20    |
| 503        | 50    |

Assim, na Terceira Forma Normal, a informação de preço não está mais associada à tabela `Detalhes_Pedidos`, mas sim à tabela independente `Precos_Produtos`, eliminando a dependência transitiva e garantindo uma melhor estruturação dos dados.

A normalização não é um processo único e pode variar dependendo do contexto e das necessidades específicas do banco de dados. É uma prática importante para garantir a eficiência, integridade e manutenção dos dados ao longo do tempo.

## Criando tabelas
Para criar tabelas no PostgreSQL, você pode usar a linguagem SQL por meio do comando `CREATE TABLE`. Aqui está um exemplo simples de como criar uma tabela:

Suponha que desejamos criar uma tabela para armazenar informações de clientes com campos como `id`, `nome`, `email` e `idade`:

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    idade INTEGER
);
```

Neste exemplo:

- `clientes` é o nome da tabela que estamos criando.
- `id` é uma coluna que utilizou `SERIAL` como tipo de dado, o que implica que essa coluna será autoincrementada.
- `nome` é uma coluna do tipo `VARCHAR(100)`, que armazenará strings de até 100 caracteres.
- `email` é outra coluna do tipo `VARCHAR(100)` para armazenar endereços de e-mail.
- `idade` é uma coluna do tipo `INTEGER` para armazenar valores numéricos inteiros.

Além disso, o `PRIMARY KEY` na coluna `id` indica que essa coluna é a chave primária da tabela, ou seja, será única para cada linha e servirá como identificador único para cada registro na tabela.

Depois de executar esse comando no PostgreSQL, a tabela `clientes` será criada e estará pronta para armazenar dados de clientes com essas especificações de colunas.

### Relacionando tabelas

Para criar outra tabela e vinculá-la à tabela existente usando uma chave estrangeira, você pode seguir este exemplo:

Suponha que você deseje criar uma tabela para armazenar pedidos feitos por clientes, vinculando cada pedido a um cliente específico da tabela `clientes`.

```sql
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER,
    produto VARCHAR(100),
    quantidade INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```

Neste exemplo:

- `pedidos` é o nome da nova tabela que estamos criando.
- `id` é uma coluna que será usada como chave primária para identificar exclusivamente cada pedido.
- `cliente_id` é uma coluna que será usada para vincular este pedido a um cliente na tabela `clientes`.
- `produto` é uma coluna que armazenará o nome do produto relacionado ao pedido.
- `quantidade` é uma coluna para registrar a quantidade do produto no pedido.

A linha `FOREIGN KEY (cliente_id) REFERENCES clientes(id)` indica que a coluna `cliente_id` na tabela `pedidos` é uma chave estrangeira que referencia a coluna `id` na tabela `clientes`. Isso estabelece um vínculo entre os pedidos e os clientes, garantindo que só seja possível inserir valores na coluna `cliente_id` que existam na coluna `id` da tabela `clientes`.

Assim, ao criar e inserir dados nessas tabelas, você pode garantir que os pedidos estejam associados a clientes existentes na tabela `clientes`, mantendo a integridade referencial entre elas.

## Inserindo dados nas tabelas

Para inserir dados nas tabelas que criamos no exemplo anterior, você pode utilizar o comando `INSERT INTO` no PostgreSQL. Aqui está um exemplo de como inserir dados nas tabelas `clientes` e `pedidos`:

### Inserindo dados na tabela `clientes`:

```sql
INSERT INTO clientes (nome, email, idade) VALUES
    ('João', 'joao@email.com', 30),
    ('Maria', 'maria@email.com', 25);
```

Isso irá inserir dois registros na tabela `clientes`, um para o cliente João e outro para Maria, com seus respectivos emails e idades.

### Inserindo dados na tabela `pedidos`:

Supondo que os clientes João e Maria (com os IDs 1 e 2, respectivamente) fizeram pedidos:

```sql
INSERT INTO pedidos (cliente_id, produto, quantidade) VALUES
    (1, 'Laptop', 2),
    (2, 'Mouse', 1);
```

Esses comandos `INSERT INTO` inserem linhas nas tabelas `clientes` e `pedidos`, relacionando os pedidos aos clientes pelos IDs correspondentes.

Você pode ajustar os valores para refletir os dados reais que deseja inserir nas tabelas e garantir que os IDs dos clientes correspondam aos IDs inseridos anteriormente na tabela `clientes`.

### Inserção de dados por arquivo CSV

Para inserir dados de um arquivo CSV em uma tabela do PostgreSQL, você pode usar o comando `COPY`. Este comando permite carregar dados de um arquivo CSV diretamente para uma tabela no banco de dados. Certifique-se de que o arquivo CSV esteja acessível para o PostgreSQL e que a estrutura do arquivo corresponda à estrutura da tabela onde você deseja inserir os dados.

Aqui está um exemplo básico de como usar o `COPY` para inserir dados de um arquivo CSV em uma tabela:

Suponha que temos um arquivo CSV chamado `dados.csv` com dados a serem inseridos na tabela `minha_tabela`. A estrutura do arquivo CSV deve corresponder à estrutura da tabela `minha_tabela`.

```sql
COPY minha_tabela FROM '/caminho/para/seu/arquivo/dados.csv' DELIMITER ',' CSV HEADER;
```

Explicação:
- `minha_tabela`: Nome da tabela onde você deseja inserir os dados.
- `/caminho/para/seu/arquivo/dados.csv`: Caminho absoluto para o arquivo CSV.
- `DELIMITER ','`: Indica que o delimitador no arquivo CSV é a vírgula. Se o seu arquivo usar um delimitador diferente, você pode alterar essa parte do comando.
- `CSV HEADER`: Especifica que a primeira linha do arquivo CSV contém os cabeçalhos das colunas.

Certifique-se de que o usuário do PostgreSQL tenha permissões adequadas para acessar o arquivo no caminho especificado. Se o arquivo estiver localizado no servidor PostgreSQL, o caminho será relativo ao sistema de arquivos do servidor.

Lembre-se de substituir `minha_tabela` e o caminho para o arquivo CSV pelos nomes reais da sua tabela e caminho do arquivo.

## Editando e removendo dados

Para editar ou remover dados de um banco de dados PostgreSQL, você pode usar as cláusulas `UPDATE` e `DELETE` em consultas SQL.

### Editar dados com a cláusula UPDATE:

A cláusula `UPDATE` é usada para modificar registros em uma tabela.

Por exemplo, se você quiser alterar o nome de um cliente na tabela `clientes`:

```sql
UPDATE clientes
SET nome = 'Novo Nome'
WHERE cliente_id = 1;
```

Isso alterará o nome do cliente com `cliente_id` igual a 1 para 'Novo Nome'.

### Remover dados com a cláusula DELETE:

A cláusula `DELETE` é usada para remover registros de uma tabela.

Por exemplo, se você quiser excluir um cliente da tabela `clientes`:

```sql
DELETE FROM clientes
WHERE cliente_id = 2;
```

Isso excluirá o cliente com `cliente_id` igual a 2 da tabela.

⚠️⚠️⚠️ Tenha cuidado ao executar comandos `UPDATE` e `DELETE`, pois eles afetam diretamente os dados no banco de dados. Sempre faça backup dos dados importantes antes de realizar alterações significativas.⚠️⚠️⚠️

Antes de executar operações `UPDATE` ou `DELETE`, é recomendável testar as consultas usando uma cláusula `SELECT` para garantir que você está selecionando os registros corretos que serão afetados pela operação.

Além disso, dependendo das restrições e configurações do banco de dados, pode ser necessário considerar a integridade referencial para garantir que a remoção de dados não viole as relações entre tabelas.

## Permissionamento e views

No PostgreSQL, é possível controlar o acesso aos dados por meio de permissões e criar visualizações (views) para oferecer uma camada de abstração sobre os dados subjacentes. Vou explicar um pouco sobre ambos:

### Permissões no PostgreSQL:

O PostgreSQL possui um sistema de permissões robusto que permite controlar quem pode acessar, modificar ou executar operações em objetos do banco de dados, como tabelas, sequências, funções, etc.

- **GRANT e REVOKE:** Esses comandos são usados para conceder e revogar privilégios. Por exemplo, para conceder SELECT em uma tabela aos usuários:

    ```sql
    GRANT SELECT ON tabela TO usuario;
    ```

- **Roles (Funções):** Você pode criar roles (funções) que representam usuários ou grupos de usuários e atribuir permissões a essas roles.

    ```sql
    CREATE ROLE myrole;
    GRANT myrole TO usuario;
    ```

- **Níveis de Permissão:** As permissões podem ser concedidas em níveis de objeto específicos (tabelas, views, schemas) e podem ser configuradas para diferentes tipos de operações (SELECT, INSERT, UPDATE, DELETE).

### Views no PostgreSQL:

As views são consultas armazenadas que se comportam como tabelas virtuais. Elas podem simplificar consultas complexas ou expor apenas um subconjunto de dados para os usuários, mantendo a estrutura subjacente dos dados intacta.

- **Criar uma view:** Para criar uma view no PostgreSQL:

    ```sql
    CREATE VIEW nome_da_view AS
    SELECT coluna1, coluna2
    FROM tabela
    WHERE condição;
    ```

- **Usando Views:** Depois de criar uma view, você pode consultá-la da mesma forma que consulta uma tabela.

    ```sql
    SELECT * FROM nome_da_view;
    ```

- **Atualização de Views:** Em alguns casos, é possível atualizar os dados através de uma view (quando a view é simples o suficiente para permitir essa operação), usando regras ou triggers para redirecionar as operações de atualização para as tabelas subjacentes.

### Considerações sobre Segurança:

Ao usar views para controlar o acesso aos dados, é importante garantir que os usuários tenham permissões adequadas para acessar a view, mesmo que não tenham permissões diretas nas tabelas subjacentes.

As permissões devem ser configuradas de forma cuidadosa para garantir a segurança e a integridade dos dados, garantindo que os usuários só possam acessar, modificar ou excluir os dados conforme autorizado.

O uso conjunto de permissões e views pode oferecer um controle refinado sobre o acesso aos dados e simplificar o uso do banco de dados para diferentes usuários e aplicações.

## Índices no PostegreSQL

Os índices no PostgreSQL são estruturas que ajudam a acelerar consultas ao banco de dados, especialmente em tabelas grandes, permitindo um acesso mais rápido aos dados.

### Tipos de Índices no PostgreSQL:

1. **Índice B-Tree:**
   - Este é o tipo de índice padrão no PostgreSQL. É adequado para uma ampla gama de consultas e é eficaz na maioria dos casos.

   ```sql
   CREATE INDEX indice_nome ON tabela_usada (coluna);
   ```

2. **Índice Hash:**
   - Útil para consultas de igualdade, mas não funciona bem para intervalos ou comparações parciais.

   ```sql
   CREATE INDEX indice_hash ON tabela_usada USING hash (coluna);
   ```

3. **Índice GiST e GIN:**
   - São índices usados para dados complexos como arrays, geometrias, texto completo, etc.
   
   ```sql
   CREATE INDEX indice_gist ON tabela_usada USING gist (coluna);
   CREATE INDEX indice_gin ON tabela_usada USING gin (coluna);
   ```

### Uso de Índices:

- **Adição de Índices:**
  Ao criar um índice, você especifica a tabela, a coluna e o tipo de índice que deseja usar.

- **Remoção de Índices:**
  Você pode remover um índice existente com o comando `DROP INDEX`.

  ```sql
  DROP INDEX indice_nome;
  ```

### Considerações ao Usar Índices:

- **Custo de Manutenção:**
  Índices aceleram consultas, mas podem diminuir a velocidade de inserção/atualização, pois o banco de dados precisa manter os índices atualizados.

- **Escolha de Colunas para Índices:**
  Selecione cuidadosamente as colunas para criar índices. Colunas frequentemente usadas em cláusulas WHERE, JOIN, ou ORDER BY são bons candidatos para índices.

- **Análise do Planejador de Consultas:**
  O planejador de consultas do PostgreSQL geralmente é eficaz na escolha dos índices corretos, mas às vezes pode ser necessário ajustar manualmente com a cláusula `EXPLAIN`.

Os índices são uma ferramenta poderosa para otimizar o desempenho das consultas, mas devem ser usados com cuidado, considerando o equilíbrio entre o desempenho das consultas e o custo de manutenção dos índices durante operações de inserção/atualização.