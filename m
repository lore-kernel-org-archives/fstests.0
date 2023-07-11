Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D0EB64DC
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Jul 2023 15:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjGKPwa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Jul 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGKPw3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jul 2023 11:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A69C
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689090711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2aS3+6YGHduZDD1v2t1tUuR1t8lJ6ds7x80UTz92VwU=;
        b=VAOByqOwCb6/8oVQXD1NYKz7I+fObEcT4LUVZuQz6/36wScekQwuxwbnxFZEfG7fDjNpqg
        gYX2NvXFu+3kHoONq8+UKbVncdb0dboVwpWP4jvfMKAqwE3ha1X+BoTQAaZzj6CF3iDQd5
        3V9fyt2wLQwJL826Zb2rGBvoIRIOKQ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-oGpheeOCNq-MdXv4mRVKdA-1; Tue, 11 Jul 2023 11:51:48 -0400
X-MC-Unique: oGpheeOCNq-MdXv4mRVKdA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0EC91066544;
        Tue, 11 Jul 2023 15:51:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB1CC492B01;
        Tue, 11 Jul 2023 15:51:47 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id CB74F3096A42; Tue, 11 Jul 2023 15:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id C78103F7CF;
        Tue, 11 Jul 2023 17:51:42 +0200 (CEST)
Date:   Tue, 11 Jul 2023 17:51:42 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>
cc:     fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I run the test 558 on bcachefs, it works like a fork-bomb and kills
the machine. The reason is that the "while" loop spawns "create_file"
subprocesses faster than they are able to complete.

This patch fixes the crash by limiting the number of subprocesses to 128.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 tests/generic/558 |    1 +
 1 file changed, 1 insertion(+)

Index: xfstests-dev/tests/generic/558
===================================================================
--- xfstests-dev.orig/tests/generic/558
+++ xfstests-dev/tests/generic/558
@@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
 while [ $i -lt $loop ]; do
 	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
 	let i=$i+1
+	if [ $((i % 128)) = 0 ]; then wait; fi
 done
 wait
 

