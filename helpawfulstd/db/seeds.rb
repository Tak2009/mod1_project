require_relative "../app/models/student.rb"

s1 = Student.create(s_profile_name: "Takeshi", location: "London", age:20, wanna_learn: "Ruby", contact_email: "1@gmail.com", password: "a")
s2 = Student.create(s_profile_name: "Dave", location: "Manchester", age:30, wanna_learn: "Ruby", contact_email: "2@gmail.com", password: "a")
s3 = Student.create(s_profile_name: "Dan", location: "Leeds", age:40, wanna_learn: "Python", contact_email: "3@gmail.com", password: "a")
s4 = Student.create(s_profile_name: "Tom", location: "London", age:50, wanna_learn: "Ruby", contact_email: "4@gmail.com", password: "a")
s5 = Student.create(s_profile_name: "Tony", location: "Dublin", age:60, wanna_learn: "Ruby", contact_email: "5@gmail.com", password: "a")
s6 = Student.create(s_profile_name: "Naomi", location: "London", age:34, wanna_learn: "C++", contact_email: "6@gmail.com", password: "a")
s7 = Student.create(s_profile_name: "Henry", location: "Liverpool", age:40, wanna_learn: "PHP", contact_email: "7@gmail.com", password: "a")
s8 = Student.create(s_profile_name: "Aya", location: "Oxford", age:15, wanna_learn: "Ruby", contact_email: "8@gmail.com", password: "a")
s9 = Student.create(s_profile_name: "Mikasa", location: "London", age:15, wanna_learn: "Ruby", contact_email: "9@gmail.com", password: "a")
s10 = Student.create(s_profile_name: "Albin", location: "London", age:15, wanna_learn: "Ruby", contact_email: "10@gmail.com", password: "a")

t1 = Tutor.create(t_profile_name: "David", location: "London", language: "PHP", experience: 5, price: 100, contact_email: "109@gmail.com", password: "a")
t2 = Tutor.create(t_profile_name: "David", location: "London", language: "JavaScript", experience: 5, price: 100, contact_email: "110@gmail.com", password: "a")
t3 = Tutor.create(t_profile_name: "David", location: "London", language: "Ruby", experience: 5, price: 100, contact_email: "111@gmail.com", password: "a")
t4 = Tutor.create(t_profile_name: "Yan", location: "Leeds", language: "Ruby", experience: 5, price: 200, contact_email: "112@gmail.com", password: "a")
t5 = Tutor.create(t_profile_name: "Jess", location: "Manchester", language: "C#", experience: 3, price: 70, contact_email: "113@gmail.com", password: "a")
t6 = Tutor.create(t_profile_name: "Teru", location: "Tokyo", language: "Python", experience: 3, price: 65, contact_email: "114@gmail.com", password: "a")
t7 = Tutor.create(t_profile_name: "Ryan", location: "Dublin", language: "C++", experience: 2, price: 50, contact_email: "115@gmail.com", password: "a")
t8 = Tutor.create(t_profile_name: "Daniel", location: "Liverpool", language: "PHP", experience: 3, price: 55, contact_email: "116@gmail.com", password: "a")
t9 = Tutor.create(t_profile_name: "Erisa", location: "Swansea", language: "JavaScript", experience: 4, price: 120, contact_email: "117@gmail.com", password: "a")
t10 = Tutor.create(t_profile_name: "Erisa", location: "Swansea", language: "Ruby", experience: 5, price: 150, contact_email: "118@gmail.com", password: "a")
t11 = Tutor.create(t_profile_name: "Tac", location: "Swansea", language: "Ruby", experience: 5, price: 150, contact_email: "119@gmail.com", password: "a")
t12 = Tutor.create(t_profile_name: "Mac", location: "Swansea", language: "Ruby", experience: 5, price: 150, contact_email: "120@gmail.com", password: "a")
t13 = Tutor.create(t_profile_name: "Tama", location: "Leeds", language: "Python", experience: 4, price: 150, contact_email: "121@gmail.com", password: "a")

r1 = Review.create(student_id: s1.id, student_own_level: 3, tutor_id: t4.id, language: t4.language, rating_for_tutor: 5, comment: "good in general")
r2 = Review.create(student_id: s6.id, student_own_level: 3, tutor_id: t5.id, language: t5.language, rating_for_tutor: 1, comment: "aaaa")
r3 = Review.create(student_id: s3.id, student_own_level: 3, tutor_id: t6.id, language: t6.language, rating_for_tutor: 2, comment: "feZC in general")
r4 = Review.create(student_id: s4.id, student_own_level: 5, tutor_id: t3.id, language: t3.language, rating_for_tutor: 3, comment: "jkood iffsneral")
r5 = Review.create(student_id: s10.id, student_own_level: 4, tutor_id: t3.id, language: t3.language, rating_for_tutor: 3, comment: "ehhhhod in general")
r6 = Review.create(student_id: s5.id, student_own_level: 2, tutor_id: t10.id, language: t10.language, rating_for_tutor: 4, comment: "qqod in gefral")
r7 = Review.create(student_id: s6.id, student_own_level: 2, tutor_id: t7.id, language: t7.language, rating_for_tutor: 3, comment: "oocsbiaveral")
r8 = Review.create(student_id: s2.id, student_own_level: 2, tutor_id: t3.id, language: t3.language, rating_for_tutor: 5, comment: "goZCaboal")
r9 = Review.create(student_id: s7.id, student_own_level: 1, tutor_id: t8.id, language: t8.language, rating_for_tutor: 1, comment: "sfCSkncal")
r10 = Review.create(student_id: s7.id, student_own_level: 1, tutor_id: t1.id, language: t1.language, rating_for_tutor: 1, comment: "fCin general")
r11 = Review.create(student_id: s7.id, student_own_level: 1, tutor_id: t1.id, language: t1.language, rating_for_tutor: 1, comment: "gxbls; zcnl")
r12 = Review.create(student_id: s3.id, student_own_level: 3, tutor_id: t6.id, language: t6.language, rating_for_tutor: 2, comment: "fvsveneral")
r13 = Review.create(student_id: s3.id, student_own_level: 3, tutor_id: t13.id, language: t13.language, rating_for_tutor: 2, comment: "fbbdeneral")
r14 = Review.create(student_id: s9.id, student_own_level: 3, tutor_id: t3.id, language: t3.language, rating_for_tutor: 4, comment: "fbbdeneral")
r15 = Review.create(student_id: s10.id, student_own_level: 2, tutor_id: t3.id, language: t3.language, rating_for_tutor: 2, comment: "fbbdeneral")