Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558FC77B73
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDXOLr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjDXOLp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A987AA8
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVg4KrBUfFttvVSKsQu3RFyEXXfYi9QKcbNBHehDGqE=;
        b=NrfZd0oiKQvOqZPa7U2XGj/MBkJsFfPFeL4uzPzgsgHLS+GUrb3Fqj+sNKHCHquE9DY4hE
        LjXwUGU7EqseckN4cU9/9z+pFRWpqFMulsVg9FPGS+wolTTyKf86bjFgL8I8JAY1VVLygp
        k+RDFSmO0dXgs6XtS+h4fOwk4DDgbEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-7kJH00wlMjS3fXZBjwywMw-1; Mon, 24 Apr 2023 10:10:53 -0400
X-MC-Unique: 7kJH00wlMjS3fXZBjwywMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D5DC811E7C;
        Mon, 24 Apr 2023 14:10:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9302027043;
        Mon, 24 Apr 2023 14:10:51 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 2/6] generic/314, afs: Allow for a filesystem that doesn't honour SGID inheritance
Date:   Mon, 24 Apr 2023 15:10:38 +0100
Message-Id: <20230424141042.450535-3-dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The AFS filesystem doesn't do any special handling for the SUID, SGID and
SVTX bits and doesn't perform any sort of propagation.  Further, only a
user with cell admin rights can set non-0777 bits.

Handle this by adding a "_require_sgid_inheritance" clause and labelling
the test with it, thereby skipping for filesystems that don't support it.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
cc: linux-afs@lists.infradead.org
---
 common/rc                    | 9 +++++++++
 doc/requirement-checking.txt | 7 +++++++
 tests/generic/314            | 1 +
 3 files changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index 8b8cb714..00c5fcfe 100644
--- a/common/rc
+++ b/common/rc
@@ -5097,6 +5097,15 @@ _save_coredump()
 	$COREDUMP_COMPRESSOR -f "$out_file"
 }
 
+_require_sgid_inheritance()
+{
+	case $FSTYP in
+	afs)
+		_notrun "SGID-based group ID inheritance is not supported on $FSTYP"
+		;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 45d2756b..a3588ee9 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -16,6 +16,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 
 	_require_chattr <letters>
 	_require_exportfs
+	_require_sgid_inheritance
 
  (3) System call requirements.
 
@@ -97,6 +98,12 @@ _require_exportfs
      The test also requires the use of the open_by_handle_at() system call and
      will be skipped if it isn't available in the kernel.
 
+_require_sgid_inheritance
+
+     The test required that the $TEST_DEV filesystem supports the inheritance
+     of the SGID bit and the GID from a marked directory.  The test will be
+     skipped if not supported.
+
 
 ========================
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/314 b/tests/generic/314
index 9449d30f..dd617089 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -17,6 +17,7 @@ _supported_fs generic
 _require_test
 _require_user
 _require_chown
+_require_sgid_inheritance
 
 rm -rf $TEST_DIR/$seq-dir
 

