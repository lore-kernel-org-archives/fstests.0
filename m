Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47582 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935253AbaKNN3N (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:29:13 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 2/7] Created empty environment files in test categories
Date: Fri, 14 Nov 2014 14:27:42 +0100
Message-Id: <1415971667-16873-2-git-send-email-jtulak@redhat.com>
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This patch creates empty enviornment files in test categories, because
part of the underlying infrastructure is common with parsing group
files. So nonexistence of these files causes error messages.  (Althoug
it should not break anything)

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 tests/btrfs/environment   | 7 +++++++
 tests/ext4/environment    | 7 +++++++
 tests/generic/environment | 7 +++++++
 tests/shared/environment  | 7 +++++++
 tests/udf/environment     | 7 +++++++
 tests/xfs/environment     | 7 +++++++
 6 files changed, 42 insertions(+)
 create mode 100644 tests/btrfs/environment
 create mode 100644 tests/ext4/environment
 create mode 100644 tests/generic/environment
 create mode 100644 tests/shared/environment
 create mode 100644 tests/udf/environment
 create mode 100644 tests/xfs/environment

diff --git a/tests/btrfs/environment b/tests/btrfs/environment
new file mode 100644
index 0000000..238a8c2
--- /dev/null
+++ b/tests/btrfs/environment
@@ -0,0 +1,7 @@
+# QA environments control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
diff --git a/tests/ext4/environment b/tests/ext4/environment
new file mode 100644
index 0000000..238a8c2
--- /dev/null
+++ b/tests/ext4/environment
@@ -0,0 +1,7 @@
+# QA environments control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
diff --git a/tests/generic/environment b/tests/generic/environment
new file mode 100644
index 0000000..238a8c2
--- /dev/null
+++ b/tests/generic/environment
@@ -0,0 +1,7 @@
+# QA environments control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
diff --git a/tests/shared/environment b/tests/shared/environment
new file mode 100644
index 0000000..238a8c2
--- /dev/null
+++ b/tests/shared/environment
@@ -0,0 +1,7 @@
+# QA environments control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
diff --git a/tests/udf/environment b/tests/udf/environment
new file mode 100644
index 0000000..238a8c2
--- /dev/null
+++ b/tests/udf/environment
@@ -0,0 +1,7 @@
+# QA environments control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
diff --git a/tests/xfs/environment b/tests/xfs/environment
new file mode 100644
index 0000000..238a8c2
--- /dev/null
+++ b/tests/xfs/environment
@@ -0,0 +1,7 @@
+# QA environments control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
-- 
1.9.3

