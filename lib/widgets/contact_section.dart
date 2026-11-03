import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isLoading = false;
  String? _statusMessage;
  bool _success = false;

  // Replace this with your Formspree form endpoint.
  static const String formspreeUrl = 'https://formspree.io/f/mrppovbv';

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(formspreeUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          '_replyto': _emailController.text.trim(),
          'subject': _subjectController.text.trim(),
          'message': _messageController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _success = true;
          _statusMessage = 'Thank you! Your message has been sent.';
        });

        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      } else {
        setState(() {
          _success = false;
          _statusMessage = 'Unable to send your message. Please try again.';
        });
      }
    } catch (_) {
      setState(() {
        _success = false;
        _statusMessage = 'Something went wrong. Please check your connection.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }

          if (label == 'Email' &&
              !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
            return 'Please enter a valid email address';
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let’s Work Together',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Have a job opportunity, project, or question? '
                'Send me a message.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(width: 10),
                  SelectableText(
                    'manishsahu363@gmail.com',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _field(
                      label: 'Name',
                      controller: _nameController,
                      hint: 'Your full name',
                    ),
                    _field(
                      label: 'Email',
                      controller: _emailController,
                      hint: 'Your email address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _field(
                      label: 'Subject',
                      controller: _subjectController,
                      hint: 'Job opportunity / Project / Other',
                    ),
                    _field(
                      label: 'Message',
                      controller: _messageController,
                      hint: 'Describe your requirements...',
                      maxLines: 5,
                    ),
                    if (_statusMessage != null) ...[
                      Text(
                        _statusMessage!,
                        style: TextStyle(
                          color: _success ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isLoading ? null : _sendMessage,
                        icon: _isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send),
                        label: Text(
                          _isLoading ? 'Sending...' : 'Send Message',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
