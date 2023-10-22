Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1610C25B42
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Oct 2023 21:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjJVVzp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Oct 2023 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjJVVzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Oct 2023 17:55:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A040E9
        for <fstests@vger.kernel.org>; Sun, 22 Oct 2023 14:55:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39MLtXx5015861
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 17:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698011735; bh=dlesaoQKY+KjkCjqsr+L5wxhJXrQEutjyWxL3PRNSHc=;
        h=From:Subject:Date:Message-Id:MIME-Version;
        b=iUboLUdWqzv5PR2Nbu0KmHWtzFSD05wOkYxFl4V1kFE41CNAV6TWpx20940LlAyzp
         pbm3pVPsTLMZxyTE1BzWzoHP0K6X7JvwLwPvK+SRB/Ky6lpRhCYPTf3OAswJ0DxqXS
         HWjo6HwE+p9fzFXh2eH0xrz0wsS7U+oBE6nHPf5dAr8LLkXZyEJPfDuWeP48AggZ9g
         FRfrwhGhuQ0GDCm3ToRzLmJuB4Wodsd0IiqQvRbWnu1mSiezvmm/+4s2qlAZZeZXzx
         eRYO4g/Dg5LhQjh7KkJi0cb8MkaXiCERHQ1LQWBLu/3foOUxwdolLNnUnRbFa8Waef
         QBBD1MuKE2S8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 855F715C0247; Sun, 22 Oct 2023 17:55:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/2] Fix test failures caused by storage devcies with 4k sectors
Date:   Sun, 22 Oct 2023 17:55:27 -0400
Message-Id: <20231022215529.2202150-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When testing with an SSD with a 4k logical sector size, I ran into a
number of test failures that were caused by assumption that the
storage device can support 1k block sizes.

Fix this by skipping those tests, or in the case of generic/563, make
sure the loop device has the same block size as the backing scratch
device.  (Arguably losetup should do that, but at least today, it
doesn't.)

This test series was tested using:

    gce-xfstests --local-ssd-nvme -c ext4,xfs,btrfs -g auto

and comparing it against the results of running the same set of tests
without the --local-ssd-nvme option, which introduces the use of a 4k
sector storage device.

With these patches applied, there is one remaining failure with
xfs/157 but I'm not sure how to deal with it, since Google searches
regarding the failure message just simply say "Don't try to use a
regular file as a logdev", which isn't particularly helpful here.
Maybe the right thing is to just hard code a _notrun if "blockdev
--getss $SCRATCH_DEV" is not 512?  It's not clear to me, so I've left
it.

I also noted two new failures with btrfs, generic/175 and generic/251.
The cause of why these tests are failing with a 4k sector device is
not obvious to me.  But certainly things are much better with this
patch, and perhaps the the btrfs and xfs developers can address these
last new test failures if they care about this particular test
scenario.



Theodore Ts'o (2):
  common: check if the scratch device can support 1024 block sizes
  generic/563: create the loop dev with the same block size as the
    scratch dev

 common/rc         | 22 ++++++++++++++++++++--
 tests/ext4/055    |  1 +
 tests/generic/563 |  2 +-
 tests/xfs/205     |  1 +
 tests/xfs/432     |  1 +
 tests/xfs/516     |  1 +
 6 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.31.0

