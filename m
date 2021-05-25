Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA0C47084
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6351F6140F
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhEYNfb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233199AbhEYNfa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=adjd6EDHTzO3d/PW7vdoqOFYbVlYZvtFi+tLT0NWunw=;
        b=MYgZNo70FFWN866FGlxcuE4Sf34RYbQE6AtpSo/TsNgMNFWfCDb0spELCrM+CUpnALPwZM
        +yttEUml+y5QY/2+4rH+0n3FZ8yotXDFMjF3tOC6qMJjXvSBP3d2Jtohr2UhaAgZZJQNTv
        uXv4xiG7ZQKaBGOltuuP+URNJY2RqtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-z0mcrYQQP36gDQA25LbnDg-1; Tue, 25 May 2021 09:33:58 -0400
X-MC-Unique: z0mcrYQQP36gDQA25LbnDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B526BBEED;
        Tue, 25 May 2021 13:33:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8E251037F20;
        Tue, 25 May 2021 13:33:49 +0000 (UTC)
Subject: [PATCH 0/9] Add support for using xfstests to test AFS 
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:33:48 +0100
Message-ID: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

 (*) AFS doesn't support SUID/SGID/SVTX bits and doesn't support SGID/GID
     propagation.

 (*) For AFS, the DIO alignment is 1 (don't have to deal with DMA).  This
     causes posix_memalign() to fail.

I've added fixes/workarounds for the above.  There are also three -g quick
tests that fail still.  generic/258 and generic/634 fail because they try
to use dates that the server refuses to handle (and gives EOVERFLOW for),
and generic/478 fails because AFS file locking can't lock ranges.

A kernel patch[1] is required to make generic/035 work.

David

Link: https://lore.kernel.org/r/162194384460.3999479.7605572278074191079.stgit@warthog.procyon.org.uk/ [1]
---
David Howells (9):
      Add AFS support
      generic/294, afs: Allow for mknod subtest failing if mknod not supported
      generic/314, afs: Allow for a filesystem that doesn't honour SGID inheritance
      generic/317, afs: Allow for a filesystem not to honour the local uid/gid
      generic/123, generic/128, afs: Allow for an fs that does its own perm management
      Add the ability to require O_TMPFILE to be supported for a test
      afs: Indicate the minimum DIO alignment is 1
      generic/465: Fix handling of DIO alignment < sizeof(long)
      Fix other posix_memalign() alignment issues


 common/rc                                     | 48 +++++++++++++++++++
 doc/requirement-checking.txt                  | 39 +++++++++++++++
 .../aio-dio-append-write-read-race.c          |  7 +--
 src/aio-dio-regress/aiocp.c                   |  2 +
 src/aio-dio-regress/aiodio_sparse2.c          |  3 +-
 src/dio-interleaved.c                         |  5 +-
 tests/generic/123                             |  1 +
 tests/generic/128                             |  1 +
 tests/generic/294                             |  8 ++++
 tests/generic/294.cfg                         |  1 +
 tests/generic/294.out                         |  5 --
 tests/generic/294.out.mknod                   |  6 +++
 tests/generic/294.out.nomknod                 |  7 +++
 tests/generic/314                             |  1 +
 tests/generic/317                             |  1 +
 tests/generic/531                             |  1 +
 16 files changed, 126 insertions(+), 10 deletions(-)
 create mode 100644 tests/generic/294.cfg
 delete mode 100644 tests/generic/294.out
 create mode 100644 tests/generic/294.out.mknod
 create mode 100644 tests/generic/294.out.nomknod


