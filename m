Return-Path: <SRS0=C4aD=EO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C196BC388F9
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64908206D4
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoigWzNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgKHM0h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Nov 2020 07:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgKHM0g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Nov 2020 07:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604838395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F9u9qYwCYGwnKvUW3Qwuq0EBArWLV1qdPypf2tsQD8g=;
        b=CoigWzNF0Y9UGTRgTe30DcWHiDg1sAuXAoLf4wGy8YuRT8eNhNF3YqK84K5xE9Icxc50fm
        0LayQnlf0QbyybvqMIsv5h451BiuznDFlEm+WB9Fa6hIwkKKCHwRFR1Xo3Oded52hLMpdZ
        BrGDoDnhyrHYn/IGES4Xwf1BtldrtA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-D1k5cZqIM9miGlPD-kFFmQ-1; Sun, 08 Nov 2020 07:26:33 -0500
X-MC-Unique: D1k5cZqIM9miGlPD-kFFmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C7E1005E65
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:33 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1422C5B4CA
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:31 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/3] xfstests: fsx IO_URING test cases
Date:   Sun,  8 Nov 2020 20:26:20 +0800
Message-Id: <20201108122623.12980-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset bases on https://patchwork.kernel.org/cover/11769847/, which
makes xfstests fsstress and fsx supports IO_URING.

The io_uring IOs in fsstress will be run automatically when fsstress get
running. But fsx need a special option '-U' to run IO_URING read/write, so
add two new cases to xfstests to do fsx buffered and direct IO IO_URING
test.

[1/3] new helper to require io_uring feature
[2/3] fsx buffered IO io_uring test
[3/3] fsx direct IO io_uring test

And the [2/3] just found an io_uring regression bug (need LVM TEST_DEV):
https://bugzilla.kernel.org/show_bug.cgi?id=209243

Feel free to tell me, if you have more suggestions to test io_uring on
filesystem.

Thanks,
Zorro

