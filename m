Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5AEE49A3
	for <linux-fstests@archiver.kernel.org>; Sat, 19 Aug 2023 16:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjHSQ0U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 19 Aug 2023 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjHSQ0U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 19 Aug 2023 12:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6512756
        for <fstests@vger.kernel.org>; Sat, 19 Aug 2023 09:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB48761E36
        for <fstests@vger.kernel.org>; Sat, 19 Aug 2023 16:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B21CC433CA
        for <fstests@vger.kernel.org>; Sat, 19 Aug 2023 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692462372;
        bh=rX89G/Uo4uyZiiXUm9zovEY4wvxgZKBB9CZ0MhPDgZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iLWwCkeFgjiZppwysotTQnc8eV+l2g2eKxRMP4xS0O5sX2jeO9J+D6p0jAWLZwXBp
         Rjwp8myLXHID/XnCZK9d7s1pM4JUyn+L/cyY6i/oM5LETefTxJbxyEjLVttT47zo8U
         JhCWtvDnLYA+7aIWao/gK4bQJf2i2G8LxvqLCXgLrh5+7apOu/25W7DDtfAzJ4n1Jh
         JoYXKj3Dzt7ImajLgZKR1Nyqx3l1a0f4dyajx5DjOOs1FKG71ugrMLd3iXIbM3HKlr
         EezkH3IdeZufLzcjhbf3RuyHKGI2gLbk+AgNJmIpAkV/8bPiZEsnZo/4oGbLW7X0jo
         rcTf+I05T1xSQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-570b6e1a413so245558eaf.3
        for <fstests@vger.kernel.org>; Sat, 19 Aug 2023 09:26:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrkFhB+Om/nfgNAAUnmWI+K+M+aOoaQLviBzspoWOLW2U+Zfhi
        ja+OcWDpWIcTfUUQc6SH5sSVs1Xl1fFCogPqhO0=
X-Google-Smtp-Source: AGHT+IGvJwEZNyNofUwwXM9IuvkUKE/TpkMFUaXe2fXjERAE+4PSdq2AiURHFS1Hin2sbqdORfo+sj0YHEeqWHsJ1go=
X-Received: by 2002:a4a:3956:0:b0:56e:4921:deb0 with SMTP id
 x22-20020a4a3956000000b0056e4921deb0mr2863333oog.8.1692462371362; Sat, 19 Aug
 2023 09:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
 <9eadebb8-1bc7-1c19-ad3d-04b31271f8dc@fujitsu.com> <20230818124325.vxod6jkdzirdeaak@zlang-mailbox>
In-Reply-To: <20230818124325.vxod6jkdzirdeaak@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sat, 19 Aug 2023 17:25:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
Message-ID: <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
Subject: Re: [PATCH] generic/471: Remove this broken case
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>, "shr@fb.com" <shr@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 18, 2023 at 1:43=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Wed, Aug 16, 2023 at 02:58:10PM +0000, Yang Xu (Fujitsu) wrote:
> > on  2023/08/15 18:44, Filipe Manana wrote:
> > > On Mon, Aug 14, 2023 at 4:04=E2=80=AFPM Yang Xu <xuyang2018.jy@fujits=
u.com> wrote:
> > >>
> > >> I remember this case fails on last year becuase of
> > >> kernel commit cae2de69 ("iomap: Add async buffered write support")
> > >> kernel commit 1aa91d9 ("xfs: Add async buffered write support").
> > >> as below:
> > >>       pwrite: Resource temporarily unavailable
> > >>       wrote 8388608/8388608 bytes at offset 0
> > >>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >>      -RWF_NOWAIT time is within limits.
> > >>      +pwrite: Resource temporarily unavailable
> > >>      +(standard_in) 1: syntax error
> > >>      +RWF_NOWAIT took  seconds
> > >>
> > >> So For async buffered write requests, the request will return -EAGAI=
N
> > >
> > > I'm curious about this.
> > >
> > > All the xfs_io pwrite calls are being done with Direct IO (-d)
> > > argument, so how does that explain the failure?
> >
> > I am not understand async buffer write, but with the following
> > discussion link[1] maybe explain this failure and explain why btrfs pas=
sed.
> > >
> > >> if the ilock cannot be obtained immediately.
> > >
> > > What is the ilock? That seems to be xfs specific.
> >
> > yes, I guess it is xfs_ilock and they are xfs specific.
> > >
> > > The test passes on btrfs and btrfs supports async buffered writes -
> > > but I'm still puzzled, because the test only does direct IO writes.
> > > Does xfs falls back from direct IO to buffered IO?
> > >
> > >>
> > >> Here also a discussion[1] that seems generic/471 has been broken.
> > >
> > > Well that discussion doesn't help me understand things. It mentions
> > > some other discussion, presumably with more details. Where's that
> > > other discussion?
> >
> > I think the url that Jens mention should be this[1] when he reviewed
> > Stefan V7 patch for "io-uring/xfs: support async buffered writes".
> >
> > [1]https://lkml.kernel.org/linux-fsdevel/ca60a7dc-b16d-d8ce-f56c-547b44=
9da8c9@kernel.dk/
>
> Hi Filipe,
>
> Does above explanation make sense to you?

Not completely.

It justifies that the test's assumptions are not necessarily correct,
that I understood and it's reasonable.

However I don't see, neither in that thread nor in this patch's
changelog, why the test started to fail (on xfs, it still passes on
btrfs and ext4) after adding support for async buffered IO writes to
xfs and iomap - as all the writes done by the test are using direct
IO.

At least the changelog should point to that thread, and not the one it
currently refers to because it doesn't provide any useful information.
For completeness it should also justify why the async buffered write
support broke the test, as it points out the test fails after those 2
commits for buffered write support, yet there are no buffered writes
performed by the test.

Anyway, don't make me hold back a patch just because I'm too curious.

Thanks.

>
> This patch got several RVBs, but as this patch removes a generic patch, s=
o
> I'd like to see there's not objection from any fs list. If btrfs still ha=
ve
> more review points, I'll hold this patch, won't merge it in next release.
>
> Thanks,
> Zorro
>
> >
> >
> > Best Regards
> > Yang Xu
> > >
> > > Thanks.
> > >
> > >>
> > >> Now, I met this problem in my linux distribution, then I found the a=
bove
> > >> discussion. IMO, remove this case is ok and then we can avoid to mee=
t this
> > >> false report again.
> > >>
> > >> [1]https://lore.kernel.org/linux-xfs/b2865bd6-2346-8f4d-168b-17f06bb=
edbed@kernel.dk/
> > >> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > >> ---
> > >>   tests/generic/471     | 67 ---------------------------------------=
----
> > >>   tests/generic/471.out | 13 ---------
> > >>   2 files changed, 80 deletions(-)
> > >>   delete mode 100755 tests/generic/471
> > >>   delete mode 100644 tests/generic/471.out
> > >>
> > >> diff --git a/tests/generic/471 b/tests/generic/471
> > >> deleted file mode 100755
> > >> index fbd0b12a..00000000
> > >> --- a/tests/generic/471
> > >> +++ /dev/null
> > >> @@ -1,67 +0,0 @@
> > >> -#! /bin/bash
> > >> -# SPDX-License-Identifier: GPL-2.0
> > >> -# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
> > >> -#
> > >> -# FS QA Test No. 471
> > >> -#
> > >> -# write a file with RWF_NOWAIT and it would fail because there are =
no
> > >> -# blocks allocated. Create a file with direct I/O and re-write it
> > >> -# using RWF_NOWAIT. I/O should finish within 50 microsecods since
> > >> -# block allocations are already performed.
> > >> -#
> > >> -. ./common/preamble
> > >> -_begin_fstest auto quick rw
> > >> -
> > >> -# Import common functions.
> > >> -. ./common/populate
> > >> -. ./common/filter
> > >> -. ./common/attr
> > >> -
> > >> -# real QA test starts here
> > >> -_require_odirect
> > >> -_require_test
> > >> -_require_xfs_io_command pwrite -N
> > >> -
> > >> -# Remove reminiscence of previously run tests
> > >> -testdir=3D$TEST_DIR/$seq
> > >> -if [ -e $testdir ]; then
> > >> -       rm -Rf $testdir
> > >> -fi
> > >> -
> > >> -mkdir $testdir
> > >> -
> > >> -# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail=
 with -EAGAIN
> > >> -# when writing to a file range except if it's a NOCOW file and an e=
xtent for the
> > >> -# range already exists or if it's a COW file and preallocated/unwri=
tten extent
> > >> -# exists in the target range. So to make sure that the last write s=
ucceeds on
> > >> -# all filesystems, use a NOCOW file on btrfs.
> > >> -if [ $FSTYP =3D=3D "btrfs" ]; then
> > >> -       _require_chattr C
> > >> -       # Zoned btrfs does not support NOCOW
> > >> -       _require_non_zoned_device $TEST_DEV
> > >> -       touch $testdir/f1
> > >> -       $CHATTR_PROG +C $testdir/f1
> > >> -fi
> > >> -
> > >> -# Create a file with pwrite nowait (will fail with EAGAIN)
> > >> -$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> > >> -
> > >> -# Write the file without nowait
> > >> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testd=
ir/f1 | _filter_xfs_io
> > >> -
> > >> -time_taken=3D`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1=
M" $testdir/f1 | awk '/^1/ {print $5}'`
> > >> -
> > >> -# RWF_NOWAIT should finish within a short period of time so we are =
choosing
> > >> -# a conservative value of 50 ms. Anything longer means it is waitin=
g
> > >> -# for something in the kernel which would be a fail.
> > >> -if (( $(echo "$time_taken < 0.05" | bc -l) )); then
> > >> -       echo "RWF_NOWAIT time is within limits."
> > >> -else
> > >> -       echo "RWF_NOWAIT took $time_taken seconds"
> > >> -fi
> > >> -
> > >> -$XFS_IO_PROG -c "pread -v 0 8M" $testdir/f1 | _filter_xfs_io_unique
> > >> -
> > >> -# success, all done
> > >> -status=3D0
> > >> -exit
> > >> diff --git a/tests/generic/471.out b/tests/generic/471.out
> > >> deleted file mode 100644
> > >> index ab23272e..00000000
> > >> --- a/tests/generic/471.out
> > >> +++ /dev/null
> > >> @@ -1,13 +0,0 @@
> > >> -QA output created by 471
> > >> -pwrite: Resource temporarily unavailable
> > >> -wrote 8388608/8388608 bytes at offset 0
> > >> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >> -RWF_NOWAIT time is within limits.
> > >> -00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .......=
.........
> > >> -*
> > >> -00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  .......=
.........
> > >> -*
> > >> -00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .......=
.........
> > >> -*
> > >> -read 8388608/8388608 bytes at offset 0
> > >> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >> --
> > >> 2.27.0
> > >>
>
