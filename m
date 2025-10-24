Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094772C027B
	for <fstests@vger.kernel.org>; Fri, 24 Oct 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296483; cv=none; b=G9EJ3fp+E1jwZFgWR8PYWd6JHIwvTkZpvoxQFcOIeKLgC0z6kYJKje076gOjHpMX/DNpmsF8V6Skc+yIpueS/QfGlC8SQ6E+a19l0aIHoK7rXtiBhBkphRRzAQGXZaVP4Gx/MhLkajMDdMtdKwsVad9GukUiWzAINJGoVXPZ2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296483; c=relaxed/simple;
	bh=kzd8hR8ZB48TRf1FBLYy52ZbdXMgU2pQUI3oHfpkBtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Nm7QJZ/XLYhX/JAY6jtqSAJwofGkv7NccuISEAqKF1dPwQfCaDxAjBZNebsvwGwtbVCgY+N8lSRi1I+z2iPbBzE8/xJafFLzv1gzCstnyQG8DuN8GP+B6jtzakiqp3tL5HOhHaKtc0gK4XxkWnSr7lSINt2RVsNKDLQX3cnOIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmmN4878; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmmN4878"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27053843bso2587616b3a.1
        for <fstests@vger.kernel.org>; Fri, 24 Oct 2025 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761296481; x=1761901281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzOfaQD9roYcEhX3qr2200GMaOEmWqdNntaV+C+xDvo=;
        b=FmmN48785e4CoOH3n5OKyz1wzyowcEBIxngIdu6viSgpOh6bZqog7kKSWaVMX8wFOs
         AwQKnR51WVp0KQQ2Rkv+EZ7+Vk0fiOZT8uvXDIeSqZYzP1DZ8Wo04ndBJ3hn3lH+bpwm
         THir5zWbRxLgqy4AG8dcyYGlhxbEbE69kuX+YbFY892vpRqIoFtbaJ9B7tcXzvto3+Ta
         mfq2kNCfX51IR/bswYaPXPeCpmdenqIGdYJrzpcnWALJPGQDuTj/XvUaTTQOYR8zs18T
         1z4WHtf7RtwbHqWo7WvLYxxnZHNCkYhdCES622mEgaDIEmgnQXKyWlO76hVeTVCdbw4f
         TRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296481; x=1761901281;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzOfaQD9roYcEhX3qr2200GMaOEmWqdNntaV+C+xDvo=;
        b=VENjw6uyFuz5ajrArOGU/+bBOt2GYql8VQLldaXWybDnTWzDd7AaoOCTN8yHoszDoL
         dCQnKXZpnh0Y7RZPl0MwfwEq2QW5sGQB12FsefMiyHO396yEhr/6brRJCd42GWbIBXe/
         kjh/qebJ+aj0/TND/68X8PVbkFsEIwYd8qxCnoa8AlvPkcm6qazNjj8285ul8ejeLAfM
         9os66Jjf1wzy1LRloVHMyHAEQFL3o4K5eSYr7WQISuFXlXZji1GcrPcwIBAc6s6fM78P
         liNAJfyMEVAEA8vg2rKN1FT2VezGJK5dAxyc4UzSQRTh70lSNWVe1XLKybBeVfVuPvUz
         J1Zg==
X-Gm-Message-State: AOJu0Yyppv3GQfqatwuIZNYQt/XiOLsD48hiyCgaFpSR7Nri4S/Sz0XW
	L50vIil+dotC5Xsq/71dgne5mgbAc8CUgAU5/TKX9ZcaT14dDrMb39TZD/g+bQ==
X-Gm-Gg: ASbGncvBHVOU6noqHLWciSbfUhyU94ZSCX88O1KJnkimmhMe7H1vBT8ruwdCl3XHu7T
	gNGCjiXL/1669dNmmeZZ1b+RDtskFCeAYH0RxIiH5ija8cW+7UDM7hdoUQSpqlwBEgfxcVcaW22
	CLg4rUHWA3mN+dUQJRcjrRqjhKoFdUDnNOzDH++RbUIhKj+GwCyrIxNpd763Be8KAekTqAI/SQO
	eWvTX/Ps1yIU20W+THXyqQRDtLd8dfacYQZ9bWnRVkZEzL2b2GTTs90eeQIIoc6HPlLfKfCIzju
	WTKlgosyexGWKGsRf17TCrjzSGcdr8uKO48Hw3iZtpTvO4VFJI+ZMUMdcqeszv2NY/YBdyeJKIc
	zkUdSJzNUQ5d/UJXlTWtf8ovopJgmJoPuYS6ShHDy2nQGDREr9bHZzXXaytEZOjaLMygRCPOsEF
	JKfXGMqnsGxt5sNChrx+bZr6gPKzOYnB3CPMLHcXWDI55iSLACMInF
X-Google-Smtp-Source: AGHT+IEWrEXZsXwa1nm/Ns8JJ7ZzpHbBOT23EPNhXFS4lCF44h+6JLL3rQbtrCdZsowGvK3GciFshw==
X-Received: by 2002:a05:6a00:4652:b0:79a:f5eb:3dce with SMTP id d2e1a72fcca58-7a28686017dmr1852730b3a.31.1761296481235;
        Fri, 24 Oct 2025 02:01:21 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b343sm5215739b3a.45.2025.10.24.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:01:20 -0700 (PDT)
Message-ID: <95366976c8fee19ab2901c4b11fe5925042fdc95.camel@gmail.com>
Subject: Re: [PATCH 7/8] common/attr: fix _require_noattr2
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Date: Fri, 24 Oct 2025 14:31:16 +0530
In-Reply-To: <176054618026.2391029.1336336050566653412.stgit@frogsfrogsfrogs>
References: 
	<176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
	 <176054618026.2391029.1336336050566653412.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-15 at 09:38 -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> attr2/noattr2 doesn't do anything anymore and aren't reported in
> /proc/mounts, so we need to check /proc/mounts and _notrun as a result.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/attr |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> diff --git a/common/attr b/common/attr
> index 1c1de63e9d5465..35e0bee4e3aa53 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -241,7 +241,11 @@ _require_noattr2()
>  		|| _fail "_try_scratch_mkfs_xfs failed on $SCRATCH_DEV"
>  	_try_scratch_mount -o noattr2 > /dev/null 2>&1 \
>  		|| _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
> +	grep -w "$SCRATCH_MNT" /proc/mounts | awk '{print $4}' | grep -q -w noattr2
If noatrr2 doesn't do anything, then in that case _try_scratch_mount will ignore noattr2 and mount
will succeed. With the above change, we are just checking if noattr2 appears in /proc/mounts(after
the mount), if yes then the preconditions returns true, else the test using this precondition is
notrun. Right?

This looks okay to me.
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

--NR
> +	local res=${PIPESTATUS[2]}
>  	_scratch_unmount
> +	test $res -eq 0 \
> +		|| _notrun "noattr2 mount option no longer functional"
>  }
>  
>  # getfattr -R returns info in readdir order which varies from fs to fs.
> 

