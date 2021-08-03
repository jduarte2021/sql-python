-- 1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?

SELECT MONTHNAME(charged_datetime) as mes, SUM(amount) as ingresos
FROM billing
WHERE MONTHNAME(charged_datetime) = 'March';

-- 2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?

SELECT client_id, SUM(amount) 
FROM billing 
WHERE client_id = 2;

-- 3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?

SELECT domain_name as Dominio, client_id 
FROM sites
WHERE client_id = 10;

-- 4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por
-- mes por año para el cliente con una identificación de 1? ¿Qué pasa con el cliente = 20?

SELECT *
FROM sites;

SELECT client_id AS cliente, COUNT(domain_name) AS cantidad_de_sitios, MONTHNAME(created_datetime) AS mes, YEAR(created_datetime) AS año
FROM sites
WHERE client_id ='1'
GROUP BY mes;

SELECT client_id AS cliente, COUNT(domain_name) AS cantidad_de_sitios, MONTHNAME(created_datetime) AS mes, YEAR(created_datetime) AS año
FROM sites
WHERE client_id ='20'
GROUP BY mes;

-- 5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios entre 
-- el 1 de enero de 2011 y el 15 de febrero de 2011?

SELECT *
FROM leads;

SELECT sites.domain_name AS pagina, leads.leads_id AS guias, DATE_FORMAT(leads.registered_datetime, '%d/%m/%Y') as fecha
FROM sites
JOIN leads ON sites.site_id = leads.leads_id
WHERE leads.registered_datetime BETWEEN '2011-01-01' AND '2011-02-15';

-- 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes 
-- potenciales que hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?

SELECT clients.first_name, clients.last_name, COUNT(leads.registered_datetime) AS total
FROM clients
JOIN sites ON clients.client_id = sites.site_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY clients.first_name
ORDER BY total DESC;

-- 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
-- que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?

SELECT CONCAT(clients.first_name,' ', clients.last_name) AS nombre, COUNT(leads.registered_datetime) AS total, MONTHNAME(leads.registered_datetime) AS mes
FROM clients
JOIN sites ON clients.client_id = sites.site_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01' AND '2011-06-31'
GROUP BY nombre
ORDER BY mes;


-- 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes 
-- potenciales que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 
-- y el 31 de diciembre de 2011? Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre 
-- todos los clientes, los nombres del sitio y el número total de clientes potenciales generados en cada sitio en todo momento.

SELECT clients.first_name, clients.last_name, sites.domain_name, COUNT(leads.registered_datetime) AS total, DATE_FORMAT(MIN(leads.registered_datetime), '%d/%m/%Y') as fecha
FROM clients
JOIN sites ON clients.client_id = sites.site_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY clients.first_name, clients.last_name, clients.client_id, sites.domain_name
ORDER BY clients.first_name, clients.last_name, sites.domain_name;

-- 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. 
-- Pídalo por ID de cliente.

SELECT CONCAT(clients.first_name,' ',clients.last_name) AS nombre, SUM(billing.amount) AS total, MONTHNAME(charged_datetime) AS mes, YEAR(billing.charged_datetime) AS año
FROM billing
JOIN clients ON billing.client_id = clients.client_id
JOIN sites ON clients.client_id = sites.site_id
JOIN leads ON sites.site_id = leads.site_id
GROUP BY nombre,año, mes
ORDER BY nombre,año;

-- 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados 
-- para que cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo 
-- llamado 'sitios' que tiene todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)

SELECT CONCAT(clients.first_name,' ',clients.last_name) AS nombre, GROUP_CONCAT(DISTINCT sites.domain_name) AS sitios
FROM billing
JOIN clients ON billing.client_id = clients.client_id
JOIN sites ON clients.client_id = sites.site_id
JOIN leads ON sites.site_id = leads.site_id
GROUP BY nombre;


-- SELECT *FROM sites
-- GROUP BY client_id;

-- SELECT *
-- FROM billing
-- JOIN clients ON billing.client_id = clients.client_id
-- JOIN sites ON clients.client_id = sites.site_id
-- JOIN leads ON sites.site_id = leads.site_id
