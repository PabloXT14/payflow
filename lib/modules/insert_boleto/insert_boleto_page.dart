import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  const InsertBoletoPage({super.key});

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  String? barcode;

  final controller = InsertBoletoController();

  final moneyInputTextFormatter = CurrencyTextInputFormatter.currency(
    locale: "pt_BR",
    symbol: "R\$",
    decimalDigits: 2,
  );

  final dueDateInputTextFormatter = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final barcodeTextInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Lê o argumento passado pelo Navigator
    barcode = ModalRoute.of(context)?.settings.arguments as String?;

    // ✅ Se o argumento existir, preenche o campo de código de barras
    if (barcode != null) {
      barcodeTextInputController.text = barcode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.input),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),

        child: Column(
          children: [
            // TITLE
            Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 24),
                width: 216,
                child: Text(
                  "Preencha os dados do boleto",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingMd.copyWith(
                    color: AppColors.heading,
                  ),
                ),
              ),
            ),

            // INPUTS
            Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteractionIfError,
              child: Column(
                spacing: 16,
                children: [
                  InputText(
                    hint: "Nome do boleto",
                    icon: Icon(
                      Icons.description_outlined,
                      size: 24,
                      color: AppColors.primary,
                    ),
                    validator: controller.validateName,
                    onChanged: (value) {
                      controller.onChange(name: value);
                    },
                  ),

                  InputText(
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [dueDateInputTextFormatter],
                    hint: "Vencimento",
                    icon: FaIcon(
                      FontAwesomeIcons.circleXmark,
                      size: 24,
                      color: AppColors.primary,
                    ),
                    validator: controller.validateDueDate,
                    onChanged: (value) {
                      controller.onChange(dueDate: value);
                    },
                  ),
                  InputText(
                    keyboardType: TextInputType.number,
                    inputFormatters: [moneyInputTextFormatter],
                    hint: "Valor",
                    icon: FaIcon(
                      FontAwesomeIcons.wallet,
                      size: 24,
                      color: AppColors.primary,
                    ),
                    validator: (value) => controller.validateValue(
                      moneyInputTextFormatter.getUnformattedValue().toDouble(),
                    ),
                    onChanged: (value) {
                      controller.onChange(
                        value: moneyInputTextFormatter
                            .getUnformattedValue()
                            .toDouble(),
                      );
                    },
                  ),
                  InputText(
                    controller: barcodeTextInputController,
                    hint: "Código",
                    icon: FaIcon(
                      FontAwesomeIcons.barcode,
                      size: 24,
                      color: AppColors.primary,
                    ),
                    validator: controller.validateBarcode,
                    onChanged: (value) {
                      controller.onChange(barcode: value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        backgroundColor: AppColors.background,
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () {
          controller.onSubmit();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
