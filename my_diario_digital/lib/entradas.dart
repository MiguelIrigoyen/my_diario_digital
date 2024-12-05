//import '/flutter_flow/flutter_flow_icon_button.dart';
//import '/flutter_flow/flutter_flow_theme.dart';
//import '/flutter_flow/flutter_flow_util.dart';
//import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'entradas_model.dart';
export 'entradas_model.dart';

class EntradasWidget extends StatefulWidget {
  /// create a page with a top bar that contains from left to right: a home
  /// button that directs you to the main screen, a button with the text
  /// "Categorias", another button with the text "Por fecha", another button
  /// with the text "Por lugar". below that, a list of containers that take up
  /// the whole width of the screen and a height of 100px, these contain a small
  /// image to the left of the container, top middle will be a medium text with
  /// a date, and below that text, a smaller text with a brief description
  const EntradasWidget({super.key});

  @override
  State<EntradasWidget> createState() => _EntradasWidgetState();
}

class _EntradasWidgetState extends State<EntradasWidget> {
  late EntradasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @overrideg
  void initState() {
    super.initState();
    _model = createModel(context, () => EntradasModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 2,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.home,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Categorias',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.transparent,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                letterSpacing: 0.0,
                              ),
                              elevation: 0,
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Fecha',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.transparent,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                letterSpacing: 0.0,
                              ),
                              elevation: 0,
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Ubicacion',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.transparent,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                letterSpacing: 0.0,
                              ),
                              elevation: 0,
                            ),
                          ),
                        ].divide(SizedBox(width: 16)),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1624715153088-8f2b8478cfb1?w=500&h=500',
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '15 de Junio, 2023',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      'Descripcion',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4)),
                                ),
                              ),
                            ].divide(SizedBox(width: 16)),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1726688203956-ef774c2d73c3?w=500&h=500',
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '12 de Junio, 2023',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      'Descripcion',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4)),
                                ),
                              ),
                            ].divide(SizedBox(width: 16)),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1723758099039-9bdb1cac795d?w=500&h=500',
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '8 de Junio, 2023',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      'Descripcion',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4)),
                                ),
                              ),
                            ].divide(SizedBox(width: 16)),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1656596991280-e7029666071e?w=500&h=500',
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5 de Junio, 2023',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      'Descripcion',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4)),
                                ),
                              ),
                            ].divide(SizedBox(width: 16)),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1483809715206-0499044b5b69?w=500&h=500',
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1 de Junio, 2023',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      'Descripcion',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4)),
                                ),
                              ),
                            ].divide(SizedBox(width: 16)),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 12)).around(SizedBox(height: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
