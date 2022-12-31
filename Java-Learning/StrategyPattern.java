import java.util.*;


//定义策略接口
interface DealStrategy{
    void dealMythod(String option);
}


//定义具体的策略1
class DealSina implements DealStrategy {
    @Override
    public void dealMythod(String option) {
        System.out.println("sina");
    }
}


//定义具体的策略2
class DealWeChat implements DealStrategy {
    @Override
    public void dealMythod(String option) {
        System.out.println("wechat");
    }
}


//定义上下文，负责使用DealStrategy角色
class DealContext {
    private String type;
    private DealStrategy deal;

    public DealContext(String type,DealStrategy deal) {
        this.type = type;
        this.deal = deal;
    }

    public DealStrategy getDeal() {
        return deal;
    }

    public boolean options(String type) {
        return this.type.equals(type);
    }
}


public class StrategyPattern {
    private static List<DealContext> algs = new ArrayList();
    static {
        algs.add(new DealContext("Sina", new DealSina()));
        algs.add(new DealContext("WeChat", new DealWeChat()));
    }

    public static void shareOptions(String type) {
        DealStrategy dealStrategy = null;
        for (DealContext deal : algs) {
            if (deal.options(type)) {
                dealStrategy = deal.getDeal();
                break;
            }
        }
        assert dealStrategy != null;
        dealStrategy.dealMythod(type);
    }

    public static void main(String[] args) {
        shareOptions("Sina");
    }
}