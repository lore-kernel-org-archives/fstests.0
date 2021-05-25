Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42523C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3006141B
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhEYNgO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233342AbhEYNgO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmQaGqpIIJmY/5WJJHzH1UkDUCE4o5rH09ZF0vaeMn8=;
        b=IWOaQ4DMKTcRt7DbFalBdw/HctpnjJuRN0ufBonh9YNofLPeHfWPhUBsyipaKNQIfEeijs
        qj0kPz+RP0wtu8VCuRG4B7bs3xRbXf4Enk/8K9cyN09EBWL2DVZL7dprGLb9gtEzmTRoBS
        al6FGVBMhYUg+eIiDuTkADN3IYpj9WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-kFNhraOrOsSvvOxbN49ODg-1; Tue, 25 May 2021 09:34:42 -0400
X-MC-Unique: kFNhraOrOsSvvOxbN49ODg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B395E8A07CF;
        Tue, 25 May 2021 13:34:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1792461094;
        Tue, 25 May 2021 13:34:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/9] generic/314,
 afs: Allow for a filesystem that doesn't honour SGID inheritance
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:09 +0100
Message-ID: <162194964929.4011860.17079665160292202971.stgit@warthog.procyon.org.uk>
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

The AFS filesystem doesn't do any special handling for the SUID, SGID and
SVTX bits and doesn't perform any sort of propagation.  Further, only a
user with cell admin rights can set non-0777 bits.

Handle this by adding a "_require_sgid_inheritance" clause and labelling
the test with it, thereby skipping for filesystems that don't support it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 common/rc                    |    9 +++++++++
 doc/requirement-checking.txt |    7 +++++++
 tests/generic/314            |    1 +
 3 files changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index 4ffec9a2..4d4b0280 100644
--- a/common/rc
+++ b/common/rc
@@ -4613,6 +4613,15 @@ _has_mknod()
 	esac
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
index d31ba3fb..6efc8dc8 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -18,6 +18,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 	_require_exportfs
 	_require_mknod
 	_has_mknod
+	_require_sgid_inheritance
 
  (3) System call requirements.
 
@@ -106,6 +107,12 @@ _has_mknod
      _require_mknod will cause the test to be skipped; _has_mknod returns 0 if
      mknod is supported and 1 otherwise.
 
+_require_sgid_inheritance
+
+     The test required that the $TEST_DEV filesystem supports the inheritance
+     of the SGID bit and the GID from a marked directory.  The test will be
+     skipped if not supported.
+
 
 ========================
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/314 b/tests/generic/314
index 540f0feb..8ed08542 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -30,6 +30,7 @@ _supported_fs generic
 _require_test
 _require_user
 _require_chown
+_require_sgid_inheritance
 
 rm -rf $TEST_DIR/$seq-dir
 


