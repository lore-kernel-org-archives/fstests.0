Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FBEC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Oct 2021 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425D560EE3
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Oct 2021 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhJRQkH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Oct 2021 12:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbhJRQkH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 18 Oct 2021 12:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A887260ED3
        for <fstests@vger.kernel.org>; Mon, 18 Oct 2021 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634575075;
        bh=iPDMfAF1taRCvfAj95eNLRzTQ75G1k7LTRotqZV43p0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=TQuj78cym1PJ2y5EzKThh+zRGJ/icoyIm2zyroG2NBdNzTw955u2b2PLMv1RKid5V
         /BuqAy6rphIHJZFtTYkh1AWfODVV9W8ltjDDlCAMa9mrbBx2F5Z5eCK/peDRz8G+eK
         FJK+vxtqMvbjmd6cvSdllqtyv2tSmmmlDJVfj01GU3atKwH+s/oFmgtE/P3bFKr46c
         e2TrdjPQbCciDfRiwCkGhGTyWGQxcll4Mz7gcXtjEt4VnSu7j/ZK35ivrqkeLifcgB
         nmpiIQeFqnCOZNJcqB/YXXaC843s+BMuI71K4KP2uuoc7e82wFpd8J+S0OjsWldUfs
         S5ev6Pdhhmsdw==
Date:   Mon, 18 Oct 2021 09:37:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/648: dmerror must be unmounted
Message-ID: <20211018163755.GK24282@magnolia>
References: <20211016021456.3097323-1-zlang@redhat.com>
 <20211016035024.GI24282@magnolia>
 <20211016100937.jq3i2kgnykszqmbk@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016100937.jq3i2kgnykszqmbk@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Oct 16, 2021 at 06:09:37PM +0800, Zorro Lang wrote:
> On Fri, Oct 15, 2021 at 08:50:24PM -0700, Darrick J. Wong wrote:
> > On Sat, Oct 16, 2021 at 10:14:56AM +0800, Zorro Lang wrote:
> > > Sometimes g/648 fail to unmount dmerror with this error:
> > > 
> > >    umount: /mnt/xfstests/scratch: target is busy.
> > > 
> > > Even worse, it will cause all later test cases fail as:
> > > 
> > >   mount: bad usage
> > >   Try 'mount --help' for more information.
> > >   check: failed to mount $SCRATCH_DEV using specified options
> > >   Interrupted!
> > > 
> > > So we shouldn't _fail directly if dmerror_unmount fails, use a while
> > > loop to try to make sure it's unmounted.
> > 
> > Can we preserve the "iteration XXX scratch unmount failed" message,
> > please?
> 
> Sure, how about this:
>  -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
>  +	_dmerror_unmount >> $seqres.full 2>&1
>  +	while [ $? -ne 0 ]; do
>  +              echo "iteration $i scratch unmount failed" >> $seqres.full
>  +		sleep 1
>  +		_dmerror_unmount >> $seqres.full 2>&1
>  +	done
> 
> Or this (if you don't like the infinite while loop).
> 
>  +      is_unmounted=1
>  +      for ((j = 0; j < 50; j++)); do
>  +              sleep 1
>  +              _dmerror_unmount > $tmp.unmount.err 2>&1
>  +              if [ $? -eq 0 ];then
>  +                      is_unmounted=0
>  +                      break
>  +              fi
>  +      done
>  +      if [ $is_unmounted -ne 0 ];then
>  +              cat $tmp.unmount.err
>  +              _fail "iteration $i scratch unmount failed"
>  +      fi
> 
> Or other suggestions you have :)

I like the second one.  FWIW the reason for "iteration XXX umount
failed" is that reviewers asked for that diagnostic capability so that
it would be easier to figure out how much progress the test made before
something broke.

--D

> 
> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/generic/648 | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/648 b/tests/generic/648
> > > index 83dd111d..218f207b 100755
> > > --- a/tests/generic/648
> > > +++ b/tests/generic/648
> > > @@ -104,7 +104,7 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
> > >  		wait > /dev/null 2>&1
> > >  		ps -e | grep fsstress > /dev/null 2>&1
> > >  	done
> > > -	for ((i = 0; i < 10; i++)); do
> > > +	for ((j = 0; j < 10; j++)); do
> > >  		test -e "$snap_aliveflag" || break
> > >  		sleep 1
> > >  	done
> > > @@ -112,7 +112,11 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
> > >  	# Mount again to replay log after loading working table, so we have a
> > >  	# consistent fs after test.
> > >  	$UMOUNT_PROG $loopmnt
> > > -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
> > > +	_dmerror_unmount > /dev/null 2>&1
> > > +	while [ $? -ne 0 ]; do
> > > +		sleep 1
> > > +		_dmerror_unmount > /dev/null 2>&1
> > > +	done
> > >  	_dmerror_load_working_table
> > >  	if ! _dmerror_mount; then
> > >  		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
