Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE3C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08AA60F36
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhKBPbN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233684AbhKBPbM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Nov 2021 11:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635866917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yDeQfGqYNFCRAZFJK3ApwVseiOzNIbnwMmUU1R150fk=;
        b=fppurOqSePuORTUTfw4lIeqAY2FhEHreiGiWuk3aF5K5kuue06HmKzYb7wILSAiDyzQeyV
        lre9URwMDeW6VFNffIWT8F5koPhzyKALl8WMZh9CV5kos7GcXDNoAUSSenO7se1eRqT/7r
        Tk/cmExO2KOOokIuVP3gVgjVp9RjqII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-xK0wUBhJNXKXXNLnCJhPwQ-1; Tue, 02 Nov 2021 11:28:36 -0400
X-MC-Unique: xK0wUBhJNXKXXNLnCJhPwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DD881397B02
        for <fstests@vger.kernel.org>; Tue,  2 Nov 2021 15:28:35 +0000 (UTC)
Received: from andromeda.lan (unknown [10.40.193.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8503E70871
        for <fstests@vger.kernel.org>; Tue,  2 Nov 2021 15:28:34 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/2] xfstests: Fix generic/643 on ext2 and ext3
Date:   Tue,  2 Nov 2021 16:28:26 +0100
Message-Id: <20211102152828.26895-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

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
 tests/generic/643 | 27 +++++++++------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.31.1

