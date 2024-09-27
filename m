Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEAE1C0DFA
	for <fstests@vger.kernel.org>; Fri, 27 Sep 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450738; cv=none; b=lcvueEd0Na+iKUaYtHXen3ISYMsvT8YufjbHfMYjyqKnO8Z8zZHym1B0Se/yM1izPyUI95uutQEWIrqawZeEoG1mFhkrxfYs9cFVHYISXJ22frkup+CoQ5MWXSj/VsadVUWnpBCIFU+Qmi0Onjd2LdJwAUxKOcI5E7M3R0CdIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450738; c=relaxed/simple;
	bh=f7bGe1XnDPAesKZRPAYufX9U8pcGPBgKLDt8rHID6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueBZlj20CWx/0oFsvf7oP1rLX5gKyIUV/AD5CVBFwS3YMWnCDGZ9KdsUxHAhrk1FJQNhnA2VVyB0qaJYPcCT4ec0Z3J9Iy8Y5QXCSrK9cUPBBwvFXSKIy5uDUvDq7aiXLmYSkcPMVthDkNEQx5gQj8/s6ojzn76RrfgpT7Gzd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX0jPtCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX0jPtCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A6C4CEC4;
	Fri, 27 Sep 2024 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727450738;
	bh=f7bGe1XnDPAesKZRPAYufX9U8pcGPBgKLDt8rHID6VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hX0jPtCqbApOWLpVlWfMWuijbe/VKgeRylwH71TyGwEHxJR0lkLTRVPzcE+1zHyxg
	 TcoBIufZZsQZMKr3RCMi5elk1AJdvvgzF0lhLW3LPzlKLBb47XR+Bk6ccnjCEbXFxa
	 72ohuWh6ApF4+gx/m/0CcA9FxUwVj9TdPweuaUPCJiDIboZYbdizMiCyxDBROqD6XF
	 9Zb34sYI+EX4bm7mNA2QEYepwga3lfls8KfJOKoMVM5PdmvdO9/8MkldrWowZ/1bq5
	 xY4YxlyPBTZGDvDB05PJQgNsS3zwkPV/vTS8FxtVATePvlVJuXaKpgFn5e+UWq+05k
	 oVlkypl+3dGmA==
Date: Fri, 27 Sep 2024 08:25:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <20240927152537.GQ21877@frogsfrogsfrogs>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
 <20240926145028.GC21840@frogsfrogsfrogs>
 <ZvWD6SsfGJDisYP9@bfoster>
 <20240927054231.adwhqd2cyexfu3if@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZvagFdWEcffZs06i@bfoster>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvagFdWEcffZs06i@bfoster>

On Fri, Sep 27, 2024 at 08:07:49AM -0400, Brian Foster wrote:
> On Fri, Sep 27, 2024 at 01:42:31PM +0800, Zorro Lang wrote:
> > On Thu, Sep 26, 2024 at 11:55:21AM -0400, Brian Foster wrote:
> > > On Thu, Sep 26, 2024 at 07:50:28AM -0700, Darrick J. Wong wrote:
> > > > On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> > > > > The various fallocate flags are mostly ifdef'd for backward
> > > > > compatibility with the exception of the associated test_fallocate()
> > > > > calls to verify functionality at runtime. I suspect the reason for
> > > > > this was to avoid ifdef ugliness around having to clear the runtime
> > > > > flag for each operation, but unfortunately this defeats the purpose
> > > > > of the ifdef protection everywhere else.
> > > > > 
> > > > > Factor out the fallocate related test calls into a new helper and
> > > > > add the appropriate ifdefs.
> > > > > 
> > > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > > ---
> > > > >  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
> > > > >  1 file changed, 45 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > index 677f8c9f..417743c5 100644
> > > > > --- a/ltp/fsx.c
> > > > > +++ b/ltp/fsx.c
> > > > > @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
> > > > >  #endif
> > > > >  }
> > > > >  
> > > > > +void
> > > > > +test_fallocate_calls(void)
> > > > > +{
> > > > > +	if (fallocate_calls)
> > > > > +		fallocate_calls = test_fallocate(0);
> > > > > +	if (keep_size_calls)
> > > > > +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > > +
> > > > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > > > +	if (unshare_range_calls)
> > > > > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > > +#else
> > > > > +	unshare_range_calls = 0;
> > > > > +#endif
> > > > > +
> > > > > +#ifdef FALLOC_FL_PUNCH_HOLE
> > > > > +	if (punch_hole_calls)
> > > > > +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > > +#else
> > > > > +	punch_hole_calls = 0;
> > > > > +#endif
> > > > > +
> > > > > +#ifdef FALLOC_FL_ZERO_RANGE
> > > > > +	if (zero_range_calls)
> > > > > +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > > +#else
> > > > > +	zero_range_calls = 0;
> > > > > +#endif
> > > > > +
> > > > > +#ifdef FALLOC_FL_COLLAPSE_RANGE
> > > > > +	if (collapse_range_calls)
> > > > > +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > > +#else
> > > > > +	collapse_range_calls = 0;
> > > > > +#endif
> > > > 
> > > > The concept looks fine, but collapse and zero range have been in the
> > > > kernel for a decade now, do we really need to have ifdef tests for them?
> > > > 
> > > 
> > > Probably not.. but why even bother worrying about individual flags? The
> > > insert and unshare flags have been around for 9 and 8 years
> > > respectively, none of these were fully ifdef'd from the beginning, and
> > > I'm not aware of anyone that has actually complained.
> > > 
> > > I'm not convinced that this patch matters for anybody in practice. I
> > > included it just because it was simple enough to include the minimum
> > > mechanical fix and I was slightly curious if somebody could come up with
> > > a more elegant solution. In the spirit of being practical, maybe the
> > > better approach here is to just remove the (at least the falloc flag
> > > related) ifdefs entirely? We can always add them back if somebody
> > > complains...
> > 
> > As this patch is still controversial, I'll merge the other one at first, to
> > catch up the release of this week. We can talk this one later, if you still
> > hope to have it :)
> > 
> 
> Thanks. In thinking more about it.. my reasoning above was that it seems
> like the value of these ifdefs is to avoid disruption when new
> functionality is introduced, but at the same time the fstests user base
> may not be necessarily all that interested in eternal backwards
> compatibility for ancient runtimes, etc. Therefore, I wonder if it's
> reasonable to have an (informal) expiration date for when we can clear
> out some of this cruft to keep the code cleaner and more maintainable
> going forward.
> 
> So I largely agree with Darrick's point, it's just that personally I'm
> less interested in discussion over which fallocate flags to include or
> not because to my mind that suggests we might as well just drop the
> ifdefs entirely. That said, I'm not all that invested beyond just trying
> to be proactive since I happened to be hacking in this area, so if you
> guys want to leave things as is, or agree on a subset of flags to ifdef,
> just let me know and I'll drop it or send a v2.

Usually I just let Christoph complain and remove the ifdefs, but if I
have to use my own rule, it would be that ifdefs and ./configure
trickery isn't necessary for any symbol that is at least 5 years old.

Recent complaints on the mailing list have caused me to revise that to
10 years old though (see recent memfd_create fixes). :)

I also remember that a lot of the old crufty ifdef stuff (iirc) was kept
around so that fstests would continue to run on old RHELs.  Once in a
while our QA folks rebase fstests to latest, but they also tend to patch
back in whatever ./configure magic they need for 2.6 era kernels.

--D

> Brian
> 
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Brian
> > > 
> > > > --D
> > > > 
> > > > > +
> > > > > +#ifdef FALLOC_FL_INSERT_RANGE
> > > > > +	if (insert_range_calls)
> > > > > +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > > +#else
> > > > > +	insert_range_calls = 0;
> > > > > +#endif
> > > > > +}
> > > > > +
> > > > >  bool
> > > > >  keep_running(void)
> > > > >  {
> > > > > @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
> > > > >  		check_trunc_hack();
> > > > >  	}
> > > > >  
> > > > > -	if (fallocate_calls)
> > > > > -		fallocate_calls = test_fallocate(0);
> > > > > -	if (keep_size_calls)
> > > > > -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > > -	if (unshare_range_calls)
> > > > > -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > > -	if (punch_hole_calls)
> > > > > -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > > -	if (zero_range_calls)
> > > > > -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > > -	if (collapse_range_calls)
> > > > > -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > > -	if (insert_range_calls)
> > > > > -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > > +	test_fallocate_calls();
> > > > >  	if (clone_range_calls)
> > > > >  		clone_range_calls = test_clone_range();
> > > > >  	if (dedupe_range_calls)
> > > > > -- 
> > > > > 2.46.1
> > > > > 
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 
