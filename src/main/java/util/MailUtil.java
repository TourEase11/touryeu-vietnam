package util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class MailUtil {

    private static final String FROM_EMAIL = "sinestreayue@gmail.com";
    private static final String PASSWORD = "yaqp jjkp lzab tcgk"; // App Password

    public static void sendBookingConfirmation(
            String toEmail,
            String customerName,
            String tourName,
            String departureDate,
            int numPeople,
            double totalPrice) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject("Xác nhận đặt tour");

            message.setText(
                    "Xin chào " + customerName + "\n\n" +
                    "Bạn đã đặt tour:\n" +
                    "- Tour: " + tourName + "\n" +
                    "- Ngày khởi hành: " + departureDate + "\n" +
                    "- Số người: " + numPeople + "\n" +
                    "- Tổng tiền: " + totalPrice + " VNĐ\n\n" +
                    "Cảm ơn bạn!"
            );

            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
