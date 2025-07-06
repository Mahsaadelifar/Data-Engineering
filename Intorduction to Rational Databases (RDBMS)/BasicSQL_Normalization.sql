-- A tabel in 1NF : unique and non null rows + each cell holds one value only

-- Drop the tables if they're already there
DROP TABLE IF EXISTS BookShop;
DROP TABLE IF EXISTS BookShop_Authordetails;

-- create BookShop table 
CREATE TABLE BookShop(
BOOK_ID VARCHAR(4) NOT NULL,
TITLE VARCHAR(100) NOT NULL,
AUTHOR_NAME VARCHAR(30) NOT NULL,
AUTHOR_BIO VARCHAR(250) NOT NULL,
AUTHOR_ID INTEGER NOT NULL,
PUBLICATION_DATE DATE NOT NULL,
PRICE_USD DECIMAL CHECK(PRICE_USD>0) NOT NULL,
PRIMARY KEY(BOOK_ID)
);

-- Insert sample data
INSERT INTO BookShop VALUES
('B101', 'Introduction to Algorithms', 'Thomas H. Cormen', 'Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein. He is a Full Professor of computer science at Dartmouth College and currently Chair of the Dartmouth College Writing Program.', 123 , '2001-09-01', 125),
('B201', 'Structure and Interpretation of Computer Programs', 'Harold Abelson', ' Harold Abelson, Ph.D., is Class of 1922 Professor of Computer Science and Engineering in the Department of Electrical Engineering and Computer Science at MIT and a fellow of the IEEE.', 456, '1996-07-25', 65.5),
('B301', 'Deep Learning', 'Ian Goodfellow', 'Ian J. Goodfellow is a researcher working in machine learning, currently employed at Apple Inc. as its director of machine learning in the Special Projects Group. He was previously employed as a research scientist at Google Brain.', 369, '2016-11-01', 82.7),
('B401', 'Algorithms Unlocked', 'Thomas H. Cormen', 'Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein. He is a Full Professor of computer science at Dartmouth College and currently Chair of the Dartmouth College Writing Program.', 123, '2013-05-15', 36.5),
('B501', 'Machine Learning: A Probabilistic Perspective', 'Kevin P. Murphy', '', 157, '2012-08-24', 46);

-- Retrieve all documents
SELECT * FROM bookshop;


-- A table in 2NF : 1NF + create a seperate table for the values that appear to be the same for two or more rows
-- The bookshop table has author Thomas H. Cormen for the distict rows B101 and B401 and therefore AUTHOR_NAME, AUTHOR_BIO, and AUTHOR_ID will be seperated to a new table Bookshop_AuthorDetails with AUTHOR_ID as a foriegn key to Bookshop table and a primary key to BookShop_AuthorDetails

-- Create BookShop_AuthorDetails table
CREATE TABLE BookShop_AuthorDetails (
AUTHOR_ID INTEGER NOT NULL,
AUTHOR_NAME VARCHAR(30) NOT NULL,
AUTHOR_BIO VARCHAR(250) NOT NULL,
PRIMARY KEY(AUTHOR_ID)
);

-- Insert records from BookSHop table
INSERT INTO BookShop_AuthorDetails SELECT DISTINCT AUTHOR_ID, AUTHOR_NAME, AUTHOR_BIO FROM bookshop;

-- Show the contetc of BookShop_AuthorDetails
SELECT * FROM bookshop_AuthorDetails;

-- Alter the BookShop table and add Author ID as a foreign key and remove AUTHOR_NAME and AUTHOR_BIO
ALTER TABLE BookShop
ADD CONSTRAINT FK_AUTHOR_ID
FOREIGN KEY (AUTHOR_ID)
REFERENCES BookShop_AuthorDetails(AUTHOR_ID)
ON UPDATE NO ACTION
ON DELETE RESTRICT,
DROP COLUMN AUTHOR_NAME,
DROP COLUMN AUTHOR_BIO;

-- Show the contetc of BookShop
SELECT * FROM bookshop;


-- table in 3NF : 1NF + 2NF + mobe any column not dependent on the primary key to another table
-- Does not apply to this table since it's already in 3NF