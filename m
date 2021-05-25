Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFDC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332786108D
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhEYNft (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233301AbhEYNfs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYoIzX4Cg1Ujpmr1j1oX2egUtxkMyBoHrZBZwTCNZjk=;
        b=YMoqsohDXoiaDRwSx/5gWgk2V4HADrhMQdta4naI9gt+A7hHxDiPZAf+xDh2lqndiAscgU
        sr5TwDy0pYbG7OH2rl/nyTXEdgpUl1eEIh2bXPzYqMqU7NWzLXCZSCmMDQzuT7sF1rRYbL
        zDORY5jNuwyg238lbSbvjuW45Lfymkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-aO7xCHcAMiGQx-kYWnLVUw-1; Tue, 25 May 2021 09:34:15 -0400
X-MC-Unique: aO7xCHcAMiGQx-kYWnLVUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 121ACE7B77;
        Tue, 25 May 2021 13:34:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46ED761094;
        Tue, 25 May 2021 13:34:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/9] generic/294,
 afs: Allow for mknod subtest failing if mknod not supported
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:02 +0100
Message-ID: <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If mknod is not supported, some of generic/294 will fail due to that rather
than what's actually being tested - but the other subtests will still work
as before.

Add a "_has_mknod" function that can be used to find out if the mknod tests
should be skipped.  This is then used to allow the rest of generic/294 to
be employed on AFS.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 common/rc                     |   10 ++++++++++
 doc/requirement-checking.txt  |    9 +++++++++
 tests/generic/294             |    8 ++++++++
 tests/generic/294.cfg         |    1 +
 tests/generic/294.out         |    5 -----
 tests/generic/294.out.mknod   |    6 ++++++
 tests/generic/294.out.nomknod |    7 +++++++
 7 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 tests/generic/294.cfg
 delete mode 100644 tests/generic/294.out
 create mode 100644 tests/generic/294.out.mknod
 create mode 100644 tests/generic/294.out.nomknod

diff --git a/common/rc b/common/rc
index f24d0e87..4ffec9a2 100644
--- a/common/rc
+++ b/common/rc
@@ -4603,6 +4603,16 @@ _getcap()
 	return ${PIPESTATUS[0]}
 }
 
+_has_mknod()
+{
+	case $FSTYP in
+	afs)
+		return 1;;
+	*)
+		return 0;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 45d2756b..d31ba3fb 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -16,6 +16,8 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 
 	_require_chattr <letters>
 	_require_exportfs
+	_require_mknod
+	_has_mknod
 
  (3) System call requirements.
 
@@ -97,6 +99,13 @@ _require_exportfs
      The test also requires the use of the open_by_handle_at() system call and
      will be skipped if it isn't available in the kernel.
 
+_require_mknod
+_has_mknod
+
+     The test requires that the $TEST_DEV filesystem supports mknod(2).
+     _require_mknod will cause the test to be skipped; _has_mknod returns 0 if
+     mknod is supported and 1 otherwise.
+
 
 ========================
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/294 b/tests/generic/294
index 55b24e12..4fc05082 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -8,6 +8,7 @@
 # we ask to create an already-existing entity on an RO filesystem
 #
 seq=`basename $0`
+seqfull=$0
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
@@ -34,6 +35,13 @@ _require_scratch
 _require_symlinks
 _require_mknod
 
+features=""
+if ! _has_mknod; then
+	echo HAS NO MKNOD $?
+	features="nomknod"
+fi
+_link_out_file "$features"
+
 rm -f $seqres.full
 _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
 
diff --git a/tests/generic/294.cfg b/tests/generic/294.cfg
new file mode 100644
index 00000000..c0466cde
--- /dev/null
+++ b/tests/generic/294.cfg
@@ -0,0 +1 @@
+nomknod: nomknod
diff --git a/tests/generic/294.out b/tests/generic/294.out
deleted file mode 100644
index 78024728..00000000
--- a/tests/generic/294.out
+++ /dev/null
@@ -1,5 +0,0 @@
-QA output created by 294
-mknod: SCRATCH_MNT/294.test/testnode: File exists
-mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
-touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
-ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
diff --git a/tests/generic/294.out.mknod b/tests/generic/294.out.mknod
new file mode 100644
index 00000000..4aea9d82
--- /dev/null
+++ b/tests/generic/294.out.mknod
@@ -0,0 +1,6 @@
+QA output created by 294
+mknod: SCRATCH_MNT/294.test/testnode: Operation not permitted
+mknod: SCRATCH_MNT/294.test/testnode: Read-only file system
+mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
+touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
+ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
diff --git a/tests/generic/294.out.nomknod b/tests/generic/294.out.nomknod
new file mode 100644
index 00000000..43658aa8
--- /dev/null
+++ b/tests/generic/294.out.nomknod
@@ -0,0 +1,7 @@
+QA output created by 294
+HAS NO MKNOD
+mknod: SCRATCH_MNT/294.test/testnode: Operation not permitted
+mknod: SCRATCH_MNT/294.test/testnode: Read-only file system
+mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
+touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
+ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists


