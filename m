Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5628F3
	for <fstests@vger.kernel.org>; Tue, 13 May 2025 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108076; cv=none; b=GXhxvNWhv+DPfPwztevzKr8WvPPtzoJdYFC7PANBacxxpGb2UxDnh+BskRpS3RH7k1CM6CP3d+8DiEWNa84pl/8WphNWCYeD/zOtr+bOwSzTFLp/rLvEOeDr4L50jfS/XDJmPxA/zVzSFZzcg2qPhSYB0k1nquSXJ6fz9jHrRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108076; c=relaxed/simple;
	bh=hRH+6aWhH21hs+2kU0RbjkWjO41F/xMKBMdOnJ3rnm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNEDQn/fFxFN9YSF6R2Cr0y0IFBonTuYlREaTIijQtEVqIj5kEE39bjD42hJCZvswccy19r7vYXtNxCcJI5Zt5MUfj66UYFomNWI7s76NVvxtZIOYIPUqBlUyfSEp9/vHkv2bZB+7JsaYHT8o137ek/uPY+ZyEbYB/JXCzIHHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQTvWbxQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQTvWbxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747108073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dp+Me7leNaFPo8EMiSbqWzWf1Bq9HMOIH5exuvOFAc=;
	b=fQTvWbxQJs3fA+5R894etZmZBtyfduBo8rM/jsVxrGXjIpwzNHnzaEsqcyDVQSkh4S8EQ5
	qAcSJmd4Z19BsGKZl92+64tWgwcXNWvW5xszHd2cZGz1uqPAZcpy7HLLZlviFC6e3mLjLa
	VUMlCHee+Ndtace8h8BH6gOK++I3LgE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-sWwz7YVmOuGvc3ByeXEVvg-1; Mon, 12 May 2025 23:47:51 -0400
X-MC-Unique: sWwz7YVmOuGvc3ByeXEVvg-1
X-Mimecast-MFC-AGG-ID: sWwz7YVmOuGvc3ByeXEVvg_1747108071
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22e3abea7e8so54302705ad.2
        for <fstests@vger.kernel.org>; Mon, 12 May 2025 20:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747108071; x=1747712871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dp+Me7leNaFPo8EMiSbqWzWf1Bq9HMOIH5exuvOFAc=;
        b=sE/X/JzA/4CY90ePVDsLvgq/sex+T/KikEVPuMm/SKJS/drUjjsInBQKbij2UZzxJk
         W3nalmvTh3lhrH4H7sd3X6z/vgy0V24bGYJ2WG3tb1dJw1ej7+rnsvEE0RCbfIj15hoa
         YUJk5HsNyRVVZoqTEBNKnsLAVnznxY9wx1Tm4PN5rWj0BrVsTDD1rfpQe/Sqz2iqSoSK
         rgJrriwX8DnDAgsGjpayk8mZdnLJgr5pMHskOfR4pNPVZ5EGSygiBwCQmu9lCRjo2WIi
         iwudWRX8tH56azN/LDSJVWcHIcBJDg8kbtzBAJzn1doq0xfhNiDuCGnWku84KypgmaJD
         U25A==
X-Forwarded-Encrypted: i=1; AJvYcCVe63lEyQq9rHvaiJsIVuiCES6UZgsgT3zyqE624W5S5QXR78Ju/mdD1R/IXb9TstcDbj9ko7Jx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlse47kp7OeH+66zPxQHXJElMNIl09vN1rIX88A/aSYyET1MQh
	yKld8SL/p89dZNk4TPTef5k2CSJXBLr3SENTjywEml8f685pR6vZahsXIKOoILAVhg506C17zWB
	C7OzH9PGFzEKIfUvFsyoaoaAP3YSQtij8MFiF/cKcW4ax82GhGuxV8qM=
X-Gm-Gg: ASbGncsV7YFNQxgWWdBV/jxLmdm4NTyvHC2B6fury5Jfy1PzmvtdsDuYlrujGDRDyE2
	N7B87QgxvPdzQISaatahAWq7dkQKd3d9exPqqZCwFV+BwLRDUHNEGJ7lEB/JqkrnPIndWDLReGn
	JBm8bvsuhAvpxCtCbCaeRWeCX/yuAgQu7TrDx3E49SrW82zzKMcaLWsnj48pJOfEyov3zccR4HA
	e/JTkFmtP/nke5dBFmUoD23VqOA+MZXtFsHjMyhVHj5oE78royqW8JbKFiBmgau/CMi5TbOZY8H
	5lqo+ZN8Ed4oDXjdwzGzOSnawsCUt1P99aFgTDqtwKhXsD0Ijm/q
X-Received: by 2002:a17:903:2f88:b0:21f:988d:5758 with SMTP id d9443c01a7336-22fc8d98a75mr280449745ad.35.1747108070705;
        Mon, 12 May 2025 20:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn4SUh4CywVMmhVcV/nqkmdj9Gy9a7na0ooAGo3LbtuP+Ld6nTEEatIh8H2Q2WCI7LOaMktQ==
X-Received: by 2002:a17:903:2f88:b0:21f:988d:5758 with SMTP id d9443c01a7336-22fc8d98a75mr280449495ad.35.1747108070334;
        Mon, 12 May 2025 20:47:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b445sm70800205ad.181.2025.05.12.20.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 20:47:49 -0700 (PDT)
Date: Tue, 13 May 2025 11:47:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] selftest: add a test that flakes
Message-ID: <20250513034746.omeueunfdx7asgpp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250510004256.451058-1-leah.rumancik@gmail.com>
 <434c560c632558cdc32b45f2aef54c68ca6c0baa.camel@gmail.com>
 <20250512151949.GR25667@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512151949.GR25667@frogsfrogsfrogs>

On Mon, May 12, 2025 at 08:19:49AM -0700, Darrick J. Wong wrote:
> On Mon, May 12, 2025 at 07:32:15PM +0530, Nirjhar Roy (IBM) wrote:
> > On Fri, 2025-05-09 at 17:42 -0700, Leah Rumancik wrote:
> > > Add selftest/007 which should fail about half of the time.
> > 
> > I have already posted something similar[1] a couple of months back. It got an approval didn't get
> > picked up. 
> > [1] https://lore.kernel.org/all/20250113164639.GG1251194@frogsfrogsfrogs/
> 
> Aha, I /was/ thinking "Gee , haven't I reviewed this before?"

Oh, that patchset is marked with RFC, and most of patches aren't acked (except
the 1/5), so I didn't merge it and wait later updates.

> 
> Zorro: any plans to merge
> https://lore.kernel.org/all/03ba6c154c9e2cf3d68131b3af2ca12b96663d25.1736496620.git.nirjhar.roy.lists@gmail.com/ ?

Sure, I'll pick up that single patch to merge at first, as it's gotten enough
acks :)

Thanks,
Zorro

> 
> --D
> 
> > --NR
> > > 
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > ---
> > >  tests/selftest/007     | 14 ++++++++++++++
> > >  tests/selftest/007.out |  3 +++
> > >  2 files changed, 17 insertions(+)
> > >  create mode 100755 tests/selftest/007
> > >  create mode 100644 tests/selftest/007.out
> > > 
> > > diff --git a/tests/selftest/007 b/tests/selftest/007
> > > new file mode 100755
> > > index 00000000..0e983b37
> > > --- /dev/null
> > > +++ b/tests/selftest/007
> > > @@ -0,0 +1,14 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. 007
> > > +#
> > > +# A test that flakes due to occasional output mismatch
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest selftest
> > > +
> > > +echo "I am intentionally flaky"
> > > +echo $((RANDOM % 2))
> > > +status=0
> > > +exit
> > > diff --git a/tests/selftest/007.out b/tests/selftest/007.out
> > > new file mode 100644
> > > index 00000000..0b5e439a
> > > --- /dev/null
> > > +++ b/tests/selftest/007.out
> > > @@ -0,0 +1,3 @@
> > > +QA output created by 007
> > > +I am intentionally flaky
> > > +0
> > 
> > 
> 

