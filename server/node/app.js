'use strict';


var neo4j = require('neo4j');

var db = new neo4j.GraphDatabase({
    url: 'http://neo4j:neo4j@localhost:7474'
});

db.cypher({
    query: 'MATCH (n:`SKILL`) RETURN n'
}, (err, skills) => {
    skills.forEach((skill) => {
        let name = skill.n.properties.name;
        let domains = skill.n.properties.domains;
        if(domains) {
            let domain = domains[0];
            console.log(`INSERT INTO Skill (name,domain_id,company_id) VALUES ('${name}', (SELECT id FROM Domain WHERE name = '${domain}' and company_id = 1), 1);`);
            console.log(`INSERT INTO Skill (name,domain_id,company_id) VALUES ('${name}', (SELECT id FROM Domain WHERE name = '${domain}' and company_id = 2), 2);`);
        } else {
            console.log(`INSERT INTO Skill (name,company_id) VALUES ('${name}', 1);`);
            console.log(`INSERT INTO Skill (name,company_id) VALUES ('${name}', 2);`);
        }
    });
});

db.cypher({
    query: 'MATCH (n:`XEBIAN`) RETURN n'
}, (err, users) => {
    users.forEach((user) => {
        let email = user.n.properties.email;
        let companyId = 1;
        if(email.toLowerCase().indexOf('wescale')>=0) {
            companyId = 2;
        }
        let diploma = user.n.properties.diploma;
        diploma = diploma ? `${diploma+"-01-01"}` : null;
        let displayName = user.n.properties.displayName;
        if(diploma) {
            console.log(`INSERT INTO User (company_id, diploma, email, name) VALUES (${companyId}, '${diploma}', '${email}', '${displayName}');`);
        } else {
            console.log(`INSERT INTO User (company_id, email, name) VALUES (${companyId}, '${email}', '${displayName}');`);
        }
    });
});

//INSERT INTO UserSkill(skill_id, user_id, level, interested) VALUES ((SELECT MIN(id) FROM Skill WHERE name = 'Dark Souls' AND company_id=1), (SELECT id FROM User WHERE email = 'llaroche@xebia.fr' AND company_id=1), 3, 1);

db.cypher({
    query: 'MATCH (user)-[r:`HAS`]->(skill) RETURN user,skill,r'
}, (err, userskills) => {
        userskills.forEach((userskill) => {
        //console.log(JSON.stringify(userskill));

        let skillName = userskill.skill.properties.name;
        let email = userskill.user.properties.email;
        let level = userskill.r.properties.level;
        let interested = userskill.r.properties.like === true ? 1 : 0;
        let companyId = 1;
        if(email.toLowerCase().indexOf('wescale')>=0) {
            companyId = 2;
        }

        console.log(`INSERT INTO UserSkill(skill_id, user_id, level, interested) VALUES ((SELECT MIN(id) FROM Skill WHERE name = '${skillName}' AND company_id=${companyId}), (SELECT id FROM User WHERE email = '${email}' AND company_id=${companyId}), ${level}, ${interested});`);

});
});