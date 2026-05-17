-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
WHERE persona.tipo = 'alumno'
ORDER BY persona.apellido1 ASC;


-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades. (nombre, apellido1, apellido2)
SELECT 
persona.nombre,
persona.apellido1,
persona.apellido2
FROM persona
WHERE persona.telefono IS NULL;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999. (id, nombre, apellido1, apellido2, fecha_nacimiento)
SELECT 
persona.id,
persona.nombre,
persona.apellido1,
persona.apellido2,
persona.fecha_nacimiento
FROM persona
WHERE persona.fecha_nacimiento BETWEEN '1998-12-31' AND '2000-01-01';


-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K. (nombre, apellido1, apellido2, nif)
SELECT 
persona.nombre,
persona.apellido1,
persona.apellido2,
persona.nif
FROM persona 
WHERE persona.tipo = 'profesor' 
AND persona.telefono IS NULL 
AND persona.nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7. (id, nombre, cuatrimestre, curso, id_grado)
SELECT
asignatura.id,
asignatura.nombre,
asignatura.cuatrimestre,
asignatura.curso,
asignatura.id_grado
FROM asignatura
WHERE asignatura.id_grado = 7 
AND asignatura.curso = 3 
AND asignatura.cuatrimestre = 1;


-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom. (apellido1, apellido2, nombre, departamento)
SELECT 
persona.apellido1,
persona.apellido2,
persona.nombre,
departamento.nombre AS departamento
FROM persona
JOIN profesor ON profesor.id_profesor = persona.id
JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY persona.apellido1 ASC , persona.nombre ASC;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M. (nombre, anyo_inicio, anyo_fin)
SELECT 
asignatura.nombre,
curso_escolar.anyo_inicio,
curso_escolar.anyo_fin
FROM persona
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
WHERE persona.nif = '26902806M';

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015). (nombre)
SELECT DISTINCT
departamento.nombre AS nombre
FROM departamento
JOIN profesor ON profesor.id_departamento = departamento.id
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019. (nombre, apellido1, apellido2)
SELECT DISTINCT
persona.nombre,
persona.apellido1,
persona.apellido2
FROM persona
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;


-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 10. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. (departamento, apellido1, apellido2, nombre)
SELECT 
departamento.nombre AS departamento,
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
JOIN profesor ON profesor.id_profesor = persona.id
LEFT JOIN departamento ON departamento.id = profesor.id_departamento
ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;


-- 11. Retorna un llistat amb els professors/es que no estan associats a un departament. (apellido1, apellido2, nombre)
SELECT 
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
JOIN profesor ON profesor.id_profesor = persona.id
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.id IS NULL;

-- 12. Retorna un llistat amb els departaments que no tenen professors/es associats. (nombre)
SELECT 
departamento.nombre
FROM departamento
LEFT JOIN profesor ON profesor.id_departamento = departamento.id
WHERE profesor.id_departamento IS NULL;

-- 13. Retorna un llistat amb els professors/es que no imparteixen cap assignatura. (apellido1, apellido2, nombre)
SELECT 
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona 
JOIN profesor ON profesor.id_profesor = persona.id
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- 14. Retorna un llistat amb les assignatures que no tenen un professor/a assignat. (id, nombre)
SELECT
asignatura.id,
asignatura.nombre
FROM asignatura
LEFT JOIN profesor ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- 15. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar. (nombre)
SELECT DISTINCT
departamento.nombre
FROM departamento
LEFT JOIN profesor ON profesor.id_departamento = departamento.id
LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor
LEFT JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
WHERE alumno_se_matricula_asignatura.id_asignatura IS NULL;

-- 16. Retorna el nombre total d'alumnes que hi ha. (total)
SELECT
COUNT(persona.id) AS total
FROM persona
WHERE persona.tipo = 'alumno';

-- 17. Calcula quants alumnes van néixer en 1999. (total)
SELECT
COUNT(persona.id) AS total
FROM persona
WHERE persona.tipo = 'alumno'
AND persona.fecha_nacimiento BETWEEN '1998-12-31' AND '2000-01-01';

-- 18. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es. (departamento, total)
SELECT 
departamento.nombre AS departamento,
COUNT(profesor.id_profesor) AS total
FROM departamento
JOIN profesor ON profesor.id_departamento = departamento.id
GROUP BY departamento.id, departamento.nombre
ORDER BY total DESC;

-- 19. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat. (departamento, total)
SELECT 
departamento.nombre AS departamento,
COUNT(profesor.id_profesor) AS total
FROM departamento
LEFT JOIN profesor ON profesor.id_departamento = departamento.id
GROUP BY departamento.id, departamento.nombre;


-- 20. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures. (grau, total)
SELECT 
grado.nombre AS grau,
COUNT(asignatura.id) AS total
FROM grado
LEFT JOIN asignatura ON asignatura.id_grado = grado.id
GROUP BY grado.id, grado.nombre
ORDER BY total DESC;

-- 21. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades. (grau, total)
SELECT 
grado.nombre AS grau,
COUNT(asignatura.id) AS total
FROM grado
JOIN asignatura ON asignatura.id_grado = grado.id 
GROUP BY grado.id, grado.nombre
HAVING total > 40;


-- 22. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. (grau, tipus, total_creditos)
SELECT 
grado.nombre AS grau,
asignatura.tipo AS tipo,
SUM(asignatura.creditos) AS total_creditos
FROM grado 
JOIN asignatura ON asignatura.id_grado = grado.id
GROUP BY grado.id, grado.nombre, asignatura.tipo;


-- 23. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats. (anyo_inicio, total)
SELECT 
curso_escolar.anyo_inicio,
COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno) AS total
FROM curso_escolar
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
GROUP BY curso_escolar.anyo_inicio;


-- 24. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures. (id, nombre, apellido1, apellido2, total)
SELECT 
persona.id,
persona.nombre,
persona.apellido1,
persona.apellido2,
COUNT(asignatura.id) AS total
FROM persona 
JOIN profesor ON profesor.id_profesor = persona.id
LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor
GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2
ORDER BY total DESC;

-- 25. Retorna totes les dades de l'alumne/a més jove. (*)
SELECT
persona.id,
persona.nif,
persona.nombre,
persona.apellido1,
persona.apellido2,
persona.ciudad,
persona.direccion,
persona.telefono,
persona.fecha_nacimiento,
persona.sexo,
persona.tipo
FROM persona 
ORDER BY persona.fecha_nacimiento DESC
LIMIT 1;

-- 26. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura. (apellido1, apellido2, nombre)
SELECT 
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
JOIN profesor ON profesor.id_profesor = persona.id
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

