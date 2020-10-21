/****** HR ����Ÿ ��ȸ ����2 ****************
/*1�� HR �μ��� � ����� �޿������� ��ȸ�ϴ� ������ �ð� �ִ�. 
  Tucker ��� ���� �޿��� ���� �ް� �ִ� ����� 
  �̸��� ��(Name���� ��Ī), ����, �޿��� ����Ͻÿ�
*****************************************************/

SELECT Last_name||''||First_name as NAME, job_id, salary
FROM employees
WHERE salary>(select salary from employees where Last_name in('Tucker'))
order by salary desc
;

select salary from employees where Last_name in ('Tucker') ;

/*2�� ����� �޿� ���� �� ������ �ּ� �޿��� �ް� �ִ� ����� 
  �̸��� ��(Name���κ�Ī), ����, �޿�, �Ի����� ����Ͻÿ�
********************************************************/

SELECT job_id, min(salary)
FROM EMPLOYEES 
group by job_id
order by 2 desc
;

SELECT DISTINCT Last_name||''||First_name as NAME, job_id, salary, hire_date
FROM employees
where (job_id,salary) in (select job_id, min(salary) from employees group by job_id) order by salary desc;

/*3�� �Ҽ� �μ��� ��� �޿����� ���� �޿��� �޴� ����� 
  �̸��� ��(Name���� ��Ī), �޿�, �μ���ȣ, ������ ����Ͻÿ�
***********************************************************/

SELECT Last_name||''||First_name as NAME, a.salary, a.department_id, a.job_id, b.sal
FROM employees a,(select department_id, round(avg(salary)) sal from employees group by department_id) b
where a.department_id = b.department_id and a.salary>b.sal;

--60�� �μ� ���
select employee_id, salary
from employees
where salary> 5760
and department_id=60
;

-- �μ��� ��ձ޿�
select department_id, avg(salary)
from employees
--where department_id = 60
group by department_id;


/*4�� ��� ����� �ҼӺμ� ��տ����� ����Ͽ� ������� �̸��� ��(Name���� ��Ī),
  ����, �޿�, �μ���ȣ, �μ���տ���(Department Avg Salary�� ��Ī)�� ����Ͻÿ�
***************************************************************/
--��� ����� ��տ���
SELECT 12*salary*(1+NVL(commission_pct,0)) from employees;

--��� �μ� ��տ���
SELECT  round(avg(12*salary*(1+NVL(commission_pct,0)))) from employees group by department_id;
--�μ� �� Ȯ��
select distinct department_id from employees;

SELECT Last_name||''||First_name as NAME, e.job_id,e.salary,e.department_id, b.c "Department Avg Salary" 
FROM employees e, (SELECT  round(avg(12*salary*(1+NVL(commission_pct,0)))) c, department_id d from employees group by department_id) b
WHERE e.department_id=b.d
ORDER BY e.department_id
;

/*5�� HR ��Ű���� �ִ� Job_history ���̺��� ������� ���� ���� �̷��� ��Ÿ���� ���̺��̴�. 
  �� ������ �̿��Ͽ� ��� ����� ���� �� ������ ���� �̷� ������ ����ϰ��� �Ѵ�. 
  �ߺ��� ��������� ������ �� ���� ǥ���Ͽ� ����Ͻÿ�
  (�����ȣ, ����)
*********************************************************************/
--��������
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES 
ORDER BY EMPLOYEE_ID
;
--�����̷�
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY 
ORDER BY EMPLOYEE_ID
;
--�ߺ���� 176�� 200���� �ߺ��ִ���
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
UNION ALL
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY 
ORDER BY EMPLOYEE_ID, JOB_ID;

SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY 
ORDER BY EMPLOYEE_ID, JOB_ID;



/*6�� �� �������� �� ����� ���� �̷� ������ Ȯ���Ͽ���. 
  ������ '��� ����� ���� �̷� ��ü'�� ������ ���ߴ�. 
  ���⿡���� ��� ����� ���� �̷� ���� ����(JOB_HISTORY) �� 
  �������濡 ���� �μ������� �����ȣ�� ���� ������� ����Ͻÿ�
  (���տ����� UNION Ȱ�� : �����ȣ, �μ���ȣ, ���� ���� ���)
**********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
UNION ALL
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY 
ORDER BY EMPLOYEE_ID, JOB_ID;
  
/*7�� HR �μ������� �ű� ������Ʈ�� �������� �̲� �ش� �����ڵ��� 
  �޿��� �λ� �ϱ�� �����Ͽ���. 
  ����� ���� 107���̸� 19���� ������ �ҼӵǾ� �ٹ� ���̴�. 
  �޿� �λ� ����ڴ� ȸ���� ����(Distinct job_id) �� ���� 5�� �������� 
  ���ϴ� ����� �ش�ȴ�. ������ ������ ���ؼ��� �޿��� ����ȴ�. 
  5�� ������ �޿� �λ���� ������ ����.
  HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
**********************************************************************/

--������� ���� �޿�
SELECT employee_id, job_id, salary
FROM employees;

--����� �� HR_REP(10%)�μ��� �λ�
SELECT employee_id, job_id, salary, case job_id when 'HR_REP' then salary*1.1
                                    when 'MK_REP' then salary*1.12
                                    when 'PR_REP' then salary*1.15
                                    when 'SA_REP' then salary* 1.18
                                    when 'IT_PROG' then salary*1.2
                                    else salary
                                    end �λ�޿�
FROM employees
;


/*8�� HR �μ������� �ֻ��� �Ի��Ͽ� �ش��ϴ� 2001����� 2003����� �Ի��ڵ��� �޿��� 
  ���� 5%, 3%, 1% �λ��Ͽ� ���п� ���� �������� �����ϰ��� �Ѵ�. 
  ��ü ����� �� �ش� �⵵�� �ش��ϴ� ������� �޿��� �˻��Ͽ� �����ϰ�, 
  �Ի����ڿ� ���� �������� ������ �����Ͻÿ�
**********************************************************************/
--���� ������ ����� �޿� �λ�=��� 
--�׷��� �ش� ��� �˻��ؼ� �λ��� �����ϰ� ��������
SELECT employee_id, hire_date, salary, case when (hire_date like '03%')
                                                           then salary*1.01
                                                      when (hire_date like '02%')
                                                           then salary*1.03
                                                      when (hire_date like '01%')
                                                           then salary*1.05
                                                      else salary
                                                      end as �ֻ����Ի���                                                
FROM EMPLOYEES
WHERE hire_date between('01/01/01') and ('03/12/31')
ORDER BY hire_date
;

--01���Ի���
select employee_id, hire_date
from employees
where hire_date like '01%';

--�Ի糯¥��
SELECT employee_id, hire_date
from employees
where hire_date < TO_DATE('20031212','YYYYMMDD')
;



/*9�� �μ��� �޿� �հ踦 ���ϰ�, �� ����� ������ ���� ǥ���Ͻÿ�.
  Sum Salary > 100000 �̸�, "Excellent"
  Sum Salary > 50000 �̸�, "Good"
  Sum Salary > 10000 �̸�, "Medium"
  Sum Salary <= 10000 �̸�, "Well"
**********************************************************************/
SELECT department_id, sum(salary), case  when sum(salary)>100000 then 'Excellent'
                                         when sum(salary)>50000 and sum(salary)<=100000 then 'Good'
                                         when sum(salary)>10000 and sum(salary)<=50000 then 'Medium'
                                         when sum(salary)<=10000 then 'Well'
                                         end as ���
FROM employees
GROUP BY department_id
order by department_id
;

SELECT e.department_id, d.department_name,sum(salary), case  when sum(salary)>100000 then 'Excellent'
                                         when sum(salary)>50000 and sum(salary)<=100000 then 'Good'
                                         when sum(salary)>10000 and sum(salary)<=50000 then 'Medium'
                                         when sum(salary)<=10000 then 'Well'
                                         end as ���
FROM employees e, departments d
where e.department_id=d.department_id
GROUP BY e.department_id,d.department_name
order by e.department_id
;

/*10�� 2005�� ������ �Ի��� ��� �� ������ "MGR"�� ���Ե� ����� 15%, 
  "MAN"�� ���Ե� ����� 20% �޿��� �λ��Ѵ�. 
  ���� 2005����� �ٹ��� ������ ��� �� "MGR"�� ���Ե� ����� 25% �޿��� �λ��Ѵ�. 
  �̸� �����ϴ� ������ �ۼ��Ͻÿ�
**********************************************************************/

--2005�� ���� �Ի���
SELECT employee_id, hire_date 
FROM employees
where hire_date<'05/01/01';

--������ MGR�� ���Ե� ��� �޿� 15%
SELECT employee_id, hire_date, salary, job_id, case when (job_id like '%MGR' and hire_date<'05/01/01') then salary*1.15 
                                                 when (job_id like '%MAN' and hire_date<'05/01/01') then salary*1.2 
                                                 when (job_id like '%MGR' and hire_date>='05/01/01') then salary*1.25
                                                
                                                 end as �λ���
FROM employees
;

/*11�� ������ �Ի��� ��� �� ���
  (���1) ������ �Ի��� ��� ���� �Ʒ��� ���� �� �ະ�� ��µǵ��� �Ͻÿ�(12��).
  1�� xx
  2�� xx
  3�� xx
  ..
  12�� xx
  �հ� XXX
**********************************************************************/  
SELECT job_id, count(*)
from employees
group by job_id;


select TO_CHAR(hire_date, 'MM'), count(*)
from employees
group by TO_CHAR(hire_date,'MM')
UNION
select '�հ�', count(*) 
from employees
order by TO_CHAR(hire_date, 'MM');


SELECT TO_CHAR(HIRE_DATE, 'MM')||'��' AS HIRED_MONTH, COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
UNION
SELECT '�հ�', COUNT(*) 
FROM EMPLOYEES
ORDER BY HIRED_MONTH;


---------------------------------------------------------
/* (���2) ù �࿡ ��� ���� �Ի� ��� ���� ��µǵ��� �Ͻÿ�
  1�� 2�� 3�� 4�� .... 11�� 12��
  xx  xx  xx xx  .... xx   xx
**********************************************************************/


--1�� �Ի��� ��
SELECT distinct(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/01/%') "1���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/02/%') "2���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/03/%') "3���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/04/%') "4���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/05/%') "5���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/06/%') "6���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/07/%') "7���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/08/%') "8���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/09/%') "9���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/10/%') "10���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/11/%') "11���Ի�",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/12/%') "12���Ի�",
count(*) �����
FROM employees
group by 1
;

SELECT DECODE(TO_CHAR(hire_date,'MM'),'01',count(*),0) "1��",
       DECODE(TO_CHAR(hire_date,'MM'),'02',count(*),0) "2��",
       DECODE(TO_CHAR(hire_date,'MM'),'03',count(*),0) "3��",
       DECODE(TO_CHAR(hire_date,'MM'),'04',count(*),0) "4��",
        DECODE(TO_CHAR(hire_date,'MM'),'05',count(*),0) "5��",
      DECODE(TO_CHAR(hire_date,'MM'),'06',count(*),0) "6��",
DECODE(TO_CHAR(hire_date,'MM'),'07',count(*),0) "7��",
DECODE(TO_CHAR(hire_date,'MM'),'08',count(*),0) "8��",
DECODE(TO_CHAR(hire_date,'MM'),'09',count(*),0) "9��",
DECODE(TO_CHAR(hire_date,'MM'),'10',count(*),0) "10��",
DECODE(TO_CHAR(hire_date,'MM'),'11',count(*),0) "11��",
 DECODE(TO_CHAR(hire_date,'MM'),'12',count(*),0) "12��"
from employees
group by TO_CHAR(hire_date,'MM')
order by TO_CHAR(hire_date,'MM');




--����
select sum(m1) "1��", sum(m2) "2��", sum(m3) "3��", sum(m4) "4��", sum(m5) "5��", sum(m6) "6��", sum(m7) "7��", sum(m8) "8��", sum(m9) "9��", sum(m10) "10��", sum(m11) "11��", sum(m12) "12��", sum(m13) "�ѿ�"

from (

select decode(to_char(hire_date,'mm'), '01', count(*), 0) m1,

decode(to_char(hire_date,'mm'), '02', count(*), 0) m2,

decode(to_char(hire_date,'mm'), '03', count(*), 0) m3,

decode(to_char(hire_date,'mm'), '04', count(*), 0) m4,

decode(to_char(hire_date,'mm'), '05', count(*), 0) m5,

decode(to_char(hire_date,'mm'), '06', count(*), 0) m6,

decode(to_char(hire_date,'mm'), '07', count(*), 0) m7,

decode(to_char(hire_date,'mm'), '08', count(*), 0) m8,

decode(to_char(hire_date,'mm'), '09', count(*), 0) m9,

decode(to_char(hire_date,'mm'), '10', count(*), 0) m10,

decode(to_char(hire_date,'mm'), '11', count(*), 0) m11,

decode(to_char(hire_date,'mm'), '12', count(*), 0) m12,

count(*) m13

from employees

group by to_char(hire_date,'mm')

);











SELECT *
  FROM (
         SELECT null
              , TO_CHAR(hire_date, 'FMMM') || '��' hire_month
           FROM employees
       )
 PIVOT ( 
         COUNT(*) 
         FOR hire_month IN ('1��', '2��', '3��', '4��', '5��', '6��'
                           ,'7��', '8��', '9��', '10��', '11��', '12��')
       )
  
       ;







