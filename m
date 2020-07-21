Return-Path: <SRS0=G+6p=BA=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351DC433EC
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jul 2020 09:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7EF2070A
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jul 2020 09:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGUJiq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:38:46 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:55072 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGUJiq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Jul 2020 05:38:46 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06L9cDPs080351;
        Tue, 21 Jul 2020 12:38:38 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 32bvr3jb0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 12:38:38 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jul
 2020 12:38:36 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@redhat.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic: add missing runtime checks for mknod/mkfifo
Date:   Tue, 21 Jul 2020 12:38:30 +0300
Message-ID: <20200721093830.12498-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=827 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210067
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some generic tests explicitly run 'mknod' or 'mkfifo' command, however
the correspondent runtime check is missing, this results in a test
failure instead of selecting not to execute the test.

The change adds _require_mknod check to the next generic tests:

  * generic/157
  * generic/158
  * generic/294
  * generic/423

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/157 | 1 +
 tests/generic/158 | 1 +
 tests/generic/294 | 1 +
 tests/generic/423 | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/generic/157 b/tests/generic/157
index 09b42bc9d8c8..cdd29af30dd1 100755
--- a/tests/generic/157
+++ b/tests/generic/157
@@ -31,6 +31,7 @@ _cleanup()
 _supported_os Linux
 _require_test_reflink
 _require_scratch_reflink
+_require_mknod
 
 rm -f $seqres.full
 
diff --git a/tests/generic/158 b/tests/generic/158
index 369aad8b2eb5..173090a3d40c 100755
--- a/tests/generic/158
+++ b/tests/generic/158
@@ -31,6 +31,7 @@ _cleanup()
 _supported_os Linux
 _require_test_dedupe
 _require_scratch_dedupe
+_require_mknod
 
 rm -f $seqres.full
 
diff --git a/tests/generic/294 b/tests/generic/294
index 32c89b039374..bc13185e937c 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -33,6 +33,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_symlinks
+_require_mknod
 
 rm -f $seqres.full
 _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
diff --git a/tests/generic/423 b/tests/generic/423
index 6db55fd6f757..fd538a1b029d 100755
--- a/tests/generic/423
+++ b/tests/generic/423
@@ -39,6 +39,7 @@ _require_test_program "stat_test"
 _require_test_program "af_unix"
 _require_statx
 _require_symlinks
+_require_mknod
 
 function check_stat () {
 	$here/src/stat_test $* || echo stat_test failed
-- 
2.25.1

