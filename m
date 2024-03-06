Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DC1420BB
	for <fstests@vger.kernel.org>; Wed,  6 Mar 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754686; cv=none; b=OV6dDBDKCYJ3qAldj1rNrjttw/m6HGk51I1FrmA2zX/llkEm7kWaa5IHcCeG+L5zEMNtZ1SxqF5d5r7boae08fCdtv1N6v5icHzcuE9cIsrxcYqHLVwTwjo3htDJbo0d+V79tyUaICUfWCJzVo9qmz/bqp24dNjteHJUZPjcOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754686; c=relaxed/simple;
	bh=CMb8pibMz4WgMwM2ztZiQSNz3Q3pYgajWZ3VtHGYqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwpTY6xpvGvG80WqtFlve8mPbubHli/CNNnYipNGUoAsWMt31cMnA0JiKHqSOpGrRX4efo1UlOsqTcmA0tGzvA3bP7YwuP78xqxbcw1z0Odnh/H5/muSd2dHA+NfXV5rz6rO7LyDVnRH7S8rVzIxtZO0IeC0UG3mq5bwMtouhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGhVHWZ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGhVHWZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709754683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cekf8mGcnJHeSFwkCfUPviVisxyaY7cCM5d4VnlIz1c=;
	b=HGhVHWZ3rw0obbwpqCWeHRsyW1yKVWYoa5gDe9zR/3YoVJj0ZbQbD7E0PSxjenDo4RQ8jq
	XeA+OZywGP5xuBb0rEz0NDogz8G9Nbcm4evmVkAai/XdsnOIcPDn3flW60WI7fKO8yyIgA
	aGmUx7RfTMAPVTIfBGFL8LpXLwCla6k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-q81NN1_ENAecFcPfdh7WRQ-1; Wed, 06 Mar 2024 14:51:22 -0500
X-MC-Unique: q81NN1_ENAecFcPfdh7WRQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29976f92420so133721a91.0
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2024 11:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754681; x=1710359481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cekf8mGcnJHeSFwkCfUPviVisxyaY7cCM5d4VnlIz1c=;
        b=sUyhdSlbqh8XxRnJnoJWFREUS5ZpH6Ajy9W7qvXlk4u65h2J8Lu+nl6Ok3vsOCS25T
         UWiI8Ir1zBUuQ9ipoQArdrL1Ip5ZT9izWFuZvmQMSpJUafd1hZPt7jqWsnYeHsoXX6MX
         Oj46zmZ5POpNOw5L+dE4WfpDyxbvtDxzLzudeFSrs9aZB8sCqzVsR+lLQdNgMF1bdauj
         V1WEB+Y0w1cfackJyyITYrUobCZBP9X9hpgd67Q2fTMOTKmoVWR6X+id7B1WIk+3bliA
         WBXw07T3UNOnNDfycFhBkdUlSyPAriIUfh6a5yLnwBBnKInUS/6Iw5zGSYbYksebOvXm
         GC9w==
X-Gm-Message-State: AOJu0Yz7zFa1xP568s536oijXTGsN8eZF5UsBwuvfxH5sSon28Z6w+wr
	Bbwh//zNKoVnVsDOf8NGHSfdj3Qcjbxn7FKWYpcaoZ2FTBaq3pamk40MDhQ3k4vcwH9xvm3D/sj
	OVP0msT6ycdYLmu4Mkns2lxcshrRzlgg/5XPtIT3PyJDlVTmnYwZ9ItA=
X-Received: by 2002:a17:90a:17a4:b0:29b:9e1:2fb0 with SMTP id q33-20020a17090a17a400b0029b09e12fb0mr1499076pja.0.1709754676187;
        Wed, 06 Mar 2024 11:51:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPzxPG8iJdGpBY8ws0lzaPSpJy2MSBFhZJCZv4sxH3m+tn1s1ADtCP5Cv0G8mHpjF6SgpzbQ==
X-Received: by 2002:a17:90a:17a4:b0:29b:9e1:2fb0 with SMTP id q33-20020a17090a17a400b0029b09e12fb0mr1499048pja.0.1709754675596;
        Wed, 06 Mar 2024 11:51:15 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a348900b0029658c7bd53sm127365pjb.5.2024.03.06.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:51:15 -0800 (PST)
Date: Thu, 7 Mar 2024 03:51:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 3/3] common/rc: force enable io_uring in _require_io_uring
Message-ID: <20240306195111.irajj7gojh5auahk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240306091935.4090399-1-zlang@kernel.org>
 <20240306091935.4090399-4-zlang@kernel.org>
 <20240306154324.GZ6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306154324.GZ6188@frogsfrogsfrogs>

On Wed, Mar 06, 2024 at 07:43:24AM -0800, Darrick J. Wong wrote:
> On Wed, Mar 06, 2024 at 05:19:35PM +0800, Zorro Lang wrote:
> > If kernel supports io_uring, userspace still can/might disable that
> > supporting by set /proc/sys/kernel/io_uring_disabled=2. Let's set
> > it to 0, to always enable io_uring (ignore error if there's not
> > that file).
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  common/rc | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 50dde313..966c92e3 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2317,6 +2317,9 @@ _require_aiodio()
> >  # this test requires that the kernel supports IO_URING
> >  _require_io_uring()
> >  {
> > +	# Force enable io_uring if kernel supports it
> > +	sysctl -w kernel.io_uring_disabled=0 &> /dev/null
> 
> _require_XXX functions are supposed to be predicates that _notrun the
> test if XXX isn't configured or available.  Shouldn't this be:

Yeah, that makes sense, I tried to find a place to force enable io_uring,
forgot it's not proper for _require_XXX function.

> 
> 	local io_uring_knob="$(sysctl --values kernel.io_uring_disabled)"
> 	test "$io_uring_knob" -ne 0 && _notrun "io_uring disabled by admin"

And I think I need to change the src/feature.c:check_uring_support() too,
check -EPERM as I did in fsstress.c.

> 
> Alternately -- if it _is_ ok to turn this knob, then there should be a
> cleanup method to put it back after the test.

Yeah, I'm still wondering if we should let fstests touch/set the io_uring_disabled
sysctl. Or we leave this job to the fstests user/wrapper script, fstests just
_notrun if io_uring is off.

Thanks,
Zorro

> 
> --D
> 
> > +
> >  	$here/src/feature -R
> >  	case $? in
> >  	0)
> > -- 
> > 2.43.0
> > 
> > 
> 

