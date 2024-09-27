Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC61482E2
	for <fstests@vger.kernel.org>; Fri, 27 Sep 2024 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727415762; cv=none; b=clBg4/0sIOR0iwVoNKNEml8E1xZr0rE048JqCvrySpd61dHNRGpsN64xIFPQZJoX0N9BWrCRzlvSaHxNY9SeTpZ6KB05Mmu9gINhWdLvYxoFLrSrDHrBmbJsFggTQJED+8VUyl1jgXp/Mo0E7JCndDdbkJ1aIZj5Mlz9Nuopaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727415762; c=relaxed/simple;
	bh=V1cljLRqLm+0cy7KTR/ihxcd2CvbDDBpNE4ltzU+OKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFSLf7qB4IKFBAyPCKLJPBgmXy3334l+k59dXMVhYTYl3mD0xl6AHlEHD/DGqSoxZ5at6ObhKL+0x1MQsMIoSWYX5yGFkXb2FCx7NTQOVJnN/4xQn28Jdyi5lWiyfy8XTT3LeUdIf0aypsiu2RQMvs35EyBjQhiQ4GAmiThG6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9SKTunS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9SKTunS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727415759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR5z6uJIcKTJ1oQwbZqv/ryn5JzfbDPtxKdcMOPALf4=;
	b=F9SKTunSY2oTMcXRDp4O5QNjfOwUPAqmn2nvLcwhg9ca0B0bF/Lcj4Pu3oj+l2a1yON8ZO
	Mjrpl079DdmTg4TYH8D4jq/ixypNDAKcHap6ncs80E5PNch+16k1QfPhMsiqaolSyIYERW
	z1WecJppgEMjLS6xw38q4EazWh7ncFI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0EUxkVmFNiGJZaSC93W-9Q-1; Fri, 27 Sep 2024 01:42:37 -0400
X-MC-Unique: 0EUxkVmFNiGJZaSC93W-9Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-718dd4aa409so2132125b3a.1
        for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 22:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727415756; x=1728020556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR5z6uJIcKTJ1oQwbZqv/ryn5JzfbDPtxKdcMOPALf4=;
        b=vrbkdv6F7F8fc9YnRWFvH9NN4DRfdAtl9Y7TVHW4pq/DbS/h3XSYTdinoU71x70Hud
         fSCVm7s5ZMiLyfX7ZuSSaEY8Ox9m0CwmjIXl+NthlkBNvGLCuETpGptTUtmEZcxGjwgt
         fr8fMQOz0v/ZBsxhK+T0PdqNUw+f4Cx7ygUByYLSckVHgPegNfFrrSjKPcu5YPk0ffau
         Y9tBs4EXrcaO+LEISEPGc/QUwWfxRppuD2Q3z/t0drygzAGu8g2z8LK4cpey30FjmeOo
         +ZLXLx06WWQPlxXrLJqIi77/jlO8s9Mnc+qYv/0MvAkWMFYBUQwDonN7Ht77MBz5e7Sz
         LfxA==
X-Forwarded-Encrypted: i=1; AJvYcCUitQmWKk0AtOKgiDzGSseFAblkemTIZZcGNQ0/3VQnlzr9gBMC8KYUbO2m1kRskoqhVM5mi84g@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoYnW916oWe5Ce44H55hEVyTWX847PveaQcC/LIzEjbGJ7RER
	nf+C9osctl6+SP3+A9Gar7+uSqA/dkp0sy8Klj9TOrfvWArecNk6Bi/8IU0dOtrvNvAOddR4rdy
	CmxLdHPjwO5ksFV7b4T66+LlbTF8EP0Y1HdkoAnslm8+3nUkdfwRw0Ks=
X-Received: by 2002:a05:6a21:3489:b0:1cf:38cf:dfb6 with SMTP id adf61e73a8af0-1d4fa3cc8a6mr3431510637.20.1727415755840;
        Thu, 26 Sep 2024 22:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRL1YJvV7p4NM5gBOpIjRcWqUC7Zez19+0ChVTDoordU3C8l2Xj8oTB/z1XVKIY2hLJCJ71g==
X-Received: by 2002:a05:6a21:3489:b0:1cf:38cf:dfb6 with SMTP id adf61e73a8af0-1d4fa3cc8a6mr3431487637.20.1727415755488;
        Thu, 26 Sep 2024 22:42:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264d3c9esm825395b3a.96.2024.09.26.22.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 22:42:35 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:42:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <20240927054231.adwhqd2cyexfu3if@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
 <20240926145028.GC21840@frogsfrogsfrogs>
 <ZvWD6SsfGJDisYP9@bfoster>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvWD6SsfGJDisYP9@bfoster>

On Thu, Sep 26, 2024 at 11:55:21AM -0400, Brian Foster wrote:
> On Thu, Sep 26, 2024 at 07:50:28AM -0700, Darrick J. Wong wrote:
> > On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> > > The various fallocate flags are mostly ifdef'd for backward
> > > compatibility with the exception of the associated test_fallocate()
> > > calls to verify functionality at runtime. I suspect the reason for
> > > this was to avoid ifdef ugliness around having to clear the runtime
> > > flag for each operation, but unfortunately this defeats the purpose
> > > of the ifdef protection everywhere else.
> > > 
> > > Factor out the fallocate related test calls into a new helper and
> > > add the appropriate ifdefs.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 45 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 677f8c9f..417743c5 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
> > >  #endif
> > >  }
> > >  
> > > +void
> > > +test_fallocate_calls(void)
> > > +{
> > > +	if (fallocate_calls)
> > > +		fallocate_calls = test_fallocate(0);
> > > +	if (keep_size_calls)
> > > +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > +
> > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > +	if (unshare_range_calls)
> > > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > +#else
> > > +	unshare_range_calls = 0;
> > > +#endif
> > > +
> > > +#ifdef FALLOC_FL_PUNCH_HOLE
> > > +	if (punch_hole_calls)
> > > +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > +#else
> > > +	punch_hole_calls = 0;
> > > +#endif
> > > +
> > > +#ifdef FALLOC_FL_ZERO_RANGE
> > > +	if (zero_range_calls)
> > > +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > +#else
> > > +	zero_range_calls = 0;
> > > +#endif
> > > +
> > > +#ifdef FALLOC_FL_COLLAPSE_RANGE
> > > +	if (collapse_range_calls)
> > > +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > +#else
> > > +	collapse_range_calls = 0;
> > > +#endif
> > 
> > The concept looks fine, but collapse and zero range have been in the
> > kernel for a decade now, do we really need to have ifdef tests for them?
> > 
> 
> Probably not.. but why even bother worrying about individual flags? The
> insert and unshare flags have been around for 9 and 8 years
> respectively, none of these were fully ifdef'd from the beginning, and
> I'm not aware of anyone that has actually complained.
> 
> I'm not convinced that this patch matters for anybody in practice. I
> included it just because it was simple enough to include the minimum
> mechanical fix and I was slightly curious if somebody could come up with
> a more elegant solution. In the spirit of being practical, maybe the
> better approach here is to just remove the (at least the falloc flag
> related) ifdefs entirely? We can always add them back if somebody
> complains...

As this patch is still controversial, I'll merge the other one at first, to
catch up the release of this week. We can talk this one later, if you still
hope to have it :)

Thanks,
Zorro

> 
> Brian
> 
> > --D
> > 
> > > +
> > > +#ifdef FALLOC_FL_INSERT_RANGE
> > > +	if (insert_range_calls)
> > > +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > +#else
> > > +	insert_range_calls = 0;
> > > +#endif
> > > +}
> > > +
> > >  bool
> > >  keep_running(void)
> > >  {
> > > @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
> > >  		check_trunc_hack();
> > >  	}
> > >  
> > > -	if (fallocate_calls)
> > > -		fallocate_calls = test_fallocate(0);
> > > -	if (keep_size_calls)
> > > -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > -	if (unshare_range_calls)
> > > -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > -	if (punch_hole_calls)
> > > -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > -	if (zero_range_calls)
> > > -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > -	if (collapse_range_calls)
> > > -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > -	if (insert_range_calls)
> > > -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > +	test_fallocate_calls();
> > >  	if (clone_range_calls)
> > >  		clone_range_calls = test_clone_range();
> > >  	if (dedupe_range_calls)
> > > -- 
> > > 2.46.1
> > > 
> > > 
> > 
> 
> 

