-- OPIC 자동화 시스템 데이터베이스 설정
-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS opic_automatic CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE opic_automatic;

-- question 테이블 생성
CREATE TABLE IF NOT EXISTS question (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_text TEXT NOT NULL,
    property VARCHAR(100) NOT NULL,
    link INT NOT NULL,
    INDEX idx_property_link (property, link)
);

-- answer 테이블 생성
CREATE TABLE IF NOT EXISTS answer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    studentID VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    question_number INT NOT NULL,
    question_text TEXT NOT NULL,
    answer_text TEXT NOT NULL,
    score DECIMAL(3,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_student (studentID)
);

-- grade 테이블 생성
CREATE TABLE IF NOT EXISTS grade (
    id INT PRIMARY KEY AUTO_INCREMENT,
    studentID VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_student (studentID)
);

-- 모든 61개 질문 데이터 삽입
INSERT INTO question (question_text, property, link) VALUES 
-- 공통 질문 (항상 첫 번째로 나오는 질문)
('Can you introduce yourself in as much detail as possible?', 'common', 0),

-- 종사 분야별 질문 (사업자/직장인)
('You indicated that you work. Describe your typical day at work. Try to explain some tasks that you do. Instead of chronologically explaining your day, try to focus on the daily tasks you do.', '사업자/직장인', 0),
('What specific things do you look for when choosing a job? Please pick three things that you consider when choosing a job and explain them one by one in detail.', '사업자/직장인', 1),
('When you select a job which is more important - money or job fulfillment? Why? Please explain your answer in detail.', '사업자/직장인', 2),

-- 종사 분야별 질문 (학생)
('You indicated that you are a student. What are some factors that you consider when choosing a class? Try to be as specific as possible.', '학생', 0),
('What was one of the most difficult projects or homework assignments that you have ever done for a class? Why was it difficult for you? Please explain the project or homework assignment in detail.', '학생', 1),
('What did you do last year for self-development? List two things that you did last year to change yourself.', '학생', 2),

-- 종사 분야별 질문 (취업준비생)
('What specific things do you look for when choosing a job? Please pick three things that you consider when choosing a job and explain them one by one in detail.', '취업준비생', 0),
('What was one of the most difficult projects that you have ever been involved in? What was the project about? Why did you find it so difficult? Please describe your experience in detail.', '취업준비생', 1),
('What advice have you given a friend who was going through a tough time? Choose two of the pieces of advice you gave and discuss in detail the experience related to you giving the advice.', '취업준비생', 2),

-- 거주 방식별 질문 (개인주택이나 아파트에 홀로 거주)
('Please describe your home. How many rooms are there? What do the interior design and the furniture layout look like? Try to explain your home in as much detail as possible.', '개인주택이나 아파트에 홀로 거주', 0),
('What is your favorite item of furniture at home and why do you like it? Where is this item and who uses it the most in your family? Can you think of any episode relating to the furniture? Please discuss it in detail.', '개인주택이나 아파트에 홀로 거주', 1),
('Tell me about a difficult situation you had at home while you were alone. What was the situation and how did it happen? How did you solve the problem? Please explain the situation in detail.', '개인주택이나 아파트에 홀로 거주', 2),

-- 거주 방식별 질문 (친구나 룸메이트와 함께 주택이나 아파트에 거주)
('Please describe a common space that you share with your roommate at home. What kind of furniture or home appliances are there? What is the layout of the place? Please use as much detail as possible.', '친구나 룸메이트와 함께 주택이나 아파트에 거주', 0),
('When we live with other people, we tend to experience some difficulties. Tell me about a disagreement you had with your roommate. What was the situation and how did it start? How did you resolve the situation with your roommate?', '친구나 룸메이트와 함께 주택이나 아파트에 거주', 1),
('Your roommate says that she/he wants to bring her/his family dog to the house that you are currently living in. Unfortunately, you do not want to live with a pet. Give your roommate three reasons why the dog cannot live in the house.', '친구나 룸메이트와 함께 주택이나 아파트에 거주', 2),

-- 거주 방식별 질문 (가족과 함께 주택이나 아파트에 거주)
('Please describe your home. How many rooms are there? What do the interior design and the furniture layout look like? Try to explain your home in as much detail as possible.', '가족과 함께 주택이나 아파트에 거주', 0),
('Tell me about a situation where you and your family had to fix something in your house. Describe who did what in that situation and be specific about your role. What was the result? Please describe the situation in detail.', '가족과 함께 주택이나 아파트에 거주', 1),
('What is your favorite item of furniture at home and why do you like it? Where is this item and who uses it the most in your family? Can you think of any episode relating to the furniture? Please discuss it in detail.', '가족과 함께 주택이나 아파트에 거주', 2),

-- 여가 및 취미 활동별 질문 (운동)
('Where do you normally exercise? Why did you prefer this place for exercise? What does it look like? Try to describe the place in as much detail as possible.', '운동', 0),
('Can you remember any fun episodes or anecdotes you experienced while exercising? What was the situation and how did it start? Please tell the story in as much detail as possible.', '운동', 1),
('What do you do to maintain a healthy life both mentally and physically? Explain the activities or course of action you take in detail.', '운동', 2),

-- 여가 및 취미 활동별 질문 (게임)
('Do you ever play online or mobile games? What is the genre of your favorite game? Why do you like it so much?', '게임', 0),
('You indicated that you like to play online or mobile games. Can you tell me the storyline of your favorite game? Please explain in as much detail as possible.', '게임', 1),
('Some believe that certain online games can bring about violent behavior in younger gamers.. What is your opinion? Do you agree or disagree? Why or why not? Please elaborate on your opinion in as much detail as possible.', '게임', 2),

-- 여가 및 취미 활동별 질문 (SNS)
('Which social media platform do you use the most? What features make you use this specific platform? What specific things do you use the media platform for?', 'SNS', 0),
('Tell me about a time when you uploaded the wrong information or photos onto social media? How did it happen and how did you feel when you realized your mistake? Were you able to resolve the situation? Please give me details about this experience.', 'SNS', 1),
('Some people say that social media has a negative effect on children. Do you agree or disagree with this? Please explain your thoughts and elaborate on the reasons why you agree or disagree.', 'SNS', 2),

-- 여가 및 취미 활동별 질문 (문화생활)
('Tell me about your all-time favorite film. When did you watch this film for the first time? Why is this film your all-time favorite? Can you think of any happy memories related to this film?', '문화생활', 0),
('You are at an art exhibition and you want to make a reservation for a docent tour. Please ask the receptionist three questions about booking a docent tour.', '문화생활', 1),
('You are going to a ballet performance with your friend. Your friend doesn''t know where the performance is being held or what it is about. Please tell your friend two or more descriptive details about the performance.', '문화생활', 2),

-- 여가 및 취미 활동별 질문 (여행)
('Which city in the world would you currently like to visit the most? Why did you choose that city? What does it look like? What kind of places do you want to visit there? Please describe in detail why you want to visit this city.', '여행', 0),
('Tell me about a difficult situation that you experienced while you were traveling. What exactly happened? How did you solve the problem? Describe the experience in detail.', '여행', 1),
('Imagine a vacation at a resort hotel with pools and a wide range of amenities. What kind of activities would you do? Describe a day at a resort hotel in detail.', '여행', 2),

-- 여가 및 취미 활동별 질문 (자기관리)
('What do you do to maintain a healthy life both mentally and physically? Explain the activities or course of action you take in detail.', '자기관리', 0),
('Have you ever participated in meditation? Why or why not? Talk about your experience in detail.', '자기관리', 1),
('What kind of application, other than social media apps, do you use the most on your mobile phone? Why do you use this app the most?', '자기관리', 2),

-- 여가 및 취미 활동별 질문 (예술활동)
('You went to a bar, but you don''t know anything about their drinks menu. Please ask the bartender three questions about the signature drink.', '예술활동', 0),
('What type of bar do you want to visit? What is the decor or mood like? What kind of drinks are they selling? Imagine and describe the bar that you want to visit in detail.', '예술활동', 1),
('You are ten minutes late for a concert. There are some guards in front of the closed gate. Give them three reasons to persuade them guards that you must go in inside and enjoy the concert.', '예술활동', 2),

-- 여가 및 취미 활동별 질문 (자기개발)
('Have you ever read a self-development book? What kind of book was it? Why did you choose that book?', '자기개발', 0),
('You want to take a self-development seminar. Your friend has been to many self-development seminars. Ask your friend three questions to get some recommendations for a useful seminar.', '자기개발', 1),
('What did you do last year for self-development? List two things that you did last year to change yourself.', '자기개발', 2),

-- 롤플레이 질문들 (롤플레이1)
('You booked a hotel and when you arrived at the hotel the manager said that there were no reservations under your name. Please explain your situation to the manager in order to reserve the room.', '롤플레이1', 0),
('You need to submit a report by this weekend and you only have three days left to complete it. Unfortunately, you became extremely sick and are unable to finish the report on time. Call the professor and explain your situation so that you can get an extension.', '롤플레이1', 1),
('You ordered some food through a delivery app, but unfortunately, there was a mistake, and you got the wrong order. Call the restaurant owner and provide two or three solutions to resolve this situation.', '롤플레이1', 2),

-- 롤플레이 질문들 (롤플레이2)
('You applied to several companies and were accepted by two companies. You chose the one company and must therefore turn down the other company''s offer of employment. Please call the hiring manager of the second company to inform them why you are no longer interested in the position with their company.', '롤플레이2', 0),
('Your colleague asks you to do an important presentation instead of him or her. Ask them three questions to get more information about the presentation.', '롤플레이2', 1),
('You want to get an apartment in the city. Ask a realtor three questions to get a good place for living on your own in the city.', '롤플레이2', 2),

-- 롤플레이 질문들 (롤플레이3)
('You reserved a VIP ticket to an art fair. Unfortunately, there was a mistake and you were not on the list. Explain your situation to the receptionist so that you can enter the art fair as a VIP.', '롤플레이3', 0),
('You booked two concert tickets, but unfortunately, you are not able to go to the concert. You want to give the tickets to your friend and your friend wants to know more about the concert. Please tell your friend three specific details about the concert.', '롤플레이3', 1),
('Your family decided to purchase a new sofa for the living room. Please ask a salesperson three questions to get a good sofa to put in your living room.', '롤플레이3', 2),

-- 롤플레이 질문들 (롤플레이4)
('Tell me about an experience using a food delivery app. What did you order? Why did you use that specific app? Describe the experience in detail.', '롤플레이4', 0),
('Your friend is having a birthday party at a bar. However, a mutual friend called you to ask that you make an excuse for them for being late for the party. Please explain the situation to the host of the party and give two excuses for your friend''s tardiness.', '롤플레이4', 1),
('If you were invited to a Halloween party, what kind of costume do you want to wear and why?', '롤플레이4', 2),

-- 돌발질문 (돌발질문:코로나)
('There are so many illegal students and other foreign visitors who stayed on in Korea after the outbreak of Covid-19. A lot of these people stay in Korea illegally instead of going back to their home countries. Why do you think this is happening?', '돌발질문:코로나', 0),
('In this situation, do you think the government has to intervene and manage the situation? Why or why not? Please elaborate on your ideas.', '돌발질문:코로나', 1),

-- 돌발질문 (돌발질문:코인)
('Until recently, there were so many people in Korea who invested in stocks and cryptocurrencies. In your opinion why is this so-called "investment boom" happening?', '돌발질문:코인', 0),
('One of the interesting facts about the "investment boom" is that many "gen Z" (generation Z) were involved. In your opinion why do you think the younger generation is so interested in investments instead focusing on traditional salaried employment? Please elaborate on your opinion.', '돌발질문:코인', 1),

-- 돌발질문 (돌발질문:출산율)
('Recently, the birthrate in Korea is fallen steeply. In your opinion, why is this happening?', '돌발질문:출산율', 0),
('To solve the sharp drop in the Korean birthrate, should the broader forms of family like cohabiting couples, foster families, common law marriages and so on be legalized? Please state your opinion, giving detailed reasons to explain why you feel this way.', '돌발질문:출산율', 1),

-- 추가 질문들 (나머지 질문들을 다양한 분야에 배치)
('Have you ever participated in meditation? Why or why not? Talk about your experience in detail.', '자기관리', 3),
('What is your favorite holiday out of all the Korean or foreign holidays? Explain why you like this holiday most and also how you would celebrate it.', '문화생활', 3),
('Talk about a vacation when you stayed at home. What activities did you do at home? Did you invite someone to come over? Give me some of the specifics of your experience.', '여행', 3),
('Talk about your happiest Christmas memory ever. Where were you and who were you with? Explain the day in as much detail as possible.', '문화생활', 4),
('Which kind of vacation do you prefer: going on a trip somewhere or staying at home? Explain why do you prefer that type of vacation. Please your choice in as much detail as possible.', '여행', 4),
('You are looking for a gym in a new city and you went to one place that is near your home. Please ask the fitness instructor three questions about the gym to help you decide if you like it.', '운동', 3),
('You are ten minutes late for a concert. There are some guards in front of the closed gate. Give them three reasons to persuade them guards that you must go in inside and enjoy the concert.', '문화생활', 5),
('You reserved a VIP ticket to an art fair. Unfortunately, there was a mistake and you were not on the list. Explain your situation to the receptionist so that you can enter the art fair as a VIP.', '문화생활', 6);