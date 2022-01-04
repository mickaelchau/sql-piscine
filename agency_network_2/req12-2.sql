SELECT CASE WHEN length(acronym) = 4 THEN acronym ELSE substring(acronym from '[A-Z]*') || '0' || substring(acronym from '[0-9]') END AS acronym FROM destination ORDER BY acronym;
