Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5283DC001B0
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Aug 2023 10:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjHOKq0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjHOKqB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2023 06:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692F1BEC
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 03:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94A3A623D3
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 10:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD390C433CA
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692096317;
        bh=faXjXO/JZQKFHWyOG0hg6+wiZ5cciQDytupYvubsB5Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XN0Om+S6AsJHdsbaZ1swJMrEQw4bFTfNJiaZ+aNN17l0ts8vmpWPw9c6674J0MikB
         JTC7wBnahdtweA352RAP1MWbL403v/1ovmM3XGjNWj4l0knMDrbFDQBTjR+aYAmZI0
         pKe9RZB3XXpj6eJaiWx6aeKvYwnoHVQbQG5zUdZufnKIXGnjMLrCnbRGqZ9B0gAaQ9
         oO4sgsBQhnTeSdSCzO8+64C7YsVucqn5ubHj1dUApHYO21fc+4pw2zqsEmH6lcnl/g
         GNhQF6uU3PPA1EbwBEf3Hie6ySqU/8j9t9fGXtvhhoFtQIUVpmqa4d4LiCMT4J3lde
         ffXfwBtDBTGUQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56c711a88e8so3911694eaf.2
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 03:45:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlI6ZymreZNh2D0M0GnboIQBD72uUa3H8ge5jWg6cOklIanWUf
        6aAVCuwtUjV9gQlIXKDKFg567Z6OvyJ+tnLG8b8=
X-Google-Smtp-Source: AGHT+IF46C8fE/gl+1od/K99IxC7BoDKATHjTtUlBnWLtVOQiTyTcy3NHUYoP33QlosFSp7Wm6UwILt+3tX9Cd5RCF4=
X-Received: by 2002:a05:6870:a798:b0:19f:aee0:e169 with SMTP id
 x24-20020a056870a79800b0019faee0e169mr13091936oao.30.1692096316914; Tue, 15
 Aug 2023 03:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 15 Aug 2023 11:44:40 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
Message-ID: <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
Subject: Re: [PATCH] generic/471: Remove this broken case
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org, axboe@kernel.dk,
        tytso@mit.edu, shr@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 4:04=E2=80=AFPM Yang Xu <xuyang2018.jy@fujitsu.com>=
 wrote:
>
> I remember this case fails on last year becuase of
> kernel commit cae2de69 ("iomap: Add async buffered write support")
> kernel commit 1aa91d9 ("xfs: Add async buffered write support").
> as below:
>      pwrite: Resource temporarily unavailable
>      wrote 8388608/8388608 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -RWF_NOWAIT time is within limits.
>     +pwrite: Resource temporarily unavailable
>     +(standard_in) 1: syntax error
>     +RWF_NOWAIT took  seconds
>
> So For async buffered write requests, the request will return -EAGAIN

I'm curious about this.

All the xfs_io pwrite calls are being done with Direct IO (-d)
argument, so how does that explain the failure?

> if the ilock cannot be obtained immediately.

What is the ilock? That seems to be xfs specific.

The test passes on btrfs and btrfs supports async buffered writes -
but I'm still puzzled, because the test only does direct IO writes.
Does xfs falls back from direct IO to buffered IO?

>
> Here also a discussion[1] that seems generic/471 has been broken.

Well that discussion doesn't help me understand things. It mentions
some other discussion, presumably with more details. Where's that
other discussion?

Thanks.

>
> Now, I met this problem in my linux distribution, then I found the above
> discussion. IMO, remove this case is ok and then we can avoid to meet thi=
s
> false report again.
>
> [1]https://lore.kernel.org/linux-xfs/b2865bd6-2346-8f4d-168b-17f06bbedbed=
@kernel.dk/
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/generic/471     | 67 -------------------------------------------
>  tests/generic/471.out | 13 ---------
>  2 files changed, 80 deletions(-)
>  delete mode 100755 tests/generic/471
>  delete mode 100644 tests/generic/471.out
>
> diff --git a/tests/generic/471 b/tests/generic/471
> deleted file mode 100755
> index fbd0b12a..00000000
> --- a/tests/generic/471
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
> -#
> -# FS QA Test No. 471
> -#
> -# write a file with RWF_NOWAIT and it would fail because there are no
> -# blocks allocated. Create a file with direct I/O and re-write it
> -# using RWF_NOWAIT. I/O should finish within 50 microsecods since
> -# block allocations are already performed.
> -#
> -. ./common/preamble
> -_begin_fstest auto quick rw
> -
> -# Import common functions.
> -. ./common/populate
> -. ./common/filter
> -. ./common/attr
> -
> -# real QA test starts here
> -_require_odirect
> -_require_test
> -_require_xfs_io_command pwrite -N
> -
> -# Remove reminiscence of previously run tests
> -testdir=3D$TEST_DIR/$seq
> -if [ -e $testdir ]; then
> -       rm -Rf $testdir
> -fi
> -
> -mkdir $testdir
> -
> -# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail with=
 -EAGAIN
> -# when writing to a file range except if it's a NOCOW file and an extent=
 for the
> -# range already exists or if it's a COW file and preallocated/unwritten =
extent
> -# exists in the target range. So to make sure that the last write succee=
ds on
> -# all filesystems, use a NOCOW file on btrfs.
> -if [ $FSTYP =3D=3D "btrfs" ]; then
> -       _require_chattr C
> -       # Zoned btrfs does not support NOCOW
> -       _require_non_zoned_device $TEST_DEV
> -       touch $testdir/f1
> -       $CHATTR_PROG +C $testdir/f1
> -fi
> -
> -# Create a file with pwrite nowait (will fail with EAGAIN)
> -$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> -
> -# Write the file without nowait
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testdir/f1=
 | _filter_xfs_io
> -
> -time_taken=3D`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1M" $t=
estdir/f1 | awk '/^1/ {print $5}'`
> -
> -# RWF_NOWAIT should finish within a short period of time so we are choos=
ing
> -# a conservative value of 50 ms. Anything longer means it is waiting
> -# for something in the kernel which would be a fail.
> -if (( $(echo "$time_taken < 0.05" | bc -l) )); then
> -       echo "RWF_NOWAIT time is within limits."
> -else
> -       echo "RWF_NOWAIT took $time_taken seconds"
> -fi
> -
> -$XFS_IO_PROG -c "pread -v 0 8M" $testdir/f1 | _filter_xfs_io_unique
> -
> -# success, all done
> -status=3D0
> -exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> deleted file mode 100644
> index ab23272e..00000000
> --- a/tests/generic/471.out
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -QA output created by 471
> -pwrite: Resource temporarily unavailable
> -wrote 8388608/8388608 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -RWF_NOWAIT time is within limits.
> -00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> -*
> -00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ............=
....
> -*
> -00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> -*
> -read 8388608/8388608 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> --
> 2.27.0
>
