
import java.awt.Button;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.TextArea;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Enumeration;
import java.util.Set;
import java.util.LinkedHashSet;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.StreamMessage;
import javax.jms.TextMessage;
import javax.jms.Topic;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

public class Irc {
    public static final String MSG_DEMAND = new String("[DEMAND]");
    public static final String MSG_ANSWER = new String("[ANSWER]");
    public static final String MSG_CLOSED = new String("[CLOSED]");

    public static Set<String> users = new LinkedHashSet<String>();

	public static TextArea		text;
	public static TextField		data;
	public static Frame 		frame;

	public static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	public static String subject = "MyQueue";

	public static String myName;

	public static ConnectionFactory	connectionFactory;
	public static Connection       	connection;
	public static Session		session;
	public static MessageConsumer	consumer;
	public static MessageProducer	producer;
	public static Topic		topic;

	public static void main(String argv[]) {

		if (argv.length != 1) {
			System.out.println("java Irc <name>");
			return;
		}
		myName = argv[0];

		// creation of the GUI 
		frame=new Frame();
		frame.setLayout(new FlowLayout());

		text=new TextArea(10,55);
		text.setEditable(false);
		text.setForeground(Color.red);
		frame.add(text);

		data=new TextField(55);
		frame.add(data);

		Button write_button = new Button("write");
		write_button.addActionListener(new writeListener());
		frame.add(write_button);

		Button connect_button = new Button("connect");
		connect_button.addActionListener(new connectListener());
		frame.add(connect_button);

		Button who_button = new Button("who");
		who_button.addActionListener(new whoListener());
		frame.add(who_button);

		Button leave_button = new Button("leave");
		leave_button.addActionListener(new leaveListener());
		frame.add(leave_button);

		frame.setSize(470,300);
		text.setBackground(Color.black); 
		frame.setVisible(true);
	}

	/* allow to print something in the window */
	public static void print(String msg) {
		try {
			text.append(msg+"\n");
		} catch (Exception ex) {
			ex.printStackTrace();
		}	
	}
}



// action invoked when the "write" button is clicked
class writeListener implements ActionListener {
	public void actionPerformed (ActionEvent ae) {
		try {
			TextMessage message = Irc.session.createTextMessage();
            message.setText(Irc.data.getText());
            Irc.producer.send(message);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}

// action invoked when the "connect" button is clicked
class connectListener implements ActionListener {
	public void actionPerformed (ActionEvent ae) {
		try {  
            Irc.connectionFactory = new ActiveMQConnectionFactory(Irc.url);
            Irc.connection = Irc.connectionFactory.createConnection();
            Irc.connection.start();
            
            Irc.session = Irc.connection.createSession(false,Session.AUTO_ACKNOWLEDGE);
            
            Destination destination = Irc.session.createTopic(Irc.subject);

            Irc.producer = Irc.session.createProducer(destination);
            Irc.consumer = Irc.session.createConsumer(destination);

            MessageListener listener = new MessageListener() {
                public void onMessage(Message msg) {
                    try {
                        TextMessage textmsg = (TextMessage)msg;
                        if (textmsg.getText().startsWith(Irc.MSG_DEMAND)) {
                            TextMessage message = Irc.session.createTextMessage();
                            message.setText(Irc.MSG_ANSWER + Irc.myName);
                            Irc.producer.send(message);
                        } else if (textmsg.getText().startsWith(Irc.MSG_ANSWER)) {
                            Irc.users.add(textmsg.getText().substring(Irc.MSG_ANSWER.length(), textmsg.getText().length()));
                        } else if (textmsg.getText().startsWith(Irc.MSG_CLOSED)) {
                            Irc.users.remove(textmsg.getText().substring(Irc.MSG_ANSWER.length(), textmsg.getText().length()));
                        } else {
                            Irc.print(textmsg.getText()); 
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
            };
            Irc.consumer.setMessageListener(listener);

            TextMessage message = Irc.session.createTextMessage();
            message.setText(Irc.MSG_DEMAND);
            Irc.producer.send(message);
		} catch (Exception ex) { 
			ex.printStackTrace();
		}
	}
}  



// action invoked when the "who" button is clicked
class whoListener implements ActionListener {
	public void actionPerformed (ActionEvent ae) {
		try {
            Irc.print("Liste des utilisateurs:");
		    for (String user : Irc.users) {
                Irc.print(user);
            }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}


// action invoked when the "leave" button is clicked
class leaveListener implements ActionListener {
	public void actionPerformed (ActionEvent ae) {
		try {
            TextMessage message = Irc.session.createTextMessage();
            message.setText(Irc.MSG_CLOSED + Irc.myName);
            Irc.producer.send(message);
			Irc.connection.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}