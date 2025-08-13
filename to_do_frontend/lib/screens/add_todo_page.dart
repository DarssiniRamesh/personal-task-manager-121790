import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../theme/app_theme.dart';

/// Add Todo screen mirroring the provided design:
/// - AppBar (height 118, bg #9395D3, back chevron, title "Add Task")
/// - Two underline fields: Title and Detail
/// - Primary "ADD" button (width = screen - 28, height ~65, radius 15)
// PUBLIC_INTERFACE
class AddTodoPage extends StatefulWidget {
  // PUBLIC_INTERFACE
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _detailCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _detailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<TodoProvider>().addTodo(
            title: _titleCtrl.text,
            subtitle: _detailCtrl.text,
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Stack(
        children: [
          // Content area below app bar
          Positioned.fill(
            top: 44 + AppTheme.appBarHeight,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Form(
                key: _formKey,
                child: Padding(
                  // Fields align to 356px width centered: use screen padding then ConstrainedBox
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 356),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title field
                          Text('Title', style: labelStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _titleCtrl,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: UnderlineInputBorder(),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 23.12 / 16,
                              color: AppTheme.color000000,
                            ),
                            validator: (v) {
                              if ((v ?? '').trim().isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 36),

                          // Detail field
                          Text('Detail', style: labelStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _detailCtrl,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: UnderlineInputBorder(),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 23.12 / 16,
                              color: AppTheme.color000000,
                            ),
                            validator: (v) {
                              if ((v ?? '').trim().isEmpty) {
                                return 'Please enter a detail';
                              }
                              return null;
                            },
                          ),

                          // Primary ADD button (width = screen - 28)
                          const SizedBox(height: 24),
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 386),
                              child: SizedBox(
                                width: double.infinity,
                                height: 65.0652,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.color9395d3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 6,
                                  ),
                                  onPressed: _submit,
                                  child: Text(
                                    'ADD',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Status bar placeholder
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 44,
            child: Container(color: AppTheme.colorWhite),
          ),

          // Custom AppBar with back chevron and "Add Task"
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            height: AppTheme.appBarHeight,
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
              color: AppTheme.color9395d3,
              child: Stack(
                children: [
                  // Back button
                  Positioned(
                    left: 0,
                    top: 20,
                    child: IconButton(
                      tooltip: 'Go back',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 32),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      // Offset to account for back button width similar to CSS margin-left: 44px
                      padding: const EdgeInsets.only(left: 44),
                      child: Text(
                        'Add Task',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
