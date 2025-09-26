Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68651D5154
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900962; cv=none; b=qmWIcWdnyqfpvy9lli0m4SBoB/gXNdNx6b4B5HTiCiRWR/xYBYxbw+LCVtST0gQPSlMvbCyMgec1LfqG90xP11fjIl1PLmi88NLcNgyasgwhwh+aDq37VQiMoYYbsHFyxVC+H6AgAiXfs4RbQKZG1juJpeCrPRyyNr+zmxB+M+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900962; c=relaxed/simple;
	bh=DIY1/K7PAISZ3lY0wenUqREBig6mZBSOUoa1uwmn2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVyL8ZM67UPC+Fw8A5pCaRGYmlY7QZfb7bPayAqlTuviYsBzMkzhgbZKvdWvMAbHmwLUEF4s3/MIPTrH/8/Ngu5o4FABFhwhxBeny6zKUffDPqcS2xuHtxv9s9IWYsf90aGsCsEP5c2LdmL1SvM5ujACG/ZztxY0v6337sgshoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfkncqrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfkncqrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758900958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMnZJwNq/Qh9pPuQIYwq9bT1GHx7kd5Vb/OSc2d1dpI=;
	b=DfkncqrTjQOl2CQ3xS3Jsxfl+ZYNNb7Ezpz6KWLQFjbakyrGPedCETyCtxzbGeyg8VqHVy
	DEAV6NPDBL2YEvaWfxkWKAdhQ3VtclvzPwrhR3QaatRwWxNNeTvx63qP5kV6oYIEMx1q50
	krvtYF8n6u4WY5xrk3O5bNyMnoSvIIE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Lh9_1tM7NfmLEx01xUP5lg-1; Fri, 26 Sep 2025 11:35:55 -0400
X-MC-Unique: Lh9_1tM7NfmLEx01xUP5lg-1
X-Mimecast-MFC-AGG-ID: Lh9_1tM7NfmLEx01xUP5lg_1758900954
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1988090b3a.2
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 08:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900946; x=1759505746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMnZJwNq/Qh9pPuQIYwq9bT1GHx7kd5Vb/OSc2d1dpI=;
        b=Ye8FT/uDyrLbaYUC7o+Q1wqHgvpmvy15WGgOKZGjA+QcdLF0hfAxgsCV6eDxcMMwgh
         K1f2I8XcZ0vQfw9U/XYcKQMO2EHtriiaIbXvM/oTkQXR8OGxhr3Xe8cwfFES/OFdBL+7
         fjhxCwPtnbMnArDPXdY4jjlNBECo+TSJhrohxrjWtELFH3pBQHtHAudK7qLN9GJUX+rz
         aBxizjdgbw1rdS7l5nRpn9ldsCZHmIKR0Zb4LHlFPMxPxKo1n8SpT4Tjdmv2PtPd0khM
         jzIIkUfvg2hZhoLgbi49w587sRgx1b6/VrP95UQEvJKdGq/PE1rwnN3zE2dLmhOVS8os
         IS3w==
X-Forwarded-Encrypted: i=1; AJvYcCV35FdGNRnfNyJ3Vz3Fwqjfj+yEXQnjJB+MJs+fuEv6Pd3ILB5m8/OwcKgDcQ06lxTxPtBcdorh@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfoVcFpWUvZFd7rLx1WzFWQeQCZZKuSMxe1dckzIlliGhBJkV
	hUlLxeUpHJhOBMbudAA/xAM1/kvAe299ABSyZdtSVlPmkYE1QWfNFYluGm3j+tjU1MEkih1H0vx
	2tiUHc8W7LWvxt10gOJ7zK5TKUK/rFW6e5Fr7jSCZ3vXqU9HyrKTuoluyjsE=
X-Gm-Gg: ASbGnctfpamJGfRIt11wRXdolspswF6lUkw5sWF3YAoLHhBIMFyaFljPkDMjuPogWCO
	lyeYrPyX9zG0SJXL7uSL3fQ9MHa1xcbi1XgvugIG8FA2+abj6/Pu7oHQ4rR5CwG3QahTbbL2Rpo
	FkczBpEvdITsTS7Mt7xwxFBegrOD3Ln2pRGJC+9KRZ0FabexEVJE08ELqTbTigq1sfJ4K/xcbVf
	D5b3KhzO4GbDIw+ytpvnwpy93+T7wrxkReRc8mAKjXSjVdV3aWacrEkb/D/nLnRtgveph0cIiwh
	jQrfnZR1a0aDMcJIZjIj99LPrGhNU2r8hdQiUR0EcMCKwTNpE4AXkFC5MrBM1fzuN+K7hpoWFMG
	+mfoD
X-Received: by 2002:a05:6a21:a8a:b0:2fa:52a0:e838 with SMTP id adf61e73a8af0-2fa52a0e86bmr1863147637.36.1758900946191;
        Fri, 26 Sep 2025 08:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcI6P0UwKryoSs2/8FpENei96l+FfS1D9JGd5pXUeSXa5ves2yT85gWQSP1/Q9ATYqMG6Hnw==
X-Received: by 2002:a05:6a21:a8a:b0:2fa:52a0:e838 with SMTP id adf61e73a8af0-2fa52a0e86bmr1863110637.36.1758900945648;
        Fri, 26 Sep 2025 08:35:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cdd1sm4667586b3a.3.2025.09.26.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:35:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:35:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: cem@kernel.org
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs/613: remove attr2 tests
Message-ID: <20250926153541.zemxeuidyugeh3v2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250925093005.198090-1-cem@kernel.org>
 <20250925093005.198090-3-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925093005.198090-3-cem@kernel.org>

On Thu, Sep 25, 2025 at 11:29:25AM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Linux kernel commit b9a176e54162 removes several deprecated options
> from XFS, causing this test to fail.
> 
> Giving the options have been removed from Linux for good, just stop
> testing these options here.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  tests/xfs/613     | 6 ------
>  tests/xfs/613.out | 4 ----
>  2 files changed, 10 deletions(-)
> 
> diff --git a/tests/xfs/613 b/tests/xfs/613
> index 9b27a7c1f2c2..c26a4424f486 100755
> --- a/tests/xfs/613
> +++ b/tests/xfs/613
> @@ -163,12 +163,6 @@ do_test()
>  }
>  
>  echo "** start xfs mount testing ..."
> -# Test attr2
> -do_mkfs -m crc=0

OK, as attr2 option is removed earlier than V4 xfs, so the _require_xfs_nocrc
is helpless for this case. Thanks for fixing this,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> -do_test "" pass "attr2" "true"
> -do_test "-o attr2" pass "attr2" "true"
> -do_test "-o noattr2" pass "attr2" "false"
> -
>  # Test logbsize=value.
>  do_mkfs -m crc=0 -l version=1
>  # New kernel (refer to 4f62282a3696 xfs: cleanup xlog_get_iclog_buffer_size)
> diff --git a/tests/xfs/613.out b/tests/xfs/613.out
> index 2a693c53c584..add534bd63a9 100644
> --- a/tests/xfs/613.out
> +++ b/tests/xfs/613.out
> @@ -2,10 +2,6 @@ QA output created by 613
>  ** create loop device
>  ** create loop mount point
>  ** start xfs mount testing ...
> -FORMAT: -m crc=0
> -TEST: "" "pass" "attr2" "true"
> -TEST: "-o attr2" "pass" "attr2" "true"
> -TEST: "-o noattr2" "pass" "attr2" "false"
>  FORMAT: -m crc=0 -l version=1
>  TEST: "-o logbsize=16384" "pass" "logbsize=16k" "true"
>  TEST: "-o logbsize=16k" "pass" "logbsize=16k" "true"
> -- 
> 2.51.0
> 

