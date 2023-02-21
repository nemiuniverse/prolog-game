:- style_check(-singleton).
:- dynamic(yourPosition/1).
:- dynamic(found/2).
:- dynamic(murderer/1).
:- dynamic(people/7).

room(garden).
room(office).
room(bedroom).
room(bathroom).
room(corridor).
room(livingRoom).
room(diningRoom).
room(kitchen).
room(outside).

roomDesc(garden, 'You are the garden. It is winter now, everything is covered by snow.').
roomDesc(office, 'You are in the office, what a mess!').
roomDesc(bedroom, 'You are in the bedroom, there are two pillows for people and one for a dog.').
roomDesc(bathroom, 'You are in the bathroom, you can barely see yourself in the steamy mirror.').
roomDesc(corridor, 'You are in the corridor, you can go into every room from here.').
roomDesc(livingRoom, 'You are in the corridor, you can go into anywhere from here.').
roomDesc(diningRoom, 'You are in the dining room, there are still some dishes left after the dinner.').
roomDesc(kitchen, 'You are in the kitchen, so clean, that it is almost… Suspicious!').
roomDesc(outside, 'I should go back inside…').

person(mrsWhiskers).
person(joanWhiskers).
person(lilyWhiskers).
person(dylanBlack).
person(kateBlack).
person(johnSmith).
person(ethanWhiskers).
person(you).

connected(corridor, garden).
connected(corridor, office).
connected(corridor, bedroom).
connected(corridor, bathroom).
connected(corridor, livingRoom).
connected(corridor, diningRoom).
connected(corridor, kitchen).
connected(corridor, outside).
connected(office, bedroom).
connected(livingRoom, diningRoom).
connected(diningRoom, kitchen).
connected(garden, corridor).
connected(office, corridor).
connected(bedroom, corridor).
connected(bedroom, office).
connected(bathroom, corridor).
connected(livingRoom, corridor).
connected(diningRoom, corridor).
connected(kitchen, corridor).
connected(outside, corridor).
connected(office, corridor).
connected(diningRoom, livingRoom).
connected(kitchen, diningRoom).

yourPosition(outside).


murderer(mrsWhiskers).


personRoom(mrsWhiskers, bedroom).
personRoom(joanWhiskers, garden).
personRoom(lilyWhiskers, office).
personRoom(dylanBlack, bathroom).
personRoom(kateBlack, livingRoom).
personRoom(johnSmith, diningRoom).
personRoom(ethanWhiskers, kitchen).

item(photo, 'I have found a photo of Mrs Whiskers and John Smith with Mr Whiskers.').
item(knifeSet, 'I have found a set of knives. Murder weapon was exactly from the same set! And one is missing.').
item(document, 'I have found a document - a divorce petition. Hm, I think Mr and Mrs White was not that great marriage at all.').
item(leaflet, 'I have found a leaflet: houses for sale in New Orlean. It’s a city where Lily Whiskers goes to the colleague.').

evidence(photo, livingRoom).
evidence(knifeSet, kitchen).
evidence(document, office).
evidence(leaflet, garden).

found(photo, false).
found(knifeSet, false).
found(document, false).
found(leaflet, false).

testimony(mrsWhiskers, 'Mrs Whiskers: My poor husband. I miss him so much! It was me, who found a body. It was in his office. His head was all covered with blood. Police said, that we was attacked from behind and he didn’t have any chances for defence. Oh god help me.').

testimony(joanWhiskers, 'Joan Whiskers: I am so sad daddy is not here. He supposed to play with me and my dolls, but Mr Smith came and they fight over some document. And the next day daddy died.').

testimony(lilyWhiskers, 'Lily Whiskers: I came home last week from the collage. I wanted to give up on it, but dad said he spent too much money for this. And now he’s gone… Now I will continue studying, but only for him.').

testimony(dylanBlack, 'Dylan Black: Mr Whiskers was my wife’s big friend. They grew up together you know. I always thought the affair, but my wife says they were like siblings and I believe her.').

testimony(kateBlack, 'Kate Black: Tony Whiskers was my big friend. I admit, he was my crush, when I was young, but then I met my husband. I will miss our Sunday dinners in summer.').

testimony(johnSmith, 'John Smith: Mr Whiskers was my business partner and I respected him very much. He knew how to maintain work-life balance. I did not have that luck.').

testimony(ethanWhiskers, 'Ethan Whiskers: My brother was a good man. But I have never liked his wife. Look at her, she is shedding crocodile tears. She had an affair with John Smith, I bet. I saw them in the caffe together!').



start :- writeln('Area seems calm and peaceful, but in this building was committed a serious crime. Body of Mr Whiskers was found this Monday. Now there’s a funeral banquet, right after Mr Whiskers was burried.  It’s a job for you, detective! Interrogate people here, find the evidences and decide, who is the murderer.').

go(X, Y) :- connected(X,Y), yourPosition(X),
move(X,Y),
(Y=corridor), writeln('You are in the corridor, you can go into every room from here.'), !;
(Y=garden), writeln('You are the garden. It is winter now, everything is covered by snow.'), !;
(Y=office), writeln('You are in the office, what a mess!'), !;
(Y=bedroom), writeln('You are in the bedroom, there are two pillows for people and one for a dog.'), !;
(Y=bathroom), writeln('You are in the bathroom, you can barely see yourself in the steamy mirror.'), !;
(Y=livingRoom), writeln('You are in the corridor, you can go into anywhere from here.'), !;
(Y=diningRoom), writeln('You are in the dining room, there are still some dishes left after the dinner.'), !; 
(Y=kitchen), writeln('You are in the kitchen, so clean, that it is almost… Suspicious!'), !;
(Y=outside), writeln('I should go back inside…'), !;
writeln('I cannot go there.').

whereAmI :- yourPosition(X),
    write('Your position is '), writeln(X).

printPeople :- people(X),
     writeln(X).

move(X, Y) :- retract(yourPosition(X)), assert(yourPosition(Y)).


people([mrsWhiskers, kateBlack, dylanBlack, ethanWhiskers, lilyWhiskers, joanWhiskers, johnSmith]).

isMurderer(X) :- murderer(X), found(photo, true), found(knifeSet, true), found(document, true), found(leaflet, true),  write('That’s right! It’s Mrs Whiskers fault! He wanted to leave her, so she killed him. You solved the case - justice wins another time.'); write('I think I’ve missed something…'), fail.

talk(X) :- personRoom(X,Y), yourPosition(Y), testimony(X,Z), writeln(Z); writeln('That’s all for now.').

search(X) :- yourPosition(X), evidence(Y,X), item(Y,Z), retract(found(Y,false))	, assert(found(Y,true)), writeln(Z); writeln('No more evidences here.').


help :- writeln('You can search room by search(room) option'),
	writeln('You can talk to people by talk(person) option'),
	writeln('You can print all people you need to talked to by using printPeople option'),
	writeln('You can visit room closest to you by go(X, Y) (X=from, Y=to) option'),
	writeln('Decide who is the murderer by using isMurderer(name)'),
	writeln('Good luck!').




