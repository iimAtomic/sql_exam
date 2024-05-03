-- 1. Créer la vue ALL_WORKERS
CREATE VIEW ALL_WORKERS AS
SELECT last_name, first_name, NULL AS age, start_date
FROM WORKERS_FACTORY_2
WHERE end_date IS NULL
UNION ALL
SELECT last_name, first_name, age, first_day AS start_date
FROM WORKERS_FACTORY_1
WHERE last_day IS NULL
ORDER BY start_date DESC;


-- 2. Créer la vue ALL_WORKERS_ELAPSED
CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT last_name, first_name, age, start_date, 
       ROUND((SYSDATE - start_date), 0) AS days_elapsed
FROM ALL_WORKERS;

-- 3. Créer la vue BEST_SUPPLIERS
CREATE VIEW BEST_SUPPLIERS AS
SELECT s.name AS supplier_name, 
       SUM(sb.quantity) AS total_quantity_delivered
FROM SUPPLIERS_BRING_TO_FACTORY_1 sb
JOIN SUPPLIERS s ON sb.supplier_id = s.supplier_id
GROUP BY s.name
HAVING SUM(sb.quantity) > 1000
ORDER BY total_quantity_delivered DESC;

-- 4. Créer la vue ROBOTS_FACTORIES
CREATE VIEW ROBOTS_FACTORIES AS
SELECT r.id AS robot_id, r.model, f.main_location AS factory_location
FROM ROBOTS_FROM_FACTORY rf
JOIN ROBOTS r ON rf.robot_id = r.id
JOIN FACTORIES f ON rf.factory_id = f.id;
