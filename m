Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A1C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9A6141B
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhEYNg3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233314AbhEYNg3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9xgDJWyjpDTs/DvmtCqcApB9n1plAz2WIVToAPGLuM=;
        b=DyJ5TNIgPloEAWlPA9PFZQG3Yn+lGnfKLAhMeDPZFT2XSf8z3yrAe3tsX3GZhnYqFGVKfU
        jZoToNc0D8sX2mpaXhzEqkavnJq7Pl+9N37KTfH6dToZPEDlwVZ9dJx+WDxgonHPYSCaE2
        ufQBHScUHDdTL/tjzzf4VipV2hE2L8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-tCFLDAqlOYefd6HVEK_JUQ-1; Tue, 25 May 2021 09:34:57 -0400
X-MC-Unique: tCFLDAqlOYefd6HVEK_JUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A466800FF0;
        Tue, 25 May 2021 13:34:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFD2410016F8;
        Tue, 25 May 2021 13:34:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/9] generic/317,
 afs: Allow for a filesystem not to honour the local uid/gid
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:15 +0100
Message-ID: <162194965595.4011860.7333324355639736586.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Each AFS cell has it's own set of user IDs that is uses internally, in its
ACL system and in its protection management protocol.  The user ID used by
the fileserver is selected from the set belonging to the fileserver's cell
according to the authentication token associated with an RPC operation -
and this is set as a file's user ID when it is created.

This means that tests that expect to set a UID and see the same UID still
set afterwards will fail.

Add a "_require_use_local_uidgid" clause to indicate that a test expects
internal UID/GID information to be seen in the stat output and should be
skipped if AFS's case.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 common/rc                    |    9 +++++++++
 doc/requirement-checking.txt |    8 ++++++++
 tests/generic/317            |    1 +
 3 files changed, 18 insertions(+)

diff --git a/common/rc b/common/rc
index 4d4b0280..a04433da 100644
--- a/common/rc
+++ b/common/rc
@@ -4622,6 +4622,15 @@ _require_sgid_inheritance()
 	esac
 }
 
+_require_use_local_uidgid()
+{
+	case $FSTYP in
+	afs)
+		_notrun "$FSTYP doesn't honour local uid and gid"
+		;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 6efc8dc8..c945e16a 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -19,6 +19,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 	_require_mknod
 	_has_mknod
 	_require_sgid_inheritance
+	_require_use_local_uidgid
 
  (3) System call requirements.
 
@@ -113,6 +114,13 @@ _require_sgid_inheritance
      of the SGID bit and the GID from a marked directory.  The test will be
      skipped if not supported.
 
+_require_use_local_uidgid
+
+     The test requires that the $TEST_DEV filesystem sets the uid and gid of a
+     newly created file to the creating process's fsuid and fsgid.  Remote
+     filesystems, for example, may choose other settings or not even have these
+     concepts available.  The test will be skipped if not supported.
+
 
 ========================
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/317 b/tests/generic/317
index 289dfabe..112e2e97 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -46,6 +46,7 @@ _require_user
 _require_ugid_map
 _require_userns
 _require_chown
+_require_use_local_uidgid
 qa_user_id=`id -u $qa_user`
 
 _filter_output()


