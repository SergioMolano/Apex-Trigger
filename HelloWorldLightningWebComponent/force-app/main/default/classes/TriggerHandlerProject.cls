public class TriggerHandlerProject extends TriggerHandler {
    
    public override void beforeInsert() {
        for (Account acc : (List<Account>) Trigger.new) {
            if (acc.Name != null && acc.Name.length() <= 80 - 10) {
                acc.Name += ' - Adaptus';
            } else if (acc.Name != null && acc.Name.length() > 80 - 10) {
                acc.Name = acc.Name.substring(0, 80 - 10) + ' - Adaptus';
            }
        }
    }

    public override void afterInsert() {
        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : (List<Account>) Trigger.new) {
            Contact newContact = new Contact(
                FirstName = 'Candidate name',
                LastName = 'Candidate lastname',
                AccountId = acc.Id,
                Email = 'candidate_name@adaptus.com'
            );
            contactsToInsert.add(newContact);
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }

    public override void afterUpdate() {
        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : (List<Account>) Trigger.new) {
            Contact newContact = new Contact(
                FirstName = 'Candidate name',
                LastName = 'Candidate lastname',
                AccountId = acc.Id,
                Email = 'candidate_name@adaptus.com'
            );
            contactsToInsert.add(newContact);
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }

    public override void afterDelete() {
        List<Task> tasksToInsert = new List<Task>();

        for (Account acc : (List<Account>) Trigger.old) {
            Task newTask = new Task(
                Subject = 'Deleted account ' + acc.Name,
                ActivityDate = Date.today()
            );
            tasksToInsert.add(newTask);
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}
