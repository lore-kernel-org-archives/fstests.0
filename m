Received: from mail-wm0-f66.google.com ([74.125.82.66]:33823 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934881AbdACJP2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2017 04:15:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so47309191wmi.1
        for <fstests@vger.kernel.org>; Tue, 03 Jan 2017 01:15:28 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 3/3] check: document tests include/exclude options
Date: Tue,  3 Jan 2017 11:15:14 +0200
Message-Id: <1483434914-15909-1-git-send-email-amir73il@gmail.com>
In-Reply-To: <1483363379-10210-2-git-send-email-amir73il@gmail.com>
References: <1483363379-10210-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add argument description and examples to usage() for the
various tests include and exclude options.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 8d1ec71..5a93c94 100755
--- a/check
+++ b/check
@@ -80,9 +80,36 @@ check options
 testlist options
     -g group[,group...]	include tests from these groups
     -x group[,group...]	exclude tests from these groups
-    -X file		exclude individual tests
+    -X exclude_file	exclude individual tests
     -E external_file	exclude individual tests
     [testlist]		include tests matching names in testlist
+
+testlist argument is a list of tests in the form of <test dir>/<test name>.
+
+<test dir> is a directory under tests that contains a group file,
+with a list of the names of the tests in that directory.
+
+<test name> may be either a specific test file name (e.g. xfs/001) or
+a test file name match pattern (e.g. xfs/*).
+
+group argument is either a name of a tests group to collect from all
+the test dirs (e.g. quick) or a name of a tests group to collect from
+a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
+
+exclude_file argument refers to a name of a file inside each test directory.
+for every test dir where this file is found, the listed test names are
+excluded from the list of tests to run from that test dir.
+
+external_file argument is a path to a single file containing a list of tests
+to exclude in the form of <test dir>/<test name>.
+
+examples:
+ check xfs/001
+ check -g quick
+ check -g xfs/quick
+ check -x stress xfs/*
+ check -X .exclude -g auto
+ check -E ~/.xfstests.exclude
 '
 	    exit 0
 }
-- 
2.7.4

