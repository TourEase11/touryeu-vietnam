package tourbook;

import util.DatabaseUtil;

public class Server {
    public static void main(String[] args) {
        try {
            // Initialize database
            System.out.println("Initializing database...");
            DatabaseUtil.getConnection();

            System.out.println("\n" +
                    "========================================\n" +
                    "   Tour Booking Application\n" +
                    "========================================\n");
            System.out.println("Server started successfully!");
            System.out.println("\nIMPORTANT: Please run this application using one of these methods:");
            System.out.println("\n1. Using Eclipse:");
            System.out.println("   - Import project into Eclipse");
            System.out.println("   - Right-click project > Run As > Run on Server");
            System.out.println("   - Select Tomcat 9.0");
            System.out.println("\n2. Using Maven:");
            System.out.println("   - Run: mvnw.cmd jetty:run");
            System.out.println("   - Open: http://localhost:8080");
            System.out.println("\n3. Using standalone Tomcat:");
            System.out.println("   - Build WAR file");
            System.out.println("   - Deploy to Tomcat webapps folder");
            System.out.println("\nDatabase initialized with:");
            System.out.println("  - Admin user: admin / admin123");
            System.out.println("  - Test user: user1 / user123");
            System.out.println("  - Sample tours and categories");
            System.out.println("\n========================================\n");

        } catch (Exception e) {
            System.err.println("Error starting server:");
            e.printStackTrace();
        }
    }
}
