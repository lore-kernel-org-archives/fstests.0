Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E34C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 16:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiGTQpG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiGTQoH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 12:44:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3766AC9
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 09:44:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KGi10Z023368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658335442; bh=RsacFu/gkpReCLWTpyvQT/8up/a9sHbIrRf+StS7fB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=edi0wyxjZWZVVwaVX55YmnWFXD+ZHRVgJzOxe/7g2CJJnAqGvDrMkX9J/wG2EhwQQ
         szkcL+Vq8y7xqhbT+UEzfu8v83wS2q/rsP69+LnUfPEUbgF/a1uvqUu2ml6n/eSPHX
         K5IwaUv+rnDNQCJ832aeoTajR49U1guAzmJ5WF+/HjTMZEz75Chf6VdFP62px4E60V
         rmKomQEiV6z0Ev5kP5hK/eW5YbjpDAa9tnWHd0ZSOCcGcNux/ZfpNLt0kILHj2+Fvf
         NZt/r3A/kVV2VMSigqKADCJf/MoEeyDmeo/30IF0hqfdZrlmhsUcCwya1YpuvJWxDL
         U4eGUgrbLwNzg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0926C15C3EC3; Wed, 20 Jul 2022 12:44:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/4] generic/556: add a check to make sure ext4 supports encrypted casefolding
Date:   Wed, 20 Jul 2022 12:43:54 -0400
Message-Id: <20220720164356.4078789-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720164356.4078789-1-tytso@mit.edu>
References: <20220720164356.4078789-1-tytso@mit.edu>
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
index d9126f4c..e3e89508 100644
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
index 404a3243..80563502 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -13,6 +13,7 @@ _begin_fstest auto quick casefold
 . ./common/attr
 
 _supported_fs generic
+_require_encrypted_casefold
 _require_scratch_nocheck
 _require_scratch_casefold
 _require_symlinks
-- 
2.31.0

