Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF45EE9A
	for <fstests@vger.kernel.org>; Tue, 23 Jan 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017401; cv=none; b=ZtluJiHHuBpg/tfBftjJ3hIgx5ZbYgl3dlmEVWnrn3hhkLBMl5b48p3jhuEWkWeKkCwjkXAj3VpM5fhoybTOmqsavuVo1U+KyZOsFI1ixmzXSZVW1C2vkVbTKirSfpbHhkCZcd1KFJmavHoZXJgdhzoEVufDlYY9SvoeQlX9oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017401; c=relaxed/simple;
	bh=W4EqJ0vRKlYqj7IZdm3aXW9vvK33evG1LUBootpjFBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1mDMItdYwM6I/WPB0IqT28wFuY+7HkpxR1waS8tMmX7Q3dgIVhPXfU1rNJFkEzd7I99Y11D6nU4H3BvuA05pmb6fo7QOdM9eRMf9w60ZGmf77RSxt42bvUQ+YGHkhAzeaagpqUbNceOrGrWUv3um0lic6hjWEV6WuMxHftpxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwY25sJZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwY25sJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706017399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knMCk+XJ2+Y7IAEs5qmkHSFN1nBekOKyiXDu5KBUAE4=;
	b=LwY25sJZf4f3U3bs6ihC+NV+gXhEuTLK+Fwy1Xdg/qftBlUBUVUF4zIeatdko5ZxBEMXG7
	e52uJvKqQZyxZwNB/eeYRQWC76qNPO+bJsc43ZYeZ2qSySFoQG3k/MNxoTVRBKOr81zQ1E
	YaIBahf9tCp1zOHJKVDPfys0uizV5A0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-jOglYmTSMeigqiYysiVPXw-1; Tue, 23 Jan 2024 08:43:18 -0500
X-MC-Unique: jOglYmTSMeigqiYysiVPXw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so2383479a12.0
        for <fstests@vger.kernel.org>; Tue, 23 Jan 2024 05:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706017397; x=1706622197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knMCk+XJ2+Y7IAEs5qmkHSFN1nBekOKyiXDu5KBUAE4=;
        b=vGvHej4JU6cZ1Rz7HYCXQUNfJ84Hz4WthatG8bFAQB7Db4eEVmgfq3M3xeHKYwX6jq
         f/okUaOOOK6eO+McZXDdSlbjLzomoGbth6BWI7XamSW1vO2S0GcftuFdfzBT9Bm6MxXn
         3UFWbuyizR6a9Tr1vFxHtBMZT/jRMIgIgjCNn1jg9nYHLbDKJEBkxPwQBd/4D8Ts3zUs
         ir1f9cgc2KMt4ZrFOxTiGfj4jv+nZZpSUvwlc7NL7rtnj81/gwaguQ3s2gubXQwu5eR0
         hcTgUTmK0VFVtU7HPiYw8S5WaOA1EFVNPoJhx+CSQfgcSGIfClftEktdZXQdDOl0+qgu
         kpiA==
X-Gm-Message-State: AOJu0YwcnpFxIEwyml4eiT7a1w1CjsffkB6oq5deOlnIPimt9UizrTEV
	omMVWfV/fQoRPTjRTOAPAxg+0uZvxwP0zTDT7HAHbBGj4Okj0u35btoAb3H/axdl/MBdqEBibLH
	Tlqlvtw8jXT3c5C4s5kkUAg7hh9aVdobvPZ/o7F5RxFLf2Tk5UxcIv1M=
X-Received: by 2002:a17:90a:4b8f:b0:28e:73f1:2065 with SMTP id i15-20020a17090a4b8f00b0028e73f12065mr2568749pjh.7.1706017396626;
        Tue, 23 Jan 2024 05:43:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBa0PN9zeWTjGvbVpj6VeFH3XpHQUcIJEDnHoxmOJwhhw3fQT8NkATNtrKe5nVsIMDxymjNA==
X-Received: by 2002:a17:90a:4b8f:b0:28e:73f1:2065 with SMTP id i15-20020a17090a4b8f00b0028e73f12065mr2568737pjh.7.1706017396309;
        Tue, 23 Jan 2024 05:43:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a318500b0029095a896c8sm5247021pjb.40.2024.01.23.05.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:43:16 -0800 (PST)
Date: Tue, 23 Jan 2024 21:43:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Dave Chinner <david@fromorbit.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	fstests@vger.kernel.org, djwong@kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 0/2] fstest changes for LBS
Message-ID: <20240123134310.6mrzqdvs64ka6o6p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240122111751.449762-1-kernel@pankajraghav.com>
 <CGME20240123002508eucas1p16e632cbdbc7abf62fc1fde342bbaa3d6@eucas1p1.samsung.com>
 <Za8HXDfoIK+lyMvR@dread.disaster.area>
 <69e73772-80e2-4cfe-a95d-d680d7686e3c@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e73772-80e2-4cfe-a95d-d680d7686e3c@samsung.com>

On Tue, Jan 23, 2024 at 09:52:39AM +0100, Pankaj Raghav wrote:
> On 23/01/2024 01:25, Dave Chinner wrote:
> > On Mon, Jan 22, 2024 at 12:17:49PM +0100, Pankaj Raghav (Samsung) wrote:
> >> From: Pankaj Raghav <p.raghav@samsung.com>
> >>
> >> Some tests need to be adapted to for LBS[1] based on the filesystem
> >> blocksize. These are generic changes where it uses the filesystem
> >> blocksize instead of assuming it.
> >>
> >> There are some more generic test cases that are failing due to logdev
> >> size requirement that changes with filesystem blocksize. I will address
> >> them in a separate series.
> >>
> >> [1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
> >>
> >> Pankaj Raghav (2):
> >>   xfs/558: scale blk IO size based on the filesystem blksz
> >>   xfs/161: adapt the test case for LBS filesystem
> > 
> > Do either of these fail and require fixing for a 64k page size
> > system running 64kB block size?
> > 
> > i.e. are these actual 64kB block size issues, or just issues with
> > the LBS patchset?
> > 
> 
> I had the same question in mind. Unfortunately, I don't have access to any 64k Page size
> machine at the moment. I will ask around if I can get access to it.
> 
> @Zorro I saw you posted a test report for 64k blocksize. Is it possible for you to
> see if these test cases(xfs/161, xfs/558) work in your setup with 64k block size?

Sure, I'll reserve one ppc64le and give it a try. But I remember there're more failed
cases on 64k blocksize xfs.

Thanks,
Zorro

> 
> CCing Ritesh as I saw him post a patch to fix a testcase for 64k block size.
> 

