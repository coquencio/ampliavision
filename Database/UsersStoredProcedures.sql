
delimiter //
CREATE PROCEDURE UserRegistration(in name varchar(30),in pass varchar(40),in tok varchar (50))
BEGIN
    INSERT INTO users (userName, password, Token) values (name, pass, tok);
END //
delimiter ;

delimiter //
CREATE PROCEDURE GetToken(in name varchar(30),in pass varchar(40))
BEGIN
    SELECT Token FROM users where userName = name and password = pass;
END //
delimiter ;
