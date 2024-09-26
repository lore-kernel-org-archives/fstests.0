Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C014D71D
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366059; cv=none; b=HnUoiVF7Wij5xW83DObfBptLmL3vtpxJDBtxEKjPw0G+QngSzEkZ5+HWwef2fN6XzuyvHrGPxmETPp0p3e3jhQ+jwK/lNFUttws7LgS5e8Dv1FZma4fYfWk2kDT+/Ld+pJQ0Lrv+v/VycTdHyUB8ASmpjPcxU08w6ZHzOxGoqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366059; c=relaxed/simple;
	bh=uiLkgk+54CMpafdsfa0rhqbdrW3TEOOKxgGbufpEqJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byJe0yniB8+ybRnsEc3uld1HxT/Dm5c5jVXNTyhy/9ntDTo5SxaTQg7ZiOys5eM3TUk9MA6AECQ4s8Gyspm3IwMIc8fNFqgik7uMqXuBlwGekHXCWbQvc/lCr5Ng7tW576Oygtbwm6hlSat59IVFvYeLPtgV4DxZOjQzsgkhFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRnvxacH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRnvxacH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727366057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Va8IAaRC4LhFXtYjgfi8mQAC/K5uI3iebOsA0BPjRV4=;
	b=DRnvxacHzN/VgSM6x8/uIHTV8PuyQ5LxgEtkF3SkWNEJC5vJ0i9J5R57A1qgV2hcR9eqL0
	lxs96LjF0WfiixlXqjT63ekDxklx6RWmWgpIJGrXgr3Q0ajOrOVqMKw5gBYG6bP4R515Nq
	BsD4/M7URuWE7vW6NV0yYAt7g08eLiE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-tAo8UvUzPrWc_OMjWdlLCw-1; Thu,
 26 Sep 2024 11:54:13 -0400
X-MC-Unique: tAo8UvUzPrWc_OMjWdlLCw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 153E11979056;
	Thu, 26 Sep 2024 15:54:13 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.70])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B5F519560A3;
	Thu, 26 Sep 2024 15:54:12 +0000 (UTC)
Date: Thu, 26 Sep 2024 11:55:21 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <ZvWD6SsfGJDisYP9@bfoster>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
 <20240926145028.GC21840@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926145028.GC21840@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Sep 26, 2024 at 07:50:28AM -0700, Darrick J. Wong wrote:
> On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> > The various fallocate flags are mostly ifdef'd for backward
> > compatibility with the exception of the associated test_fallocate()
> > calls to verify functionality at runtime. I suspect the reason for
> > this was to avoid ifdef ugliness around having to clear the runtime
> > flag for each operation, but unfortunately this defeats the purpose
> > of the ifdef protection everywhere else.
> > 
> > Factor out the fallocate related test calls into a new helper and
> > add the appropriate ifdefs.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 45 insertions(+), 14 deletions(-)
> > 
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 677f8c9f..417743c5 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
> >  #endif
> >  }
> >  
> > +void
> > +test_fallocate_calls(void)
> > +{
> > +	if (fallocate_calls)
> > +		fallocate_calls = test_fallocate(0);
> > +	if (keep_size_calls)
> > +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > +
> > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > +	if (unshare_range_calls)
> > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > +#else
> > +	unshare_range_calls = 0;
> > +#endif
> > +
> > +#ifdef FALLOC_FL_PUNCH_HOLE
> > +	if (punch_hole_calls)
> > +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > +#else
> > +	punch_hole_calls = 0;
> > +#endif
> > +
> > +#ifdef FALLOC_FL_ZERO_RANGE
> > +	if (zero_range_calls)
> > +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > +#else
> > +	zero_range_calls = 0;
> > +#endif
> > +
> > +#ifdef FALLOC_FL_COLLAPSE_RANGE
> > +	if (collapse_range_calls)
> > +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > +#else
> > +	collapse_range_calls = 0;
> > +#endif
> 
> The concept looks fine, but collapse and zero range have been in the
> kernel for a decade now, do we really need to have ifdef tests for them?
> 

Probably not.. but why even bother worrying about individual flags? The
insert and unshare flags have been around for 9 and 8 years
respectively, none of these were fully ifdef'd from the beginning, and
I'm not aware of anyone that has actually complained.

I'm not convinced that this patch matters for anybody in practice. I
included it just because it was simple enough to include the minimum
mechanical fix and I was slightly curious if somebody could come up with
a more elegant solution. In the spirit of being practical, maybe the
better approach here is to just remove the (at least the falloc flag
related) ifdefs entirely? We can always add them back if somebody
complains...

Brian

> --D
> 
> > +
> > +#ifdef FALLOC_FL_INSERT_RANGE
> > +	if (insert_range_calls)
> > +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > +#else
> > +	insert_range_calls = 0;
> > +#endif
> > +}
> > +
> >  bool
> >  keep_running(void)
> >  {
> > @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
> >  		check_trunc_hack();
> >  	}
> >  
> > -	if (fallocate_calls)
> > -		fallocate_calls = test_fallocate(0);
> > -	if (keep_size_calls)
> > -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > -	if (unshare_range_calls)
> > -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > -	if (punch_hole_calls)
> > -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > -	if (zero_range_calls)
> > -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > -	if (collapse_range_calls)
> > -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > -	if (insert_range_calls)
> > -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > +	test_fallocate_calls();
> >  	if (clone_range_calls)
> >  		clone_range_calls = test_clone_range();
> >  	if (dedupe_range_calls)
> > -- 
> > 2.46.1
> > 
> > 
> 

