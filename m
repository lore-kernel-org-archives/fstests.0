Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4061FEB64D9
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 19:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGGT3r (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjGGT1q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 15:27:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BB1BE1
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 12:27:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-26-156-224.bstnma.fios.verizon.net [108.26.156.224])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 367JR7Aw017026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 15:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688758028; bh=sRqItxLRuffNlLih98B+BJXWVfOKHMtM1fKQ1F8LnDE=;
        h=From:To:Cc:Subject:Date;
        b=UcGhN6yQcFBaIWtXqlVaIhfFiH6nRaPKaQUVaLRf/rFrMlhy46d/ENNi7qZ8LoMJ0
         zdoKJOdKzYNZOb+O0LSjl325Wpa9be8kDAkG68APmAbAINoJArRqPxSRvzK5PPvOGu
         wz/rH++qwNzl4C5Ndd+e8DpDcsLDUGTda0iv+1zn+gmAI8adUrOirVaQgi16SJHNhf
         otYBalIIYRNn/WrzKopYaEz0HfTLXZIsVThfned4Z+WIn/b4DvX2PZ3ORU6aGqqWzn
         U4xBKR7F2YFkZp3ygtn/z0EuEOSx7Y//QIu9lSDNy5QV5Y57Na7CdTHY7uXL2v9RZE
         p5yJMGUFfWiBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4E6CD15C0296; Fri,  7 Jul 2023 15:27:07 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH -v2 1/2] report: safely update the result.xml file
Date:   Fri,  7 Jul 2023 15:27:03 -0400
Message-Id: <20230707192704.2654426-1-tytso@mit.edu>
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
GCE) or "preemptible" (Oracle) instance, the VM can be halted whenever
the Cloud provider needs the capacity for customers who are willing to
pay full price.  ("Spot" instances can be 60% to 90% cheaper ---
allowing the frugal kernel developer to get up to 10 times more
testing for the same amount of money.  :-)

Since a "spot" VM can get terminated at any time, it is possible for
the check script to be killed while it is in the middle of rewriting
the result.xml file.  If the result.xml file is only partially
written, information regarding the tests run before VM termination
will be lost.

To address this race, write the new result.xml file as result.xml.new,
and only rename it to result.xml after the XML file is fully written
out.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---

Changes from v1:
  * make sure result.xml.new doesn't exist (it could be named pipe
    or a symlink or some other foolishness) before writing to it.
  * fsync result.xml.new before renaming it to result.xml
  * minor updates to the commit description

 common/report | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/common/report b/common/report
index 9bfa09ecc..3c58f0e3c 100644
--- a/common/report
+++ b/common/report
@@ -109,13 +109,16 @@ _xunit_make_section_report()
 	local notrun_count="$4"
 	local sect_time="$5"
 	local timestamp
+	local tmp_fn="$REPORT_DIR/result.xml.new"
+	local out_fn="$REPORT_DIR/result.xml"
 
 	if [ $sect_name == '-no-sections-' ]; then
 		sect_name='global'
 	fi
 	local report=$tmp.report.xunit.$sect_name.xml
+	rm -f "$tmp_fn"
 	# Header
-	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
+	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$tmp_fn"
 	if [ -n "$test_start_time" ]; then
 		timestamp="$(date -Iseconds --date="$test_start_time")"
 	else
@@ -123,7 +126,7 @@ _xunit_make_section_report()
 	fi
 
 	local fstests_ns="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git"
-	cat >> $REPORT_DIR/result.xml << ENDL
+	cat >> "$tmp_fn" << ENDL
 <testsuite
  xmlns="$fstests_ns"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
@@ -142,19 +145,20 @@ ENDL
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
+	sync "$tmp_fn" && mv "$tmp_fn" "$out_fn"
+	echo "Xunit report: $out_fn"
 }
 
 _xunit_make_testcase_report()
-- 
2.31.0

