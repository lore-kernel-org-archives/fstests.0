Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C9FC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356460AbiELQxI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiELQxI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2A73DA76
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23FDFB82948
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96CFC385B8;
        Thu, 12 May 2022 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374383;
        bh=IwSwZMSRVlliDgZNCmpSD+bezRxjFsenOA0+RnPDhRo=;
        h=From:To:Cc:Subject:Date:From;
        b=Hs6R1vSMbCWqFD3zkJ/a463MLsKNpumLW22r14PiQN0Svn1ppx11vi2I4VXTpUgfB
         2D7unSdmTFOcucu9r0OoRh03TaF7TtTNh+J2vA4gN5LUjftv1fhioouv71mkGGNsT7
         AOaunu6QvDn8BXGXPGV4qkzo83CNx8VXoc852ilJSJGxHCGlUFqxwBpTQ2hkwvjXkf
         Xj0CDJtIj5wjFCunpeHQOoUJJ4FhXrF30vM77Q+odqTBII+tCHQc2brqCEuKforEfI
         q+KjvM05RIhe4OVPSQgbig5gBh0xtUp/6DztIm7HLOHEnuOrvbCZDBikL1QjX8umji
         kYtGyqyENPsVg==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 00/13] rename & split tests
Date:   Thu, 12 May 2022 18:52:37 +0200
Message-Id: <20220512165250.450989-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6010; h=from:subject; bh=6IJ6CPQEp6LitJsuVFdZ1tQ2a+0qKJTNWRhhSB1EZgI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWrtdvnIo9HhQTF1C1/rI/9fzFe2Fnact0K5YHLgsVdYq L8i5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKXjRgZbsvd1Ws0v/pUJU2X96pugH +P8FJpB/5t4goffT6/cNuyhpHhiX1/R5h+Ruell5Gu4jah56TaytYKnTkkYmuzJu19wn9OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey everyone,

Please note that this patch series contains patches that will be
rejected by the fstests mailing list because of the amount of changes
they contain. So tools like b4 will not be able to find the whole patch
series on a mailing list. In case it's helpful I've added the
"fstests.vfstest.for-next" tag which can be pulled. Otherwise it's
possible to simply use the patch series as it appears in your inbox.

All vfstests pass:

#### btrfs ####
ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /mnt/scratch

btrfs/245 52s ...  54s
generic/633 58s ...  51s
generic/644 60s ...  49s
generic/645 161s ...  143s
generic/656 63s ...  55s
Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
Passed all 5 tests

#### ext4 ####
ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /mnt/scratch

generic/633 47s ...  50s
generic/644 46s ...  49s
generic/645 135s ...  139s
generic/656 53s ...  54s
Ran: generic/633 generic/644 generic/645 generic/656
Passed all 4 tests

#### xfs ####
ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /mnt/scratch

generic/633 58s ...  58s
generic/644 62s ...  60s
generic/645 161s ...  161s
generic/656 62s ...  63s
xfs/152 133s ...  133s
xfs/153 94s ...  92s
Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
Passed all 6 tests

/* v2 */
* This rebases the patchset on top the for-next branch.
* Last week we merged 858a19c5e9b0 ("idmapped_mounts: Prepare for
  support for more features"). The patch switched feature checking from
  a boolean to a flag. It failed convert all tests. This adds a patch to
  fix this in patch 01/13.
* A patch has been added to remove an invalid test. The semantics for a
  specific corner-case where we allowed a mount's idmapping to change
  while there were active writers will be altered.

/* v1 */
As announced multiple times already we need to rename and split the
idmapped mount testsuite into separate source files and also give it a
better name to reflect the fact that it covers a lot more than just
idmapped mounts.

I have decided against compiling different binaries for now. Instead we
compile a single vfstest binary that can be called with various command
line switches to run the various test suites. This is not different than
what we did for the idmapped-mounts binary. Of course, nothing prevents
us from using multiple binaries in the future.

Thanks!
Christian

Christian Brauner (13):
  idmapped-mounts: make all tests set their required feature flags
  src: rename idmapped-mounts folder
  src/vfs: rename idmapped-mounts.c file
  vfstest: rename struct t_idmapped_mounts
  utils: add missing global.h include
  utils: add struct vfstest_info
  utils: move helpers into utils
  missing: move sys_execveat() to missing.h
  utils: add struct test_suite
  vfstests: split idmapped mount tests into separate suite
  vfstest: split out btrfs idmapped mounts test
  vfstest: split out remaining idmapped mount tests
  vfs/idmapped-mounts: remove invalid test

 .gitignore                                    |     4 +-
 common/rc                                     |    32 +-
 src/Makefile                                  |     2 +-
 src/detached_mounts_propagation.c             |     2 +-
 src/feature.c                                 |     2 +-
 src/idmapped-mounts/idmapped-mounts.c         | 14625 ----------------
 src/idmapped-mounts/utils.c                   |   425 -
 src/idmapped-mounts/utils.h                   |   130 -
 src/{idmapped-mounts => vfs}/Makefile         |    14 +-
 src/vfs/btrfs-idmapped-mounts.c               |  3854 ++++
 src/vfs/btrfs-idmapped-mounts.h               |    15 +
 src/vfs/idmapped-mounts.c                     |  7747 ++++++++
 src/vfs/idmapped-mounts.h                     |    18 +
 src/{idmapped-mounts => vfs}/missing.h        |    11 +
 src/{idmapped-mounts => vfs}/mount-idmapped.c |     0
 src/vfs/utils.c                               |  1050 ++
 src/vfs/utils.h                               |   373 +
 src/vfs/vfstest.c                             |  2073 +++
 tests/btrfs/245                               |     2 +-
 tests/generic/633                             |     2 +-
 tests/generic/644                             |     2 +-
 tests/generic/645                             |     2 +-
 tests/generic/656                             |     2 +-
 tests/xfs/152                                 |     4 +-
 tests/xfs/153                                 |     2 +-
 25 files changed, 15177 insertions(+), 15216 deletions(-)
 delete mode 100644 src/idmapped-mounts/idmapped-mounts.c
 delete mode 100644 src/idmapped-mounts/utils.c
 delete mode 100644 src/idmapped-mounts/utils.h
 rename src/{idmapped-mounts => vfs}/Makefile (59%)
 create mode 100644 src/vfs/btrfs-idmapped-mounts.c
 create mode 100644 src/vfs/btrfs-idmapped-mounts.h
 create mode 100644 src/vfs/idmapped-mounts.c
 create mode 100644 src/vfs/idmapped-mounts.h
 rename src/{idmapped-mounts => vfs}/missing.h (93%)
 rename src/{idmapped-mounts => vfs}/mount-idmapped.c (100%)
 create mode 100644 src/vfs/utils.c
 create mode 100644 src/vfs/utils.h
 create mode 100644 src/vfs/vfstest.c


base-commit: 87cf32ad3fa234e3d5ec501e0f86516bef91d805
-- 
2.34.1

