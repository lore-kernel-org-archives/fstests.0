Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04F3A1DB
	for <fstests@vger.kernel.org>; Sat, 27 Sep 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758980554; cv=none; b=L9r6rF5tOkwojsE7F1dCS/YtjDXubTAXXNpu6DYJYOL2nmoo6jO2C2a5ivhag5+4lVWHTH2dr70FsYypXHOPkHgPLFJm9D6uN5yhfdJH6LW+ddRGHSKwUfKZ/hc0HBOCyUib6VtTZfBVi68xrSUzuXBFQFCNUBM1ePY/6vEH/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758980554; c=relaxed/simple;
	bh=haVa2FYln1DFT4lQrDBmGPxlqVCrDYMvGAXepYOSysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYcAaEtMxMIg3OjzZ+O79txZgQKIoomYkwtazFdbFBcUDuEFD6xZMI80b2GKWaypFRMFO/QsWfqKsa3CEGt6amEMajkMAbAAf3nO6WAIvGg5RF5DJ8cNr2dfNVXpNod+w+dAsYTIZc6a3E4LjXYvdvQj3qrbJ9xVe1AG1eGS+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb5ouB0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb5ouB0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758980550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmkIvQPM2ADXSUqY6gn5wB5OFGrkKwBAfwHOpfjikvE=;
	b=fb5ouB0NYTHRZH4FZBFnzuBqBNcS2lslRXHz4EuLFWrsj+vpP0ZA4KVBvU45vyeYmh5OVn
	sTPo/QD7sjeqIRnLB188kc0+Y5nTKyXXWqm37mwnoYWtgg94fvRHL4XKI0+BYAeMx27L5L
	K1/PINkUKHbDKqiCxWkeZKbcIOt4TkY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-06vogzuKN7KJkifvyRy9VA-1; Sat, 27 Sep 2025 09:42:29 -0400
X-MC-Unique: 06vogzuKN7KJkifvyRy9VA-1
X-Mimecast-MFC-AGG-ID: 06vogzuKN7KJkifvyRy9VA_1758980548
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269af520712so37680115ad.2
        for <fstests@vger.kernel.org>; Sat, 27 Sep 2025 06:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758980548; x=1759585348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmkIvQPM2ADXSUqY6gn5wB5OFGrkKwBAfwHOpfjikvE=;
        b=kpVD/h0s2eNqJB0nP2bco9y1iAmBB1a0KshkiOYG66p/f8fG2YKZoutMTrTc9hljti
         +yy9iIsNE8b4AJol83mZTfnvxYiwyWT4WDdIf08ZH9mRFxyIf+RB3pp4zH17h9C7cFqB
         /KluaNF7Zkfsnw40oAqSs3z7WeUY57zpH/j7vZdvqTIVin3CX7Op05McDS9SSJ6oz0lF
         7rqswfE6IC3jy/OMqaK0Avg3svhupqIyvdy5DC8wPWE08L6GPp8aoczqxj+HEqwahP70
         kKtFVIswY3wbCWmnVuDxxQEifmnpsGJu2jCR4AA6DCCJ1bGy2N+5QD4Q0e+rGrYQIA9O
         wHgA==
X-Forwarded-Encrypted: i=1; AJvYcCWsUYYgxZdMsTMkCPnaxl+W3gE1yprg3hri/cUxhBOT6mOgCJeqvXdJ0WbpeTFfIn5fAJCYqhQx@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDCkc5+BM9lvJ+ZPV1IaZS8RUeyO8Hdax4cPJjgKukPCfIHFP
	0P/cE1dy8VYHYMw8kBYk3itlXi5pKe11TKlN65W+BVIRIhCVwpNNfdz88aekTVNlUlkDQCgFcQf
	9edzhmgE2r4jCcD0N32ti46U9e8WlaAOAGaelSgU3YHCqmTiRpnp79edRDLc=
X-Gm-Gg: ASbGnctilbElCrsGjo5SdNECeMEA7UpgNlfU4pBDffjVvvAMds8oRPNBK9nCn8HIaqC
	fgtiEpzW9hzQE7XX93QpZlm1zWS3b1q/+YWHBaFCH6q9d5hgY7RqW87Vqazw+kR6AMfvuRSZnrU
	rrgjh2ktiH94mI4hHnUq31Uu/ylExOVz2jXYbPbX/ujSQ7fw51vp2/Tx2KttR1zsE79OMNzIg0D
	VjPjcoPWjXsJ7rkCo/tkM89Uh0eLqbEIVf32M7Hh4gzzZOpDD1g7IM/sp/sXj+KNXjSjk4s4Jlk
	f83S5Eh5LtztT781WGeTC50sexuUfbfF9h/gn0OIUWjbDXdpSTvWC0uLep2zlxG16eSB0aNEDni
	+XSZW
X-Received: by 2002:a17:902:ef44:b0:246:a543:199 with SMTP id d9443c01a7336-27ed596f868mr122801705ad.54.1758980547983;
        Sat, 27 Sep 2025 06:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB9dCScFCS3vj2Ifiurh+Svb1BBDypwlPwTMJaD8FpwkzjA3KPv0tqx1q6bqQCdr7SZyufPA==
X-Received: by 2002:a17:902:ef44:b0:246:a543:199 with SMTP id d9443c01a7336-27ed596f868mr122801445ad.54.1758980547487;
        Sat, 27 Sep 2025 06:42:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adcac9sm81400315ad.148.2025.09.27.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 06:42:27 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:42:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/513: remove attr2 and ikeep tests
Message-ID: <20250927134222.p4zss33wiydx7uve@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250925093005.198090-1-cem@kernel.org>
 <20250925093005.198090-2-cem@kernel.org>
 <U0YSQNAPJPxdjhRuMKtVrn5xeRxslOHWmqaK5CBJVb8e4kouZQJMwV5DuEzY7FXc_H284GanCX6ODMEH3OKxdg==@protonmail.internalid>
 <20250926153237.ahnp3bgdffsvz7qg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <apyibmyaeixj7my7c36ljib3sqkmjvttnpfyderar6erhq6qhx@xdox3y22d4pr>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apyibmyaeixj7my7c36ljib3sqkmjvttnpfyderar6erhq6qhx@xdox3y22d4pr>

On Sat, Sep 27, 2025 at 09:29:50AM +0200, Carlos Maiolino wrote:
> On Fri, Sep 26, 2025 at 11:32:37PM +0800, Zorro Lang wrote:
> > On Thu, Sep 25, 2025 at 11:29:24AM +0200, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cem@kernel.org>
> > >
> > > Linux kernel commit b9a176e54162 removes several deprecated options
> >                       ^^^^^^^^^^^^
> > 
> > I think this's a commit id of xfs-linux, not mainline linux. Anyway,
> > this patch makes sense to me.
> 
> Yes, because these patches are not in Linus's tree yet, I'll send them
> on 6.18 merge window. I just thought it would make sense to send them to
> fstests ASAP.

Sure, it's good to me to merge this into fstests at first, as xfs list already
acked and merged :)

> 
> 
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > 
> > 
> > > from XFS, causing this test to fail.
> > >
> > > Giving the options have been removed from Linux for good, just stop
> > > testing these options here.
> > >
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > ---
> > >  tests/xfs/513     | 11 -----------
> > >  tests/xfs/513.out |  7 -------
> > >  2 files changed, 18 deletions(-)
> > >
> > > diff --git a/tests/xfs/513 b/tests/xfs/513
> > > index d3be3ced68a1..7dbd2626d9e2 100755
> > > --- a/tests/xfs/513
> > > +++ b/tests/xfs/513
> > > @@ -182,12 +182,6 @@ do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
> > >  do_test "-o allocsize=$((dbsize / 2))" fail
> > >  do_test "-o allocsize=2g" fail
> > >
> > > -# Test attr2
> > > -do_mkfs -m crc=1
> > > -do_test "" pass "attr2" "true"
> > > -do_test "-o attr2" pass "attr2" "true"
> > > -do_test "-o noattr2" fail
> > > -
> > >  # Test discard
> > >  do_mkfs
> > >  do_test "" pass "discard" "false"
> > > @@ -205,11 +199,6 @@ do_test "-o sysvgroups" pass "grpid" "false"
> > >  do_test "" pass "filestreams" "false"
> > >  do_test "-o filestreams" pass "filestreams" "true"
> > >
> > > -# Test ikeep
> > > -do_test "" pass "ikeep" "false"
> > > -do_test "-o ikeep" pass "ikeep" "true"
> > > -do_test "-o noikeep" pass "ikeep" "false"
> > > -
> > >  # Test inode32|inode64
> > >  do_test "" pass "inode64" "true"
> > >  do_test "-o inode32" pass "inode32" "true"
> > > diff --git a/tests/xfs/513.out b/tests/xfs/513.out
> > > index 39945907140b..127f1681f979 100644
> > > --- a/tests/xfs/513.out
> > > +++ b/tests/xfs/513.out
> > > @@ -9,10 +9,6 @@ TEST: "-o allocsize=PAGESIZE" "pass" "allocsize=PAGESIZE" "true"
> > >  TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
> > >  TEST: "-o allocsize=2048" "fail"
> > >  TEST: "-o allocsize=2g" "fail"
> > > -FORMAT: -m crc=1
> > > -TEST: "" "pass" "attr2" "true"
> > > -TEST: "-o attr2" "pass" "attr2" "true"
> > > -TEST: "-o noattr2" "fail"
> > >  FORMAT:
> > >  TEST: "" "pass" "discard" "false"
> > >  TEST: "-o discard" "pass" "discard" "true"
> > > @@ -24,9 +20,6 @@ TEST: "-o nogrpid" "pass" "grpid" "false"
> > >  TEST: "-o sysvgroups" "pass" "grpid" "false"
> > >  TEST: "" "pass" "filestreams" "false"
> > >  TEST: "-o filestreams" "pass" "filestreams" "true"
> > > -TEST: "" "pass" "ikeep" "false"
> > > -TEST: "-o ikeep" "pass" "ikeep" "true"
> > > -TEST: "-o noikeep" "pass" "ikeep" "false"
> > >  TEST: "" "pass" "inode64" "true"
> > >  TEST: "-o inode32" "pass" "inode32" "true"
> > >  TEST: "-o inode64" "pass" "inode64" "true"
> > > --
> > > 2.51.0
> > >
> > 
> 

