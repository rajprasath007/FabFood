import java.io.*;
import java.sql.*;

public class SqlEntry {
    public static void main(String[] args) {

        String imagePath = "E://Downloads/hotel.jpg";
        String url = "jdbc:mysql://localhost:3306/fooddelivery";
        String user = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "UPDATE restaurant SET image = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

                File file = new File(imagePath);
                if (!file.exists()) {
                    System.err.println("Error: File not found.");
                    return;
                }

                try (FileInputStream fis = new FileInputStream(file)) {
                    pstmt.setBinaryStream(1, fis, file.length());

                    int rowsAffected = pstmt.executeUpdate();
                    System.out.println(rowsAffected + " rows affected.");
                } catch (IOException e) {
                    System.err.println("Error reading the file: " + e.getMessage());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
