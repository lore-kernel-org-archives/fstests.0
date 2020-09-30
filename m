Return-Path: <SRS0=elmR=DH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC9C2D0A8
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E2E2075F
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 07:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvhxKWMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgI3HzL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3HzL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Sep 2020 03:55:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247FC061755
        for <fstests@vger.kernel.org>; Wed, 30 Sep 2020 00:55:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j13so709770ilc.4
        for <fstests@vger.kernel.org>; Wed, 30 Sep 2020 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9Pq3is8pdaXg8URoTMH84AoVwoVgWv13R9wzCKvTYs=;
        b=IvhxKWMX8Ci2ArMqQZX2NVFn5F5o5JbozKtB/C3brIVBvXrBT2cRCRl4e3n3m9hIgf
         eHhHrZjXb6nJGRAt4TfXSBFNdfA0pDFadNs2sdyIiCb/IcJ/hiVmIMNu77FiVNpwzx92
         ms77Rc91GNK6Yi0CdLG3+Yf0onPnktQi+bq+gN7NAyExXnGd2EjoGWbC/hRr2S7XGtt6
         E2ba8ll2T8VWTWdH00WPiG9zAlKh0uaRCaszzIYegaamNrhdYToWLW14rGsw5VoJruEO
         2xMDjOYybV2x9IQWpgc78/FO0IDW2bOz8BKd54jlnNLEy4tbUucc7F8qjpfdZExY/CPe
         LEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9Pq3is8pdaXg8URoTMH84AoVwoVgWv13R9wzCKvTYs=;
        b=IZifz4mPGcU93BAX5eD38/3Qfe/c4Xf+OuoQ9ZgLH9m860mKaqD5ZWS30gdp744hlo
         rUIAxF+nl+dwZI2uvdiZCG1U8W2NVYaxrw+Yoruj1Vp2O1TkZDrquCspfFt+O7kdFk+u
         6oAPobe65zr+YYZ80OgCcv7n9WuONeNbuKjcM8Ivh4UBVx8HpVhvlffCtgjhQ5xxG6+E
         AoXpKV9IY4stp0XA9o0d82AKjBaEcRkeNThJFmg42qNX0rB9+hUFM4P1nByA2BbDB8NL
         f9KdqkyLd3wa6gigUi46Tf1fE1Hkk53KDxFjP/2FQ8oAva6EmyIWGUPtscDAuKr3mGoR
         RPfA==
X-Gm-Message-State: AOAM533lSnuv9GzeVPYp6zKa3e1Kpyv+HZxnjiNQagtCibEFrkGJR1fa
        vopHph9KNBG6qgRwv6XxuJnyJdyAKCAyZT6jTUevAjE1bIQ=
X-Google-Smtp-Source: ABdhPJzeVMAWU9NJS/kIDMygTRfqM59LY3LwWKxt9muerhihPB7CJ0yQ0h7T7ZugrbnfllMKtur7iRQx6mEmLOGLsJo=
X-Received: by 2002:a92:8b41:: with SMTP id i62mr1060858ild.9.1601452510466;
 Wed, 30 Sep 2020 00:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200930050409.24705-1-yangx.jy@cn.fujitsu.com> <5F741881.5020309@cn.fujitsu.com>
In-Reply-To: <5F741881.5020309@cn.fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Sep 2020 10:54:58 +0300
Message-ID: <CAOQ4uxhXBbmAiGpiAx8=3TiFi-Or+dfEgET5rHwBTYFd+df1Zg@mail.gmail.com>
Subject: Re: [PATCH] overlay/071: Fix undefined OVL_BASE_SCRATCH_DIR
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 30, 2020 at 8:33 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> Hi Amir,
>
> I always got diffenent inode number if underlying fileystem is ext4.
> ------------------------------------------------
> # diff -u /var/lib/xfstests/tests/overlay/071.out
> /var/lib/xfstests/results//overlay/071.out.bad
> --- /var/lib/xfstests/tests/overlay/071.out 2020-09-30
> 12:59:30.478968816 +0800
> +++ /var/lib/xfstests/results//overlay/071.out.bad 2020-09-30
> 13:13:02.342920819 +0800
> @@ -1,2 +1,26 @@
> QA output created by 071
> +--- /tmp/25096.lower.lo 2020-09-30 13:12:59.594920981 +0800
> ++++ /tmp/25096.before.lo 2020-09-30 13:12:59.706920975 +0800
> +@@ -1,7 +1,7 @@
> +-8590721028 file
> +-8590721029 symlink
> +-8590721030 link
> +-8590721031 chrdev
> +-8590721032 blkdev
> +-8590721033 fifo
> +-8590721034 socket
> ++9223372045445496836 file
> ++9223372045445496837 symlink
> ++9223372045445496838 link
> ++9223372045445496839 chrdev
> ++9223372045445496840 blkdev
> ++9223372045445496841 fifo
> ++9223372045445496842 socket
> +file not found by ino 8590721028 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> +symlink not found by ino 8590721029 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> +link not found by ino 8590721030 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> +chrdev not found by ino 8590721031 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> +blkdev not found by ino 8590721032 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> +fifo not found by ino 8590721033 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> +socket not found by ino 8590721034 (from /tmp/25096.lower.lo) - see
> /var/lib/xfstests/results//overlay/071.full
> Silence is golde
> ------------------------------------------------
> Is this expected behavior? :-)

Yes and No :-)

The result is expected. It is not expected for the test to fail.
This is a test bug.

The bug is in this line and in the comment above it:
# Compare inode numbers in lower overlay vs. nested overlay
# With nested xino lower/lower, all inode numbers overflow xino bits and
# d_ino/i_ino in nested overlay are the same as in lower overlay.
check_inode_numbers $lowertestdir $tmp.lower.lo $tmp.before.lo

This test is meant to cover the case of "xino=on/auto, ino overflow" from:
https://github.com/torvalds/linux/blob/master/Documentation/filesystems/overlayfs.rst#inode-properties

The correct part of the comment is:
# With nested xino lower, all inode numbers overflow xino bits
Meaning that all inode numbers at $lowertestdir have the MSB set
(e.g. file ino 9223372045445496836  = 0x80000002000C0004)

With lower fs xfs, the other part of the comment is also correct:
# ...and d_ino/i_ino in nested overlay are the same as in lower overlay

Because in the lower overlay ($SCRATCH_MNT/lowertestdir)
lower files also have the MSB set.

However, because ext4 has a known inode number limit of 32bit
(see ovl_can_decode_fh) the lower overlay inodes do not have the
MSB set (e.g. file ino 8590721028 = 0x2000C0004).

Long story short, I think we need to remove this line and comment
from the test and leave it the same as overlay/070:

# Record inode numbers before copy up
record_inode_numbers $lowertestdir $tmp.before.lo
record_inode_numbers $uppertestdir $tmp.before.up

This recording is just for the sake of logging info in 070.full.

>
> Best Regards,
> Xiao Yang
> On 2020/9/30 13:04, Xiao Yang wrote:
> > Replace undefined OVL_BASE_SCRATCH_DIR with OVL_BASE_SCRATCH_MNT
> >
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Will you also fix the test bug please.

Thanks!
Amir.
