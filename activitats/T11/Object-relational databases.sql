-- Exercise 1: Create object types
CREATE TYPE Member AS OBJECT (
    idMember CHAR(4),
    fullname VARCHAR2(100),
    username VARCHAR2(15),
    phone VARCHAR2(15),
    email VARCHAR2(100),
    dateEntry DATE
);

CREATE TYPE Teacher UNDER Member (
    title VARCHAR2(100),
    salary NUMBER(8, 2),
    category VARCHAR2(20)
);

CREATE TYPE Groups AS OBJECT (
    groupId INTEGER,
    code CHAR(3),
    name VARCHAR2(50),
    tutor REF Teacher,
    level INTEGER,
    morning CHAR(1),
    requirements VARCHAR2(100)
);

CREATE TYPE Student UNDER Member (
    enrolid INTEGER,
    birthdate DATE,
    groupId REF Groups,
    gender CHAR(1),
    nationality VARCHAR2(15)
);

-- Exercise 2: Create constructor method for Teacher
CREATE OR REPLACE TYPE BODY Teacher AS
    CONSTRUCTOR FUNCTION Teacher(
        idMember CHAR,
        fullname VARCHAR2,
        username VARCHAR2,
        phone VARCHAR2,
        email VARCHAR2,
        title VARCHAR2,
        salary NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.idMember := idMember;
        SELF.fullname := fullname;
        SELF.username := username;
        SELF.phone := phone;
        SELF.email := email;
        SELF.title := title;
        SELF.salary := salary;
        SELF.category := 'Secondary School';
        SELF.dateEntry := SYSDATE;
        RETURN;
    END;
END;

-- Exercise 3: Create getTeacher method
CREATE OR REPLACE TYPE BODY Teacher AS
    MEMBER FUNCTION getTeacher RETURN VARCHAR2 IS
    BEGIN
        RETURN fullname || ' (' || title || ') / ' || category;
    END;
END;

-- Exercise 4: Create TeacherList varray
CREATE TYPE TeacherList AS VARRAY(15) OF Teacher;

DECLARE
    TeacherList_1 TeacherList := TeacherList(
            Teacher('T001', 'Juliette Smith', 'juli', '666123456', 'juliette.smith@pau.cat', 'Bachelor in Computer Science', 60000),
            Teacher('T002', 'Nicole Brown', 'nico', '666111222', 'nicole.brown@pau.cat', 'Data Science Master', 50000)
        );
BEGIN
    NULL;
END;

-- Exercise 5: Create Groups_tab table and insert rows
CREATE TABLE Groups_tab OF Groups;

INSERT INTO Groups_tab VALUES (
    Groups(
          10,
          'S1W',
          'Desenvolupament d''Aplicacions Web',
          (SELECT REF(t) FROM TABLE(TeacherList_1) t WHERE t.idMember = 'T002'),
          1,
          'Y',
          'Middle school, high school, university'
    )
);

INSERT INTO Groups_tab VALUES (
    Groups(
        20,
        'S2P',
        'Desenvolupament d''Aplicacions Multiplataforma',
        (SELECT REF(t) FROM TABLE(TeacherList_1) t WHERE t.idMember = 'T001'),
        2,
        'N',
        'S1P'
    )
);

-- Exercise 6: Create Students table and insert rows
CREATE TABLE Students OF Student;

INSERT INTO Students VALUES (
    Student(
        'S001',
        'Alice in Wonderland',
        'ally',
        '665663311',
        'alice.wonder@pau.cat',
        TO_DATE('14/04/2023', 'DD/MM/YYYY'),
        1,
        TO_DATE('01/01/1990', 'DD/MM/YYYY'),
        (SELECT REF(g) FROM Groups_tab g WHERE g.groupId = 10),
        'F',
        'Wonderland'
    )
);

INSERT INTO Students VALUES (
    Student(
        'S002',
        'George Jobs',
        'geor',
        '665662222',
        'george.jobs@pau.cat',
        TO_DATE('14/04/2023', 'DD/MM/YYYY'),
        2,
        TO_DATE('23/04/1989', 'DD/MM/YYYY'),
        (SELECT REF(g) FROM Groups_tab g WHERE g.groupId = 20),
        'M',
        'English'
    )
);

-- Exercise 7: Modify and insert group from Groups_tab table
DECLARE
    oneGroup Groups;
BEGIN
    SELECT VALUE(g) INTO oneGroup FROM Groups_tab g WHERE g.groupId = 20;
    oneGroup.groupId := 30;
    oneGroup.code := 'S1P';
    oneGroup.tutor := (SELECT REF(t) FROM TABLE(TeacherList_1) t WHERE t.idMember = 'T002');
    INSERT INTO Groups_tab SELECT oneGroup FROM DUAL;
END;
