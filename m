Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C44ADD89
	for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005984; cv=none; b=rMe3luf+yp61bOLuxFb3x2yGmZBmnkaM4EegLIe3B/DtnjbCYlukpwLXdTnOEdMvZTLBce+FlylL6DMdn2zXmtib4BytntVHzYYhsCtgVaBfltJfX6Ir4TqxlDujP2b7BByBzeKgJIFuFcPFl1cMJHphOkR+ajqiHUMDIxv1+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005984; c=relaxed/simple;
	bh=ddppiMTLoiGM3Hl8siANnc8eBtMPbi1uRzJy3PZZ0rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L54kAvXrPWDfyxxqv+B6oqbaWyDO/oy6QuD/XG/rWumsjKdxkxv8Mm1827rBS80qUttFjEEKDWUjl8PxUK59ieJ8YoqDswMuASe5Oxmg94xAsOrLoj/5reZkAcarelbqyBY/zl/5QEoUfm7Yz+Knz4kLRbVJh5/81JtUfVjc3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcMVcQxM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIHxH3Qv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcMVcQxM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIHxH3Qv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769005981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VL+/iVqESUmv13R5ujPhwXjFR8oMqK6nvHaKLtQR0EY=;
	b=PcMVcQxMh6B4PPech8oY/h4eGt0AS9uhJ7WZqvHAj15BGWIkWX2GeCOVFPjlfM481IAVy/
	ApKEDgFn20YA544PtoPv7sKknEA/YVWbZLIwcTZskA28j1Qphm6ZDNTUM2Tn253U2ljcvx
	+s5kDq1sBET7fjGfucrpm/y+QtHO2gg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-gIGehurpPBinpAuFFy2DPw-1; Wed, 21 Jan 2026 09:33:00 -0500
X-MC-Unique: gIGehurpPBinpAuFFy2DPw-1
X-Mimecast-MFC-AGG-ID: gIGehurpPBinpAuFFy2DPw_1769005979
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7dd05696910so3993943b3a.2
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769005978; x=1769610778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VL+/iVqESUmv13R5ujPhwXjFR8oMqK6nvHaKLtQR0EY=;
        b=JIHxH3QvV0qCx3X8LEWbAACf5QleLkc2CBri4XxY51d8nxNPrEbdHggtGr4bHhfJ75
         L0p5w0MrNYRMvvsotJJ/JIkoREUEytsKxQ2WC0qBQchx9XAdjzgVcgU6p8UIYdqn8Y6q
         1dSPV/qVBtcBSqfTXehATw339qoBFlP8NeC9L4hhhemeNjPtx+Icesil0nHx/Rwa+qWG
         pVMl65oQPqZOAe5gHIAqvqvw0Pi+e/NC//rG9ZUjcutngfqu5JuHMr4MBDnkh8nw5mag
         sSPbSylrN5JdUscckXKTD57uvz8LzESgZPNxCnDk9MCcfln6ctsNtPJESTjMZLFc9LAY
         nNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005978; x=1769610778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL+/iVqESUmv13R5ujPhwXjFR8oMqK6nvHaKLtQR0EY=;
        b=SGFjyA5C+wyYvRq8jOlpWBNb859gRxcs/fj4j4LOki1xBmcyjvWLS7/GboWPqE3P2P
         vM84MZWQ0Y7jzHN29X3dmyDVRLP4V7b++Ko/xUwQGZ9u+ia1o5VuEqgl/L3U2V6gAric
         Z0ZqXK0C/haKXMCq2/AlLMM67+16r1w9gLj7Wj67lMy6jgHMdKgH6wKgKCfif9RQ2728
         MMel4ykm4+ZgxFL7GDJPmfbdGF0ylHlOHVsDMFQs/IKwPKBm323O1XUXq+xrSFFPBUGV
         CmEu47goSQYsJQ2NiWByYHJn7Dkw91WIdrmSiFrdIxaCS8ntPoomfrmn8u2cl6rd48Vm
         zt0A==
X-Gm-Message-State: AOJu0YwAvJN3ByM/UCHb3Eh8ObfUTwt9p0nZV81SZUv/q7lRJuqMV1fS
	fm0vbnX98X9tJ7YUyPtNHTnZ7eVqHLlEnOV1XDbgT5E0Yf1OpzSiy2IxUsAz5Yk4lLJtrm2mW/z
	MUMx3c3XQ9U67VMoFfZW24Hawl3yzMC0Q/S9PynvzgaWXO6x5hO4Va3T3gQoDO2b9s5Vzdw==
X-Gm-Gg: AZuq6aKWuxPEjt5aWlLGZFkOwR/aLTy2wco1i8D6d0kTzJ0HRNXGiIZGwCehY3xFHuO
	Lw5ITQLtmcmOj0Ejn9Ijc+M3CpaxEasKnEhOWIXzVgTKz15fKTVO8C7cyjfWrDoYjcqiSq7CddD
	mB9vgApG6lOOGURWokpD9nsDEZ4ZCBZlSKmlaAITtf1NzP4J8cwoqgRx7NMU5Np1tKgJDJ1ij6X
	FPXabS7pRkzlNb4Gdttkw9Y49Qk9itYtf1fz2+dKOKk8dIgNTxwbx4UbE4EoEf9KuQ9KLjUd6n4
	hyl0V6oYJl2Xpxz+e8NnKhmPGgPoH8/xGe0RCFCQzf/Vfu2MK0pwZawjTDndhxuuCT0MB9MUsCC
	MVlKBD8Nm0WRpKAA6FeClAMtkF+cpml3QiBjEHBYbdhHRzsVbRQ==
X-Received: by 2002:a05:6a00:244e:b0:81f:4e60:1c6f with SMTP id d2e1a72fcca58-81fa0348286mr15576503b3a.64.1769005978496;
        Wed, 21 Jan 2026 06:32:58 -0800 (PST)
X-Received: by 2002:a05:6a00:244e:b0:81f:4e60:1c6f with SMTP id d2e1a72fcca58-81fa0348286mr15576471b3a.64.1769005977924;
        Wed, 21 Jan 2026 06:32:57 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b50fasm15243069b3a.64.2026.01.21.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:32:57 -0800 (PST)
Date: Wed, 21 Jan 2026 22:32:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: caokewu <caokewu1@uniontech.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/307: allocate donor file size dynamically
Message-ID: <20260121143253.57aihtsht2wiiyge@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <996DAD8F7CC08BFC+20260119055411.1573173-1-caokewu1@uniontech.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996DAD8F7CC08BFC+20260119055411.1573173-1-caokewu1@uniontech.com>

On Mon, Jan 19, 2026 at 01:54:11PM +0800, caokewu wrote:
> Currently, the donor file size is hardcoded to 250M. fsstress can generate
> more data than this limit, which causes the `e4compact` helper to crash.
> Specifically, `e4compact.c:do_defrag_range()` contains the following
> assertion:
> 
>     assert(donor->length >= len);
> 
> If the donor file is not large enough to accommodate the data being compacted,
> this assertion fails (or validation logic rejects it), causing the test to
> fail unexpectedly with an abort or error.
> 
> Additionally, the previous 'usage' calculation used `du -sch`, which outputs
> human-readable sizes (e.g., "1.5M"). xfs_io's falloc command does not
> support decimal values in length arguments, leading to syntax errors during
> file allocation.
> 
> Fix this by:
> 1. Using `du -sm` to calcuate the required size in integer MB (rounding up),
>    avoiding decimal issues.
> 2. Allocating the donor file using this calculated `usage` size instead of
>    the fixed 250M limit, ensuring it is always large enough for the operation.
> 
> Signed-off-by: caokewu <caokewu1@uniontech.com>
> ---
>  tests/ext4/307 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index 1f0e42ca..48073347 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -24,9 +24,10 @@ _workout()
>  	_run_fsstress $args
>  	find $out -type f > $out.list
>  	cat $out.list | xargs  md5sum > $out.md5sum
> -	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> +	# Use -m to get integer MB size to avoid decimals (e.g. 1.5M) which xfs_io rejects
> +	usage=$(du -sm $out | awk '{print $1}')
>  	echo "Allocate donor file"
> -	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +	$XFS_IO_PROG -c "falloc 0 ${usage}m" -f $SCRATCH_MNT/donor | _filter_xfs_io

Haha, I suspect the author of this case might forgot to change the "250M" to "$usage",
otherwise, why calculate $usage but never accually use it :))

Anyway, this change looks good to me. If no more review points from ext4 list, I'll
merge this patch directly.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	echo "Perform compacting"
>  	cat $out.list | run_check $here/src/e4compact \
>  		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> -- 
> 2.51.0
> 
> 

