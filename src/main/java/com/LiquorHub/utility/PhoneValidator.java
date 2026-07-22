package com.LiquorHub.utility;

/**
 * Accepts either a strict 10-digit local number, or an international number
 * with a leading country code (+E.164 style).
 */
public final class PhoneValidator {

	public static final String HINT =
			"Use 10 digits (e.g. 9876543210) or international with country code (e.g. +919876543210).";

	private PhoneValidator() {
	}

	/** Strip spaces, dashes, parentheses, and dots. Keeps leading +. */
	public static String normalize(String raw) {
		if (raw == null) {
			return "";
		}
		String s = raw.trim();
		boolean plus = s.startsWith("+");
		s = s.replaceAll("[\\s().\\-]", "");
		if (plus && !s.startsWith("+")) {
			s = "+" + s.replace("+", "");
		} else if (!plus) {
			s = s.replace("+", "");
		}
		return s;
	}

	public static boolean isValid(String raw) {
		String phone = normalize(raw);
		if (phone.isEmpty()) {
			return false;
		}
		// Strict 10-digit local
		if (phone.matches("\\d{10}")) {
			return true;
		}
		// International: + then 8–15 digits (E.164)
		return phone.matches("\\+[1-9]\\d{7,14}");
	}
}
