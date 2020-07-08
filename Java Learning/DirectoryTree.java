import java.io.File;
import java.util.*;

public class Main {

    public static void main(String[] args) {
        String path = "A:\\IdeaProjects\\JavaItems";
//        File file = new File(path);
//        System.out.println(file.getName());
//        System.out.println(file.getAbsolutePath());
//        try {
//            System.out.println(file.getCanonicalPath());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        System.out.println(file.getPath());

        try {
            System.out.println(tree(path));
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    private static HashMap<String, HashMap> tree(String path) throws Exception {
        File file = new File(path);
        File[] files = file.listFiles();
        HashMap<String, HashMap> content = new HashMap<>();

        String[] pathSplit = path.split("\\\\");  // Win
        String dirName = pathSplit[pathSplit.length - 1];

        if (files == null) {
            throw new Exception("invalid path");
        } else {
            content.put("Directory", new HashMap<>());
            content.put("File", new HashMap<>());

            for (File f : files) {
                if (f.isDirectory()) {
                    HashMap<String, HashMap> next = tree(f.getAbsolutePath());  // recursive
                    content.get("Directory").put(f.getName(), next);
                } else {
                    content.get("File").put(f.getName(), new HashMap<>());
                }
            }
        }

        return tree;
    }

}
