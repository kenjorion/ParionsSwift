import Nodemailer from 'nodemailer';
import Firebase from 'firebase';
import Nexmo from 'nexmo';
import mjml2html from 'mjml';

export const FirebaseAuth = Firebase.initializeApp({
  apiKey: 'AIzaSyCmFgBQZ4y_Vl2UClhV4F9SMZtIzZ2gYp4',
  authDomain: 'woosh-fff74.firebaseapp.com',
  projectId: 'woosh-fff74'
});

export const TransporterAuth = Nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'woosh.company@gmail.com',
    pass: 'aytwoosh2019'
  }
});

export const NexmoAuth = new Nexmo({
  apiKey: 'abcf1d28',
  apiSecret: 'ewTv0qj6KCErKlAD'
}, {
  debug: true
});

export const SocketEvents = {
  getAllWooshersLocation: 'getAllWooshersLocation',
  updateAllWooshersLocation: 'updateAllWooshersLocation',
  setWoosherLocation: 'setWoosherLocation',
  removeWoosherLocation: 'removeWoosherLocation',
  setClientOrder: 'setClientOrder',
  wooshFindNewOrder: 'wooshFindNewOrder',
  wooshReceiveOrder: 'wooshReceiveOrder',
  wooshNoOrderFound: 'wooshNoOrderFound',
  wooshAcceptOrder: 'wooshAcceptOrder',
  woosherUpdateLocation: 'woosherUpdateLocation',
  clientFindOrderActive: 'clientFindOrderActive',
  clientAcceptedOrderActive: 'clientAcceptedOrderActive',
  clientNoAcceptedOrderActive: 'clientNoAcceptedOrderActive',
  clientCancelOrder: 'clientCancelOrder',
  clientGetWoosherLocationWithOrder: 'clientGetWoosherLocationWithOrder',
  clientReceiveWoosherLocationWithOrder: 'receiveWoosherLocationWithOrder',
};



export const htmlMail = mjml2html(`
<mjml>
  <mj-body>
    <mj-section>
      <mj-column>
        <mj-image width="100px" src="/images/woosh_logo@3x.png"></mj-image>
      </mj-column>
    </mj-section>
    <mj-section background-url="https://images.pexels.com/photos/713297/pexels-photo-713297.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260" background-size="cover" background-repeat="no-repeat">
      <mj-column width="600px">
        <mj-spacer height="200px" />
      </mj-column>
    </mj-section>
    <mj-raw>
      <!-- Intro text -->
    </mj-raw>
    <mj-section background-color="#fafafa">

      <mj-column width="400px">
        <mj-text font-style="italic" font-size="20px" font-family="Helvetica Neue" color="#626262">Bienvenue chez Woosh !</mj-text>
        <mj-text color="#525252">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rutrum enim eget magna efficitur, eu semper augue semper. Aliquam erat volutpat. Cras id dui lectus. Vestibulum sed finibus lectus, sit amet suscipit nibh. Proin nec commodo purus.
          Sed eget nulla elit. Nulla aliquet mollis faucibus.</mj-text>
      </mj-column>
    </mj-section>
  </mj-body>
</mjml>
`).html;
