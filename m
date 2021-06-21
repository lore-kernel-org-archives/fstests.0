Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E9EC4743C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEB060200
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 16:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhFUQxW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:53:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53664 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232747AbhFUQvU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jun 2021 12:51:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15LGn4Sl015988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 12:49:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 867C015C3CD5; Mon, 21 Jun 2021 12:49:04 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic/556: add a check to make sure ext4 supports encrypted casefolding
Date:   Mon, 21 Jun 2021 12:49:01 -0400
Message-Id: <20210621164901.1809010-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some older kernels support ext4 file systems with encryption enabled,
and with casefold enabled, but not file systems have both encryption
*and* casefolding enabled.  On those kernels, generic/556 will fail.
Fortunately, we can test if ext4 supports encrypted casefold via the
presence of /sys/fs/ext4/features/encrypted_casefold.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/casefold   | 17 +++++++++++++++++
 tests/generic/556 |  1 +
 2 files changed, 18 insertions(+)

diff --git a/common/casefold b/common/casefold
index 9172d818..7b76b986 100644
--- a/common/casefold
+++ b/common/casefold
@@ -43,6 +43,23 @@ _require_scratch_casefold()
 	_require_command "$LSATTR_PROG" lsattr
 }
 
+_require_encrypted_casefold ()
+{
+    case $FSTYP in
+	ext4)
+	    if test ! -f /sys/fs/ext4/features/casefold ; then
+		_notrun "casefolding not supported"
+	    fi
+	    if test ! -f /sys/fs/ext4/features/encryption ; then
+		_notrun "file system encryption not supported"
+	    fi
+	    if test ! -f /sys/fs/ext4/features/encrypted_casefold ; then
+		_notrun "encrypted casefolding not supported"
+	    fi
+	    ;;
+	esac
+}
+
 _scratch_mkfs_casefold()
 {
 	case $FSTYP in
diff --git a/tests/generic/556 b/tests/generic/556
index 3145188c..7916a08e 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -16,6 +16,7 @@ status=1 # failure is thea default
 . ./common/attr
 
 _supported_fs generic
+_require_encrypted_casefold
 _require_scratch_nocheck
 _require_scratch_casefold
 _require_symlinks
-- 
2.31.0

