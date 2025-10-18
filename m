Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A823C17
	for <fstests@vger.kernel.org>; Sat, 18 Oct 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760798611; cv=none; b=ZL3UzKB9SvMzZzanX4Ii6lnOUwGkqCjuWy9mWsRohTz84qa2Fo0Wf07C2I91k+Qk81QnizA+N7GaH2BSnIkGyhQcDg1uPSvNXpovX49xo3bVGabUfNili+aTcFSAMKbP+3UeLTrL5tMIkNQV25fYpkNfSgvxmvJhaGVRsEz9hsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760798611; c=relaxed/simple;
	bh=opfjU0v2OxIyWEP92tg2xgp3LRAE5uu/vhAdTNpajdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBBLGIR7hgHbbjzCGDDfc3ImG3DkEvoOeyufcI+wJl65VcRclnryDAhyr/M9ZjGKHFxJHWmeFEiqYwbqvyudxtYbvPyCqIhP9gnGS9itZpSzQ8sxgdLXpGuu1Ar+zWRUZE2DHGfHXB7dSyMaeip+DFq+so4cpLlQq8m2p9slKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plk2NRyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plk2NRyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760798608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYYjMReaIBtU1+uzq457Di32+sHdvL71gJGa9DZ+Tyk=;
	b=Plk2NRyilN8XuDRsQ4J+egAPMFMEuD+ALb8163Oo8VWYbj7bD4KpoSITN9sWB9ZR/aRqGu
	QMdI+G3IGxkSg2rYqxA7GfreBwYQpEyg7tdlBOV6foqHBzQ4VEB7IeRD96skcVoLfo3tSa
	00ZI83kicRytP1o/ni5wA1ty/NUFZac=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-eQP6KuHONSuBFCdzYqMxfw-1; Sat, 18 Oct 2025 10:43:26 -0400
X-MC-Unique: eQP6KuHONSuBFCdzYqMxfw-1
X-Mimecast-MFC-AGG-ID: eQP6KuHONSuBFCdzYqMxfw_1760798605
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290d860acbcso38261545ad.1
        for <fstests@vger.kernel.org>; Sat, 18 Oct 2025 07:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760798605; x=1761403405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYYjMReaIBtU1+uzq457Di32+sHdvL71gJGa9DZ+Tyk=;
        b=IYZDblLqfEJqANTuUMYPUhKenakWti45HziHOqjzi9osyP2D1dKgyveI40F2LTWAkG
         A+jCGSNHA4t3JmnJC//nTqRdTFVr2CgPIEGXr5rYdEzYvL2A6P7mhnTNpMILCW6++J/W
         KSPakjkzFq0LIuQyMYAqhfWOftplDLm1tU/niGLl+x9ctAMIepVI4G+wzVx+rsjt9w56
         j6sIcqjYfCEaG7kGfdDKZXx+Dqjg/3UQN+0p6pzztYADXAlJ7XIIa80/Iwn8K6A17TgN
         YxsHgTtZII9ksUMBpKicDF+wwSoMOvhRq9lFSkfCpPISzhewW3BZvSkqeKnUKM4drVWj
         I+Dw==
X-Gm-Message-State: AOJu0Yx2HVVmzv1B5e5pkwQptEDQtD+/eAoYHiRZGcvaDrIzXqlelEzq
	TT5ok6Fj4L7tZwCjFsTGak/o9T64MOzo0B8n3NYVmGUJefbCrkUBHcEpO/0OplFqu49y40SDDd1
	6ydLAAMyKAOQUni5U61DulWqecad73dzeuL2EOs1BftlH7XOQlWsy8UJSvbSM1JBK7PA=
X-Gm-Gg: ASbGncuh8DfEdz/5iFWy1HP3/ojfPgixCxLruaGzeX5MNc9ZiJSjhPGFMO1IeNGo4RA
	UzUh8blRJTR2Bj2IwZlLimrdFU9/MGAeoQ/aUo0DzflCG9WvLTtSR9IFdHstDXv1UhBKLQiAebU
	h83eL0XAEKyqITPn7yiUJoguBPY1xb6rkt2b2Nz73rBaaZSzC3CGJXcVxv3s8zlx9V7zkJWECbr
	ym760jF79yU37xu/qKi9LR1kdPJxq1Cl3Own+RDKMqbwe/cmHi4fLpC//zNscBzT2oCnx6DBYyB
	PFjQ5r7Pk9bdviRIS3n1F6HFjhXZNKpZGr8eVR9DZaFQcjOIa39suZjP1E+3ZbmEqvXngPLMYRZ
	ioyMbzbO6BiXswcbpzjNdBKIv5fcnJH+R+OTi4zo=
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id d9443c01a7336-290c99a9669mr86544175ad.0.1760798604894;
        Sat, 18 Oct 2025 07:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7oWUaquXvDx/1kREYhuLrs9SDFE8IKYZeEcMDukZISV/b1Uiir1gKKOoYa2ZVllOVWwMSmw==
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id d9443c01a7336-290c99a9669mr86543995ad.0.1760798604438;
        Sat, 18 Oct 2025 07:43:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5850sm28306035ad.66.2025.10.18.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:43:23 -0700 (PDT)
Date: Sat, 18 Oct 2025 22:43:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/8] common/attr: fix _require_noattr2
Message-ID: <20251018144318.owo63ppez7ormj5f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618026.2391029.1336336050566653412.stgit@frogsfrogsfrogs>
 <20251017171325.b35z55fbubi3kxut@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20251017225546.GI6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017225546.GI6178@frogsfrogsfrogs>

On Fri, Oct 17, 2025 at 03:55:46PM -0700, Darrick J. Wong wrote:
> On Sat, Oct 18, 2025 at 01:13:25AM +0800, Zorro Lang wrote:
> > On Wed, Oct 15, 2025 at 09:38:32AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > attr2/noattr2 doesn't do anything anymore and aren't reported in
> > > /proc/mounts, so we need to check /proc/mounts and _notrun as a result.
> > > 
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  common/attr |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > 
> > > diff --git a/common/attr b/common/attr
> > > index 1c1de63e9d5465..35e0bee4e3aa53 100644
> > > --- a/common/attr
> > > +++ b/common/attr
> > > @@ -241,7 +241,11 @@ _require_noattr2()
> > >  		|| _fail "_try_scratch_mkfs_xfs failed on $SCRATCH_DEV"
> > >  	_try_scratch_mount -o noattr2 > /dev/null 2>&1 \
> > >  		|| _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
> > > +	grep -w "$SCRATCH_MNT" /proc/mounts | awk '{print $4}' | grep -q -w noattr2
> > 
> > How about use findmnt? e.g.
> > 
> >     grep -qw noattr2 <(findmnt -rncv -M / -o OPTIONS)

Sorry, the "/" should be $SCRATCH_MNT.

> > 
> > > +	local res=${PIPESTATUS[2]}
> > 
> > Then the PIPESTATUS isn't needed either.
> > 
> > I can help to do this change if you agree.
> 
> Yes, that works!  Excellent suggestion.

The patch 1,2,3,5,7,8 has been acked/reviewed, do you need I merge these patches
in the release of this weekend at first, as this's a random fixes patchset. Or
I can wait your next version, then merge the whole patchset when it's all get
reviewed ?

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > >  	_scratch_unmount
> > > +	test $res -eq 0 \
> > > +		|| _notrun "noattr2 mount option no longer functional"
> > >  }
> > >  
> > >  # getfattr -R returns info in readdir order which varies from fs to fs.
> > > 
> > 
> > 
> 

