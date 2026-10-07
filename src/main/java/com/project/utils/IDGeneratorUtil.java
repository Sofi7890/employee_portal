package com.project.utils;

import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Simple development-time ID generator.
 * NOT safe for concurrent production use.
 */
public final class IDGeneratorUtil {
    private IDGeneratorUtil() {}

    private static final Pattern FINAL_DIGITS = Pattern.compile("(\\d+)$");

    public static String nextId(List<String> existingIds, String prefix, int width) {
        if (width < 1) throw new IllegalArgumentException("width must be >= 1");
        String safePrefix = (prefix == null) ? "" : prefix;

        int max = 0;
        if (existingIds != null) {
            for (String id : existingIds) {
                if (id == null) continue;
                if (!safePrefix.isEmpty() && !id.startsWith(safePrefix)) continue;
                Optional<Integer> n = extractNumber(id);
                if (n.isPresent()) max = Math.max(max, n.get());
            }
        }

        int next = max + 1;
        String fmt = "%s%0" + width + "d";
        return String.format(fmt, safePrefix, next);
    }

    private static Optional<Integer> extractNumber(String id) {
        if (id == null) return Optional.empty();
        Matcher m = FINAL_DIGITS.matcher(id.trim());
        if (m.find()) {
            try {
                return Optional.of(Integer.parseInt(m.group(1)));
            } catch (NumberFormatException ex) {
                return Optional.empty();
            }
        }
        return Optional.empty();
    }
}
