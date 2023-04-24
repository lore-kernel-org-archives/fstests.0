Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F87DC7618E
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjDXOL5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjDXOLx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75E393DD
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5H1Lt2zv8UWKkyIPzbmGo3PUjh7uVDdJthgSW3MJGRo=;
        b=d3LnNyM8rYa2rlb3oap1LJtOMeIi8QVUS9NlD9kiF68JNeoDAF60bSRmN+vJpbqaEqtEBy
        Hb3EQTsDdcc70QXg1995cby0wdY5MfngDoKGXLUgrhNBHwW8PZk114oFZX37/g67fIJOsH
        7qo59fA4mqFeEZ50wE3TVUb03aEyGgo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504--6DFc9mNO2i8LHJfCvPrLw-1; Mon, 24 Apr 2023 10:10:56 -0400
X-MC-Unique: -6DFc9mNO2i8LHJfCvPrLw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BD903C0ED60;
        Mon, 24 Apr 2023 14:10:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6682492C13;
        Mon, 24 Apr 2023 14:10:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 3/6] generic/317, afs: Allow for a filesystem not to honour the local uid/gid
Date:   Mon, 24 Apr 2023 15:10:39 +0100
Message-Id: <20230424141042.450535-4-dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
 common/rc                    | 9 +++++++++
 doc/requirement-checking.txt | 8 ++++++++
 tests/generic/317            | 1 +
 3 files changed, 18 insertions(+)

diff --git a/common/rc b/common/rc
index 00c5fcfe..e0978a03 100644
--- a/common/rc
+++ b/common/rc
@@ -5106,6 +5106,15 @@ _require_sgid_inheritance()
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
index a3588ee9..f24ecf5c 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -17,6 +17,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
 	_require_chattr <letters>
 	_require_exportfs
 	_require_sgid_inheritance
+	_require_use_local_uidgid
 
  (3) System call requirements.
 
@@ -104,6 +105,13 @@ _require_sgid_inheritance
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
index 134d5e3f..39cccc8b 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -38,6 +38,7 @@ _require_user
 _require_ugid_map
 _require_userns
 _require_chown
+_require_use_local_uidgid
 qa_user_id=`id -u $qa_user`
 
 _filter_output()

