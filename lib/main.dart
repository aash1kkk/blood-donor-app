import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red[700],
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[700],
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ).apply(bodyColor: Colors.white, displayColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: GoogleFonts.poppins(color: Colors.grey[400]),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: Colors.red[700], size: 60),
            const SizedBox(height: 20),
            Text(
              'Welcome to Blood Donation',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Help save lives by connecting donors',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.group),
              label: const Text('View Donors'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonorListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Donor {
  final String name;
  final String bloodGroup;
  final String contact;

  Donor({required this.name, required this.bloodGroup, required this.contact});
}

class DonorListScreen extends StatefulWidget {
  const DonorListScreen({super.key});

  @override
  State<DonorListScreen> createState() => _DonorListScreenState();
}

class _DonorListScreenState extends State<DonorListScreen> {
  final List<Donor> _donors = [
    Donor(name: 'Aashik', bloodGroup: 'B+', contact: '6382781490'),
    Donor(name: 'Havertz', bloodGroup: 'A+', contact: '9876543213'),
    Donor(name: 'Mikel', bloodGroup: 'O+', contact: '7167931510'),
    Donor(name: 'Ojas', bloodGroup: 'O+', contact: '9115673107'),
    Donor(name: 'Prabu', bloodGroup: 'AB+', contact: '9567831071'),
    Donor(name: 'Mukul', bloodGroup: 'B+', contact: '9211711567'),
    Donor(name: 'Charan', bloodGroup: 'AB-', contact: '9147118323'),
    Donor(name: 'Sahana', bloodGroup: 'O+', contact: '9812767818'),
    Donor(name: 'Samaira', bloodGroup: 'B-', contact: '981762097'),
    Donor(name: 'Aymer', bloodGroup: 'O+', contact: '9711467310'),
    Donor(name: 'Saka', bloodGroup: 'A+', contact: '9071881367'),
    Donor(name: 'Timber', bloodGroup: 'O-', contact: '9926434671'),
    Donor(name: 'Jorge', bloodGroup: 'A-', contact: '7881907156'),
    Donor(name: 'Sanchita', bloodGroup: 'AB+', contact: '6192988167'),
    Donor(name: 'Mohit', bloodGroup: 'AB-', contact: '9310774814'),
    Donor(name: 'Hari', bloodGroup: 'A+', contact: '8776711267'),
    Donor(name: 'Nithik', bloodGroup: 'B+', contact: '9010721156'),
    Donor(name: 'Joshua', bloodGroup: 'B-', contact: '9812411467'),
    Donor(name: 'Merino', bloodGroup: 'O-', contact: '9319719597'),
  ];

  String? _selectedBloodGroup;
  final List<String> _bloodGroups = [
    'All',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  List<Donor> get _filteredDonors {
    if (_selectedBloodGroup == null || _selectedBloodGroup == 'All') {
      return _donors;
    }
    return _donors
        .where((donor) => donor.bloodGroup == _selectedBloodGroup)
        .toList();
  }

  Future<void> _makePhoneCall(String phoneNumber, String donorName) async {
    final sanitizedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: sanitizedNumber);
    final shouldCall = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey[850],
            title: Text(
              'Call $donorName?',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            content: Text(
              'Call $sanitizedNumber?',
              style: GoogleFonts.poppins(color: Colors.grey[400]),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(color: Colors.red[700]),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Call',
                  style: GoogleFonts.poppins(color: Colors.red[700]),
                ),
              ),
            ],
          ),
    );

    if (shouldCall != true) return;

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        await FlutterClipboard.copy(sanitizedNumber);
        if (!mounted) return;
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                backgroundColor: Colors.grey[850],
                title: Text(
                  'Dialer Unavailable',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                content: Text(
                  'Phone number $sanitizedNumber copied to clipboard. Paste it into a calling app.',
                  style: GoogleFonts.poppins(color: Colors.grey[400]),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'OK',
                      style: GoogleFonts.poppins(color: Colors.red[700]),
                    ),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error launching dialer: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donor List'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Filter by Blood Group',
                prefixIcon: Icon(Icons.filter_list, color: Colors.red[700]),
              ),
              value: _selectedBloodGroup,
              isExpanded: true,
              items:
                  _bloodGroups.map((String bloodGroup) {
                    return DropdownMenuItem<String>(
                      value: bloodGroup,
                      child: Text(bloodGroup),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBloodGroup = newValue;
                });
              },
            ),
          ),
          Expanded(
            child:
                _filteredDonors.isEmpty
                    ? Center(
                      child: Text(
                        'No donors found',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey[400],
                        ),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: _filteredDonors.length,
                      itemBuilder: (context, index) {
                        final donor = _filteredDonors[index];
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.red[700],
                              child: Text(
                                donor.bloodGroup,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              donor.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'Blood Group: ${donor.bloodGroup}\nContact: ${donor.contact}',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[400],
                              ),
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: Icon(Icons.phone, color: Colors.red[700]),
                              tooltip: 'Call ${donor.name}',
                              onPressed: () {
                                _makePhoneCall(donor.contact, donor.name);
                              },
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[700],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AddDonorScreen(
                    onAddDonor: (donor) {
                      setState(() {
                        _donors.add(donor);
                      });
                    },
                  ),
            ),
          );
        },
        tooltip: 'Add Donor',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddDonorScreen extends StatefulWidget {
  final Function(Donor) onAddDonor;

  const AddDonorScreen({super.key, required this.onAddDonor});

  @override
  State<AddDonorScreen> createState() => _AddDonorScreenState();
}

class _AddDonorScreenState extends State<AddDonorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  String? _selectedBloodGroup;
  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Donor'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a New Donor',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Colors.red[700]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  prefixIcon: Icon(Icons.bloodtype, color: Colors.red[700]),
                ),
                value: _selectedBloodGroup,
                items:
                    _bloodGroups.map((String bloodGroup) {
                      return DropdownMenuItem<String>(
                        value: bloodGroup,
                        child: Text(bloodGroup),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBloodGroup = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a blood group';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone, color: Colors.red[700]),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Add Donor'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final donor = Donor(
                        name: _nameController.text,
                        bloodGroup: _selectedBloodGroup!,
                        contact: _contactController.text,
                      );
                      widget.onAddDonor(donor);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
