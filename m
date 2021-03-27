Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C5C433DB
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B42619F8
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhC0LTZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 27 Mar 2021 07:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhC0LTZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Mar 2021 07:19:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D064619B8;
        Sat, 27 Mar 2021 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616843965;
        bh=DEunEqC3VXLWkZsewrLlvevuay3Grko/mnvA/dpNEz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxdPa3yKEc4B2alSbesboExgHJqpgv/2LrPeR1cQwXbxrFmHX7MYMAQMp+5Swq2IO
         g73gj6UpnvTkpT4nOuPYCzcjK7mXtPpOZn5N6UMF6aVf+rxFVdPqtMxy08uGlV9uiP
         oqTlxRPCXBS9Y8YwWqkeRfGuHiU18ISGT3W9EWDPEWC8PCCFtk5Ny/8Gu9C4rljU88
         O9pEnD9UIAzpAgV0kCKfI55QT9Ljb3RKuPLwdUl+Zd61mzUhgpBoFsh3RGEKKyo4CZ
         c7+7p2gC+fdbkVNYMgXI5P+Sbn1GZqlIa6lr2nZhejhZSYQa3FKcVQDoEJ8mbqupbi
         mOxPTDk5VUU2Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v11 4/6] common/quota: move _qsetup() helper to common code
Date:   Sat, 27 Mar 2021 12:18:54 +0100
Message-Id: <20210327111856.1211544-5-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210327111856.1211544-1-brauner@kernel.org>
References: <20210327111856.1211544-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=wM9Q2AdFuvVYmj1+BgTxu13NVAXYIAuRDfZKkOg26xw=; m=G9up2oLwo++96UH6tgmgi4o4ese0pNaEOzVzPn2cm5o=; p=WU5/GGIh2yNDrbksNUPmm2Bl9QB12TJxW4HV+CzVmqw=; g=03a67e8d3f5d58609a3b5e24479cc8492106b35a
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYF8UlgAKCRCRxhvAZXjcoubmAP4mF28 YPcXfE5CgugxuJyTMS06PnmvmR5Q/cTmv9kRASwD+N1dVgv3SO/c7UjYfSoGvVJS2fc8PLULzMQnh Q1r/8gw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

It's already used in two tests and will be used in a third.

Cc: Eryu Guan <guan@eryu.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Suggested-by: Eryu Guan <guan@eryu.me>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 - v9 */
patch not present

/* v10 */
patch introduced

/* v11 */
unchanged
---
 common/quota  | 20 ++++++++++++++++++++
 tests/xfs/050 | 19 -------------------
 tests/xfs/299 | 19 -------------------
 3 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/common/quota b/common/quota
index 1437d5f7..32a9a555 100644
--- a/common/quota
+++ b/common/quota
@@ -329,5 +329,25 @@ _report_quota_inodes() {
 	repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $6, $7, $8}' | sort -r
 }
 
+# Determine which type of quota we're using
+_qsetup()
+{
+	opt=$1
+	enforce=0
+	if [ $opt = "u" -o $opt = "uno" ]; then
+		type=u
+		eval `_choose_uid`
+	elif [ $opt = "g" -o $opt = "gno" ]; then
+		type=g
+		eval `_choose_gid`
+	elif [ $opt = "p" -o $opt = "pno" ]; then
+		type=p
+		eval `_choose_prid`
+	fi
+	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
+
+	echo "Using type=$type id=$id" >> $seqres.full
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/xfs/050 b/tests/xfs/050
index 1df97537..e7c81d0a 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -69,25 +69,6 @@ _filter_and_check_blks()
 	' | _filter_quota_report
 }
 
-_qsetup()
-{
-	opt=$1
-	enforce=0
-	if [ $opt = "u" -o $opt = "uno" ]; then
-		type=u
-		eval `_choose_uid`
-	elif [ $opt = "g" -o $opt = "gno" ]; then
-		type=g
-		eval `_choose_gid`
-	elif [ $opt = "p" -o $opt = "pno" ]; then
-		type=p
-		eval `_choose_prid`
-	fi
-	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
-
-	echo "Using type=$type id=$id" >> $seqres.full
-}
-
 _exercise()
 {
 	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
diff --git a/tests/xfs/299 b/tests/xfs/299
index b862e67e..26b7fcfd 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -62,25 +62,6 @@ _filter_and_check_blks()
 	' | _filter_quota_report
 }
 
-_qsetup()
-{
-	opt=$1
-	enforce=0
-	if [ $opt = "u" -o $opt = "uno" ]; then
-		type=u
-		eval `_choose_uid`
-	elif [ $opt = "g" -o $opt = "gno" ]; then
-		type=g
-		eval `_choose_gid`
-	elif [ $opt = "p" -o $opt = "pno" ]; then
-		type=p
-		eval `_choose_prid`
-	fi
-	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
-
-	echo "Using type=$type id=$id" >> $seqres.full
-}
-
 _exercise()
 {
 
-- 
2.27.0

