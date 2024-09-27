Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441AC189537
	for <fstests@vger.kernel.org>; Fri, 27 Sep 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438833; cv=none; b=rBZG5o+B328C5etYZu3Y2qFD4kMEIoysnunjgp1I9pinjRZp13UsGDXozPBhTP9ea4kpr5Uov1QJ4qXrgJcQg494EWXMHqOCbkVnICyltkdWmByT2SmJV84n9HbGTDWT6QqvjPQnaOEtIHaBrYo2J/H/2I60Dk8MhudezroZeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438833; c=relaxed/simple;
	bh=ZrQTFN8/ZrALqH9agpn1U0H+2Ua4dLCMyz4nSBTEP/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih6we2rbNYVGVoZKY+m2engiju6qDjPBvA634cCepxLOP7cpRVy4uxV5Sp6Lw40nkO9dMWlYLDwr9kco718LU53K9ACJQ6TkI2hGZSdF80QJSNCnImnlhq+MeU0EbH2RUDii/jKw6UIi5SnhyNcuuMpVkxR9A8qF+XuBTJ9ZcQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcS2jiSI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcS2jiSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727438831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KerRZUxGCvbyq5X2bQ8yvg5z5Vl6nreeyhAX7Ttjqs=;
	b=QcS2jiSIPEFpzXiGUzlLSR7EFqanpldDuCgk3/sr4qwHFsEqwyB9BLMRdbb7v5mKLCbJLl
	+Gy5Fh6ZJcaGIlH7KoV7odQw0Nfo9UPoxu1FZufHAOjMkLAwA6RiWGqrxfGdF4az4T9zdJ
	8469ssGEdPqv1o53kV7udVApiTquh3s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-U9TWnCNgPsWo8o8lFcE76w-1; Fri,
 27 Sep 2024 08:07:07 -0400
X-MC-Unique: U9TWnCNgPsWo8o8lFcE76w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26FE419780E9;
	Fri, 27 Sep 2024 12:07:06 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449CC300F99E;
	Fri, 27 Sep 2024 12:06:40 +0000 (UTC)
Date: Fri, 27 Sep 2024 08:07:49 -0400
From: Brian Foster <bfoster@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <ZvagFdWEcffZs06i@bfoster>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
 <20240926145028.GC21840@frogsfrogsfrogs>
 <ZvWD6SsfGJDisYP9@bfoster>
 <20240927054231.adwhqd2cyexfu3if@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927054231.adwhqd2cyexfu3if@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Sep 27, 2024 at 01:42:31PM +0800, Zorro Lang wrote:
> On Thu, Sep 26, 2024 at 11:55:21AM -0400, Brian Foster wrote:
> > On Thu, Sep 26, 2024 at 07:50:28AM -0700, Darrick J. Wong wrote:
> > > On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> > > > The various fallocate flags are mostly ifdef'd for backward
> > > > compatibility with the exception of the associated test_fallocate()
> > > > calls to verify functionality at runtime. I suspect the reason for
> > > > this was to avoid ifdef ugliness around having to clear the runtime
> > > > flag for each operation, but unfortunately this defeats the purpose
> > > > of the ifdef protection everywhere else.
> > > > 
> > > > Factor out the fallocate related test calls into a new helper and
> > > > add the appropriate ifdefs.
> > > > 
> > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > ---
> > > >  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
> > > >  1 file changed, 45 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index 677f8c9f..417743c5 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > > @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
> > > >  #endif
> > > >  }
> > > >  
> > > > +void
> > > > +test_fallocate_calls(void)
> > > > +{
> > > > +	if (fallocate_calls)
> > > > +		fallocate_calls = test_fallocate(0);
> > > > +	if (keep_size_calls)
> > > > +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > +
> > > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > > +	if (unshare_range_calls)
> > > > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > +#else
> > > > +	unshare_range_calls = 0;
> > > > +#endif
> > > > +
> > > > +#ifdef FALLOC_FL_PUNCH_HOLE
> > > > +	if (punch_hole_calls)
> > > > +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > +#else
> > > > +	punch_hole_calls = 0;
> > > > +#endif
> > > > +
> > > > +#ifdef FALLOC_FL_ZERO_RANGE
> > > > +	if (zero_range_calls)
> > > > +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > +#else
> > > > +	zero_range_calls = 0;
> > > > +#endif
> > > > +
> > > > +#ifdef FALLOC_FL_COLLAPSE_RANGE
> > > > +	if (collapse_range_calls)
> > > > +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > +#else
> > > > +	collapse_range_calls = 0;
> > > > +#endif
> > > 
> > > The concept looks fine, but collapse and zero range have been in the
> > > kernel for a decade now, do we really need to have ifdef tests for them?
> > > 
> > 
> > Probably not.. but why even bother worrying about individual flags? The
> > insert and unshare flags have been around for 9 and 8 years
> > respectively, none of these were fully ifdef'd from the beginning, and
> > I'm not aware of anyone that has actually complained.
> > 
> > I'm not convinced that this patch matters for anybody in practice. I
> > included it just because it was simple enough to include the minimum
> > mechanical fix and I was slightly curious if somebody could come up with
> > a more elegant solution. In the spirit of being practical, maybe the
> > better approach here is to just remove the (at least the falloc flag
> > related) ifdefs entirely? We can always add them back if somebody
> > complains...
> 
> As this patch is still controversial, I'll merge the other one at first, to
> catch up the release of this week. We can talk this one later, if you still
> hope to have it :)
> 

Thanks. In thinking more about it.. my reasoning above was that it seems
like the value of these ifdefs is to avoid disruption when new
functionality is introduced, but at the same time the fstests user base
may not be necessarily all that interested in eternal backwards
compatibility for ancient runtimes, etc. Therefore, I wonder if it's
reasonable to have an (informal) expiration date for when we can clear
out some of this cruft to keep the code cleaner and more maintainable
going forward.

So I largely agree with Darrick's point, it's just that personally I'm
less interested in discussion over which fallocate flags to include or
not because to my mind that suggests we might as well just drop the
ifdefs entirely. That said, I'm not all that invested beyond just trying
to be proactive since I happened to be hacking in this area, so if you
guys want to leave things as is, or agree on a subset of flags to ifdef,
just let me know and I'll drop it or send a v2.

Brian


> Thanks,
> Zorro
> 
> > 
> > Brian
> > 
> > > --D
> > > 
> > > > +
> > > > +#ifdef FALLOC_FL_INSERT_RANGE
> > > > +	if (insert_range_calls)
> > > > +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > +#else
> > > > +	insert_range_calls = 0;
> > > > +#endif
> > > > +}
> > > > +
> > > >  bool
> > > >  keep_running(void)
> > > >  {
> > > > @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
> > > >  		check_trunc_hack();
> > > >  	}
> > > >  
> > > > -	if (fallocate_calls)
> > > > -		fallocate_calls = test_fallocate(0);
> > > > -	if (keep_size_calls)
> > > > -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > -	if (unshare_range_calls)
> > > > -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > -	if (punch_hole_calls)
> > > > -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > -	if (zero_range_calls)
> > > > -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > -	if (collapse_range_calls)
> > > > -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > -	if (insert_range_calls)
> > > > -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > +	test_fallocate_calls();
> > > >  	if (clone_range_calls)
> > > >  		clone_range_calls = test_clone_range();
> > > >  	if (dedupe_range_calls)
> > > > -- 
> > > > 2.46.1
> > > > 
> > > > 
> > > 
> > 
> > 
> 

