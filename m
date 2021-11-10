Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1BBC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1EC61058
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhKJMoP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231510AbhKJMoP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Nov 2021 07:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636548087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X9OHW8yQA1DPd+bqfq6EHr2z728l5Dp9trSDXKRtGD0=;
        b=EBT/49pH698W2EVgzfdTWkVQdp3YVJ7bHytToslmDGuxL92Ox8hP99xPlEvwiRygeilzKu
        RBzrALgDwNnWQr0WoV420HYAU9PifapDEXY5o1Jcsk25cTKNF+01AhIc78GOUfF//huDXb
        axr1HS/3ZOc7JqCifFHKVNZvjS3p/Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-HsfOQVlxNF-6up7GgCIXGg-1; Wed, 10 Nov 2021 07:41:26 -0500
X-MC-Unique: HsfOQVlxNF-6up7GgCIXGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D9A210168C8
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 12:41:25 +0000 (UTC)
Received: from andromeda.lan (unknown [10.40.193.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968E15D9DE
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 12:41:24 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH V2 0/2] xfstests: Fix generic/643 on ext2 and ext3
Date:   Wed, 10 Nov 2021 13:41:17 +0100
Message-Id: <20211110124119.43974-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello.

This is the 2nd version of this series to fix test g/643.

This version ensures _format_swapfile helper returns the swap size in bytes
every time (previous version returned it in a different unit, depending on the
swap's size) and updates remaining users of _format_swapfile() to discard its
return value.

This also slightly change patch 2, making g/643 to use swapon to retrieve swap
size (more details in the patch's description).

Original cover-letter below.


Currently, generic/643 test fails on ext2 and ext3 filesystems when using 1k
block sizes.
The failure itself happens due the mapping of indirect blocks to iomap extents
and the aligment constraints imposed by iomap. Specific details are described in
patch 2.

To fix the test, I modified it to use the swapfile size described in the swap
header (patch 2), and to retrieve such information, at mkswap time, I modified
the _format_swapfile() function, and I believe such modification requires its own
patch (patch 1).

These changes have also been tested on 64k pages (both on arm and PPC) to ensure
it doesn't break the test on such architectures.

Carlos Maiolino (2):
  common/rc: Enable _format_swapfile to return the swap size
  generic/643: Fix for 1k block sizes for ext2 and ext3

 common/rc         | 10 +++++++---
 tests/btrfs/173   |  2 +-
 tests/btrfs/174   |  2 +-
 tests/btrfs/175   |  4 ++--
 tests/btrfs/176   |  2 +-
 tests/btrfs/177   |  2 +-
 tests/generic/356 |  2 +-
 tests/generic/357 |  2 +-
 tests/generic/493 |  2 +-
 tests/generic/494 |  2 +-
 tests/generic/554 |  2 +-
 tests/generic/569 |  2 +-
 tests/generic/643 | 27 +++++++++------------------
 13 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.31.1

