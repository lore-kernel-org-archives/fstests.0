Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6827C77B73
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDXOL6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjDXOLx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB538A62
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSLVXz6VcgrnOmoX2Kb+W3oz8Pemf5mI9LVXUVdD7vQ=;
        b=EIyzdVeuv0bE0uhT3hHY9IrUVQxWYzFWHlyr0jQoQ5J3VFEsXuuJIjwHEjejYUAn9w+ua+
        ApALtMWfkw1Xo3nZEmrGKIudHAD/8cXtp7WvI65z6ULeO3qvP2YzA64WHcgPbk3xIOCOB0
        kHXQAVCGCPWQZ4d6BIyaVpJLQxs7GyA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-x_CyZSDGOziTPrqsTup26w-1; Mon, 24 Apr 2023 10:11:00 -0400
X-MC-Unique: x_CyZSDGOziTPrqsTup26w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86A0F3814941;
        Mon, 24 Apr 2023 14:10:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8673492C13;
        Mon, 24 Apr 2023 14:10:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 4/6] generic/123, generic/128, afs: Allow for an fs that does its own perm management
Date:   Mon, 24 Apr 2023 15:10:40 +0100
Message-Id: <20230424141042.450535-5-dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The AFS filesystem has its own distributed permission management system
that's based on a per-cell user and group database used in conjunction with
ACLs.  The user is determined by the authentication token acquired from the
kaserver or Kerberos, not by the local fsuid/fsgid.  For the most part, the
uid, gid and mask on a file are ignored.

The generic/123 and generic/128 tests check that the UNIX permission bits do
what would normally be expected of them - but this fails on AFS.  Using "su"
to change the user is not effective on AFS.  Instead, "keyctl session" would
need to be used and an alternative authentication token would need to be
obtained.

Provide a "_require_unix_perm_checking" clause so that these tests can be
suppressed in cases such as AFS.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 common/rc                    | 9 +++++++++
 doc/requirement-checking.txt | 8 ++++++++
 tests/generic/123            | 1 +
 tests/generic/128            | 1 +
 4 files changed, 19 insertions(+)

diff --git a/common/rc b/common/rc
index e0978a03..4dfc3301 100644
--- a/common/rc
+++ b/common/rc
@@ -5115,6 +5115,15 @@ _require_use_local_uidgid()
 	esac
 }
 
+_require_unix_perm_checking()
+{
+	case $FSTYP in
+	afs)
+		_notrun "$FSTYP doesn't perform traditional UNIX perm checking"
+		;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index f24ecf5c..802bf2a3 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -18,6 +18,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 	_require_exportfs
 	_require_sgid_inheritance
 	_require_use_local_uidgid
+	_require_unix_perm_checking
 
  (3) System call requirements.
 
@@ -112,6 +113,13 @@ _require_use_local_uidgid
      filesystems, for example, may choose other settings or not even have these
      concepts available.  The test will be skipped if not supported.
 
+_require_unix_perm_checking
+
+     The test requires that the $TEST_DEV filesystem performs traditional UNIX
+     file permissions checking.  A remote filesystem, for example, might use
+     some alternative distributed permissions model involving authentication
+     tokens rather than the local fsuid/fsgid.
+
 
 ========================
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/123 b/tests/generic/123
index f9b28abb..43f90b46 100755
--- a/tests/generic/123
+++ b/tests/generic/123
@@ -28,6 +28,7 @@ _supported_fs generic
 
 _require_test
 _require_user
+_require_unix_perm_checking
 
 my_test_subdir=$TEST_DIR/123subdir
 
diff --git a/tests/generic/128 b/tests/generic/128
index dc1d43f4..924d6aa8 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -18,6 +18,7 @@ _supported_fs generic
 _require_scratch
 _require_user
 _require_chmod
+_require_unix_perm_checking
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount "-o nosuid"

