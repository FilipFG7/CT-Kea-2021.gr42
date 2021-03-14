 use module4;

INSERT INTO users
VALUES 
('7', 'Filip', 'Gavalier', 'Slovakia', 'fg7@gmail.com', 50155115),
('9', 'Roman', 'Chaloupka', 'Slovakia', 'rc9@gmail.com', 54364895),
('11', 'Jakub', 'Pales', 'Slovakia', 'jp11@gmail.com', 54364898);


insert into quiz
VALUES 
('7', '1', 'Yes', 'Creative',5),
('7', '2', 'Yes', 'Development',5),
('7', '3', 'No', 'Digital Marketing',0),
('7', '4', 'No', 'Creative',0),
('7', '5', 'Yes', 'Development',5),
('7', '6', 'No', 'Digital Marketing',0),
('7', '7', 'No', 'Creative',0),
('7', '8', 'Yes', 'Development',5),
('7', '9', 'Yes', 'Digital Marketing',5),
('7', '10', 'Yes', 'Creative',5),
('7', '11', 'Yes', 'Development',5),
('7', '12', 'Yes', 'Digital Marketing',5),
('9', '1', 'Yes', 'Creative',5),
('9', '2', 'No', 'Development',0),
('9', '3', 'No', 'Digital Marketing',0),
('9', '4', 'Yes', 'Creative',5),
('9', '5', 'Yes', 'Development',5),
('9', '6', 'No', 'Digital Marketing',0),
('9', '7', 'No', 'Creative',0),
('9', '8', 'Yes', 'Development',5),
('9', '9', 'Yes', 'Digital Marketing',5),
('9', '10', 'Yes', 'Creative',5),
('9', '11', 'Yes', 'Development',5),
('9', '12', 'Yes', 'Digital Marketing',5),
('11', '1', 'Yes', 'Creative',5),
('11', '2', 'No', 'Development',0),
('11', '3', 'No', 'Digital Marketing',0),
('11', '4', 'No', 'Creative',0),
('11', '5', 'Yes', 'Development',5),
('11', '6', 'Yes', 'Digital Marketing',5),
('11', '7', 'Yes', 'Creative',5),
('11', '8', 'Yes', 'Development',5),
('11', '9', 'Yes', 'Digital Marketing',5),
('11', '10', 'Yes', 'Creative',5),
('11', '11', 'Yes', 'Development',5),
('11', '12', 'Yes', 'Digital Marketing',5);



insert into quiz_results(UserID, Creative_points,Development_points,DM_points)
select UserID,
sum(CASE when Question_field = 'Creative' then Question_points END) as Creative_points,
sum(CASE WHEN Question_field = 'Development' then Question_points END) as Development_points,
sum(CASE when Question_field = 'Digital Marketing' then Question_points END) as DM_points
from quiz group by UserID;

insert into course(UserID, QuizID, Suggested_course)
select UserID, QuizID, 
Greatest(Creative_points,Development_points,DM_points)
as Suggested_course
from quiz_results
group by UserID;


update course c
join quiz_results q
on c.UserID = q.UserID
set Suggested_course = 'Creative'
where q.Creative_points > q.Development_points and q.Creative_points > q.DM_points;
update course c
join quiz_results q
on c.UserID = q.UserID
set Suggested_course = 'Development'
where q.Development_points > q.Creative_points and q.Development_points > q.DM_points;
update course c
join quiz_results q
on c.UserID = q.UserID
set Suggested_course = 'DM'
where q.DM_points > q.Development_points and q.DM_points > q.Creative_points;
update course c
join quiz_results q
on c.UserID = q.UserID
set Suggested_course = 'Creat.,Develop.'
where q.Creative_points = q.Development_points and q.Creative_points > q.DM_points;
update course c
join quiz_results q
on c.UserID = q.UserID
set Suggested_course = 'Develop., DM'
where q.Development_points > q.Creative_points and q.Development_points = q.DM_points;
update course c
join quiz_results q
on c.UserID = q.UserID
set Suggested_course = 'DM,Creat.'
where q.DM_points > q.Development_points and q.DM_points = q.Creative_points;
update course c
join quiz_results q
on c.UserID= q.UserID
set Suggested_course = 'DM,Creat.,Develop.'
where q.Creative_points = q.Development_points and q.Creative_points = q.DM_points;



Select Users.UserID, Users.FirstName, Users.LastName, course.Suggested_course, course.CourseID
from users
inner join course on users.UserID = Course.UserID;


