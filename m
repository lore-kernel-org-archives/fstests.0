Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85752C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jan 2022 04:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiA0E7i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Jan 2022 23:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbiA0E7i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jan 2022 23:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643259576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQ4OiDu9BjJjvcyPcDT/bLeiU8ePaOdP8XCKK5yWfmw=;
        b=Xhh73JdBChrXGp8u/hRQONHy4Y2GzeEhEBvLE4og2FJJDifeN2j0HFl0xexiwQBHuoISkP
        H8+0h6cdKW1r3Y+FdZH2Q6Ib5rO9pHSAnkSdq46aRaxeJpxKg6jk4dk1/K/rE4yfeNY+nu
        tvW0ptRyefmcC6EhADS7T+HIZvprqko=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-AIkjJgPSM6qph2zZnFsWKw-1; Wed, 26 Jan 2022 23:59:35 -0500
X-MC-Unique: AIkjJgPSM6qph2zZnFsWKw-1
Received: by mail-pf1-f200.google.com with SMTP id i6-20020a626d06000000b004c0abfd53b3so993958pfc.12
        for <fstests@vger.kernel.org>; Wed, 26 Jan 2022 20:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UQ4OiDu9BjJjvcyPcDT/bLeiU8ePaOdP8XCKK5yWfmw=;
        b=B7HHh1JNPkE9v1YjvhgNwGFzDrfEagZKZSY3PR8OpkUIJTpTh7wCTrkY8stemr2Tp6
         adaD4RKQwGPRv6B5Fr8HE+vOkFOGbZiz6oaXYsB7hOHOtohHxowffuM7lM2oV+BuVS3w
         pKltTsjWRo4oaZEuCaM7mJRBiGyAkMb9boy0bK+ZOJV0W4ndA8l/tdadVcdpZ/Cn/wad
         vPl9u5x5bEqugp/tXJiRPJDoPCgXO0cMtRBctgqSXYAkxcDFMB60xkgD+7YOvBbwRxsg
         oyZuOEHumCJXzB3a74yYiuThu5q99QFLKmiyBeJEtUwDUbWvNNLccpt1aSF1hgCghuQG
         6Z5A==
X-Gm-Message-State: AOAM530HonJMevQX7wE3hwbDhL0JqAfTsSmt+RRWKU4UzxIZ9T6AR2lr
        QBhBqZlWGd1PCtzAtuaide4qgIvVgAnsLJUv6y9aSbngIwaFoe93ziWQn+KQlZ19P9W1QAn61UT
        sJJXsig5N0GOVJTK9+A==
X-Received: by 2002:a17:90b:1c91:: with SMTP id oo17mr12352882pjb.104.1643259574154;
        Wed, 26 Jan 2022 20:59:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPgTOPZbn1EBDoUyvf7lgLDTF5dHzt7LUGuodUywHuBE5PXjdzbJjuImTRNhld99KZMeba6A==
X-Received: by 2002:a17:90b:1c91:: with SMTP id oo17mr12352862pjb.104.1643259573762;
        Wed, 26 Jan 2022 20:59:33 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e19sm2751789pfv.62.2022.01.26.20.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 20:59:33 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:59:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Eryu Guan <guan@eryu.me>, "djwong@kernel.org" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr
 corrupted
Message-ID: <20220127045928.ad2d7bqdatiymq7a@zlang-mailbox>
Mail-Followup-To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Eryu Guan <guan@eryu.me>, "djwong@kernel.org" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <20211126232817.GA266000@magnolia>
 <1642407736-3898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ye1TiTOUdGoemiV9@desktop>
 <61F20B74.1090008@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61F20B74.1090008@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 27, 2022 at 03:02:36AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/1/23 21:09, Eryu Guan wrote:
> > On Mon, Jan 17, 2022 at 04:22:16PM +0800, Yang Xu wrote:
> >> Add getfattr operation in these three cases, we can also use xfs/126(corrupt a leaf
> >> xattr's data extent) to reproduce a deadlock. This deadlock is introduced by kernel
> >> commit 07120f1abdff ("xfs: Add xfs_has_attr and subroutines") and fixed by kernel
> >
> > So this was introduced since 5.9 kernel, and
> >
> >> commit a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname").
> >
> > fixed in 5.16 kernel.
> >
> > And adding this regression test in xfs/126, which passed in the past.
> > probably would cause all the affected kernels in between start to hang,
> > and trigger a false positive regression alert.
> >
> > So IMO it'd be better to make a separated&  targeted regression test for
> > this case, as Darrick suggested.
> Ok, Now, I understand but don't figure out how to setattr  to use leaf 
> attr block accuratly and corrupt leaf attr accuratly even I have read 
> the documentation[1] instead of xfs/126 using generic fuzz way.

Generally, if you keep creating attr entries, until the attr out of an inode
internal attrfork space, you'll get leaf block and separated attr value blocks.
If you keep creating more attr entries, until the attr entries out of a block
size, you'll get node and leaf blocks.

From xfs/126, Darrick use a while loop to create attrs in about 8 blocks.

nr="$((8 * blksz / 40))"
seq 0 "${nr}" | while read d; do
        setfattr -n "user.x$(printf "%.08d" "$d")" -v "0000000000000000" "${SCRATCH_MNT}/attrfile"
done

(Although I don't know why it's 40. From above setfattr command, I think each xfs_attr_leaf_name_local
takes 28 bytes, each xfs_attr_leaf_entry takes 8 bytes. And there're node and leaf blocks, not sure
how Darrick knows it'll take 8 blocks :).

I didn't give it a test, not sure if Darrick would like to get 1 node block and 7 leaf blocks at here.
Then he loop trash each ablocks (from 1 to end), except the root node block.

loff=1
while true; do
        _scratch_xfs_db -x -c "inode ${inode}" -c "ablock ${loff}" -c "stack" | grep -q 'file attr block is unmapped' && break
        _scratch_xfs_db -x -c "inode ${inode}" -c "ablock ${loff}" -c "stack" -c "blocktrash -o 4 -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
        loff="$((loff + 1))"
done

Thanks,
Zorro



> 
> So if somebody can do this or teach me, I will be pleasure.
> 
> [1]https://github.com/djwong/xfs-documentation/blob/master/design/XFS_Filesystem_Structure/extended_attributes.asciidoc
> 
> 
> Best Regards
> Yang Xu
> >
> > Thanks,
> > Eryu
> >
> >>
> >> Also making getfattr operation after xattr corrupted is a common part, so we can
> >> test whether the similar deadlock occurs in the future in xfs/124(corrupt a block xattr)
> >> and xfs/125(corrupt a leaf xattr's index extent).
> >>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >>   tests/xfs/124 | 2 +-
> >>   tests/xfs/125 | 2 +-
> >>   tests/xfs/126 | 2 +-
> >>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tests/xfs/124 b/tests/xfs/124
> >> index 39307218..c3cccfd5 100755
> >> --- a/tests/xfs/124
> >> +++ b/tests/xfs/124
> >> @@ -64,7 +64,7 @@ _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -
> >>
> >>   echo "+ mount image&&  modify xattr"
> >>   if _try_scratch_mount>>  $seqres.full 2>&1; then
> >> -
> >> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2>  /dev/null&&  _fail "got corrupt xattr"
> >>   	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2>  /dev/null&&  _fail "modified corrupt xattr"
> >>   	umount "${SCRATCH_MNT}"
> >>   fi
> >> diff --git a/tests/xfs/125 b/tests/xfs/125
> >> index fb5f5695..a7eb51fb 100755
> >> --- a/tests/xfs/125
> >> +++ b/tests/xfs/125
> >> @@ -64,7 +64,7 @@ _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -
> >>
> >>   echo "+ mount image&&  modify xattr"
> >>   if _try_scratch_mount>>  $seqres.full 2>&1; then
> >> -
> >> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2>  /dev/null&&  _fail "got corrupt xattr"
> >>   	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2>  /dev/null&&  _fail "modified corrupt xattr"
> >>   	umount "${SCRATCH_MNT}"
> >>   fi
> >> diff --git a/tests/xfs/126 b/tests/xfs/126
> >> index c3a74b1c..519d377e 100755
> >> --- a/tests/xfs/126
> >> +++ b/tests/xfs/126
> >> @@ -69,7 +69,7 @@ done
> >>
> >>   echo "+ mount image&&  modify xattr"
> >>   if _try_scratch_mount>>  $seqres.full 2>&1; then
> >> -
> >> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2>  /dev/null&&  _fail "got corrupt xattr"
> >>   	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2>  /dev/null&&  _fail "modified corrupt xattr"
> >>   	umount "${SCRATCH_MNT}"
> >>   fi
> >> --
> >> 2.23.0

