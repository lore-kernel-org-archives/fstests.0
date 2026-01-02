Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C727E054
	for <fstests@vger.kernel.org>; Fri,  2 Jan 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368608; cv=none; b=pGLoEkrrYT+DqzV6R1bloPEAGFknQu4y/SEZclw2H7UpmEBI5LQA5CDKSpfktX1pdtw2wkeIhIi0Q0DNFa5ovloETOnjqLWIlBHXDS0Agu1pUoZdVwxstKaam5mcFabLO8jKPCOdCmC1tqf4KBdb1OplW5F2mGFvr1wDEtckiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368608; c=relaxed/simple;
	bh=2dwqUFew7od2MeYUd4pMaUJl/7Uypsvp58tk38X2xak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOWRZi/LLo6fcEk8w7lPz41ElKshDlmX+lHvmmmDtJGeOeEYivmkJ503LhW8garTNrmpm2rmnYw3Cp4ZR+4ocvwYrL7mddlLMxEEcTfw+NK7bc9ql6Xc9tRa5SgZ9cpEBz87AQpQ0dYhOdRGAkE72cB4hMNN7FCITH6e+27sj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4q6iuCR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tsfuS1bo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4q6iuCR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tsfuS1bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767368603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubwpuamFY2AQrzeCL3bViI7nLkU6HgXAqKdT43+8US8=;
	b=G4q6iuCRtXskn6TXV0cmShZXU9VsMq3ynG0F3DcyjoWdSALBUREbLC5IXYJtmKpoJthH4U
	N0L88wb5xFJjbdsT7PYjTgqc4vMraBSGcNZTrytMg2Fn6KZJsJXFpkMQD7ETKVQUeMdrHA
	XGQxUaYGVmaVMV7ksCgHi4C+3WYelRo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Xr_T6wrEMSG1s80T_t3WEg-1; Fri, 02 Jan 2026 10:43:22 -0500
X-MC-Unique: Xr_T6wrEMSG1s80T_t3WEg-1
X-Mimecast-MFC-AGG-ID: Xr_T6wrEMSG1s80T_t3WEg_1767368602
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0dabc192eso280233995ad.0
        for <fstests@vger.kernel.org>; Fri, 02 Jan 2026 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767368602; x=1767973402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubwpuamFY2AQrzeCL3bViI7nLkU6HgXAqKdT43+8US8=;
        b=tsfuS1bonYV+ulYxe4cFsuH9z1b85Kkb0Ro6vqGfLUkFWfBZwQq6c7z8ZBGah951Qp
         5wjm5xelXbow58BfiomC42jDoXJ+Lp69BY8Ipx4DZI2QAjboDK8TxuLbbPJzX0R0LLNW
         bzpRZYLYpLpV21LbqV/m81Zl1fH7wG8ZoPvEeLrhGXqIf4O+SO7+xfa3O6q3D/MA9+HS
         3uRZB5cWupTlVtcq6wX1ukqr00YIWjXT/ng3wkuslLRQ3/DbH1AQD9d+daVQ1lSmUD0I
         nLvhn9Zn1N/UUZ41ayNShdepAf2RHwhglhCulJ+WZJVyGEuOO8SsGLlxv5f17GjGgtlZ
         9QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767368602; x=1767973402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubwpuamFY2AQrzeCL3bViI7nLkU6HgXAqKdT43+8US8=;
        b=JfIveRi4OiaMm24mK8yHw0+4FE/BrYjPG0RICCC/xKxI0hcSsMSGxR1cwKaa7nZK5F
         LeatGJ2YYY3vRiEA3vL2FR5qQf+vWthPty8tTA8+3u/HIxLkG7lIAnZs/NboJSO40dWd
         NIFT2u/0eaLebw7U4l0J3MsfB4Ofijn3IN7YNY52VkVUIUkjCCylUIP7JMCNMYsexu2G
         TjA4sEF7s2gWAaf4KiUOFSubZ3xcN1OiA8KEkujDgDBWHrfX4og0mI5GetU8TOh9AcCC
         GRvJqGA2h6LBd05mAFJDhfnQctvP/ZaJjDjwIlvOQuYwn4d2d0a3kjGdF1z7cASikQAn
         x+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvkP6+ZWc9lNixDG2uMqSZ2Ltpp8Q3/rWbjvP1a4m1Xo4n7JRwWFLnM4sWH3DtYxfyyBD66myd@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwsVwbIEqTsddcJz+G+plktoNWimqprXuFWW8/2WOG1ouQ+78
	0oXsCjhkSVjU7A+P/roFWdzUK2wdfFq9TpHtCCTdJefOGgjFu5p42piRh2jQVe4+TdBbHAtxeQX
	Z6ZIK+A0rDJaUKKu6nPM5A4UQPh+xeRxUIakuleY5AGDJHtmNWb3US71usqE=
X-Gm-Gg: AY/fxX6q41aXQxQWhWC46yqtwVaIhG92EhwtYMO1K4OKjRdSD6adkaKWvxGLoAdnyFL
	lYSNAbEJ04Z3YLYbwiZqUEdYHcuEEViP0wcDYYSi3sacEIwE5HYVjqIIwzpMcsOOdzeTNsjahQr
	mKLHpOfJLSvFvYMQ7zIqpQYHUyOoh4GHPH+LvOUi1v9uBR0/8OXIVWmaZW7kgXN3LDdAV3OPTKt
	MuikFbk4EGmzh3kRtIIRW9HnkmdK4F8e3AF77IKGNRVqFiJOkDta5DHCumForm6gX9cqxB5Hame
	DXumKJTn80hq00apUGertKLPLZTO/8iXDxnYdaf2CJehRs+ltS4xivgE6HNJlzh3lbDsCuJHse1
	LVr3WZ28D2LwX7PTZFRQlyDpn3ebEz+zMGjYF6jdNBmqDU85XDA==
X-Received: by 2002:a17:902:ecc8:b0:2a0:f0db:690e with SMTP id d9443c01a7336-2a2f293b522mr444812225ad.52.1767368601628;
        Fri, 02 Jan 2026 07:43:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0OCIb2Th3sRmo68pWOrOUpG3BBs23phZVPVnW42Vu89iwm2I8ZmIncZdMhhMDBnxhtTgAkA==
X-Received: by 2002:a17:902:ecc8:b0:2a0:f0db:690e with SMTP id d9443c01a7336-2a2f293b522mr444812015ad.52.1767368601080;
        Fri, 02 Jan 2026 07:43:21 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79e05712sm35655650a12.14.2026.01.02.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:43:20 -0800 (PST)
Date: Fri, 2 Jan 2026 23:43:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: zlang@kernel.org, linux-xfs@vger.kernel.org, djwong@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] punch-alternating: prevent punching all extents
Message-ID: <20260102154315.nfh5kdiz7b5cuswq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251221102500.37388-1-cem@kernel.org>
 <20251231184618.qpl2d32gth4ajcsp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aVfHvxvMVbS7phq_@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVfHvxvMVbS7phq_@nidhogg.toxiclabs.cc>

On Fri, Jan 02, 2026 at 02:36:01PM +0100, Carlos Maiolino wrote:
> On Thu, Jan 01, 2026 at 02:46:18AM +0800, Zorro Lang wrote:
> > On Sun, Dec 21, 2025 at 11:24:50AM +0100, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cem@kernel.org>
> > > 
> > > If by any chance the punch size is >= the interval, we end up punching
> > > everything, zeroing out the file.
> > > 
> > > As this is not a tool to dealloc the whole file, so force the user to
> > > pass a configuration that won't cause it to happen.
> > > 
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > Signed-off-by: Carlos Maiolino <cem@kernel.org>
> > > ---
> > >  src/punch-alternating.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/src/punch-alternating.c b/src/punch-alternating.c
> > > index d2bb4b6a2276..c555b48d8591 100644
> > > --- a/src/punch-alternating.c
> > > +++ b/src/punch-alternating.c
> > > @@ -88,6 +88,11 @@ int main(int argc, char *argv[])
> > >  		usage(argv[0]);
> > >  	}
> > >  
> > > +	if (size >= interval) {
> > > +		printf("Interval must be > size\n");
> > > +		usage(argv[0]);
> > > +	}
> > 
> > OK, I don't mind adding this checking. May I ask which test case hit this
> > "size >= interval" issue when you ran your test?
> 
> None. I was just using the program to test some other stuff without any
> specific test.

Sure, good to know there's not other issues :) This program is a good tool to
do some other tests, especially creates lots of data extents effectively :)
I've pushed this patch to patches-in-queue branch, will merge it in next
release after testing, feel free to check it.

Thanks,
Zorro

> 
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > > +
> > >  	if (optind != argc - 1)
> > >  		usage(argv[0]);
> > >  
> > > -- 
> > > 2.52.0
> > > 
> > 
> 

