Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF051C55
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 05:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010853; cv=none; b=K/z3QXQ5GT7x/zf+4VqTrE0uRWURFaowOPNl5rTonujw3lIBl4IJyI90M+FCR+RCdfqvV8foz0LJDWd1xgJGD5VfJs4vXdHOQ1GRLfbh61/+jsABWOFxumNW4LkSK6/iC8Bc2eMkw0HpZToH2BMpfhfZxG+M0G1pQ9nb+B4gevc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010853; c=relaxed/simple;
	bh=/0ntdVjkbi+CFlHclQOoQkuKrd0kUByzbCJtOpR+7rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjL4D7oJ1RGzvjF5yzmL06d45Lh/uYQtM4f/qId0wBut1AVNte3itNTGJozaA3wvRmgZQp2IPzIrbBcH7FW/NXL5C73RYU4Osb9uzSkIBkEN1YKBhhoaGs/ulDlsj3VV3uVGOHjMFb+0Yic+Oxm4yxWtQN4nZVgTaZPE5yzBAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3XFLPTc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3XFLPTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709010851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voNUIgVYueACsrhZm/2IQh1bgotBWzE+hcOWy4uWZbk=;
	b=g3XFLPTcaE8m1e2mcGCmjZNrGcpuAY8ct/twIxkPsW5xDXeDL+am429Qo/wMaOmPYeaFr1
	8rDm9RzZh3sXiWuv3zMI5gTNSsXdSLKRVO65/5F/Rfew4zgc9LNrwczy93ZQhtiWt5yYbk
	YPPiVEyMIo742+8vJhaIUdjd0QZ079s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-qTUE4DggN5SxdhNuzVb37w-1; Tue, 27 Feb 2024 00:14:09 -0500
X-MC-Unique: qTUE4DggN5SxdhNuzVb37w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e4e4572980so2886959b3a.3
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 21:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010848; x=1709615648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voNUIgVYueACsrhZm/2IQh1bgotBWzE+hcOWy4uWZbk=;
        b=vzfISpOalPNNx+5WJfdP4Dg5hRZX5i9oLaIDvUS11gbjOIT2J2OmPKEAoeybbZk8RB
         KsHGA4wzrdnIZjFEyEzbYvXrYFi1MDSe1nGX2wni5y4ySWRubDrON6PDFdC30PPlecla
         XRSynZYDVSlBOSFPmIhhGNp2kuCK1dTYYmF/NU7hemdqpQIy1bLMwbQKYfH6AYpt9eNF
         95Ggqo4ppvWduWABWblvidV9peX7Qq/IRg3q1veyYUMJyPfppx2b+hhCXCUdR4be9HBJ
         uLwzaf2swaDv+K1ReGGcWWi3mG6VG/Qu5LJFgnU+3qo36x3yEUv0eLWWJ4IQL+VCesJa
         UGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjQnqyvqHDJ/Y7uDcq7mWju7DtTB30D7nuGLTbqVJFrJh8SJbIB/07MblrM8+eJzxotdomNbEwYtSiGAjP7y3Pb2q5kKeJow==
X-Gm-Message-State: AOJu0Yzd0fmuctWjk8EMk6BfQp9tg5jg+5MtVK+WJMwPdvn/Yjrt+A3h
	mZmFTepdy4L+SqstuaVMjV0EnrjjSYU/Fd+jlLeOcj0/Kl5xWYfNNQTrFIOzE3jDSa+H10dv5tj
	afAfig33jyAQJZWMVw/4D1U87emlQKtH/CDU505tiWRMlw3xVsuOd1NE=
X-Received: by 2002:a05:6a00:6ca6:b0:6e4:d354:160a with SMTP id jc38-20020a056a006ca600b006e4d354160amr13088411pfb.1.1709010848661;
        Mon, 26 Feb 2024 21:14:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAOd1rpJB+9Fukyy1m2hJ04OD1979pCXa69r2TU55j5qlVTm3BgPIwlv5Icp3TF/4kAnH9kA==
X-Received: by 2002:a05:6a00:6ca6:b0:6e4:d354:160a with SMTP id jc38-20020a056a006ca600b006e4d354160amr13088398pfb.1.1709010848332;
        Mon, 26 Feb 2024 21:14:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fk7-20020a056a003a8700b006e469a6ca72sm5150845pfb.15.2024.02.26.21.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 21:14:08 -0800 (PST)
Date: Tue, 27 Feb 2024 13:14:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1.1 2/8] xfs/155: fail the test if xfs_repair hangs for
 too long
Message-ID: <20240227051405.tf4gupo26yjzbqe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915247.896550.12193016117687961302.stgit@frogsfrogsfrogs>
 <20240227044100.GU616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227044100.GU616564@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 08:41:00PM -0800, Darrick J. Wong wrote:
> There are a few hard to reproduce bugs in xfs_repair where it can
> deadlock trying to lock a buffer that it already owns.  These stalls
> cause fstests never to finish, which is annoying!  To fix this, set up
> the xfs_repair run to abort after 10 minutes, which will affect the
> golden output and capture a core file.
> 
> This doesn't fix xfs_repair, obviously.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v1.1: require timeout command
> ---
>  tests/xfs/155 |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/xfs/155 b/tests/xfs/155
> index 302607b510..3181bfaf6f 100755
> --- a/tests/xfs/155
> +++ b/tests/xfs/155
> @@ -26,6 +26,11 @@ _require_scratch_nocheck
>  _require_scratch_xfs_crc		# needsrepair only exists for v5
>  _require_populate_commands
>  _require_libxfs_debug_flag LIBXFS_DEBUG_WRITE_CRASH
> +_require_command "$TIMEOUT_PROG" timeout
> +
> +# Inject a 10 minute abortive timeout on the repair program so that deadlocks
> +# in the program do not cause fstests to hang indefinitely.
> +XFS_REPAIR_PROG="timeout -s ABRT 10m $XFS_REPAIR_PROG"

I'll help to change the time to $TIMEOUT_PROG when I merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  # Populate the filesystem
>  _scratch_populate_cached nofill >> $seqres.full 2>&1
> 

