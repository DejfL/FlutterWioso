import 'package:flutter/material.dart';
import 'package:flutter_wioso/const.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback func;

  const PrimaryButton(this.text, this.func, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            secondaryColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class SeccondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback func;
  final Image? icon;

  const SeccondaryButton(this.text, this.func, {Key? key})
      : icon = null,
        super(key: key);

  const SeccondaryButton.withIcon(this.text, this.func, this.icon, {Key? key})
      : super(key: key);

  Text _buildText() {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: secondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon as Widget,
                  const SizedBox(
                    width: 10,
                  ),
                  _buildText(),
                ],
              )
            : _buildText(),
        onPressed: () {},
      ),
    );
  }
}
