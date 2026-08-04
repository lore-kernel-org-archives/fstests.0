Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDA44C641
	for <fstests@vger.kernel.org>; Tue,  4 Aug 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838372; cv=none; b=n5+8HacQG+tRMzH+jqmucd9WhStlMGlZjb/GJwduXbMwFaRm/QXB2udLtXQX2zG5N5lQtT8DC4+K9rixb/bSEwAumYSzk27Ec04WYndfaGCAvdxb5NDMRvL1MWhAadktHfjZ8Op60TkERKFljcQ44NuwLw4h+sowkFt21+Cb/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838372; c=relaxed/simple;
	bh=JPbKls7wgoCTMBw6flUbbA67B172Pnvj3jL7R7OeiXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0oI3mYhIs5OZ+kXtGIJmHJb39Migt71CWvJ3LbqJ5S2bGIhklKprjTDGgv+RITNRBhT6HIsedoLES7mWHrFYHE+feGg8QCfIujWCBVIBcFoJc3Wi8Buh9VtIUPk+eI9Ums8zsenzXwXpscsEjO2SDMQVS8OybTgPD2jeb5Kwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii2c9ujY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii2c9ujY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDD41F000E9;
	Tue,  4 Aug 2026 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785838368;
	bh=6v0FygIxqDRMQbs2mUvmsik9VKIZEN9IRiMuUrr3BoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ii2c9ujYlZNzLjAxMXXDIfteNtqTsMpeqPUKAmnRzrbE71M0DYFrcZO8nYqk5cVUy
	 a2qN3g0YRCv+BV1ZiCQ2d/Q2phYPCDX0QbDGO9BkO9UV7b1Rv2lSWfMX01m0sAbBU7
	 yPOgCBiY+fESCcuW/w/H0Z6GRtFeh7groVVMJMJMMHJTGsOBYSmqk5tsh0e0DjNBYM
	 8jWg3EmLdCHJ5grRvQSq1ec4kIpyVXJgSj9wdVXtsJgfZ9I6fLLYBEilGWrkr35R3d
	 zqlrEMG4PK7tjoK7E8YXg0aYJxUVLHl2Qc9IVFSjpqmq1YgTEbzkhf8ipxRIIFzpAy
	 dXTJGSr6RyrZg==
Date: Tue, 4 Aug 2026 18:12:43 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/347: Fix sporadic test failures
Message-ID: <anGpvjOMwsbZ0FnA@zlang-mailbox>
Mail-Followup-To: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
References: <20260730151817.4120874-1-jack@suse.cz>
 <anBNLS4JmtT8GHGu@zlang-mailbox>
 <w6jeuw6jilax7u646a6vdxqjpf7bioj4d7v4xdvh5bipitslbd@jby652g3gce5>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6jeuw6jilax7u646a6vdxqjpf7bioj4d7v4xdvh5bipitslbd@jby652g3gce5>

On Mon, Aug 03, 2026 at 01:20:22PM +0200, Jan Kara wrote:
> Hi Zorro!
> 
> On Mon 03-08-26 16:27:15, Zorro Lang wrote:
> > On Thu, Jul 30, 2026 at 05:18:17PM +0200, Jan Kara wrote:
> > > generic/347 was occasionally failing on ext4 in our QA due to ext4
> > > aborting its journal when the filesystem on thinp device was overfilled.
> > > I have tracked the problem down to journal checkpointing failing to
> > > write a metadata block to its final location due to ENOSPC failure from
> > > the thinp device. Modify the test to first preallocate blocks for the
> > > files and remount the filesystem which practically makes sure all
> > > involved metadata blocks were written and so their further modifications
> > > will not fail.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  tests/generic/347 | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/347 b/tests/generic/347
> > > index 06df0cf9eddc..56538c160392 100755
> > > --- a/tests/generic/347
> > > +++ b/tests/generic/347
> > > @@ -38,7 +38,17 @@ _setup_thin()
> > >  
> > >  _workout()
> > >  {
> > > -	# Overfill it by a bit
> > > +	# Preallocate space to avoid failure for metadata writeback
> > > +	for I in `seq 1 500`; do
> > > +		$XFS_IO_PROG -f -c "falloc 0 1M" $SCRATCH_MNT/file$I &>/dev/null
> > 
> > Thanks for this fix! Adding fallocate introduces an extra dependency via
> > _require_xfs_io_command "falloc", which will limit some filesystems can
> > run this test.
> 
> I agree the fix has some downsides. OTOH when I was thinking about it I've
> concluded that filesystems where you realistically care about behavior on
> thinp storage also do support fallocate. So I don't think this it's a
> serious test coverage limitation but it's up for discussion.

Sure, if we accept this patch, we'll need the _require_xfs_io_command "falloc"
restriction. This is a basic test for filesystems on thinp, let's try to get
more review points, if there are no objections, we can merge it at first.

>
> > Additionally, since the underlying storage is a thinp device, I doubt
> > `falloc 0 1M` actually triggers physical block allocation on the thin
> > pool (correct me if I'm wrong). If so, I suspect this 1M * 500 preallocation
> > might exhaust the 500M BACKING_SIZE prematurely (along with file system
> > metadata overhead), similar to the pwrite loop below.
> 
> We do *not* want fallocate to trigger the data block allocation. It will

Sorry, I previously thought that fallocate would trigger actual physical block
allocation on thinp under certain filesystems or mount options. However,
I just tested it out (including exFAT, and Btrfs with nodatacow/compress=zstd),
and found that none of them actually allocate physical space.

Thanks,
Zorro

> however modify all the relevant metadata blocks and subsequent unmount will
> writeout these modified metadata which forces the physical block allocation
> for the metadata which is what we need. Physical space for data blocks is
> not reserved from thinp during fallocate so we should not run out of
> backing device space during this loop.
> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
