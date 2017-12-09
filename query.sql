select s.state, i.title from states as s inner join issues as i on s.id = i.state order by s.id asc;
