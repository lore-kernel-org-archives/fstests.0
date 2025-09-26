Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906420FAAB
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900768; cv=none; b=qMnrojGcfmi9DGc9MFoaYul4VRYEuvWJhTJ2CxTQag+Fr6D6f7PyZGiTGTPuT2Pz0y1R5efIWgfUn/TBymjZalmLzF+bMyJA4h7mrVFkmGN8UyXCsmDmK03HEgow4OVihQ5dGTjY/rQn6m5xyaHMale6Ea58lCcnDjnpp/0whlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900768; c=relaxed/simple;
	bh=iHBsle/PF400EdNWEOqnnzEPMWPOeRO4DHoDpAmeaTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi5UmPC2VvyanelIbL10MQpcLuVtoicJZSL/ZaCQ8LnFXPuyY0F/LoEa8Rl6OdU5vQIGXu9wDd1W/nFaiMfmyHrzeZgrb+aGq2igsTsB/UiEHxCWmAMaiTgPyNwolbp7l5+ZFuTnTzhIfVZxnN/xjT1A1FHMTs7AGvWuicWo14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxnnbhFc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxnnbhFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758900766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+riQc1nH3P9rKBcSwd/ARgsG28q7KMLr3lc717Ft7tE=;
	b=bxnnbhFcpRHJOsTW5S5Qmnc3dRfGfreIHkpKST4hUrp/z3y1Y0Ahsch9Zv2wixVcpLpowQ
	ogcXkWw9Ycdk1B+7XT4a3p1uqN8kPTI9uZo5K2Ik9qDDdXtjgOzQD4xVpKtArF4EoBrrOr
	AIuNMOlp45465uhGx7oa3KBS5erks9c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-L9Ncr5X4NbuNV9sb-9tIqw-1; Fri, 26 Sep 2025 11:32:44 -0400
X-MC-Unique: L9Ncr5X4NbuNV9sb-9tIqw-1
X-Mimecast-MFC-AGG-ID: L9Ncr5X4NbuNV9sb-9tIqw_1758900763
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6ee6so28266675ad.0
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 08:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900763; x=1759505563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+riQc1nH3P9rKBcSwd/ARgsG28q7KMLr3lc717Ft7tE=;
        b=AQ0ggrfnB5ZQv+4Gk2+NL1OYNJL7IKCP75H4xQr+HdyqJqh+SqRWBEdOG0H2m4dCfx
         qYhjuPjurNRv97od0WWML/TehIwpFyZUlNebmOoc+zFrbelI5EA6yn71AoT9NFaUGmQS
         t8JpjtaDJlmCVMNqChje0P5FSW2B30FAnirxeYm0Ivq6OISUhO3ozH8PhNOhQpKFYU0s
         KG1+y+eG+KYW4zEbnYHcP4xk1SonDZDWNsABfQ6DbSWtXVXYD8BzQJJtEWuT3Z7Mdi2/
         bzGREpE2LC8EGdcFNF6kam5N9/73mAWhWl2410GPRuGL1zdO4NMmtr62GEGnVhWAvJF3
         HfFw==
X-Forwarded-Encrypted: i=1; AJvYcCUuz7Lkn4n0MD7wXNPPimsYW13Ktq/gMTNH+QXSRxK5X4A8shlm9I2jiKQwiCgriizBi2nh3JQj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1PZjTBELzFvwsz7yd221MlMzVX309o+tARLLL14RaxTMCOjc
	HfiBMvW6c+KXumsj/4YYT2kwZ1tVdCe4MacgnQsai3wrZ2eWga8wi5etOi4O3GWLbAiNhu3hKxy
	w45DIcueZZabODcusRZ+1r2x9h6sSYFsu19vNg468FmcsoDW4T0VOZVLGtAU=
X-Gm-Gg: ASbGncssbuUHq7GoV/TIqmYzNtV18hHKPJYd2PNPSzTSbTYECGInKW/eeu2qGOxYC9I
	L0zNgaJarQISXxA7dp9NcFsW9/cDqZFexB+vqCInbAP3mPvO0vpmKlcihojP45w6r8a3Jxm2QJP
	A5FEq5yTQjtGxsaYZRYqh9G2lWD4vp653ry9nN5XiUM/at9/X54nmA2ZvnfTiDXG65efdRNTogK
	w53iURWgUlxYycS8/+J1cNnyjL6HOvTTLM1eNdj2ieETOsFvREl4hI2J44EsgwxW62sHSiJlBrw
	gop1dJ35OS9+99OyOHabmqkYdejLfa73FUs6j0P1Xr0glps0j94q5oMYq4hKzoSk0Mddw8hKyzK
	m2sZZ
X-Received: by 2002:a17:902:cec8:b0:267:af07:6528 with SMTP id d9443c01a7336-27ed4a7a906mr83937795ad.35.1758900763283;
        Fri, 26 Sep 2025 08:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8/e+bmRY+b74cXpOoLc6CCunniKjfMbLQ91zg2oMGqXklN1xWjut0cLrb2FpFlG8yXupyBA==
X-Received: by 2002:a17:902:cec8:b0:267:af07:6528 with SMTP id d9443c01a7336-27ed4a7a906mr83937505ad.35.1758900762783;
        Fri, 26 Sep 2025 08:32:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69959e1sm57225105ad.103.2025.09.26.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:32:42 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:32:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: cem@kernel.org
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/513: remove attr2 and ikeep tests
Message-ID: <20250926153237.ahnp3bgdffsvz7qg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250925093005.198090-1-cem@kernel.org>
 <20250925093005.198090-2-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925093005.198090-2-cem@kernel.org>

On Thu, Sep 25, 2025 at 11:29:24AM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Linux kernel commit b9a176e54162 removes several deprecated options
                      ^^^^^^^^^^^^

I think this's a commit id of xfs-linux, not mainline linux. Anyway,
this patch makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>



> from XFS, causing this test to fail.
> 
> Giving the options have been removed from Linux for good, just stop
> testing these options here.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  tests/xfs/513     | 11 -----------
>  tests/xfs/513.out |  7 -------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/tests/xfs/513 b/tests/xfs/513
> index d3be3ced68a1..7dbd2626d9e2 100755
> --- a/tests/xfs/513
> +++ b/tests/xfs/513
> @@ -182,12 +182,6 @@ do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
>  do_test "-o allocsize=$((dbsize / 2))" fail
>  do_test "-o allocsize=2g" fail
>  
> -# Test attr2
> -do_mkfs -m crc=1
> -do_test "" pass "attr2" "true"
> -do_test "-o attr2" pass "attr2" "true"
> -do_test "-o noattr2" fail
> -
>  # Test discard
>  do_mkfs
>  do_test "" pass "discard" "false"
> @@ -205,11 +199,6 @@ do_test "-o sysvgroups" pass "grpid" "false"
>  do_test "" pass "filestreams" "false"
>  do_test "-o filestreams" pass "filestreams" "true"
>  
> -# Test ikeep
> -do_test "" pass "ikeep" "false"
> -do_test "-o ikeep" pass "ikeep" "true"
> -do_test "-o noikeep" pass "ikeep" "false"
> -
>  # Test inode32|inode64
>  do_test "" pass "inode64" "true"
>  do_test "-o inode32" pass "inode32" "true"
> diff --git a/tests/xfs/513.out b/tests/xfs/513.out
> index 39945907140b..127f1681f979 100644
> --- a/tests/xfs/513.out
> +++ b/tests/xfs/513.out
> @@ -9,10 +9,6 @@ TEST: "-o allocsize=PAGESIZE" "pass" "allocsize=PAGESIZE" "true"
>  TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
>  TEST: "-o allocsize=2048" "fail"
>  TEST: "-o allocsize=2g" "fail"
> -FORMAT: -m crc=1
> -TEST: "" "pass" "attr2" "true"
> -TEST: "-o attr2" "pass" "attr2" "true"
> -TEST: "-o noattr2" "fail"
>  FORMAT: 
>  TEST: "" "pass" "discard" "false"
>  TEST: "-o discard" "pass" "discard" "true"
> @@ -24,9 +20,6 @@ TEST: "-o nogrpid" "pass" "grpid" "false"
>  TEST: "-o sysvgroups" "pass" "grpid" "false"
>  TEST: "" "pass" "filestreams" "false"
>  TEST: "-o filestreams" "pass" "filestreams" "true"
> -TEST: "" "pass" "ikeep" "false"
> -TEST: "-o ikeep" "pass" "ikeep" "true"
> -TEST: "-o noikeep" "pass" "ikeep" "false"
>  TEST: "" "pass" "inode64" "true"
>  TEST: "-o inode32" "pass" "inode32" "true"
>  TEST: "-o inode64" "pass" "inode64" "true"
> -- 
> 2.51.0
> 

