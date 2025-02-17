const { Firestore } = require('@google-cloud/firestore');

// Instancier Firestore
const firestore = new Firestore();

exports.addIpToFirestore = async (req, res) => {
  const { ip_address, team_id } = req.body;  // Recevoir l'IP et un identifiant d'équipe

  try {
    // Ajouter l'IP dans Firestore
    const docRef = firestore.collection('minecraft_vms').doc(team_id);
    await docRef.set({
      ip_address: ip_address,
      created_at: new Date().toISOString(),
    });

    res.status(200).send('IP Address added to Firestore');
  } catch (error) {
    console.error('Error adding document: ', error);
    res.status(500).send('Error adding IP to Firestore');
  }
};
