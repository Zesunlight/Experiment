public class New {
    public static void main(String[] args) {
        LinkedList<Event> events = new LinkedList<>();
        events.add(new Event("2021-10-15 19:24:07"));
        events.add(new Event("2021-10-15 20:16:51"));
        events.add(new Event("2021-10-17 11:08:01"));
        events.add(new Event());
        events.add(new Event("2021-10-14 07:30:12"));

        events.sort(Comparator.comparing(Event::getCreateDate,
                Comparator.nullsLast(Comparator.naturalOrder())).reversed());
        for (Event event : events) {
            System.out.println(event.getCreateDate());
        }
    }
}

class Event {
    public Event(String createTime) {
        this.createDate = createTime;
    }

    public Event() {
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    private String createDate;
}
