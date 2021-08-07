-- 16、检索"01"课程分数小于60，按分数降序排列的学生信息
SELECT student.*,score.s_score from student,score where student.s_id = score.s_id and score.s_score <60 and c_id = "01" ORDER BY score.s_score DESC;


-- 17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
select *  from score left join (select s_id,avg(s_score) as avscore from score  group by s_id )r on score.s_id = r.s_id order by avscore desc;

-- 18.查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
-- 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
select  score.c_id ,max(score.s_score)as 最高分,min(score.s_score)as 最低分,AVG(score.s_score)as 平均分,count(*)as 选修人数,sum(case when score.s_score>=60 then 1 else 0 end )/count(*)as 及格率,sum(case when score.s_score   >=70 and score.s_score<80 then 1 else 0 end )/count(*)as 中等率,sum(case when score.s_score>=80 and  score.s_score<90 then 1 else 0 end )/count(*)as 优良率,sum(case when score.s_score>=90 then 1 else 0 end )/count(*)as 优秀率  from score GROUP BY score.c_id ORDER BY count(*)DESC, score.c_id ASC;


-- 19、按各科成绩进行排序，并显示排名 
select a.c_id, a.s_id, a.s_score, count(b.s_score)+1 as rankfrom score as a  left join score as b on a.s_score <   b.s_score and a.c_id = b.c_id group by a.c_id, a.s_id,a.s_score order by a.c_id, rank ASC;
-- 20、查询学生的总成绩并进行排名
set @crank=0;
select q.s_id, total, @crank := @crank +1 as rank from(select score.s_id, sum(score.s_score) as total from score
group by score.s_id order by total desc)q;

-- 21、查询不同老师所教不同课程平均分从高到低显示 
 
-- 22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
 


-- 23、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
 select course.c_name, course.c_id, sum(case when score.s_score<=100 and score.s_score>85 then 1 else 0 end) as "[100-85]", sum(case when score.s_score<=85 and score.s_score>70 then 1 else 0 end) as "[85-70]",sum(case when score.s_score<=70 and score.s_score>60 then 1 else 0 end) as "[70-60]",sum(case when score.s_score<=60 and score.s_score>0 then 1 else 0 end) as "[60-0]" from score left join course on score.c_id = course.c_id group by score.c_id;

-- 24、查询学生平均成绩及其名次 
 
-- 25、查询各科成绩前三名的记录
            -- 1.选出b表比a表成绩大的所有组
            -- 2.选出比当前id成绩大的 小于三个的
 
 select * from score a left join score b on a.c_id = b.c_id and a.s_score<b.s_score order by a.c_id,a.s_score;
-- 26、查询每门课程被选修的学生数 
 select c_id,count(s_id) from score group by c_id;

-- 27、查询出只有两门课程的全部学生的学号和姓名 
    
select student.s_id,student.s_name from score,student where student.s_id=score.s_id   GROUP BYscore.s_id HAVING count(*)=2;
-- 28、查询男生、女生人数 
select s_sex, count(*) from student group by s_sex;

-- 29、查询名字中含有"风"字的学生信息
select *from student where student.s_name like '%风%'

-- 30、查询同名同性学生名单，并统计同名人数 

select s_name, count(*) from student group by s_name having count(*)>1;
-- 31、查询1990年出生的学生名单

 select * from student where YEAR(student.s_birth)=1990;

-- 32、查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列 
select score.c_id, course.c_name, AVG(score.s_score) as average from score, course where score.c_id = course.c_id
group by score.c_id  order by average desc,c_id asc;

-- 33、查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩 
select student.s_id, student.s_name, AVG(score.s_score) as aver from student, score where student.s_id = score.s_id
group by score.s_id having aver > 85;

-- 34、查询课程名称为"数学"，且分数低于60的学生姓名和分数 
 
select student.s_name, score.s_score from student, score, course where student.s_id = score.s_id and course.c_id = score.c_id and course.c_name = "数学" and score.s_score < 60;
-- 35、查询所有学生的课程及分数情况； 
 select student.s_name, c_id, s_score from student left join score on student.s_id = score.s_id;
 
 -- 36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数； 
select student.s_name, course.c_name,score.s_score from student,course,score where score.s_score>70 and student.s_id = score.s_id and score.c_id = course.c_id;


-- 37、查询不及格的课程
 select c_id from score where s_score< 60 group by c_id;

-- 38、查询课程编号为01且课程成绩在80分以上的学生的学号和姓名； 
select student.s_id,student.s_name  from student,score where c_id="01" and s_score>=80 and student.s_id = score.s_id;
 
-- 39、求每门课程的学生人数 
 select score.c_id,count(*) as 学生人数 from score GROUP BY score.c_id;

-- 40、查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩
-- 查询老师id   
-- 查询最高分（可能有相同分数） 
-- 查询信息
select student.*, score.s_score, score.c_id from student, teacher, course,score where teacher.t_id = course.t_id and score.s_id = student.s_id and score.c_id = course.c_id and teacher.t_name = "张三" order by score desc limit 1;
-- 41、查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩 
 select  a.c_id, a.s_id,  a.s_score from score as a inner join  score as b on a.s_id = b.s_id and a.c_id != b.c_id and a.s_score = b.s_score group by c_id, s_id;


-- 42、查询每门功成绩最好的前两名 
 
select a.s_id,a.c_id,a.s_score from score as a left join score as b on a.c_id = b.c_id and a.s_score<b.s_score group by a.c_id, a.s_id having count(b.c_id)<2 order by a.c_id;


-- 43、统计每门课程的学生选修人数（超过5人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列  
select score.c_id, count(s_id) as cc from score group by c_id having cc >5;

-- 44、查询至少选修两门课程的学生学号 
select s_id, count(c_id) as cc from score group by s_id having cc>=2;

-- 45、查询选修了全部课程的学生信息 
     
select student.* from score ,student where score.s_id=student.s_id GROUP BY score.s_id HAVING count(*) = (select DISTINCT count(*) from course );

-- 46、查询各学生的年龄
    -- 按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一

select student.s_id as 学生编号,student.s_name as  学生姓名,TIMESTAMPDIFF(YEAR,student.s_birth,CURDATE()) as 学生年龄 from student;

-- 47、查询本周过生日的学生
 select * from student where WEEKOFYEAR(student.s_birth)=WEEKOFYEAR(CURDATE());

-- 48、查询下周过生日的学生
 
select * from student  where WEEKOFYEAR(student.s_birth)=WEEKOFYEAR(CURDATE())+1;
-- 49、查询本月过生日的学生

 select * from student where MONTH(student.s_birth)=MONTH(CURDATE());

-- 50、查询下月过生日的学生

select *from student where MONTH(student.s_birth)=MONTH(CURDATE())+1;








