Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A220EB64D9
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jul 2023 20:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGFUvq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjGFUvl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2023 16:51:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015F2103
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2023 13:51:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-5.bstnma.fios.verizon.net [173.48.102.5])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 366KpP6k028530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 16:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688676686; bh=+6C+phHx0nX41BBpQVc5UaC1I5eCYiSmS4evGSQZgio=;
        h=From:To:Cc:Subject:Date;
        b=C8uwCtEVJsqVlSTTCQMFkycW5qEeMaEsCjaNlN8IxQbjCQVtjhfFrz4AaMGUQMgi1
         FTPNLrpfzDSrHQgVghg9LdAuPoeRlIWS5meCanTRhllluGVgQMoOptDAX/0OQUOVN4
         M20l8KEw6eTq2l7WZca0uLJoRnITLxnGxq7O2+2wYjUP7+dXXplbOBWv7XIo4kztKt
         mw2WKLlW3WFD3Eyn7DgTH9O9vb57zydjTwyIfqLqxhhRZ3gVEIuesnusLRfct2E4KT
         ebw3BcfISJOmiK3gdg5FDnFwWfK6yyf7PDhbEu1/CP5xfgH8gSaPe7uC0BIy5woYwX
         8ydSXfE6B5iFw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A387E15C0294; Thu,  6 Jul 2023 16:42:34 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] report: safely update the result.xml file
Date:   Thu,  6 Jul 2023 16:42:31 -0400
Message-Id: <20230706204232.1577765-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After every single test, we rewrite result.xml from scratch.  This
ensures that the XML file is always in a valid, parseable state, even
if the check script is killed or the machine crashes in the middle of
a test.

If the test is being run in a Cloud VM as a "spot" (Amazon, Azure, or
GCE) or "preemptible" (Oracle) instance, it is possible that the VM
can be halted whenever the Cloud provider needs the capacity for
customers who are willing to pay full price.  ("Spot" instances can be
60% to 90% cheaper --- allowing the frugal kernel developer to get up
to 10 times more testing for the same amount of money.  :-)

Since a "spot" VM can get terminated at any time, it is possible for
the VM to be terminated immediately after a test has completed and
while the result.xml file is in the middle of being written out.  In
that case, the result.xml file could partially written, resulting in
an invalid result.xml file and lost information about the tests run
before the VM was terminated.

To address this race, write the new result.xml file as result.xml.new,
and only rename it to result.xml after the XML file is fully written
out.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/report | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/common/report b/common/report
index 9bfa09ecc..3ad14f94e 100644
--- a/common/report
+++ b/common/report
@@ -109,13 +109,15 @@ _xunit_make_section_report()
 	local notrun_count="$4"
 	local sect_time="$5"
 	local timestamp
+	local tmp_fn="$REPORT_DIR/result.xml.new"
+	local out_fn="$REPORT_DIR/result.xml"
 
 	if [ $sect_name == '-no-sections-' ]; then
 		sect_name='global'
 	fi
 	local report=$tmp.report.xunit.$sect_name.xml
 	# Header
-	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
+	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$tmp_fn"
 	if [ -n "$test_start_time" ]; then
 		timestamp="$(date -Iseconds --date="$test_start_time")"
 	else
@@ -123,7 +125,7 @@ _xunit_make_section_report()
 	fi
 
 	local fstests_ns="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git"
-	cat >> $REPORT_DIR/result.xml << ENDL
+	cat >> "$tmp_fn" << ENDL
 <testsuite
  xmlns="$fstests_ns"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
@@ -142,19 +144,20 @@ ENDL
 	__generate_report_vars
 
 	# Properties
-	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
+	echo -e "\t<properties>" >> "$tmp_fn"
 	(for key in "${!REPORT_VARS[@]}"; do
 		_xunit_add_property "$key" "${REPORT_VARS["$key"]}"
 	done;
 	for p in "${REPORT_ENV_LIST[@]}"; do
 		_xunit_add_property "$p" "${!p}"
-	done) | sort >> $REPORT_DIR/result.xml
-	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
+	done) | sort >> "$tmp_fn"
+	echo -e "\t</properties>" >> "$tmp_fn"
 	if [ -f $report ]; then
-		cat $report >> $REPORT_DIR/result.xml
+		cat $report >> "$tmp_fn"
 	fi
-	echo "</testsuite>" >> $REPORT_DIR/result.xml
-	echo "Xunit report: $REPORT_DIR/result.xml"
+	echo "</testsuite>" >> "$tmp_fn"
+	mv "$tmp_fn" "$out_fn"
+	echo "Xunit report: $out_fn"
 }
 
 _xunit_make_testcase_report()
-- 
2.31.0

