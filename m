Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F1EB64DA
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGLWGC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWGB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 18:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C16B0
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 15:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5703961965
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 22:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8703C433C7;
        Wed, 12 Jul 2023 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689199559;
        bh=YPa/X3v0yMJtunRkgEFCckpYN0RUIKAM2yf8PptiLAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baVBpw73s066kxF4cyKTXV9UY2hqGrcu5+0/myZcVsC+sRxXk9mRfK9XMEHzO1L7q
         LkzkZx1y1drMHn3SoWLADk/5LXgRiRAKdRUysPIHP3lfGXbotUFyrfH3m3UYMGEcxc
         Hh7aIQxXCBO7vC9E5rR2AfNVXuRzlaTon2/g5klXvXCMOJ4LZlAMPJ2Idz85pHDdpG
         FCRJQzqxN9y1/cfUkHLyziClZr/ko3/Dx87rJK4cDhNYb423ICFgbmgi3wjvj9dmKb
         vmbZtp/cP3S4IfoAtezM6ZeQJQ/j9InBry+CobRfF3ZLev7YUsjrNk+4Sr2saigcXT
         HSO5F6MqQgOtQ==
Date:   Wed, 12 Jul 2023 15:05:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230712220559.GE11442@frogsfrogsfrogs>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
 <20230711234439.GC11442@frogsfrogsfrogs>
 <95f466a-56ef-291f-cad4-474617814a19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f466a-56ef-291f-cad4-474617814a19@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 12, 2023 at 11:57:49AM +0200, Mikulas Patocka wrote:
> 
> 
> On Tue, 11 Jul 2023, Darrick J. Wong wrote:
> 
> > On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> > > When I run the test 558 on bcachefs, it works like a fork-bomb and kills
> > > the machine. The reason is that the "while" loop spawns "create_file"
> > > subprocesses faster than they are able to complete.
> > > 
> > > This patch fixes the crash by limiting the number of subprocesses to 128.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > > ---
> > >  tests/generic/558 |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > Index: xfstests-dev/tests/generic/558
> > > ===================================================================
> > > --- xfstests-dev.orig/tests/generic/558
> > > +++ xfstests-dev/tests/generic/558
> > > @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
> > >  while [ $i -lt $loop ]; do
> > >  	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
> > >  	let i=$i+1
> > > +	if [ $((i % 128)) = 0 ]; then wait; fi
> > 
> > Hm.  $loop is (roughly) the number of free inodes divided by 1000.  This
> > test completes nearly instantly on XFS; how many free inodes does
> > bcachefs report after _scratch_mount?
> > 
> > XFS reports ~570k inodes, so it's "only" starting 570 processes.
> > 
> > I think it's probably wise to clamp $loop to something sane, but let's
> > get to the bottom of how the math went wrong and we got a forkbomb.
> > 
> > --D
> 
> bcachefs reports 14509106 total inodes (for a 1GB filesystem)
> 
> As the test proceeds, the number of total inodes (as well as the number of 
> free inodes) decreases.

Aha, ok.  So XFS does a similar thing (includes free space in the free
inodes count), but XFS inodes are 256-2048 bytes, whereas bcachefs
inodes can be as small as a few dozen bytes.  That's why the number of
processes is big enough to forkbomb the system.

How about we restrict the number of subshells to something resembling
the CPU count?

free_inodes=$(_get_free_inode $SCRATCH_MNT)
nr_cpus=$(( $($here/src/feature -o) * LOAD_FACTOR ))

if ((free_inodes <= nr_cpus)); then
	nr_cpus=1
	files_per_dir=$free_inodes
else
	files_per_dir=$(( (free_inodes + nr_cpus - 1) / nr_cpus ))
fi
mkdir -p $SCRATCH_MNT/testdir

echo "Create $((loop * file_per_dir)) files in $SCRATCH_MNT/testdir" >>$seqres.full
for ((i = 0; i < nr_cpus; i++)); do
	create_file $SCRATCH_MNT/testdir $files_per_dir $i >>$seqres.full 2>&1 &
done
wait


--D

> Mikulas
> 
