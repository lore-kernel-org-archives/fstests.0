Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CDDC10F1E
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Dec 2022 10:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiLRKjv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Dec 2022 05:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLRKjq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Dec 2022 05:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B79D134
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2022 02:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671359938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tyO6GaWJEPdrRydeCYofiCnC/vVvQWTP2UHTEnmEL2A=;
        b=hyzyVanaA5tspnwTv2gVICOVea4PTbaD09v1TT4V6Z8iDYW/p+W4vEF9D3RwOB0zBuNmX5
        uThove3nXQHsCOIEdZJxQsmAcQWAeBKJ/4zNIQsZLO4jitVc+E3XjFx2L3WWoPouir9zBt
        TjEUq5H9EOgtbi5Z8mLulncq6sXMIGY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-lCP3KdEMONaKS4FszoyGNw-1; Sun, 18 Dec 2022 05:38:57 -0500
X-MC-Unique: lCP3KdEMONaKS4FszoyGNw-1
Received: by mail-pg1-f200.google.com with SMTP id p7-20020a631e47000000b0047691854a86so3912759pgm.16
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2022 02:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyO6GaWJEPdrRydeCYofiCnC/vVvQWTP2UHTEnmEL2A=;
        b=KmFrvsT1q1L4jF8UleUMWxkG+kIb5QcLhNeC2xg6LxiNf/K2ud2B6MS7wq+wufGtoo
         gdRfLw2/1E05TbgTudlH4yQrik3kxj+BZiRXx7b/UghG4rE4SNk7eg04aVxyF/Zcedf9
         XksrskU5gsosN9QJG+8PVMSegjHj7GCRG0VuyJqRRsxH+V3ZINve8Fcbz0IYI7VE1yk2
         k0vjLd0MkM39hWoJqeQFMXvsjkdnqu4BR0xJYd5WyZ3PVDonkkOrxl+UaK+rLGWrdI/D
         gbjEVnIssFFMPahaoIGevV6nL3MpjP4SNMvcz4U5LveDE0vppoRnSE0gj1nP6EgKYGRa
         lIdg==
X-Gm-Message-State: ANoB5pngT6BuDikLIoreRzw1jWpuisf//vizM+eLPsGQOb2rQwy3HKAK
        jh3tfq3kofWuAC/69/eEmLguZgbzTBlANR35pp2z9TllCyQU3FsWV4knsBOuTEKqVQ39iPRlKW4
        SXAxQpEb+/jOXNZGyIQ==
X-Received: by 2002:a05:6a20:3d22:b0:a3:cc70:6dcc with SMTP id y34-20020a056a203d2200b000a3cc706dccmr55742905pzi.39.1671359935940;
        Sun, 18 Dec 2022 02:38:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/AQPN5ocW67fi1WrHISvWq5/0jZenjHK4Dna4mCkbA71FxMv88CVYNEhFtzkimCldVI96mg==
X-Received: by 2002:a05:6a20:3d22:b0:a3:cc70:6dcc with SMTP id y34-20020a056a203d2200b000a3cc706dccmr55742887pzi.39.1671359935577;
        Sun, 18 Dec 2022 02:38:55 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0017f8094a52asm4856255plg.29.2022.12.18.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:38:55 -0800 (PST)
Date:   Sun, 18 Dec 2022 18:38:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Why fstests g/673 and g/683~687 suddently fail (on xfs, ext4...) on
 latest linux v6.1+ ?
Message-ID: <20221218103850.cbqdq3bmw7zl7iad@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

fstests generic/673 and generic/683~687 are a series of test cases to
verify suid and sgid bits are dropped properly. xfs-list writes these
cases to verify xfs behavior follows vfs, e.g. [1]. And these cases
test passed on xfs and ext4 for long time. Even on my last regression
test on linux v6.1-rc8+, they were passed too.

But now the default behavior looks like be changed again, xfs and ext4
start to fail [2] on latest linux v6.1+ (HEAD [0]), So there must be
changed. I'd like to make sure what's changed, and if it's expected?

Thanks,
Zorro

[0]
commit f9ff5644bcc04221bae56f922122f2b7f5d24d62
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Dec 17 08:55:19 2022 -0600

    Merge tag 'hsi-for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-h

[1]
commit e014f37db1a2d109afa750042ac4d69cf3e3d88e
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Tue Mar 8 10:51:16 2022 -0800

    xfs: use setattr_copy to set vfs inode attributes

[2]
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/673       - output mismatch (see /var/lib/xfstests/results//generic/673.out.bad)
    --- tests/generic/673.out	2022-12-17 13:57:40.336589178 -0500
    +++ /var/lib/xfstests/results//generic/673.out.bad	2022-12-18 00:00:53.627210256 -0500
    @@ -51,7 +51,7 @@
     310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
     2666 -rw-rwSrw- SCRATCH_MNT/a
     3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
    -2666 -rw-rwSrw- SCRATCH_MNT/a
    +666 -rw-rw-rw- SCRATCH_MNT/a
     
     Test 10 - qa_user, group-exec file, only sgid
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/673.out /var/lib/xfstests/results//generic/673.out.bad'  to see the entire diff)
Ran: generic/673
Failures: generic/673
Failed 1 of 1 tests

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/683       - output mismatch (see /var/lib/xfstests/results//generic/683.out.bad)
    --- tests/generic/683.out	2022-12-17 13:57:40.696589178 -0500
    +++ /var/lib/xfstests/results//generic/683.out.bad	2022-12-18 00:04:55.297220255 -0500
    @@ -33,7 +33,7 @@
     
     Test 9 - qa_user, non-exec file falloc, only sgid
     2666 -rw-rwSrw- TEST_DIR/683/a
    -2666 -rw-rwSrw- TEST_DIR/683/a
    +666 -rw-rw-rw- TEST_DIR/683/a
     
     Test 10 - qa_user, group-exec file falloc, only sgid
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/683.out /var/lib/xfstests/results//generic/683.out.bad'  to see the entire diff)
Ran: generic/683
Failures: generic/683
Failed 1 of 1 tests

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/684       - output mismatch (see /var/lib/xfstests/results//generic/684.out.bad)
    --- tests/generic/684.out	2022-12-17 13:57:40.766589178 -0500
    +++ /var/lib/xfstests/results//generic/684.out.bad	2022-12-18 00:05:27.597220255 -0500
    @@ -33,7 +33,7 @@
     
     Test 9 - qa_user, non-exec file fpunch, only sgid
     2666 -rw-rwSrw- TEST_DIR/684/a
    -2666 -rw-rwSrw- TEST_DIR/684/a
    +666 -rw-rw-rw- TEST_DIR/684/a
     
     Test 10 - qa_user, group-exec file fpunch, only sgid
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/684.out /var/lib/xfstests/results//generic/684.out.bad'  to see the entire diff)
Ran: generic/684
Failures: generic/684
Failed 1 of 1 tests
....
....


Thanks,
Zorro

