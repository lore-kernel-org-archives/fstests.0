Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DBC77B61
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDXOLo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjDXOLl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3772BC
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uzNwOO6HT/QwtgFN8jNb1hK7tEMs8K3rk0EVFiSkHN4=;
        b=ZccomCxaPk6Qn+aB9u7z3s5W5KSe5G1oUr0xGzXNJP4Hd3dwlO2VUkIyoRllUXwpBUj0zN
        Lsik7nmVHC16l3jw5dGGQfOLrBK7G3V4335wExipdaTMEHDrlMVdJNNccexeSBlDtD84gx
        AYeEZDdJJqPLMFSsAdNt+vZlFhtWkd4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-cbN-DGCoNTG8_zs0-ha2DA-1; Mon, 24 Apr 2023 10:10:48 -0400
X-MC-Unique: cbN-DGCoNTG8_zs0-ha2DA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AD1E3814945;
        Mon, 24 Apr 2023 14:10:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C813492B03;
        Mon, 24 Apr 2023 14:10:44 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 0/6] xfstests: Add support for using xfstests to test AFS
Date:   Mon, 24 Apr 2023 15:10:36 +0100
Message-Id: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Here's a set of patches that make xfstests (mostly) work with the in-kernel
AFS client.  It has to allow for a number of features of AFS, in
particular:

 (*) AFS has its own permissions service that makes use of authentication
     tokens obtained from such as kerberos and uses this in combination
     with ACLs to determine file access rights.  This overrides the use of
     UNIX permissions and using su to impersonate another user doesn't
     work.

 (*) AFS sets the inode UID field to the user ID associated with the
     authentication token, not the client's fsuid when creating.

 (*) AFS doesn't support SUID/SGID/SVTX bits and doesn't propagate SGID on
     directories, though it will propagate the GID.

 (*) chown is rejected unless you have an authentication token that
     indicates you're the owner of the file.

I've added fixes/workarounds for the above.  There are five -g quick tests
that fail if unauthenticated:

 - generic/258
 - generic/634
	Fail because they try to use dates that the server refuses to
	handle (and gives EOVERFLOW for).

 - generic/478
	Fails because AFS file locking can't lock ranges.

 - generic/633
	Fails because of chown.

 - generic/696
	Fails because AFS doesn't propagate SGID in mkdir.  This may be a
	client (kernel) bug, a server bug or a design feature.

And if authenticated, the following additional failures occur because AFS
uses its own ACLs and authentication:

 - generic/087
 - generic/126
 - generic/193
 - generic/088

David

Changes
=======
ver #2)
 - Rebased.
 - Dropped the patches to handle the DIO blocksize being 1 as none of the
   quick tests now use it on AFS.
 - Changed generic/696 to not supply "noacl" to AFS.

Link: https://lore.kernel.org/r/162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk/ # v1

David Howells (6):
  Add AFS support
  generic/314, afs: Allow for a filesystem that doesn't honour SGID
    inheritance
  generic/317, afs: Allow for a filesystem not to honour the local
    uid/gid
  generic/123, generic/128, afs: Allow for an fs that does its own perm
    management
  generic/531: Check for O_TMPFILE
  generic/696: AFS doesn't support the "noacl" command line option

 build/rpm/xfstests.spec.in   |  2 +-
 check                        |  3 +-
 common/config                | 15 ++++++--
 common/rc                    | 69 ++++++++++++++++++++++++++++++++----
 doc/requirement-checking.txt | 23 ++++++++++++
 tests/generic/123            |  1 +
 tests/generic/128            |  1 +
 tests/generic/314            |  1 +
 tests/generic/317            |  1 +
 tests/generic/531            |  1 +
 tests/generic/696            |  5 ++-
 11 files changed, 110 insertions(+), 12 deletions(-)

