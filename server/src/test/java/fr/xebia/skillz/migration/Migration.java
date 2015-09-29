package fr.xebia.skillz.migration;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import java.io.File;
import java.io.IOException;

import static java.text.MessageFormat.format;

public class Migration {

    public static void main(String[] args) throws IOException {
        //migrateSkills();
        //migrateAllies();
        migrateUserSkills();
    }

    private static void migrateUserSkills() throws IOException {
        JsonFactory jsonFactory = new JsonFactory();
        JsonParser jp = jsonFactory.createJsonParser(new File("src/test/resources/UserSkills.json"));
        jp.setCodec(new ObjectMapper());
        JsonNode jsonNode = jp.readValueAsTree();

        JsonNode table = jsonNode.get("table");
        JsonNode response = table.get("_response");
        ArrayNode data = (ArrayNode) response.get("data");
        for (JsonNode node : data) {
            JsonNode userRow = node.get("row").get(0);
            JsonNode skillRow = node.get("row").get(1);
            JsonNode userSkillRow = node.get("row").get(2);

            String userEmail = userRow.get("email").asText();
            String skillName = skillRow.get("name").asText();
            int level = userSkillRow.get("level").asInt();
            boolean like = userSkillRow.get("like").asBoolean();
            int company = 1;
            if (userEmail.endsWith("wescale.fr")) {
                company = 2;
            }
            System.err.println(format("INSERT INTO UserSkill(skill_id, user_id, level, interested) VALUES ((SELECT MIN(id) FROM Skill WHERE name = ''{0}'' AND company_id={4}), (SELECT id FROM User WHERE email = ''{1}'' AND company_id={4}), {2}, {3});", skillName, userEmail, level, like ? 1 : 0, company));
        }
    }

    private static void migrateAllies() throws IOException {
        JsonFactory jsonFactory = new JsonFactory();
        JsonParser jp = jsonFactory.createJsonParser(new File("src/test/resources/xebians.json"));
        jp.setCodec(new ObjectMapper());
        JsonNode jsonNode = jp.readValueAsTree();

        JsonNode table = jsonNode.get("table");
        JsonNode response = table.get("_response");
        ArrayNode data = (ArrayNode) response.get("data");
        for (JsonNode node : data) {
            JsonNode row = node.get("row").get(0);
            String displayName = row.get("displayName").asText();
            String email = row.get("email").asText();
            JsonNode diplomaNode = row.get("diploma");
            String diploma;
            if (diplomaNode == null) {
                diploma = "2015";
            } else {
                diploma = diplomaNode.asText();
            }
            int companyId = email.endsWith("xebia.fr") ? 1 : 2;
            System.err.println(String.format("INSERT INTO User (company_id, diploma, email, name) VALUES (%d, '%s-01-01', '%s', '%s');", companyId, diploma, email, displayName));
        }
    }

    private static void migrateSkills() throws IOException {
        JsonFactory jsonFactory = new JsonFactory();
        JsonParser jp = jsonFactory.createJsonParser(new File("src/test/resources/skills.json"));
        jp.setCodec(new ObjectMapper());
        JsonNode jsonNode = jp.readValueAsTree();

        JsonNode table = jsonNode.get("table");
        JsonNode response = table.get("_response");
        ArrayNode data = (ArrayNode) response.get("data");
        for (JsonNode node : data) {
            JsonNode row = node.get("row").get(0);
            String name = row.get("name").asText();
            String domain = "";
            if (row.get("domains") != null) {
                domain = row.get("domains").get(0).asText();
            }
            System.err.println("INSERT INTO Skill (name,domain_id,company_id) VALUES ('" + name + "', " + byName(domain) + ", " + 1 + ");");
            System.err.println("INSERT INTO Skill (name,domain_id,company_id) VALUES ('" + name + "', " + byName(domain) + ", " + 2 + ");");
        }
    }

    private static Long byName(String domain) {
        switch (domain) {
            case "Agile":
                return 1L;
            case "Craft":
                return 2L;
            case "Mobile":
                return 3L;
            case "Back":
                return 4L;
            case "Cloud":
                return 5L;
            case "Devops":
                return 6L;
            case "Data":
                return 7L;
        }

        return null;
    }

}
