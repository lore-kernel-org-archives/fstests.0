Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E175C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4556140F
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhEYNgl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233314AbhEYNgg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFNrP1zQdZJM5yiLDWCD3v19+Fxyv7o61YEb9uAbgRU=;
        b=BlHiZlOOj+ADUgxBoq7dcdfjWACrf6cTONLNJ89UVlnpvZ4KzFSJ12flNyfD0zyGpA+NqP
        g7insEBGUcbseuZEJfH2+yiKnA3tPhiIckkJU4vAFlcXgj2ZFxQS9cwa8gijs3PQ42LR+Z
        B/7uoNZKQ8ftzeMWZpc+HJQ8hCBGk4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-Z9OMT86JNFe9jZMs04TYNw-1; Tue, 25 May 2021 09:35:03 -0400
X-MC-Unique: Z9OMT86JNFe9jZMs04TYNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4E2C1097125;
        Tue, 25 May 2021 13:34:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30F915D9CD;
        Tue, 25 May 2021 13:34:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/9] Add the ability to require O_TMPFILE to be supported for
 a test
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:29 +0100
Message-ID: <162194966940.4011860.15702357969023449902.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Provide a '_require_o_tmpfile' clause so that a test can require than
O_TMPFILE be supported by the filesystem being tested.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 common/rc                    |    9 +++++++++
 doc/requirement-checking.txt |    7 +++++++
 tests/generic/531            |    1 +
 3 files changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index e25967d9..c0659215 100644
--- a/common/rc
+++ b/common/rc
@@ -4640,6 +4640,15 @@ _require_unix_perm_checking()
 	esac
 }
 
+_require_o_tmpfile()
+{
+	case $FSTYP in
+	afs)
+		_notrun "O_TMPFILE is not supported on $FSTYP"
+		;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 9be7a84c..b708887b 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -21,6 +21,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 	_require_sgid_inheritance
 	_require_use_local_uidgid
 	_require_unix_perm_checking
+	_require_o_tmpfile
 
  (3) System call requirements.
 
@@ -129,6 +130,12 @@ _require_unix_perm_checking
      some alternative distributed permissions model involving authentication
      tokens rather than the local fsuid/fsgid.
 
+_require_o_tmpfile
+
+     The test requires that O_TMPFILE is supported by open() on that
+     filesystem, thereby allowing the creation of temporary files to be used or
+     tested.
+
 
 ========================
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/531 b/tests/generic/531
index e76418ca..2f3b1dc6 100755
--- a/tests/generic/531
+++ b/tests/generic/531
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _require_scratch
 _require_test_program "t_open_tmpfiles"
+_require_o_tmpfile
 
 rm -f $seqres.full
 _scratch_mkfs >> $seqres.full 2>&1


