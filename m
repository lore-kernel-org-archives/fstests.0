Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A679C0
	for <fstests@vger.kernel.org>; Thu,  1 May 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746090665; cv=none; b=J/kZKEFslrYcgmyUweUybQzpv6eBqts3Fa+TUsreGVexR2gGt1VboML4LLDBPKsFaPDVSM0u+fQe30l9XjtFchSvqmPafm4y8962kCmwii6hN/3vCpD6mE5GXtHoNWSuQI0q6S6wOyFO6rW2EdHX8Goi73Lwr3u4FGhLOl5vFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746090665; c=relaxed/simple;
	bh=QEmXOiaRmXnU0Pvpj2r5Tc5dFQl/2TPO2eRzIxZTpSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loXEotHMAzA3eDEYgBTpFhWviwQvRjT6OpEUn5W72xpGctAZ+h7lD4csWlqamlSbf/tXwXgQfFxFtAjRi1BlCLWxNA2oBFc/IKo2gBzYWLD2LEP8/RWfXTfPWbPb5u7dUTMtYQ8DxopYDo3EZuNpMvhdjmOfpe4Y8T5m1VGprBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGfiMCbr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGfiMCbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746090662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QxhIn1Sw5963uslvOW25nDRRIDUs0PbP3KlVBu7IStA=;
	b=UGfiMCbrscUxrsZ84gCm94Hpb35IQcjOF6doNElFdEfPzOiPD/qJRwRwsuJ7tkQCIfDat5
	HXlg391WoFdPUePnbELHiiYhiRxaaE9wZcvYCZeyGRBfpfN6ADNMBT4XZN17FVMgiFmQip
	eWdjaoSU9B8NavJPN1QRxNFyqCfldbU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-4RrnSKD2NtqYUg52wfgiCA-1; Thu, 01 May 2025 05:11:01 -0400
X-MC-Unique: 4RrnSKD2NtqYUg52wfgiCA-1
X-Mimecast-MFC-AGG-ID: 4RrnSKD2NtqYUg52wfgiCA_1746090660
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736cb72efd5so752132b3a.3
        for <fstests@vger.kernel.org>; Thu, 01 May 2025 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746090660; x=1746695460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxhIn1Sw5963uslvOW25nDRRIDUs0PbP3KlVBu7IStA=;
        b=dl5W0KM8I/ALKwNWGiBtKGyiACATcQOwoGkkj1rCfoNMun0ftQayorC2iI4krljtxb
         DNa0PLFqQB42NFPY0JdesukmuXu0zMJSNsLaf+uEMFxLlXiMCyh5r/8nQr4B4zWaTx8r
         BT72ZXuZYV3jnQBAQ5xo7ISHAixk+sTy4E2UL9yOh1OwX8QrGFicgxnlSLsktiEHj2Rw
         zq58jH+zuskWkNz2JiS+gCvLHIKAHMEpqCSQKAYpwF+CrkvQ4PyKFDJUnb71m1oSkq58
         8uO4/tF0jkfwj3BriWMRy+7twm1FYh1SGelDhMOIM3xT7R2ad9Cup+/hduyHvYQjETS+
         +riw==
X-Forwarded-Encrypted: i=1; AJvYcCVu7kpy2jdM+/6sMkVFj4J4fPrwjJYZ+hueK8ktqg2evsBssz84V1c5ZtYcLr6Om2HEo0Al+BXc@vger.kernel.org
X-Gm-Message-State: AOJu0YxNM9YkG6bhpOfO1WA+9V5oUtd3t+mqKKcwgXXXt8JGITGyN9IN
	dl4b7upREoKhkDUwlFmeXm3DpQjtdA2g7WHHI8F1snO72Cd1Wd/9MCAOUhb9ZuhkCCYv9UR4VXU
	v0ghFtGzqOb6NJ0mBPKimFGA2E/rbHyXSjAKVsH/gNJD5ZJdXbAgAjEw=
X-Gm-Gg: ASbGncvw85kBcFnr6RbMaADY/yGF058espFSDqzO+HvTnIne+t5VrWNI1rpmOoRMRzx
	Q2Qyf35wy8opB7WXtQYhd8qvmcF0r0nnOQ02i3tsNhenh3kQozSs3Gyi1Tx0VTXRssbWhko0480
	S/jrXuDAtg3tVid9GUoezbNL6hQ/rBaPtyWe+v+8PCLJb9F+6peBQpnibvHm8IE9w+1q4jHrL1Y
	mtgb5U8FfKYByKpXn+gHe1emQ20EkklCieJA7xXENO+Ff00DbPOHrZLnYNo7wSbCzaFMl9EOv2P
	b37WMXOVO077omXg3GwvmO6TSj8nfSFjYBVMoVDt4cnekAUkuOmY
X-Received: by 2002:a05:6a00:399f:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-74049254c95mr2293523b3a.16.1746090659932;
        Thu, 01 May 2025 02:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb5/7x8ZBKSA+i2VN4Rh2/jV2SOh0H2mngKBWWKI7BKImnX6gIaLln1uDeV0hnSozdCGsAzw==
X-Received: by 2002:a05:6a00:399f:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-74049254c95mr2293497b3a.16.1746090659522;
        Thu, 01 May 2025 02:10:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7404fa42fb0sm353535b3a.166.2025.05.01.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 02:10:59 -0700 (PDT)
Date: Thu, 1 May 2025 17:10:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org, david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] common: Move exit related functions to a
 common/exit
Message-ID: <20250501091053.ghovsgjb52yvb7rj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
 <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com>
 <87cyctqasl.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyctqasl.fsf@gmail.com>

On Thu, May 01, 2025 at 08:47:46AM +0530, Ritesh Harjani wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
> 
> > Introduce a new file common/exit that will contain all the exit
> > related functions. This will remove the dependencies these functions
> > have on other non-related helper files and they can be indepedently
> > sourced. This was suggested by Dave Chinner[1].
> > While moving the exit related functions, remove _die() and die_now()
> > and replace die_now with _fatal(). It is of no use to keep the
> > unnecessary wrappers.
> >
> > [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > ---
> >  check           |  2 ++
> >  common/config   | 17 -----------------
> >  common/exit     | 39 +++++++++++++++++++++++++++++++++++++++
> >  common/preamble |  3 +++
> >  common/punch    | 39 +++++++++++++++++----------------------
> >  common/rc       | 28 ----------------------------
> >  6 files changed, 61 insertions(+), 67 deletions(-)
> >  create mode 100644 common/exit
> >
> > diff --git a/check b/check
> > index 9451c350..bd84f213 100755
> > --- a/check
> > +++ b/check
> > @@ -46,6 +46,8 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
> >  
> >  # by default don't output timestamps
> >  timestamp=${TIMESTAMP:=false}
> > +. common/exit
> > +. common/test_names
> 
> So this gets sourced at the beginning of check script here.
> 
> >  
> >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
> >  
> <...>
> > diff --git a/common/preamble b/common/preamble
> > index ba029a34..51d03396 100644
> > --- a/common/preamble
> > +++ b/common/preamble
> > @@ -33,6 +33,9 @@ _register_cleanup()
> >  # explicitly as a member of the 'all' group.
> >  _begin_fstest()
> >  {
> > +	. common/exit
> > +	. common/test_names
> > +
> 
> Why do we need to source these files here again? 
> Isn't check script already sourcing both of this in the beginning
> itself?

The _begin_fstest is called at the beginning of each test case (e.g. generic/001).
And "check" run each test cases likes:

  cmd="generic/001"
  ./$cmd

So the imported things (by "check") can't help sub-case running

Thanks,
Zorro

> 
> -ritesh
> 

