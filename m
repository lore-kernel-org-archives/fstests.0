Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B5215075
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008131; cv=none; b=kmC6sdEDkWWLKvSkKZvx67S+VQeWx0W4yyBnvpBDtezNaZMBKb89jBP8OWS7WD8Ib8lnH4xRvIbdJHKBAs+pqRFGyPHFjsUY9Ajkth3gCnbx5envyyjnyfMJgg96iZRR3efN2Zq7qVWsa3bli9U5qdlRMobr4UAsfGzbaSsRiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008131; c=relaxed/simple;
	bh=NfJ5Kd49ZT8xgL3Eh/ltvUbirv39OjmcGfKNeT+zcho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzkYrgEA8U056t+5L2/Y7KE/yEU/M0+8g78/RSroAIZ2g7bnLyGtDcIPrjnlac2oD9I/h1JgQla1GY2Uil6DYzvsjVHHnpkp2YkqnTD0kUq10iFF7Xg92mKEeMGZUjiyT9fCs+Z7zH2erulRqj44BESm2Xfnvo9ogNyyfbcnrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7uyV0NA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7uyV0NA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748008128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k20uDbVVIsqeR1RbF5k+zLSYQuWw8mmX4jU34d/3eJQ=;
	b=b7uyV0NABCgMFf7aYXraw+FtE9UieXKro3D51Sen7PhJvJjcr79qDn7iuGppDQGOB2NsiI
	kdRpp6Q5TnLb00vB5F+Hu1vJiWiRmHvGasS2c92wUaD0VLSdCg+0FkiLBpsQGnZ34DsoFO
	4JqyI7HMYwHWH0S10ql/4eLEeHj2ZlA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-wTe4VgyvMmCCpNd5cRWUnw-1; Fri, 23 May 2025 09:48:47 -0400
X-MC-Unique: wTe4VgyvMmCCpNd5cRWUnw-1
X-Mimecast-MFC-AGG-ID: wTe4VgyvMmCCpNd5cRWUnw_1748008126
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-231d7f590ffso54712025ad.1
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 06:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748008126; x=1748612926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k20uDbVVIsqeR1RbF5k+zLSYQuWw8mmX4jU34d/3eJQ=;
        b=JfdfTUNDon+3o11ujgd/KBoe8wYXpC34l1oQanEKcJgHyy4C6VKkPAieOh8R4eNqRU
         t0PdKOtH/D33I//kifogxZAzC96d7hsqRAYx0a5X81GikLkuxcAjLjOSnDL3C9mdoY2G
         bOicioPaAWnBElbscKUmEn0YuLkUz0/2ILK2DL/p4Lg8lL2msqRY8P9xd0wTZDMhzw6f
         cieAdX5DIwZR/2PJaQdGSXIU/EKzqq2/nGRmw95khE/M2k8BBtvUYbIHvqac07MuRHMI
         xs4YdGhZglixN+lyX6KcCd2LicwzfZh8Yxu4vQbi/VGkp+xG7oO/lJfDC0+UdH/6zFd5
         OeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT6C89s4BhyQv/HstzHWKwdRWzwN78oZZ2tKlD9Z3gD+c6brnudBNifx4Cxx1taFUyIJVGjeau@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ar7SAM5XkD7lsfmk3N5G2gUc+XVjz1TCSdBKIqRLzOq0Unq4
	8Czwc+Kqua9Y3M1gjFrUm2SFjwsHIWy/qQStRMkNG39QMe4IDtiyALiICpv3cV3kg5qAMPQb2gp
	4chq9AYEXecBKHWE0mx3AwZ5Z13RTPnmFvkkPolXKYea5PYTQ4Nqctm0xQ+k=
X-Gm-Gg: ASbGncvx7zXInLDOy113z+roikepVTTXkjpRwj5MCSTt7G0LtcgDcFHaAt3oI+eVy6C
	ZaHq55OzULLpM5ymdS73wqbnJFye5mHL9YuNBUs/FvJrdNafeDhFUwXSoiBjTVqnPFWbN3UMRXz
	bTyhKSJs3jhs7kVlyrf9ExoaqF5L1qsieNlITLH16tv8i7oIDRnrXLvdzvTNjXu9SFN+sFY5VYz
	82tErQEq1hJAxxVTT3mTguHqfoCVsiN49Db3hTYJ+hX42UBApioVugjcNIzpsnDxm195DeZyg5H
	/1zM/0dljiXJUfG1dnUsbWlZxHFRcpfNGyN9Y6V3BIAHjARTPclY
X-Received: by 2002:a17:903:2391:b0:22f:a932:5374 with SMTP id d9443c01a7336-231de37ec19mr380393455ad.48.1748008126478;
        Fri, 23 May 2025 06:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2q82Ti8TMFMvRmE/DhmRxb4pfs7/bjpctIIy47uUuZzCZUVWLtVWfRdxbfJi5QIazPj4ddw==
X-Received: by 2002:a17:903:2391:b0:22f:a932:5374 with SMTP id d9443c01a7336-231de37ec19mr380393245ad.48.1748008126168;
        Fri, 23 May 2025 06:48:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23401ad40d5sm5222185ad.75.2025.05.23.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:48:45 -0700 (PDT)
Date: Fri, 23 May 2025 21:48:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] check: check and fix the test filesystem after
 failed tests
Message-ID: <20250523134841.he33mykno4z7ixjf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <174786719678.1398933.16005683028409620583.stgit@frogsfrogsfrogs>
 <174786719769.1398933.12370766699740321314.stgit@frogsfrogsfrogs>
 <aDAEIE-UPT6P4xsE@infradead.org>
 <20250523133900.lzgt4mthuglf7hsu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523133900.lzgt4mthuglf7hsu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, May 23, 2025 at 09:39:00PM +0800, Zorro Lang wrote:
> On Thu, May 22, 2025 at 10:14:08PM -0700, Christoph Hellwig wrote:
> > On Wed, May 21, 2025 at 03:42:54PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Currently, ./check calls _check_filesystems after a test passes to make
> > > sure that the test and scratch filesystems are ok, and repairs the test
> > > filesystem if it's not ok.
> > > 
> > > However, we don't do this for failed tests.  If a test fails /and/
> > > corrupts the test filesystem, every subsequent passing test will be
> > > marked as a failure because of latent corruptions on the test
> > > filesystem.
> > > 
> > > This is a little silly, so let's call _check_filesystems on the test
> > > filesystem after a test fail so that the badness doesn't spread.
> > > 
> > > Cc: <fstests@vger.kernel.org> # v2023.05.01
> > > Fixes: 4a444bc19a836f ("check: _check_filesystems for errors even if test failed")
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  check |    7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > diff --git a/check b/check
> > > index 826641268f8b52..818ce44da28f65 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -986,8 +986,13 @@ function run_section()
> > >  			_dump_err_cont "[failed, exit status $sts]"
> > >  			_test_unmount 2> /dev/null
> > >  			_scratch_unmount 2> /dev/null
> > > -			rm -f ${RESULT_DIR}/require_test*
> > >  			rm -f ${RESULT_DIR}/require_scratch*
> > > +
> > > +			# Make sure the test filesystem is ready to go since
> > > +			# we don't call _check_filesystems for failed tests
> > > +			(_adjust_oom_score 250; _check_filesystems) || tc_status="fail"
> > 
> > Maybe break the line after the || to improve readability?
> 
> If you mean this:
> 	(_adjust_oom_score 250; _check_filesystems) || \
> 		tc_status="fail"
> 
> I'll help that when I merge it.

Hmm... I just found there's another line write as:

  (_adjust_oom_score 250; _check_filesystems) || tc_status="fail"

nearby above patch. So I think we change both or keep consistency temporarily:)

Thanks,
Zorro


> 
> Thanks,
> Zorro
> 
> > 
> > Otherwise looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > 

