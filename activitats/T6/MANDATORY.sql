ALTER TABLE EMPLOYEE
ADD FOREIGN KEY (department_code) REFERENCES DEPARTMENT (department_code);

ALTER TABLE CLIENT
ADD FOREIGN KEY (agent_code) REFERENCES EMPLOYEE (emploee_code);