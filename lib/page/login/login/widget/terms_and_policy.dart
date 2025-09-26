import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: T.termsAndPolicyTitle.tr,
            style: TextStyle(
              color: const Color(0xFF595959),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.18,
              letterSpacing: -0.30,
            ),
          ),
          TextSpan(
            text: T.termsTitle.tr,
            style: TextStyle(
              color: const Color(0xFF595959),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              height: 1.18,
              letterSpacing: -0.30,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //todo
              },
          ),
          TextSpan(
            text: T.and.tr,
            style: TextStyle(
              color: const Color(0xFF595959),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.18,
              letterSpacing: -0.30,
            ),
          ),
          TextSpan(
            text: T.policyTitle.tr,
            style: TextStyle(
              color: const Color(0xFF595959),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              height: 1.18,
              letterSpacing: -0.30,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //todo
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
