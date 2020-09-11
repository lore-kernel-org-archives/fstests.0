Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E3BC43461
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 07:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACCD20731
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 07:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I20OQuwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIKHQV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgIKHQR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599808572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DLVtd4jc7WIysp+BwLRq9U6acYvBeB98NU2Xohop5Zw=;
        b=I20OQuwzS99cCHwBzpXzL/E6S7CygFrrB2YLIGnsxIhhRj02rDUp5r4m9qPnn1JTp6sWV7
        ZIJ3YoFL6VGo90ItsBng63epq0shieB9IOsJZKQafqrFv6/eqfUmw+Ok4C5yqRM7UqG/M4
        iiTgty6m0yjryoKTDdmFXi8Dn0f9NUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-VRaa2WGMMQG0oqBrSjCxpA-1; Fri, 11 Sep 2020 03:16:08 -0400
X-MC-Unique: VRaa2WGMMQG0oqBrSjCxpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A130B64084
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 07:16:07 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1F3B1002D41
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 07:16:05 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 0/5] fsstress,fsx: add io_uring test and do some fix
Date:   Fri, 11 Sep 2020 15:15:50 +0800
Message-Id: <20200911071555.31506-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset tries to add new IO_URING test into fsstress [1/5] and fsx
[4/5 and 5/5]. And then do some changes and bug fix by the way [2/5 and 3/5].

fsstress and fsx are important tools in xfstests to do filesystem I/Os test,
lots of test cases use it. So add IO_URING operation into fsstress and fsx
will help to cover IO_URING test from fs side.

I'm not an IO_URING expert, so cc io-uring@ list, please feel free to
tell me if you find something wrong or have any suggestions to improve
the test.

V2 did below changes:
1) 1/4 change the definition of URING_ENTRIES to 1
2) 2/4 change the difinition of AIO_ENTRIES to 1, undo an unrelated changed line
3) 4/4 turn to use io_uring_prep_readv/io_uring_prep_writev, due to old
       liburing(0.2-2) doesn't support io_uring_prep_read/io_uring_prep_write.

V3 changed io_uring_submit(&ring) to io_uring_submit_and_wait(&ring, 1). I'm
not sure if this's the real mean of Jens Axboe's review point, please check.
  https://marc.info/?l=fstests&m=159811932808057&w=2

V4 did below changes:
1) 1/5 change the "goto" related code of do_uring_rw()
2) 3/5 similar change as above
3) 4/5 new patch, separated from original 4/4 patch
3) 5/5 change #elif to #else
4) 5/5 change __uring_rw to uring_rw.
5) 5/5 change the loop logic in uring_rw().

V5 did below changes:
1) 1/5 turn to use (fd != -1)
2) 3/5 turn to use (fd != -1)
3) 5/5 change res to ret, change res2 to res.

Thanks,
Zorro



