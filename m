Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2119C001B0
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Aug 2023 02:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjHOCRZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 22:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjHOCRC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 22:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9CB0
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 19:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B8461851
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 02:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F11C433C8;
        Tue, 15 Aug 2023 02:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065820;
        bh=AIKC2j5miU+HTwQ+KAKmk6LAz7i0uX+I7dTES4VCLTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJna36VsK+fyrc+/SjF1TID91QC8UyM9OmO5k7sAOyhYpXwjH/59kzv7+bagZgdrr
         Ujqbjx56zAGKUvK+74S44ztUIz4Rer4hgfK4sudY7rxNtKECejc+WVY8ibnIlX/FjY
         Bc41aEP9wX5lXcwOg7Zx8jBJBB3oeDiPfN9xgcfF6JSRtoitqFfXn6AAeXkEXaKXzv
         KgLO/o9EKArXkf+6iyJo7tikHidZsJnmy+OSnipDewBNXMg4mOZCvJgbYZrKTcgla9
         3VU8yJIvVpHH4+fdavyuyf7fiiFBSTHGjDUdhVPp20dJIo9XjYrmYDm9SwRl7AIxJa
         T8Zt3R4w6S4Vg==
Date:   Mon, 14 Aug 2023 19:16:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/{175,297,298}: fix use of uninitialized var
Message-ID: <20230815021659.GS11377@frogsfrogsfrogs>
References: <20230812151500.553233-1-amir73il@gmail.com>
 <20230813153523.GQ11377@frogsfrogsfrogs>
 <CAOQ4uxiwyCvEshtc9QDUKKXyO0U77cq+ENy7FAz+9v4s7YUoSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiwyCvEshtc9QDUKKXyO0U77cq+ENy7FAz+9v4s7YUoSQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 13, 2023 at 09:53:30PM +0300, Amir Goldstein wrote:
> On Sun, Aug 13, 2023 at 6:35 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sat, Aug 12, 2023 at 06:15:00PM +0300, Amir Goldstein wrote:
> > > Not sure how those tests pass in regression tests.
> > > Probably truncate silently fails and is not critical to the test.
> > >
> > > in kdevops I get errors like:
> > > /data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
> > >            syntax error: operand expected (error token is "/dev/loop12)")
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  tests/generic/175 | 2 +-
> > >  tests/generic/297 | 2 +-
> > >  tests/generic/298 | 2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tests/generic/175 b/tests/generic/175
> > > index 07af2199..14825a39 100755
> > > --- a/tests/generic/175
> > > +++ b/tests/generic/175
> > > @@ -33,7 +33,7 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
> > >
> > >  fnr=19
> > >  echo "Create extents"
> > > -truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
> > > +truncate -s $(( (2 ** (fnr + 1)) * blksz)) "$testdir/file1"
> > >  for i in $(seq 0 $fnr); do
> >
> > Hmm.  Frankly I don't remember why I put those truncate calls in there.
> 
> You specifically added truncate in commit
> ddf6ff2f reflink: ensure that we can handle reflinking a lot of extents
> and then it was copied to the two new tests.
> maybe this will give you a hint?

Alas, no.  Total etch-a-sketch over here. :(

AFAICT the tests work just fine without the truncate calls, so let's
remove them.

--D

> > Does the test still work if you remove them entirely?  AFAICT the test
> > writes a single block's worth of data to the file, then truncates the
> > file size to one block.  Which I think is pointless.
> >
> > >       echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
> > >       n=$(( (2 ** i) * blksz))
> > > diff --git a/tests/generic/297 b/tests/generic/297
> > > index 6bdc3e1c..1fc48671 100755
> > > --- a/tests/generic/297
> > > +++ b/tests/generic/297
> > > @@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
> > >  fnr=26               # 2^26 reflink extents should be enough to find a slow op?
> > >  timeout=8    # guarantee a good long run...
> > >  echo "Find a reflink size that takes a long time"
> > > -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
> > > +truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
> > >  for i in $(seq 0 $fnr); do
> > >       echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
> > >       n=$(( (2 ** i) * blksz))
> >
> > The loop control logic could be converted to:
> >
> > echo "Find a reflink size that takes a long time"
> > deadline="$(( $(date +%s) + timeout ))"
> > for ((i = 0, now = $(date +%s); i < fnr && now < deadline; i++, now = $(date +%s))); do
> >         echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
> >         n=$(( (2 ** i) * blksz))
> >         $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1
> > done
> >
> > (also in 298)
> >
> 
> Whatever works is fine by me.
> Feel free to keep my commit message or drop it.
> 
> Thanks,
> Amir.
