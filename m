Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F25C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7276141B
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhEYNg0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233314AbhEYNgZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWQr8W3HTQbk6bU7f9ozUxGu3yv1BxANhnOS+L5/nkw=;
        b=bMHe5AcKCI0J0u/SGoWY59JAAGZiPNjt29i2xUDJCiYE26ihJmI7UWlTTY3QdxkfxPwBur
        QKM4f5O+R5OBfrtjjCZg+tqiZ4dsXXAwNSgOAA5+3Lb+AAeQcckaVfBmJ+ejKIHqOqR4OT
        49WnRm7dwa4ik5PKSq8okfNV8gE8m6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-uWs8WZXANL6nHrOInxBfsw-1; Tue, 25 May 2021 09:34:52 -0400
X-MC-Unique: uWs8WZXANL6nHrOInxBfsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CB5AC745D;
        Tue, 25 May 2021 13:34:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 793585C1B4;
        Tue, 25 May 2021 13:34:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/9] generic/123, generic/128,
 afs: Allow for an fs that does its own perm management
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:22 +0100
Message-ID: <162194966265.4011860.229488885734976223.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Signed
---

 common/rc                    |    9 +++++++++
 doc/requirement-checking.txt |    8 ++++++++
 tests/generic/123            |    1 +
 tests/generic/128            |    1 +
 4 files changed, 19 insertions(+)

diff --git a/common/rc b/common/rc
index a04433da..e25967d9 100644
--- a/common/rc
+++ b/common/rc
@@ -4631,6 +4631,15 @@ _require_use_local_uidgid()
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
index c945e16a..9be7a84c 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -20,6 +20,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 	_has_mknod
 	_require_sgid_inheritance
 	_require_use_local_uidgid
+	_require_unix_perm_checking
 
  (3) System call requirements.
 
@@ -121,6 +122,13 @@ _require_use_local_uidgid
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
index d2362e72..99ee4b9b 100755
--- a/tests/generic/123
+++ b/tests/generic/123
@@ -33,6 +33,7 @@ _supported_fs generic
 
 _require_test
 _require_user
+_require_unix_perm_checking
 
 my_test_subdir=$TEST_DIR/123subdir
 
diff --git a/tests/generic/128 b/tests/generic/128
index c1eae77a..91fdca1e 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -25,6 +25,7 @@ _supported_fs generic
 _require_scratch
 _require_user
 _require_chmod
+_require_unix_perm_checking
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount "-o nosuid"


