Return-Path: <SRS0=PjwK=2Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9432C2D0CE
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 06:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6822314
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 06:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMWhtZ5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgACGqP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Jan 2020 01:46:15 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45734 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACGqP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Jan 2020 01:46:15 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so35885769iln.12
        for <fstests@vger.kernel.org>; Thu, 02 Jan 2020 22:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmHzKxQbfQMHeQW1KOO0WIzMJKmOVVylgButWsDXvdI=;
        b=vMWhtZ5IvPMoTDAKMcK3sBb5Ao5WDkZwAVW/rIwVz4veSwphEVfxpr8YvdJjcI/QcM
         h7FMDSdnenX5fT/fR9HGSkIbuhvdWIt5t3jTzyQ4rbVAi3uyjaUPrep+iCfmfCFCc6wA
         l2FUxmUu9Dp8v6f3QS+7Cx4KIEY9ILvkHd78DE4HLsO/f/K/l7p0dqYdtsV9aXY789Ae
         1ENLhuWw88fUu2P0JRhWQpENHwG+dtm5BEvQT4gkCLfP3lh8+mibgIqBj6r0NRsOqgfD
         oBo+mQ7GpppTKB0Y2FizqgwkL5XfnzOs+6vS9Gd7lSbxb+GqYJH2gA+zOiqgHZJnNzam
         rhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmHzKxQbfQMHeQW1KOO0WIzMJKmOVVylgButWsDXvdI=;
        b=OtVfonI5Orli5HnET622Rdj2wfyFos/fIRC5Xq2Y73HGzwE4YWsEcbFr8rsd7+ekGk
         Fx6RPw+VNOezCY9bPylvIY0JdT0ihjMDdsffF20moSzMuo9MBgK0P4KDuSq6GV6FeolU
         a0CRsP6jsgrZsMuZlCI7kFe3Ttj7Zuml7kF1VKo3lEP8QMoz9fNpjZqXAQ16Qinmx/qk
         2h3nSrkTcjzTKnK2MGh2EB+8lJq+6F+tFgKMWD92FpFBRXNYqUjCuzamVnpZ7OERIt11
         q0tcoiYVYP7YurA+2tyYoGsgtxC83VDi0CydrsOND+z6EaFL/22g5C0mNwx/Mds5PBhC
         F4dw==
X-Gm-Message-State: APjAAAVxg78bKG0rMrz2jtGR7kfLOVXncYVUaPpdRPtLChNvIzf7IEeq
        DEnJpsfL62Se/2Q0J4q0cXOSXrxnLA/6q6tprz4=
X-Google-Smtp-Source: APXvYqwxHvqBe0Jopx2XAIE9XpPKGQn7vZfF25oPH9m7vMzNV3/ayHPb7aRY0AjQ6bAceZSyr2IGJlT4I/RGpLUuZKk=
X-Received: by 2002:a92:1642:: with SMTP id r63mr77987393ill.81.1578033974261;
 Thu, 02 Jan 2020 22:46:14 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com> <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
In-Reply-To: <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 2 Jan 2020 22:46:02 -0800
Message-ID: <CABeXuvqxLnfUMcq9+ip8vkMU43gAphr9MvveD1bw+5QeWo+3zA@mail.gmail.com>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> As a generic helper, this function has a few problems:
> 1. It assumes scratch dev is mounted (and you're not even calling it
> after _scratch_mount)

Ok, this was an oversight. I was using rootfs as scratch and didn't
catch this in my tests.

> 2. The cleanup() hook won't clean loop mnt/dev if interrupted

Agreed. I can add these in.

There are some existing functions in common/rc that do not clean up.
For example _require_scratch_swapfile might leave partial state if interrupted.

> 3. test doesn't have _require_loop (nor require ext4 as you mentioned)

Some generic functions assume many preconditions.
But, if it is preferred to be more self contained, I can model this
after something like _require_scratch_swapfile()

> All this leads me to think that perhaps it would be better off, at least until
> kernel has fsinfo, to keep this entire helper inside generic/402,
> while addressing
> the issues above in the test itself.

> A more generic solution would be harder and IMO and overkill at this point.

With fsinfo as proposed, it would not be possible to tell if fs ranges
are supported without doing the same kind of workaround.
A capability bit could be added to advertise that feature of VFS, or
it might be reasonable to assume it from the mere existence of fsinfo
syscall.

> What do you think?

The following proposed patch uses a local _cleanup handler that can handle this.
I am okay with either approach. I'm not sure which one is preferable
to xfstests maintainers.
Let me know and I can post it as a V3.

-Deepa

From f539005511f3ad83563cabc6d185b2c76ae37dea Mon Sep 17 00:00:00 2001
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 22 Dec 2019 19:18:14 -0800
Subject: [PATCH v3 1/1] generic/402: Make timestamp range check conditional

Addition of fs-specific timestamp range checking was added
in 188d20bcd1eb ("vfs: Add file timestamp range support").

Add a check for whether the kernel supports the limits check
before running the associated test.

ext4 has been chosen to test for the presence of kernel support
for this feature.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 common/rc         | 50 +++++++++++++++++++++++++++++++++++++++++++----
 tests/generic/402 | 12 +++++++++++-
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index eeac1355..796052e6 100644
--- a/common/rc
+++ b/common/rc
@@ -1751,17 +1751,18 @@ _require_loop()
 #
 _require_ext2()
 {
+    fs=${1:-ext2}
     if [ "$HOSTOS" != "Linux" ]
     then
-    _notrun "This test requires linux for ext2 filesystem support"
+    _notrun "This test requires linux for $fs filesystem support"
     fi

-    modprobe ext2 >/dev/null 2>&1
-    if grep ext2 /proc/filesystems >/dev/null 2>&1
+    modprobe $fs >/dev/null 2>&1
+    if grep $fs /proc/filesystems >/dev/null 2>&1
     then
     :
     else
-    _notrun "This test requires ext2 filesystem support"
+    _notrun "This test requires $fs filesystem support"
     fi
 }

@@ -1981,6 +1982,47 @@ _run_aiodio()
     return $status
 }

+_require_kernel_timestamp_range()
+{
+
+    _require_scratch
+    _require_loop
+    _require_ext2 ext4
+
+    # Use a subshell to clean up the nested loop mount
+    _cleanup='( umount $LOOP_MNT ; _destroy_loop_device $LOOP_DEV ;
rm -f $LOOP_FILE ; _scratch_unmount )'
+
+    _scratch_mkfs >/dev/null
+    _scratch_mount
+
+    LOOP_FILE=$SCRATCH_MNT/loop_file
+    LOOP_MNT=$SCRATCH_MNT/loop_mnt
+
+    dd if=/dev/zero of=$LOOP_FILE bs=1M count=2 2>&1 | _filter_dd ||
_fail "loopback prep failed"
+
+    # Use ext4 with 128-byte inodes, which do not have room for
extended timestamp
+    FSTYP=ext4 MKFS_OPTIONS=-I128 \
+    _mkfs_dev $LOOP_FILE >> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
+
+    LOOP_DEV=$(_create_loop_device $LOOP_FILE)
+    mkdir -p $LOOP_MNT >> $seqres.full 2>&1 || _fail "failed to
create $LOOP_MNT"
+    mount -t ext4 ${LOOP_DEV} ${LOOP_MNT} >> $seqres.full 2>&1 ||
_fail "ext4 mount failed"
+    notrun=false
+    _check_dmesg_for "ext4 filesystem being mounted at ${LOOP_MNT}
supports timestamps until 2038" || \
+        notrun=true
+
+    umount ${LOOP_MNT} >> $seqres.full 2>&1 || _fail "failed to
umount $LOOP_MNT"
+    _destroy_loop_device ${LOOP_DEV} >> $seqres.full 2>&1
+
+    _scratch_unmount
+
+    _cleanup=:
+
+    if $notrun; then
+        _notrun "Kernel does not support timestamp limits"
+    fi
+}
+
 _require_timestamp_range()
 {
     local device=${1:-$TEST_DEV}
diff --git a/tests/generic/402 b/tests/generic/402
index 0392c258..4288168a 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -16,7 +16,14 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup=:
+trap "eval \$_cleanup; _cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $tmp.*
+}

 # Get standard environment, filters and checks.
 . ./common/rc
@@ -30,6 +37,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_check_dmesg
 _require_xfs_io_command utimes

 # Compare file timestamps obtained from stat
@@ -79,6 +87,8 @@ run_test()
     done
 }

+_require_kernel_timestamp_range
+
 _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_timestamp_range $SCRATCH_DEV

-- 
2.17.1
