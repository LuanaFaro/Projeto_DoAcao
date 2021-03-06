DECLARE
V_COUNT NUMBER;
BEGIN
SELECT COUNT(*) INTO V_COUNT FROM USER_TABLES
WHERE TABLE_NAME = 'MUNICIPIO';
IF V_COUNT = 0 THEN
BEGIN
EXECUTE IMMEDIATE '
CREATE TABLE "MUNICIPIO" (
"ID" NUMBER NOT NULL ENABLE,
"STRMUNICIPIO" VARCHAR2(400) NOT NULL ENABLE,
"DTMATUALIZACAO" TIMESTAMP (6) NOT NULL ENABLE,
CONSTRAINT "MUNICIPIO_PK" PRIMARY KEY ("ID") ENABLE
)';
DBMS_OUTPUT.PUT_LINE('OPERAÇÃO REALIZADA COM SUCESSO !');
END;
ELSE
DBMS_OUTPUT.PUT_LINE('A TABELA MUNICIPIO JÁ EXISTE NO SISTEMA.');
END IF;
END;
/
DECLARE
V_COUNT INTEGER;
BEGIN
SELECT COUNT(*) INTO V_COUNT FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'MUNICIPIO_SEQ';
IF V_COUNT = 0 THEN
EXECUTE IMMEDIATE
'CREATE SEQUENCE "MUNICIPIO_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE';
ELSE
DBMS_OUTPUT.PUT_LINE('JÁ EXISTE A SEQUENCE MUNICIPIO_SEQ');
END IF;
END;
/
CREATE trigger "BI_MUNICIPIO"
before insert on "MUNICIPIO"
for each row
begin
if :NEW."ID" is null then
select "MUNICIPIO_SEQ".nextval into :NEW."ID" from sys.dual;
end if;
end;
/
ALTER TRIGGER "BI_MUNICIPIO" ENABLE;
