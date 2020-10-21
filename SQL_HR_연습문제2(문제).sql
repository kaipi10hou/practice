/****** HR 데이타 조회 문제2 ****************
/*1■ HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
  Tucker 사원 보다 급여를 많이 받고 있는 사원의 
  이름과 성(Name으로 별칭), 업무, 급여를 출력하시오
*****************************************************/

SELECT Last_name||''||First_name as NAME, job_id, salary
FROM employees
WHERE salary>(select salary from employees where Last_name in('Tucker'))
order by salary desc
;

select salary from employees where Last_name in ('Tucker') ;

/*2■ 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 
  이름과 성(Name으로별칭), 업무, 급여, 입사일을 출력하시오
********************************************************/

SELECT job_id, min(salary)
FROM EMPLOYEES 
group by job_id
order by 2 desc
;

SELECT DISTINCT Last_name||''||First_name as NAME, job_id, salary, hire_date
FROM employees
where (job_id,salary) in (select job_id, min(salary) from employees group by job_id) order by salary desc;

/*3■ 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 
  이름과 성(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
***********************************************************/

SELECT Last_name||''||First_name as NAME, a.salary, a.department_id, a.job_id, b.sal
FROM employees a,(select department_id, round(avg(salary)) sal from employees group by department_id) b
where a.department_id = b.department_id and a.salary>b.sal;

--60번 부서 평균
select employee_id, salary
from employees
where salary> 5760
and department_id=60
;

-- 부서별 평균급여
select department_id, avg(salary)
from employees
--where department_id = 60
group by department_id;


/*4■ 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 이름과 성(Name으로 별칭),
  업무, 급여, 부서번호, 부서평균연봉(Department Avg Salary로 별칭)을 출력하시오
***************************************************************/
--모든 사원의 평균연봉
SELECT 12*salary*(1+NVL(commission_pct,0)) from employees;

--모든 부서 평균연봉
SELECT  round(avg(12*salary*(1+NVL(commission_pct,0)))) from employees group by department_id;
--부서 수 확인
select distinct department_id from employees;

SELECT Last_name||''||First_name as NAME, e.job_id,e.salary,e.department_id, b.c "Department Avg Salary" 
FROM employees e, (SELECT  round(avg(12*salary*(1+NVL(commission_pct,0)))) c, department_id d from employees group by department_id) b
WHERE e.department_id=b.d
ORDER BY e.department_id
;

/*5■ HR 스키마에 있는 Job_history 테이블은 사원들의 업무 변경 이력을 나타내는 테이블이다. 
  이 정보를 이용하여 모든 사원의 현재 및 이전의 업무 이력 정보를 출력하고자 한다. 
  중복된 사원정보가 있으면 한 번만 표시하여 출력하시오
  (사원번호, 업무)
*********************************************************************/
--현재직무
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES 
ORDER BY EMPLOYEE_ID
;
--과거이력
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY 
ORDER BY EMPLOYEE_ID
;
--중복허용 176번 200번이 중복있더라
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



/*6■ 위 문제에서 각 사원의 업무 이력 정보를 확인하였다. 
  하지만 '모든 사원의 업무 이력 전체'를 보지는 못했다. 
  여기에서는 모든 사원의 업무 이력 변경 정보(JOB_HISTORY) 및 
  업무변경에 따른 부서정보를 사원번호가 빠른 순서대로 출력하시오
  (집합연산자 UNION 활용 : 사원번호, 부서번호, 업무 정보 출력)
**********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
UNION ALL
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY 
ORDER BY EMPLOYEE_ID, JOB_ID;
  
/*7■ HR 부서에서는 신규 프로젝트를 성공으로 이끈 해당 업무자들의 
  급여를 인상 하기로 결정하였다. 
  사원은 현재 107명이며 19개의 업무에 소속되어 근무 중이다. 
  급여 인상 대상자는 회사의 업무(Distinct job_id) 중 다음 5개 업무에서 
  일하는 사원에 해당된다. 나머지 업무에 대해서는 급여가 동결된다. 
  5개 업무의 급여 인상안은 다음과 같다.
  HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
**********************************************************************/

--모든사원의 현재 급여
SELECT employee_id, job_id, salary
FROM employees;

--모든사원 중 HR_REP(10%)부서만 인상
SELECT employee_id, job_id, salary, case job_id when 'HR_REP' then salary*1.1
                                    when 'MK_REP' then salary*1.12
                                    when 'PR_REP' then salary*1.15
                                    when 'SA_REP' then salary* 1.18
                                    when 'IT_PROG' then salary*1.2
                                    else salary
                                    end 인상급여
FROM employees
;


/*8■ HR 부서에서는 최상위 입사일에 해당하는 2001년부터 2003년까지 입사자들의 급여를 
  각각 5%, 3%, 1% 인상하여 지분에 따른 배당금으로 지급하고자 한다. 
  전체 사원들 중 해당 년도에 해당하는 사원들의 급여를 검색하여 적용하고, 
  입사일자에 따른 오름차순 정렬을 수행하시오
**********************************************************************/
--제일 오래된 사람들 급여 인상=배당 
--그러니 해당 사원 검색해서 인상율 적용하고 오름차순
SELECT employee_id, hire_date, salary, case when (hire_date like '03%')
                                                           then salary*1.01
                                                      when (hire_date like '02%')
                                                           then salary*1.03
                                                      when (hire_date like '01%')
                                                           then salary*1.05
                                                      else salary
                                                      end as 최상위입사자                                                
FROM EMPLOYEES
WHERE hire_date between('01/01/01') and ('03/12/31')
ORDER BY hire_date
;

--01년입사자
select employee_id, hire_date
from employees
where hire_date like '01%';

--입사날짜비교
SELECT employee_id, hire_date
from employees
where hire_date < TO_DATE('20031212','YYYYMMDD')
;



/*9■ 부서별 급여 합계를 구하고, 그 결과를 다음과 같이 표현하시오.
  Sum Salary > 100000 이면, "Excellent"
  Sum Salary > 50000 이면, "Good"
  Sum Salary > 10000 이면, "Medium"
  Sum Salary <= 10000 이면, "Well"
**********************************************************************/
SELECT department_id, sum(salary), case  when sum(salary)>100000 then 'Excellent'
                                         when sum(salary)>50000 and sum(salary)<=100000 then 'Good'
                                         when sum(salary)>10000 and sum(salary)<=50000 then 'Medium'
                                         when sum(salary)<=10000 then 'Well'
                                         end as 등급
FROM employees
GROUP BY department_id
order by department_id
;

SELECT e.department_id, d.department_name,sum(salary), case  when sum(salary)>100000 then 'Excellent'
                                         when sum(salary)>50000 and sum(salary)<=100000 then 'Good'
                                         when sum(salary)>10000 and sum(salary)<=50000 then 'Medium'
                                         when sum(salary)<=10000 then 'Well'
                                         end as 등급
FROM employees e, departments d
where e.department_id=d.department_id
GROUP BY e.department_id,d.department_name
order by e.department_id
;

/*10■ 2005년 이전에 입사한 사원 중 업무에 "MGR"이 포함된 사원은 15%, 
  "MAN"이 포함된 사원은 20% 급여를 인상한다. 
  또한 2005년부터 근무를 시작한 사원 중 "MGR"이 포함된 사원은 25% 급여를 인상한다. 
  이를 수행하는 쿼리를 작성하시오
**********************************************************************/

--2005년 이전 입사자
SELECT employee_id, hire_date 
FROM employees
where hire_date<'05/01/01';

--업무에 MGR이 포함된 사람 급여 15%
SELECT employee_id, hire_date, salary, job_id, case when (job_id like '%MGR' and hire_date<'05/01/01') then salary*1.15 
                                                 when (job_id like '%MAN' and hire_date<'05/01/01') then salary*1.2 
                                                 when (job_id like '%MGR' and hire_date>='05/01/01') then salary*1.25
                                                
                                                 end as 인상비고
FROM employees
;

/*11■ 월별로 입사한 사원 수 출력
  (방식1) 월별로 입사한 사원 수가 아래와 같이 각 행별로 출력되도록 하시오(12행).
  1월 xx
  2월 xx
  3월 xx
  ..
  12월 xx
  합계 XXX
**********************************************************************/  
SELECT job_id, count(*)
from employees
group by job_id;


select TO_CHAR(hire_date, 'MM'), count(*)
from employees
group by TO_CHAR(hire_date,'MM')
UNION
select '합계', count(*) 
from employees
order by TO_CHAR(hire_date, 'MM');


SELECT TO_CHAR(HIRE_DATE, 'MM')||'월' AS HIRED_MONTH, COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
UNION
SELECT '합계', COUNT(*) 
FROM EMPLOYEES
ORDER BY HIRED_MONTH;


---------------------------------------------------------
/* (방식2) 첫 행에 모든 월별 입사 사원 수가 출력되도록 하시오
  1월 2월 3월 4월 .... 11월 12월
  xx  xx  xx xx  .... xx   xx
**********************************************************************/


--1월 입사자 수
SELECT distinct(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/01/%') "1월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/02/%') "2월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/03/%') "3월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/04/%') "4월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/05/%') "5월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/06/%') "6월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/07/%') "7월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/08/%') "8월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/09/%') "9월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/10/%') "10월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/11/%') "11월입사",
(SELECT COUNT(hire_date)
FROM employees
where hire_date like'%/12/%') "12월입사",
count(*) 사원수
FROM employees
group by 1
;

SELECT DECODE(TO_CHAR(hire_date,'MM'),'01',count(*),0) "1월",
       DECODE(TO_CHAR(hire_date,'MM'),'02',count(*),0) "2월",
       DECODE(TO_CHAR(hire_date,'MM'),'03',count(*),0) "3월",
       DECODE(TO_CHAR(hire_date,'MM'),'04',count(*),0) "4월",
        DECODE(TO_CHAR(hire_date,'MM'),'05',count(*),0) "5월",
      DECODE(TO_CHAR(hire_date,'MM'),'06',count(*),0) "6월",
DECODE(TO_CHAR(hire_date,'MM'),'07',count(*),0) "7월",
DECODE(TO_CHAR(hire_date,'MM'),'08',count(*),0) "8월",
DECODE(TO_CHAR(hire_date,'MM'),'09',count(*),0) "9월",
DECODE(TO_CHAR(hire_date,'MM'),'10',count(*),0) "10월",
DECODE(TO_CHAR(hire_date,'MM'),'11',count(*),0) "11월",
 DECODE(TO_CHAR(hire_date,'MM'),'12',count(*),0) "12월"
from employees
group by TO_CHAR(hire_date,'MM')
order by TO_CHAR(hire_date,'MM');




--최종
select sum(m1) "1월", sum(m2) "2월", sum(m3) "3월", sum(m4) "4월", sum(m5) "5월", sum(m6) "6월", sum(m7) "7월", sum(m8) "8월", sum(m9) "9월", sum(m10) "10월", sum(m11) "11월", sum(m12) "12월", sum(m13) "총원"

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
              , TO_CHAR(hire_date, 'FMMM') || '월' hire_month
           FROM employees
       )
 PIVOT ( 
         COUNT(*) 
         FOR hire_month IN ('1월', '2월', '3월', '4월', '5월', '6월'
                           ,'7월', '8월', '9월', '10월', '11월', '12월')
       )
  
       ;







