Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8F54667
	for <fstests@vger.kernel.org>; Fri, 19 Jan 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680480; cv=none; b=sX0K/Z14mlJOM9wfvtIMwW9PsgnQKBzhLM1iUiOY7ujk1B+kyzmUUthi6m08HoldMh4V0KnKg+keVDrR7IhHV2FGWKmlYhTjf03C2FK8mP8RRQxw5c9ucik69GwYwkgwk57Z1JlbVT1n7fLitnnwshMKbewYtYIx59qk2nG2USQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680480; c=relaxed/simple;
	bh=YCyYbSKIJMFpARo3ntSuLegG9b+aQ8OdHSjhC7Lp8zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=helprG/hbunyxxw3bZwEcGVFDQM2eHviN2ZSJS324uHc0LcBNoZSe/oe/w8uV/16N1b+85f3c9mC810lsaGpecxdRJDn4y/I+aHR1AKyDYZjvs7bYvLDzabtObOTS7N1PWwzvU87416B3Dt7FvWcQVy3tGG9Ieh5k0mpavZSj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IM8L5cD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IM8L5cD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705680478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/IYbea0AebPY0Ag11OP4fbl7cOQO4x0KBWk+c1hMjk=;
	b=IM8L5cD2yFNHEt2oTQc1VNth6qpNXrWTOHyVb+gbiemuEvlZ+My4AS0aEFb8Xkg3O8PUxZ
	Tik3LBxTlMaiJF7jOGqXRDpnhORca6YXno04xbzbWsCsD26h9Xq3Rq7Eol5Ir+GZ5ZP0rW
	fCYlvgOSoScqpRKAPhHPj3W0uLLxhYU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-JYGK08IqPZufH4U6jp6jCA-1; Fri,
 19 Jan 2024 11:07:51 -0500
X-MC-Unique: JYGK08IqPZufH4U6jp6jCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B93C3821363;
	Fri, 19 Jan 2024 16:07:51 +0000 (UTC)
Received: from bfoster (unknown [10.22.8.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1305E2166B35;
	Fri, 19 Jan 2024 16:07:50 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:09:09 -0500
From: Brian Foster <bfoster@redhat.com>
To: Su Yue <l@damenly.org>
Cc: Su Yue <glass.su@suse.com>, fstests@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] common/rc: improve block size support for bcachefs
Message-ID: <ZaqepfRjb1vU+nDw@bfoster>
References: <20240117092309.1134595-1-glass.su@suse.com>
 <20240117092309.1134595-2-glass.su@suse.com>
 <ZagUdl+DlxIw+siv@bfoster>
 <h6jb49cm.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h6jb49cm.fsf@damenly.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Jan 18, 2024 at 10:59:14AM +0800, Su Yue wrote:
> 
> On Wed 17 Jan 2024 at 12:55, Brian Foster <bfoster@redhat.com> wrote:
> 
> > On Wed, Jan 17, 2024 at 05:23:09PM +0800, Su Yue wrote:
> > > For bcachefs, def_blksz is never assigned even MKFS_OPTIONS contains
> > > option
> > > '--block_size'. So block size of bcachefs on scratch dev is always
> > > 4096
> > > if _scratch_mkfs_sized is called without second parameter.
> > > 
> > > Add the pattern to set def_blksz if '--block_size' is given in
> > > MKFS_OPTIONS.
> > > 
> > > Signed-off-by: Su Yue <glass.su@suse.com>
> > > ---
> > > changelog:
> > > v2:
> > >     Born.
> > > ---
> > >  common/rc | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 31c21d2a8360..6a01de69cf05 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -950,6 +950,9 @@ _scratch_mkfs_sized()
> > >  	jfs)
> > >  		def_blksz=4096
> > >  		;;
> > > +	bcachefs)
> > > +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(--block_size)[
> > > =]?+([0-9]+).*/\2/p'`
> > > +		;;
> > 
> > So if the default bcachefs block size is 512b, I wonder if this should
> > do something like what the udf branch does a few lines above and
> > 
> mkfs.bcachefs decides block size by querying statbuf.st_blksize or
> BLKPBSZGET from the device if the option is not given.
> 
> > override the hardcoded default of 4k. ISTM this whole thing would be
> > more robust if it just elided the param in the default cases and let the
> > associated mkfs tool use its own default, but that's probably a separate
> > issue. Hm?
> > 
> Since there is no default block size of bcachefs, maybe we can let
> mkfs.bcachefs decide on its own but it will make chaos when somebody
> reports an unreproducible BUG due to the different block_size even
> we have same local.config. It just happened...
> So for now, I think 4096 is a resonable value of bcachefs block size.
> 

I think we run into this no matter what if we pick a size out of a hat,
regardless of what the value is. If somebody is testing with default
blocksize (i.e. based on mkfs) on a filesystem where the default isn't
actually 4k, then it seems quite unexpected that _scratch_mkfs_sized
would use something different from _scratch_mkfs when a block size isn't
explicitly specified. That's exactly the situation we ran into with the
generic/361 thing where I would have expected this test to use 512b
blocks.

ISTM that the 4k value in _scratch_mkfs_sized() is mainly a last resort
default value so the $blocks calculation can work for any filesystem
that might not be properly supported by the function. The function looks
a little wonky overall, but I think there are at least a couple options
to improve things for bcachefs. FWIW, it also looks to me that nothing
actually passes a blocksize param to _scratch_mkfs_sized, so perhaps we
could just drop that blocksize=$2 parameter across the board as a
simplification?

With that, I think bcache could either:

1. Do something like def_blksize=`blockdev --getpbsz $SCRATCH_DEV` in
the first switch if no block size is specified in MKFS_OPTIONS (or
whatever best mimics mkfs logic).

OR

2. Do something like the following in the last switch:

	[ -n $def_blksize ] && def_blksize="--block_size=$def_blksize"
	$MKFS_BCACHEFS_PROG ... $def_blksize $SCRATCH_DEV

... to allow mkfs to determine the block size. I _think_ that works
because the bcachefs format doesn't depend on $blocks at all, so
whatever $blocksize was set to is irrelevent unless $def_blksize was set
above, but I could be missing something. That also assumes blocksize
wasn't set to something by the caller.

If correct, option #2 seems a little cleaner to me, but other
thoughts/ideas?

Brian

> --
> Su
> > 
> > Brian
> > 
> > >  	esac
> > > 
> > >  	[ -n "$def_blksz" ] && blocksize=$def_blksz
> > > --
> > > 2.43.0
> > > 
> 

