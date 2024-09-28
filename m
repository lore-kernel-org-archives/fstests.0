Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACD12E75
	for <fstests@vger.kernel.org>; Sat, 28 Sep 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727510636; cv=none; b=mGo2sFESPlyxamBNrHIaph9jw3RNSHmO1vUB2dKw5bwBg+y2J9GZZ5fC44oGXGqbWGF/FuU80pFScK6tsXI/gReP4ar79fughykhDT72+u35heE87lsXVHOVGAW+uWyXTbJh+meTc9vGMo78ViFq9VTMHF+2ChTTzhjnaYznf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727510636; c=relaxed/simple;
	bh=CupZtwUzHzxf5ze+AqD2d1rvyLBHAhM/0UYSLMD07t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcNWMOBD4wBC0l6mzrIs0KNtREl9L8juIzDk/Ah3inc2cQBj8yDMtEfNbjhlDQrb7NSaqnnJS4Ie6XznQstqLZHcBRkeOH/9YUr7hVLrSB24tOiWjUa4VYBe2coToAqA/Kv+PpcdOIgjIziRQGntwuk5TCpXq5lj3Tv1UVRW/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlYRhZ3Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlYRhZ3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727510632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sgNH/HNBhs3F3moJpFJkvHyCgp764xzjFJrV6/0l1kU=;
	b=WlYRhZ3Z04iWpk1fgL8W3HZRJ8WP4G9eRKMJbGOY6gK4V9uzZDG09p82dWt3WhnqQx0I0F
	nsROwgIR/06g6cN9wxhhwqlDpmYU44iMp+1GDXbu7cc10mbHbluDS8naRUfDYaJ0ivwtSn
	S2lGuTedoaeYJOf+sJvWXdC8Um3+OfE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ZWjiS-htOJ-QRvwTPXGg5w-1; Sat, 28 Sep 2024 04:03:51 -0400
X-MC-Unique: ZWjiS-htOJ-QRvwTPXGg5w-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2070e327014so24276455ad.1
        for <fstests@vger.kernel.org>; Sat, 28 Sep 2024 01:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727510630; x=1728115430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgNH/HNBhs3F3moJpFJkvHyCgp764xzjFJrV6/0l1kU=;
        b=o71p8KIX+rrLe8lH2/KllyUCz7uSy2P4LsoCUNdqI/P7zVnmnMwNB/Gfpx2OvaHjTE
         atEG/8BrB8ceLoh9Bb6MXevWCnpHNfM2B0gvtvmx/QjMfyIbXjZqeXxTZL5wRVSNkjQt
         PSNX7fxRo643CFe4dWve8gV1BR3wPu0GAeUzQsmONCTuMCt7CjGQaspmD3YM+908ZPFK
         +E7JAursByAP1+ZPCttHjA6C93+pUqFf8s8uEvzVgmlqSfjJTK320ZNgea4Pe7kPMOOd
         pTe9IDtv0CAD4oW8qyz/p0EOmLDdwWt13BLn5wDxu8qg5ULJS0+PTV8rzfbL3Usdx2Ba
         iOqw==
X-Forwarded-Encrypted: i=1; AJvYcCWDS7lOXKPVydWSxEcrx4inmI7rk0wmWaeHAK7NneSJ8Jg1PtH+zFM8PCAoxhbwsElPe6Os762s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61NdVCZE7zf8osoKqFD8T6IgiuOrSQjEicEA/j3ulMPbcALDx
	GxsdSOGVS8m8EVofXN9ls+2WTBtlA3oFkP/yi1eRNPtWGbnAKMiSccDm6PDGiJEBlFHD9c5SfiO
	eXP0RQO/kIXczfDkTO8MR2pU7F3ZR/6kZT/UqQhtMnnaaEVZAfmizAY4=
X-Received: by 2002:a17:902:d2d0:b0:20b:433c:5833 with SMTP id d9443c01a7336-20b433c5de7mr71567215ad.26.1727510630367;
        Sat, 28 Sep 2024 01:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+giI1SCEbBbFEgbr/w6CYN1rJUu6JfZP/RluPjMZeqwAinSGC+TG71RwnGAoNH2lzYFOCpA==
X-Received: by 2002:a17:902:d2d0:b0:20b:433c:5833 with SMTP id d9443c01a7336-20b433c5de7mr71566905ad.26.1727510629860;
        Sat, 28 Sep 2024 01:03:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5ef69sm23062865ad.6.2024.09.28.01.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 01:03:49 -0700 (PDT)
Date: Sat, 28 Sep 2024 16:03:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <20240928080346.zwlds6k2p5qiru6a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
 <20240926145028.GC21840@frogsfrogsfrogs>
 <ZvWD6SsfGJDisYP9@bfoster>
 <20240927054231.adwhqd2cyexfu3if@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZvagFdWEcffZs06i@bfoster>
 <20240927152537.GQ21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927152537.GQ21877@frogsfrogsfrogs>

On Fri, Sep 27, 2024 at 08:25:37AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 27, 2024 at 08:07:49AM -0400, Brian Foster wrote:
> > On Fri, Sep 27, 2024 at 01:42:31PM +0800, Zorro Lang wrote:
> > > On Thu, Sep 26, 2024 at 11:55:21AM -0400, Brian Foster wrote:
> > > > On Thu, Sep 26, 2024 at 07:50:28AM -0700, Darrick J. Wong wrote:
> > > > > On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> > > > > > The various fallocate flags are mostly ifdef'd for backward
> > > > > > compatibility with the exception of the associated test_fallocate()
> > > > > > calls to verify functionality at runtime. I suspect the reason for
> > > > > > this was to avoid ifdef ugliness around having to clear the runtime
> > > > > > flag for each operation, but unfortunately this defeats the purpose
> > > > > > of the ifdef protection everywhere else.
> > > > > > 
> > > > > > Factor out the fallocate related test calls into a new helper and
> > > > > > add the appropriate ifdefs.
> > > > > > 
> > > > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > > > ---
> > > > > >  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
> > > > > >  1 file changed, 45 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > index 677f8c9f..417743c5 100644
> > > > > > --- a/ltp/fsx.c
> > > > > > +++ b/ltp/fsx.c
> > > > > > @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
> > > > > >  #endif
> > > > > >  }
> > > > > >  
> > > > > > +void
> > > > > > +test_fallocate_calls(void)
> > > > > > +{
> > > > > > +	if (fallocate_calls)
> > > > > > +		fallocate_calls = test_fallocate(0);
> > > > > > +	if (keep_size_calls)
> > > > > > +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > > > > +	if (unshare_range_calls)
> > > > > > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > > > +#else
> > > > > > +	unshare_range_calls = 0;
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_PUNCH_HOLE
> > > > > > +	if (punch_hole_calls)
> > > > > > +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > > > +#else
> > > > > > +	punch_hole_calls = 0;
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_ZERO_RANGE
> > > > > > +	if (zero_range_calls)
> > > > > > +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > > > +#else
> > > > > > +	zero_range_calls = 0;
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_COLLAPSE_RANGE
> > > > > > +	if (collapse_range_calls)
> > > > > > +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > > > +#else
> > > > > > +	collapse_range_calls = 0;
> > > > > > +#endif
> > > > > 
> > > > > The concept looks fine, but collapse and zero range have been in the
> > > > > kernel for a decade now, do we really need to have ifdef tests for them?
> > > > > 
> > > > 
> > > > Probably not.. but why even bother worrying about individual flags? The
> > > > insert and unshare flags have been around for 9 and 8 years
> > > > respectively, none of these were fully ifdef'd from the beginning, and
> > > > I'm not aware of anyone that has actually complained.
> > > > 
> > > > I'm not convinced that this patch matters for anybody in practice. I
> > > > included it just because it was simple enough to include the minimum
> > > > mechanical fix and I was slightly curious if somebody could come up with
> > > > a more elegant solution. In the spirit of being practical, maybe the
> > > > better approach here is to just remove the (at least the falloc flag
> > > > related) ifdefs entirely? We can always add them back if somebody
> > > > complains...
> > > 
> > > As this patch is still controversial, I'll merge the other one at first, to
> > > catch up the release of this week. We can talk this one later, if you still
> > > hope to have it :)
> > > 
> > 
> > Thanks. In thinking more about it.. my reasoning above was that it seems
> > like the value of these ifdefs is to avoid disruption when new
> > functionality is introduced, but at the same time the fstests user base
> > may not be necessarily all that interested in eternal backwards
> > compatibility for ancient runtimes, etc. Therefore, I wonder if it's
> > reasonable to have an (informal) expiration date for when we can clear
> > out some of this cruft to keep the code cleaner and more maintainable
> > going forward.
> > 
> > So I largely agree with Darrick's point, it's just that personally I'm
> > less interested in discussion over which fallocate flags to include or
> > not because to my mind that suggests we might as well just drop the
> > ifdefs entirely. That said, I'm not all that invested beyond just trying
> > to be proactive since I happened to be hacking in this area, so if you
> > guys want to leave things as is, or agree on a subset of flags to ifdef,
> > just let me know and I'll drop it or send a v2.
> 
> Usually I just let Christoph complain and remove the ifdefs, but if I
> have to use my own rule, it would be that ifdefs and ./configure
> trickery isn't necessary for any symbol that is at least 5 years old.
> 
> Recent complaints on the mailing list have caused me to revise that to
> 10 years old though (see recent memfd_create fixes). :)

I prefer "10 years", due to most of RHELs support 10 years (or a bit longer:)
I think some other Enterprice systems are similar.

Thanks,
Zorro

> 
> I also remember that a lot of the old crufty ifdef stuff (iirc) was kept
> around so that fstests would continue to run on old RHELs.  Once in a
> while our QA folks rebase fstests to latest, but they also tend to patch
> back in whatever ./configure magic they need for 2.6 era kernels.
> 
> --D
> 
> > Brian
> > 
> > 
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > Brian
> > > > 
> > > > > --D
> > > > > 
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_INSERT_RANGE
> > > > > > +	if (insert_range_calls)
> > > > > > +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > > > +#else
> > > > > > +	insert_range_calls = 0;
> > > > > > +#endif
> > > > > > +}
> > > > > > +
> > > > > >  bool
> > > > > >  keep_running(void)
> > > > > >  {
> > > > > > @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
> > > > > >  		check_trunc_hack();
> > > > > >  	}
> > > > > >  
> > > > > > -	if (fallocate_calls)
> > > > > > -		fallocate_calls = test_fallocate(0);
> > > > > > -	if (keep_size_calls)
> > > > > > -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > > > -	if (unshare_range_calls)
> > > > > > -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > > > -	if (punch_hole_calls)
> > > > > > -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > > > -	if (zero_range_calls)
> > > > > > -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > > > -	if (collapse_range_calls)
> > > > > > -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > > > -	if (insert_range_calls)
> > > > > > -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > > > +	test_fallocate_calls();
> > > > > >  	if (clone_range_calls)
> > > > > >  		clone_range_calls = test_clone_range();
> > > > > >  	if (dedupe_range_calls)
> > > > > > -- 
> > > > > > 2.46.1
> > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> 

