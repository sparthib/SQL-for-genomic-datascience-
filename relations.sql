
CREATE TABLE Counts (gene_id char(10) not null, spot_id varchar(30) not null, gene_counts int,
PRIMARY KEY (gene_id, spot_id)
);

CREATE TABLE SpotData (
    spot_id varchar(30) not null,
    cell_count int,
    layer_name varchar(15),
    sample_id int,
    in_tissue int,
    array_row int,
    array_col int,
    pixel_row int,
    pixel_col int,
PRIMARY KEY (spot_id)
FOREIGN KEY (sample_id) REFERENCES TissueSample(sample_id)
);

CREATE TABLE GeneData (
    gene_id char(10) not null,
    gene_name varchar(15)
PRIMARY KEY (gene_id)
);

CREATE TABLE Institutions (
    institution_id char(6) not null,
    name varchar(30),
    street_address varchar(30),
    zip_code int
PRIMARY KEY (institution_id)
);

CREATE TABLE Users (
    user_id varchar(15) not null,
    fname varchar(25),
    lname varchar(25),
    password varchar(30),
    username varchar(15),
    institution_id char(6),
    date_joined date,
    emailID varchar(30),
    phone_num int
PRIMARY KEY (user_id),
);

CREATE TABLE Zipcodes (
    zipcode int not null,
    city varchar(15),
    state varchar(2)
);

CREATE TABLE TissueSample (
    sample_id int not null,
    br_region varchar(10),
    platform_num varchar(25),
    tr_time int,
    tr_date date,
    directory varchar(30),
    scanned_by varchar(15),
    scan_date date,
    scan_time int
PRIMARY KEY (sample_id)
FOREIGN KEY (scanned_by) REFERENCES Users(user_id)
);


