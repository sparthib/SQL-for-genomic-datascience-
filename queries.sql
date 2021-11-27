/* qsn 1 Print the sum of each spot from the counts table.  */ 
SELECT SUM(gene_counts) FROM Counts 
GROUP BY(spot_id); 

/* qsn 2 Print the ratio of number of spots with zero cells to those 
with more than zero cells. */ 

WITH Z AS SELECT COUNT(spot_id) as zeros FROM SpotData
WHERE cell_count = 0,
WITH N SELECT COUNT(spot_id) as non_zeros FROM SpotData
WHERE cell_count > 0,
SELECT zeros/non_zeros FROM Z, N; 

/* qsn 3 Print the pixel row and pixel columns of all spots that 
align with Layer 1 of the brain.*/ 

SELECT pixel_row, pixel_col FROM SpotData 
WHERE layer = 'layer1'; 

/*qsn 4 
Give the number of expressed genes for all spots that are located in the 
lower right quadrant of the spot grid. (all genes for which counts > 0).
*/ 

SELECT SUM(gene_counts), spot_id FROM Counts NATURAL JOIN SpotData
GROUP BY(spot_id) WHERE 
spot_row > MAX(spot_row)/2 AND 
spot_col > MAX(spot_col)/ 2;

/* qsn 5 Select the spot with the highest proportion of mitochondrial genes. */ 

WITH M AS SELECT COUNT(*) FROM Counts NATURAL JOIN GeneData 
WHERE GeneData LIKE '%mt%',

WITH NM AS SELECT COUNT(*) FROM Counts NATURAL JOIN GeneData
WHERE GeneData NOT LIKE '%mt%',

WITH X AS SELECT SUM(*) AS mito_sum, spot_id FROM M GROUP BY spot_id, 

WITH Y AS SELECT SUM(*) AS nonmito_sum, spot_id FROM N GROUP BY spot_id,

SELECT spot_id, mito_sum/nonmito_sum AS proportion FROM X NATURAL JOIN Y 

ORDER BY DESC  proportion LIMIT 1; 


/* qsn 6 Give the name of the institution with the most number of users, 
the number of users,  and the date when the first user joined. 
*/ 

WITH U AS SELECT instituion_id, COUNT(*) as num_usersFROM Users GROUP BY institution_id,

SELECT name, num_users, user_name FROM Instituitions NATURAL JOIN U NATURAL JOIN Users 

WHERE num_users = (SELECT MAX(num_users) FROM U) 

ORDER BY date_joined LIMIT 1;

/*qsn 7 Print the number of users that are not based in Baltimore. 
*/ 

SELECT COUNT(*) FROM USERS NATURAL JOIN Instituitions NATURAL JOIN
Zipcodes WHERE City != 'Baltimore'; 

/* qsn 8 Print the email IDs of all people who work at the 
same institution as John Doe. */ 

WITH J AS SELECT instituion_id FROM Users
WHERE fname = 'John' , lname = 'Doe'
SELECT emailID FROM Users WHERE 
instituion_id = SELECT instituion_id FROM J; 

/* qsn 9 Print the first and last names of people who previously worked at 
Johns Hopkins but currently work for another institution.  */ 

SELECT U.fname, U.lname FROM Users AS U, Users AS V 
NATURAL JOIN Instituitions
WHERE U.user_id = V.user_id AND
WHERE U.date_joined < V.date_joined AND 
U.instituion_id = I.instituion_id AND 
I.name = 'Johns Hopkins University'; 


/* qsn 10 
List all sample ids and brain regions where time 
between scanning tissue sample and transferring data to 
directory was more than 48 hours, and the user it was scanned by. 
*/
SELECT sample_id, br_region, scanned_by FROM TissueSample WHERE
    tr_date >= scan_date + 2;
