import java.io.*;
import java.sql.*;

public class SqlEntry {
    public static void main(String[] args) {
        String imagePath = "E://Downloads/Dosa-Recipe-Step-By-Step-Instructions-scaled.jpg";  // Replace with the image file path
        String url = "jdbc:mysql://localhost:3306/fooddelivery"; // Database URL
        String user = "root";  // Database username
        String password = "root";  // Database password

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "update menu image = ? where name = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            	
            	pstmt.setString(2, "Dosa");
            	
                File file = new File(imagePath);
                try (FileInputStream fis = new FileInputStream(file)) {
                    pstmt.setBinaryStream(1, fis, (int) file.length()); // Set the image as BLOB
                }

                // Execute the insert
                int rowsAffected = pstmt.executeUpdate();
                System.out.println(rowsAffected + " rows affected.");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

