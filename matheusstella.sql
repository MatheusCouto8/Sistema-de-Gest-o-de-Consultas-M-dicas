/*feito pelo bloco de notas*/

CREATE DATABASE clinica;

CREATE TABLE pacientes (
id_paciente SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
idade INT NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL
);

INSERT INTO pacientes (nome, idade, email) VALUES
('Bruno', 18, 'brunorodrigues@gmail.com'),
('Mateus', 20, 'mateusmarcelino@gmail.com'),
('Luiz', 19, 'luizgomes@gmail.com'),
('Kevin', 24, 'kevin777@gmail.com'),
('Isaias', 62, 'isaiass65@gmail.com'),
('Marcelo', 48, 'silvane9008@gmail.com'),
('João', 22, 'vjoão8@gmail.com');

CREATE TABLE medicos (
id_medico SERIAL PRIMARY KEY,
nome VARCHAR(100),
especialidade VARCHAR(150)
);

INSERT INTO medicos (nome, especialidade) VALUES
('Sabrina', 'Neorologista'),
('Vitor', 'Dermatologista'),
('Ana', 'Cardiologista'),
('Liza', 'Oftalmologista'),
('Lindomar', 'Pediatra'),
('Osmar', 'Oftalmologista'),
('Paula', 'Dermatologista'),
('Rayssa', 'Pediatra');

CREATE TABLE consultas (
id_consulta SERIAL PRIMARY KEY,
id_paciente INT NOT NULL,
id_medico INT NOT NULL,
data_consulta DATE,
CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

INSERT INTO consultas (id_paciente, id_medico, data_consulta) VALUES
(1, 2, '2024-12-02');
INSERT INTO consultas (id_paciente, id_medico, data_consulta) VALUES
(2, 3, '2024-12-13');
INSERT INTO consultas (id_paciente, id_medico, data_consulta) VALUES
(3, 4, '2024-10-31');
INSERT INTO consultas (id_paciente, id_medico, data_consulta) VALUES
(4, 5, '2024-12-27');
INSERT INTO consultas (id_paciente, id_medico, data_consulta) VALUES
(5, 6, '2025-01-06');
INSERT INTO consultas (id_paciente, id_medico, data_consulta) VALUES
(7, 6, '2025-01-08');

/*mostra todos*/
SELECT
c.id_consulta,
p.nome AS nome_paciente,
p.idade,
p.email,
m.nome AS nome_medico,
m.especialidade,
c.data_consulta
FROM
consultas c
JOIN
pacientes p ON c.id_paciente = p.id_paciente
JOIN
medicos m ON c.id_medico = m.id_medico;

/*mostra as consultas que ainda não aconteceram*/
SELECT
c.id_consulta,
p.nome AS nome_paciente,
p.idade,
p.email,
m.nome AS nome_medico,
m.especialidade,
c.data_consulta
FROM
consultas c
JOIN
pacientes p ON c.id_paciente = p.id_paciente
JOIN
medicos m ON c.id_medico = m.id_medico
WHERE
c.data_consulta < CURRENT_DATE;

/*mostra os que não tem consulta*/
SELECT
p.id_paciente,
p.nome AS nome_paciente,
p.idade,
p.email
FROM
pacientes p
LEFT JOIN
consultas c ON p.id_paciente = c.id_paciente
WHERE
c.id_consulta IS NULL;

/*mostra os médicos que não tem consulta*/
SELECT
m.nome,
m.especialidade
FROM
medicos m
LEFT JOIN
consultas c ON m.id_medico = c.id_medico
WHERE
c.id_consulta IS NULL;