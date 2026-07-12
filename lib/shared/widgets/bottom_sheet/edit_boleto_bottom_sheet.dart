import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/store/boletos_store.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/format_currency.dart';
import 'package:payflow/shared/widgets/app_toast/app_toast.dart';
import 'package:payflow/shared/widgets/button/button.dart';
import 'package:payflow/shared/widgets/modals/delete_boleto_modal.dart';

class EditBoletoBottomSheet extends StatefulWidget {
  final BoletoModel data;

  const EditBoletoBottomSheet({super.key, required this.data});

  @override
  State<EditBoletoBottomSheet> createState() => _EditBoletoBottomSheetState();
}

class _EditBoletoBottomSheetState extends State<EditBoletoBottomSheet> {
  Future<void> _handleMarkBoletoAsPaid() async {
    try {
      final updatedBoleto = widget.data.copyWith(paid: true);

      await BoletosStore.instance.update(updatedBoleto);

      AppToast.success(context, "Boleto marcado como pago com sucesso!");
    } catch (e) {
      AppToast.error(context, "Erro ao marcar boleto como pago.");
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> _handleMarkBoletoAsUnpaid() async {
    try {
      final updatedBoleto = widget.data.copyWith(paid: false);

      await BoletosStore.instance.update(updatedBoleto);

      AppToast.success(context, "Boleto marcado como não pago com sucesso!");
    } catch (e) {
      AppToast.error(context, "Erro ao marcar boleto como não pago.");
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> _handleDeleteBoleto() async {
    try {
      await BoletosStore.instance.remove(widget.data.id);
      AppToast.success(context, "Boleto deletado com sucesso!");
    } catch (e) {
      AppToast.error(context, "Erro ao deletar o boleto.");
    } finally {
      Navigator.pop(context);
    }
  }

  Text _unpaidBoletoText() {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "O boleto ",
        style: AppTextStyles.headingMdRegular.copyWith(
          color: AppColors.heading,
        ),
        children: [
          TextSpan(
            text: "${widget.data.name}\n",
            style: AppTextStyles.headingMd.copyWith(color: AppColors.heading),
          ),
          TextSpan(
            text: "no valor de R\$ ",
            style: AppTextStyles.headingMdRegular.copyWith(
              color: AppColors.heading,
            ),
          ),
          TextSpan(
            text: "${formatCurrency(value: widget.data.value!)}\n",
            style: AppTextStyles.headingMd.copyWith(color: AppColors.heading),
          ),
          TextSpan(
            text: "foi pago?",
            style: AppTextStyles.headingMdRegular.copyWith(
              color: AppColors.heading,
            ),
          ),
        ],
      ),
    );
  }

  Text _paidBoletoText() {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Desmarcar o boleto ",
        style: AppTextStyles.headingMdRegular.copyWith(
          color: AppColors.heading,
        ),
        children: [
          TextSpan(
            text: "${widget.data.name}\n",
            style: AppTextStyles.headingMd.copyWith(color: AppColors.heading),
          ),
          TextSpan(
            text: "no valor de R\$ ",
            style: AppTextStyles.headingMdRegular.copyWith(
              color: AppColors.heading,
            ),
          ),
          TextSpan(
            text: "${formatCurrency(value: widget.data.value!)}\n",
            style: AppTextStyles.headingMd.copyWith(color: AppColors.heading),
          ),
          TextSpan(
            text: "como pago?",
            style: AppTextStyles.headingMdRegular.copyWith(
              color: AppColors.heading,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Draggable indicator
          Container(
            width: 43,
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.input,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          // Text
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: (widget.data.paid == true)
                ? _paidBoletoText()
                : _unpaidBoletoText(),
          ),

          // Buttons
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Button(
                  label: (widget.data.paid == true) ? "Não" : "Ainda não",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  variant: ButtonVariant.secondary,
                ),
                Button(
                  label: "Sim",
                  onTap: () async {
                    if (widget.data.paid == true) {
                      await _handleMarkBoletoAsUnpaid();
                    } else {
                      await _handleMarkBoletoAsPaid();
                    }
                  },
                ),
              ],
            ),
          ),

          // Delete Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.stroke, width: 1),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteBoletoModal(
                      data: widget.data,
                      onConfirm: _handleDeleteBoleto,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                foregroundColor: AppColors.delete,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(Icons.delete_outline, size: 20, color: AppColors.delete),
                  Text("Deletar boleto", style: AppTextStyles.textMd),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
