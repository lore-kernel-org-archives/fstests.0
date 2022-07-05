Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B471C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Jul 2022 08:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiGEITg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Jul 2022 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGEITf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Jul 2022 04:19:35 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87CCD3
        for <fstests@vger.kernel.org>; Tue,  5 Jul 2022 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1657009172; i=@fujitsu.com;
        bh=wlGn66poADMkbDo8S9J+7XOQwp4D30aqki4rakZkuM8=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=N2UqYx3b45Xb0/WTtHtCPlskt/8pqS3a5Xa/j2+dIyUPNXOYLUcWuzGXx4TO+9UaC
         XFsRr/Qs40LMsoNUizEYJd1Wbt3xCWA/UUbyckBhkhZWBJz8IxW1A6KuaSbs9Ozb1V
         YnKna7u1+tToxXT9qJolxj1b9dsBQzXoMqbw+x/U9hpBFmcaHbjhZ+cRWk4jvv4Xso
         6lzLe+AvWERdBWCFUv9cu93rVSKnVsDdHXj0KB5WsSQO9wJgEdhMpCHpvTBd1cLqPB
         eiB1RGjwplr6uk9JmaM5p30ieidS3LqQYIDZUWY4OUGbhI/PHHDqBQgQYdMtOGTG8O
         8h6YIrjQE6DJw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8ORpCvy5XC
  SwZc/khanW/ayOzB6fN4kF8AYxZqZl5RfkcCacfLvfeaC2VwVH5ta2RsYL3N0MXJxCAmcZ5RY
  cHkDK4RzkEni6fYJUM5uRonrH54zdTFycrAJaEo861zADGKLCMhK/J+xGizOLKAusXzSLzBbW
  MBQ4vDufWA2i4CKxIk5O9lBbF4BD4kZD+aCxSUEFCSmPHzPDBEXlDg58wkLxBwJiYMvXjBD1C
  hKXOr4xghhV0i8PnwJKq4mcfXcJuYJjPyzkLTPQtK+gJFpFaNVUlFmekZJbmJmjq6hgYGuoaG
  prpmukaGBXmKVbqJeaqlueWpxia6hXmJ5sV5qcbFecWVuck6KXl5qySZGYFCmFLNd2sE4t++n
  3iFGSQ4mJVHeWw8PJwnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4J33ESgnWJSanlqRlpkDjBCYt
  AQHj5IIbylImre4IDG3ODMdInWK0ZhjbcOBvcwcU2f/288sxJKXn5cqJc477RNQqQBIaUZpHt
  wgWOReYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMy/AZaApPZl4J3L5XQKcwAZ1yo+oAyCk
  liQgpqQYmVYUrE6yP/DmmZvb5coFxD88B8QVz70+Oe257KHbVydU3n+QqBb8zET1nrsnAHvJ1
  97ycWzfV+ir8Tgb80jC3lrvS1RV2Yfea8hvuou+2LrjROHP7HROB1UqP3Bhz7rRHlVSeeXtKY
  j///Em8x29drbLU85PPquLI2cPxd9H6eRLfJ0eFMDY+OK1by7k3kIvrhIr6Mj6v9W4docc976
  05Nv8tp1CB5f8DFy+9DZ734wLXpImyb2zYGv4/K7qRJniec2KDiRR77/e3uwx9djn/dvNsSyk
  8lLrGSOC4hrXxGc7vfNOmiT3hm9QktkrxV9DhFNHlEy7elY3a8kzYOnimjqIa024NzWKn+25n
  P75iV2Ipzkg01GIuKk4EAEFuT8BXAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-587.messagelabs.com!1657009172!259268!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6966 invoked from network); 5 Jul 2022 08:19:32 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-13.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Jul 2022 08:19:32 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 0EFB71AC
        for <fstests@vger.kernel.org>; Tue,  5 Jul 2022 09:19:32 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 033D47C
        for <fstests@vger.kernel.org>; Tue,  5 Jul 2022 09:19:32 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 5 Jul 2022 09:19:30 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 1/2] xfs/270: Fix syntax error
Date:   Tue, 5 Jul 2022 17:20:07 +0800
Message-ID: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Without xfsprogs commit
f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()"),
this case will fail as below:

+/var/lib/xfstests/tests/xfs/270: line 51: [: !=: unary operator expected

With this xfsprogs bug, xfs_db can't get new_ro_compat value, so report
this bash syntax error.

Fix this and add a helper output for xfsprogs bug.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/270 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/270 b/tests/xfs/270
index b740c379..4954e943 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -47,9 +47,12 @@ _scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
 new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
 						2>/dev/null)
 
-# verify the new ro_compat field is correct.
-if [ $new_ro_compat != $ro_compat ]; then
+# verify the new ro_compat field is correct. Without xfsprogs commit
+# f4afdcb0ad ("xfs_db: clean up the salvage read callsites in set_cur()"),
+# we can't get new_ro_compat value.
+if [ "$new_ro_compat" != "$ro_compat" ]; then
 	echo "Unable to set new features_ro_compat. Wanted $ro_compat, got $new_ro_compat"
+	echo "May hit a known xfsprog bug"
 fi
 
 # rw mount with unknown ro-compat feature should fail
-- 
2.27.0

