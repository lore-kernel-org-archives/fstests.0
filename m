Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895CEE49A4
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Aug 2023 04:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjHTEDY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Aug 2023 00:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjHTEDX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Aug 2023 00:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7A4EE1
        for <fstests@vger.kernel.org>; Sat, 19 Aug 2023 21:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692504000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+9bTmUcprnSBSlyWhiyyXKWw2sycGyEEnjFZIpQ9E4=;
        b=TrrcFIr/iWTM6W9pncaAOO5b4rYoeVdMhmdPU+69fhIr77LgYBmmGX/Da9mSm32DdciX8A
        637aSGBHPEXWpT1ebIyJIyx73UE5vK/Vc+tdfPGSCDv+zm3xGzqbhTrREHlrpYksE7z/Hd
        sJHdXY895aM1cjbdcH3grSUN6S+zs1w=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-PIgsXg-3PKe8IBDH8F_bRw-1; Sat, 19 Aug 2023 23:59:58 -0400
X-MC-Unique: PIgsXg-3PKe8IBDH8F_bRw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a78c2cc1adso2917301b6e.3
        for <fstests@vger.kernel.org>; Sat, 19 Aug 2023 20:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692503998; x=1693108798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+9bTmUcprnSBSlyWhiyyXKWw2sycGyEEnjFZIpQ9E4=;
        b=Vvwfa0bEi4NJuXzlycq0LVlRgYiVW8EPZpI/hTLYtEjWKDioW18wKKDVk6oB6Y0QlV
         bhnpp5odUiIOvTCd23gxgbttDgLgVRoYcbyCr4VwbCGntza6iwVa2nQNWWoPzjppuNOp
         OxCzuwR0WSxHGu/nE9qiTGAWzTbT16HRAR9viPP2p2wvuJWEuOMZ9Tl4XdvqH+35mFys
         ST/KYtnloMMDElv7/kR+W/qIuGBBMC+bMViIXdGlnf3oWvAYb3sLUR59bFqhaON7RGVf
         /QDQI8+WpV3AuWmsadFyojKAyO0zA0vH4UHqqETexIecmd8HRSNjca+t9aE+KSfJlNgj
         Tgtg==
X-Gm-Message-State: AOJu0YyejiKDhFTLHoXvcO6gjqc/c2JoseQ/TOgx3jDBf9V6npc8lnrQ
        6wbwNRPcbnKbvh1K3lI4yL2FtDY5ME9k/eASPltXAAeVfE2++enb+AjTSRl78U8lqBD5XzeYKy9
        Z4uhvabo+0E3pOINBrgdbe9UEo/mT
X-Received: by 2002:a54:4e05:0:b0:3a7:4052:afa6 with SMTP id a5-20020a544e05000000b003a74052afa6mr3740141oiy.42.1692503998050;
        Sat, 19 Aug 2023 20:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT1V3zbusXenWqnZFH/VrKx/ie8tCOYDthTLhP0KWt/vIYhqrc7xYfGcy6ZMyyu/6bObsFCg==
X-Received: by 2002:a54:4e05:0:b0:3a7:4052:afa6 with SMTP id a5-20020a544e05000000b003a74052afa6mr3740122oiy.42.1692503997699;
        Sat, 19 Aug 2023 20:59:57 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001bde12178b4sm4380751plj.33.2023.08.19.20.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 20:59:57 -0700 (PDT)
Date:   Sun, 20 Aug 2023 11:59:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>, "shr@fb.com" <shr@fb.com>
Subject: Re: [PATCH] generic/471: Remove this broken case
Message-ID: <20230820035953.seigq73sv7pxvehq@zlang-mailbox>
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
 <9eadebb8-1bc7-1c19-ad3d-04b31271f8dc@fujitsu.com>
 <20230818124325.vxod6jkdzirdeaak@zlang-mailbox>
 <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 19, 2023 at 05:25:35PM +0100, Filipe Manana wrote:
> On Fri, Aug 18, 2023 at 1:43 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Aug 16, 2023 at 02:58:10PM +0000, Yang Xu (Fujitsu) wrote:
> > > on  2023/08/15 18:44, Filipe Manana wrote:
> > > > On Mon, Aug 14, 2023 at 4:04 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:
> > > >>
> > > >> I remember this case fails on last year becuase of
> > > >> kernel commit cae2de69 ("iomap: Add async buffered write support")
> > > >> kernel commit 1aa91d9 ("xfs: Add async buffered write support").
> > > >> as below:
> > > >>       pwrite: Resource temporarily unavailable
> > > >>       wrote 8388608/8388608 bytes at offset 0
> > > >>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > >>      -RWF_NOWAIT time is within limits.
> > > >>      +pwrite: Resource temporarily unavailable
> > > >>      +(standard_in) 1: syntax error
> > > >>      +RWF_NOWAIT took  seconds
> > > >>
> > > >> So For async buffered write requests, the request will return -EAGAIN
> > > >
> > > > I'm curious about this.
> > > >
> > > > All the xfs_io pwrite calls are being done with Direct IO (-d)
> > > > argument, so how does that explain the failure?
> > >
> > > I am not understand async buffer write, but with the following
> > > discussion link[1] maybe explain this failure and explain why btrfs passed.
> > > >
> > > >> if the ilock cannot be obtained immediately.
> > > >
> > > > What is the ilock? That seems to be xfs specific.
> > >
> > > yes, I guess it is xfs_ilock and they are xfs specific.
> > > >
> > > > The test passes on btrfs and btrfs supports async buffered writes -
> > > > but I'm still puzzled, because the test only does direct IO writes.
> > > > Does xfs falls back from direct IO to buffered IO?
> > > >
> > > >>
> > > >> Here also a discussion[1] that seems generic/471 has been broken.
> > > >
> > > > Well that discussion doesn't help me understand things. It mentions
> > > > some other discussion, presumably with more details. Where's that
> > > > other discussion?
> > >
> > > I think the url that Jens mention should be this[1] when he reviewed
> > > Stefan V7 patch for "io-uring/xfs: support async buffered writes".
> > >
> > > [1]https://lkml.kernel.org/linux-fsdevel/ca60a7dc-b16d-d8ce-f56c-547b449da8c9@kernel.dk/
> >
> > Hi Filipe,
> >
> > Does above explanation make sense to you?
> 
> Not completely.
> 
> It justifies that the test's assumptions are not necessarily correct,
> that I understood and it's reasonable.
> 
> However I don't see, neither in that thread nor in this patch's
> changelog, why the test started to fail (on xfs, it still passes on
> btrfs and ext4) after adding support for async buffered IO writes to
> xfs and iomap - as all the writes done by the test are using direct
> IO.
> 
> At least the changelog should point to that thread, and not the one it
> currently refers to because it doesn't provide any useful information.

I'll add above link into commit log when I merge it.

> For completeness it should also justify why the async buffered write
> support broke the test, as it points out the test fails after those 2
> commits for buffered write support, yet there are no buffered writes
> performed by the test.

Jens? Darrick? or anyone who can help to provide an explanation about this
question Filipe asked, I'll add it into commit log too.

Thanks,
Zorro

> 
> Anyway, don't make me hold back a patch just because I'm too curious.
> 
> Thanks.
> 
> >
> > This patch got several RVBs, but as this patch removes a generic patch, so
> > I'd like to see there's not objection from any fs list. If btrfs still have
> > more review points, I'll hold this patch, won't merge it in next release.
> >
> > Thanks,
> > Zorro
> >
> > >
> > >
> > > Best Regards
> > > Yang Xu
> > > >
> > > > Thanks.
> > > >
> > > >>
> > > >> Now, I met this problem in my linux distribution, then I found the above
> > > >> discussion. IMO, remove this case is ok and then we can avoid to meet this
> > > >> false report again.
> > > >>
> > > >> [1]https://lore.kernel.org/linux-xfs/b2865bd6-2346-8f4d-168b-17f06bbedbed@kernel.dk/
> > > >> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > >> ---
> > > >>   tests/generic/471     | 67 -------------------------------------------
> > > >>   tests/generic/471.out | 13 ---------
> > > >>   2 files changed, 80 deletions(-)
> > > >>   delete mode 100755 tests/generic/471
> > > >>   delete mode 100644 tests/generic/471.out
> > > >>
> > > >> diff --git a/tests/generic/471 b/tests/generic/471
> > > >> deleted file mode 100755
> > > >> index fbd0b12a..00000000
> > > >> --- a/tests/generic/471
> > > >> +++ /dev/null
> > > >> @@ -1,67 +0,0 @@
> > > >> -#! /bin/bash
> > > >> -# SPDX-License-Identifier: GPL-2.0
> > > >> -# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
> > > >> -#
> > > >> -# FS QA Test No. 471
> > > >> -#
> > > >> -# write a file with RWF_NOWAIT and it would fail because there are no
> > > >> -# blocks allocated. Create a file with direct I/O and re-write it
> > > >> -# using RWF_NOWAIT. I/O should finish within 50 microsecods since
> > > >> -# block allocations are already performed.
> > > >> -#
> > > >> -. ./common/preamble
> > > >> -_begin_fstest auto quick rw
> > > >> -
> > > >> -# Import common functions.
> > > >> -. ./common/populate
> > > >> -. ./common/filter
> > > >> -. ./common/attr
> > > >> -
> > > >> -# real QA test starts here
> > > >> -_require_odirect
> > > >> -_require_test
> > > >> -_require_xfs_io_command pwrite -N
> > > >> -
> > > >> -# Remove reminiscence of previously run tests
> > > >> -testdir=$TEST_DIR/$seq
> > > >> -if [ -e $testdir ]; then
> > > >> -       rm -Rf $testdir
> > > >> -fi
> > > >> -
> > > >> -mkdir $testdir
> > > >> -
> > > >> -# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail with -EAGAIN
> > > >> -# when writing to a file range except if it's a NOCOW file and an extent for the
> > > >> -# range already exists or if it's a COW file and preallocated/unwritten extent
> > > >> -# exists in the target range. So to make sure that the last write succeeds on
> > > >> -# all filesystems, use a NOCOW file on btrfs.
> > > >> -if [ $FSTYP == "btrfs" ]; then
> > > >> -       _require_chattr C
> > > >> -       # Zoned btrfs does not support NOCOW
> > > >> -       _require_non_zoned_device $TEST_DEV
> > > >> -       touch $testdir/f1
> > > >> -       $CHATTR_PROG +C $testdir/f1
> > > >> -fi
> > > >> -
> > > >> -# Create a file with pwrite nowait (will fail with EAGAIN)
> > > >> -$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> > > >> -
> > > >> -# Write the file without nowait
> > > >> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testdir/f1 | _filter_xfs_io
> > > >> -
> > > >> -time_taken=`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1M" $testdir/f1 | awk '/^1/ {print $5}'`
> > > >> -
> > > >> -# RWF_NOWAIT should finish within a short period of time so we are choosing
> > > >> -# a conservative value of 50 ms. Anything longer means it is waiting
> > > >> -# for something in the kernel which would be a fail.
> > > >> -if (( $(echo "$time_taken < 0.05" | bc -l) )); then
> > > >> -       echo "RWF_NOWAIT time is within limits."
> > > >> -else
> > > >> -       echo "RWF_NOWAIT took $time_taken seconds"
> > > >> -fi
> > > >> -
> > > >> -$XFS_IO_PROG -c "pread -v 0 8M" $testdir/f1 | _filter_xfs_io_unique
> > > >> -
> > > >> -# success, all done
> > > >> -status=0
> > > >> -exit
> > > >> diff --git a/tests/generic/471.out b/tests/generic/471.out
> > > >> deleted file mode 100644
> > > >> index ab23272e..00000000
> > > >> --- a/tests/generic/471.out
> > > >> +++ /dev/null
> > > >> @@ -1,13 +0,0 @@
> > > >> -QA output created by 471
> > > >> -pwrite: Resource temporarily unavailable
> > > >> -wrote 8388608/8388608 bytes at offset 0
> > > >> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > >> -RWF_NOWAIT time is within limits.
> > > >> -00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > >> -*
> > > >> -00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > > >> -*
> > > >> -00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > >> -*
> > > >> -read 8388608/8388608 bytes at offset 0
> > > >> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > >> --
> > > >> 2.27.0
> > > >>
> >
> 

