Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70E293728
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007551; cv=none; b=s2IjDAQ6MhBzMra4NQ/CtZ50QLv7ESdowxGj0obfAt4g/DqbfyCXlqFOXvRH+zq34YRls16OWIGdc0huWn64Gv3CxDUplwPzKxEO+lEIh7R0tWg38pf4LoIZQk4V44rTv9LISb+OKW2MgHCZONIp4cmPww7PNqPbrgacz1yOZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007551; c=relaxed/simple;
	bh=2xkHme3A0nWoLMx4LEL+OvveWuxp0IwsBbSgedvQHTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPUds3a8OSjwCG0IcxyzykNJ+kwD37OhpaqyMyiKqMGXXxogE9dvWpmmZAsTZ0Oid5l2boDnUzx/JTlnrPaQpd0sCNuMOoZRDxm/YtT6TqXVWhhgy8Pgjo+c1YQPVRwb76rkHobl5UX1buEyPP+dyv+kbTpA/mn9UPbk977v10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdG9Dfwf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdG9Dfwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748007547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ami5ei6zk9Z6uelHCLcQ3d+SSnj9YctEaT4/KMBIwiM=;
	b=GdG9DfwfGz71wP9+rIMAC8IahUf8PuqcyRzZjjPi+AJAMUqVA94FXagLoSidmznO9s8mjO
	BxZBmHnO4hKHLHPShS1YUKtg0iPVj4GGdXlu6afWAvXtT4hyNnTJVvO3k0BWhzTiUDwctW
	4lvXXnIQIFUWl161+3E33F4mkQQB+jI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-U3Jst9prMgyeGbxrkXZyyw-1; Fri, 23 May 2025 09:39:06 -0400
X-MC-Unique: U3Jst9prMgyeGbxrkXZyyw-1
X-Mimecast-MFC-AGG-ID: U3Jst9prMgyeGbxrkXZyyw_1748007546
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-231e3cfc144so68425725ad.2
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 06:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007545; x=1748612345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ami5ei6zk9Z6uelHCLcQ3d+SSnj9YctEaT4/KMBIwiM=;
        b=FGVp7s8vTy8iI6riofwK23VjMKK23uNTJ/ze677t28fDX6Oc4oYNT3/Pup7Bt1jFiJ
         wGOfHRfBleExr5ap/zjCfqqvbEwCjcrJQTMsy/LCRoDVfYowyXOtmWl4s/9bjdUul39v
         bbvH5m2mvEmKQYvOLgtX+q5UKDU6WWbw98B9MTiVx2PM+OB0X5qI+X0qTqsCEzJW/k2K
         DzJRViVxUYxDHQlA2EK7NW0xquCSetfz94xfNoJN1qiMqfs/3SPy9rXIhOl+C+on0ZM/
         CR725t9imW/MooCgu2NVH7E5T4xUECT4qDlpuFItPsffOuXsMmpfdRHPiBusV9XZvxoz
         0Aaw==
X-Forwarded-Encrypted: i=1; AJvYcCVmeq+2dOtfjrf72RmPsG8lvtCZGcNiJgRM8yP7oFhQQC2voFD4GhgX593IeneQUW4ixpQsXpjs@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRmLHpfuaGE5nN1DQbCS/k+GeNcqTRMWx7tfPXysXrksW9wCk
	3T+Pr8okDdwO5LHpeJTvG3F+889Zn9bzE2Ew+gb+qLgxn5dxzvrtihoN8gA2T2jd15ZrsCvJJo/
	7ejcg9sYsa0j1xyHJxarUPlL7XV0GhlBAEei33M19LXm/ExD+9MG7xTO/X9mfxg4IiuA=
X-Gm-Gg: ASbGncvfcLYYmisEf56VebDkwk5Cbul7oLBSTAbuTu0qfbfZR7TN1H9eedjwUec7Fce
	ey2P9siAaxKK3dg/2W20VV6wD7iDLpnTt51QdHZEnQbtq+jVe+DLeoiwYH/iHDOEdhKaSoEzDLK
	nPYybI/B9ZN9YX1KGKQChrrAanuCidRlpxcgxE8Yk4dmZamA0ujV9kgD7pUp+kj0eMn1wpmmSjY
	zNZpqI3FdWb9i4BkUq8eqzTfHVtj8OQLuxtF8gq0+ZBIs4P02V0lyOnLSwf9l5/cCaUcFRRPPlR
	GmSTuLXb43WL9XqtiR8Y6IsTVMR78JJA/KUq8MxAvfb/PHD2upMq
X-Received: by 2002:a17:903:1a43:b0:22e:60b9:ac99 with SMTP id d9443c01a7336-233f25f3fa0mr49336225ad.34.1748007545506;
        Fri, 23 May 2025 06:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9p8GiL2Y+Y2SBaC9lXKxV6Bfq87MczC/P5jUv9AAoCBOaGpg78htOLqvDkWlteD7lNrKcug==
X-Received: by 2002:a17:903:1a43:b0:22e:60b9:ac99 with SMTP id d9443c01a7336-233f25f3fa0mr49335875ad.34.1748007545134;
        Fri, 23 May 2025 06:39:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac91acsm123692195ad.46.2025.05.23.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:39:04 -0700 (PDT)
Date: Fri, 23 May 2025 21:39:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] check: check and fix the test filesystem after
 failed tests
Message-ID: <20250523133900.lzgt4mthuglf7hsu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <174786719678.1398933.16005683028409620583.stgit@frogsfrogsfrogs>
 <174786719769.1398933.12370766699740321314.stgit@frogsfrogsfrogs>
 <aDAEIE-UPT6P4xsE@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDAEIE-UPT6P4xsE@infradead.org>

On Thu, May 22, 2025 at 10:14:08PM -0700, Christoph Hellwig wrote:
> On Wed, May 21, 2025 at 03:42:54PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Currently, ./check calls _check_filesystems after a test passes to make
> > sure that the test and scratch filesystems are ok, and repairs the test
> > filesystem if it's not ok.
> > 
> > However, we don't do this for failed tests.  If a test fails /and/
> > corrupts the test filesystem, every subsequent passing test will be
> > marked as a failure because of latent corruptions on the test
> > filesystem.
> > 
> > This is a little silly, so let's call _check_filesystems on the test
> > filesystem after a test fail so that the badness doesn't spread.
> > 
> > Cc: <fstests@vger.kernel.org> # v2023.05.01
> > Fixes: 4a444bc19a836f ("check: _check_filesystems for errors even if test failed")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  check |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > 
> > diff --git a/check b/check
> > index 826641268f8b52..818ce44da28f65 100755
> > --- a/check
> > +++ b/check
> > @@ -986,8 +986,13 @@ function run_section()
> >  			_dump_err_cont "[failed, exit status $sts]"
> >  			_test_unmount 2> /dev/null
> >  			_scratch_unmount 2> /dev/null
> > -			rm -f ${RESULT_DIR}/require_test*
> >  			rm -f ${RESULT_DIR}/require_scratch*
> > +
> > +			# Make sure the test filesystem is ready to go since
> > +			# we don't call _check_filesystems for failed tests
> > +			(_adjust_oom_score 250; _check_filesystems) || tc_status="fail"
> 
> Maybe break the line after the || to improve readability?

If you mean this:
	(_adjust_oom_score 250; _check_filesystems) || \
		tc_status="fail"

I'll help that when I merge it.

Thanks,
Zorro

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> 

