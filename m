Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF631EFF98
	for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998188; cv=none; b=rC9Dfaij3irWxx7KIHIXf0hF39PYfJDLnXFFJBs0DZpq+I5AIA7falzUPcx9rZP408mQwr40bnuCzxCLi38UK3eVR56JACZW0bt4xUUElbvr5U3KYMtlV7a84fISAB9npZSiZcMG1X1aP+LxIiAb3LleW9NVJFuNGIEFWVMCer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998188; c=relaxed/simple;
	bh=UnGG0CkjVKlysVBOosVFmi6pYnhwDCGfRksrQlm9tdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1XY/hWUxQDAMLSJYTUNR0MuP78yDY5vmEBEMgRbyKreTqsHJs0wOnhfArbwMXr8YJZsWPdw/YCJRSHbWmd5ZFGNQTHfyDEgV3Z6Kt8hQQELTbmlmxA9+yhbB+FdIAyL4jFYHl4BDHE8CMGDGTX4/9TDTpIFNEA4qgY5O8vXwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izvaBOib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izvaBOib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742998185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btAjlbfP0qsWwuIvhUJP7zll2gojIYYhQbD3wLOGP0o=;
	b=izvaBOibRLwkSAGvyzrDXDQy1aIEIYT1faKkTijyJD0nd1J+VrPIaOiE6nAcvHOUrGXUjk
	doK5zA6YmuLL1BsB/rSPCpJcxDyQNzZKdom7dCPM1l9FtDEqtwnUqr6xor3yiuniKrV0vL
	8IuoMv3EpQJKoKzG7NNiL7jM2E42o30=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Ppwatnm2OTCyPyoShDhsaQ-1; Wed, 26 Mar 2025 10:09:44 -0400
X-MC-Unique: Ppwatnm2OTCyPyoShDhsaQ-1
X-Mimecast-MFC-AGG-ID: Ppwatnm2OTCyPyoShDhsaQ_1742998183
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so7055681a91.3
        for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 07:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998183; x=1743602983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btAjlbfP0qsWwuIvhUJP7zll2gojIYYhQbD3wLOGP0o=;
        b=UW8ijaW+lbsuL3ilpD6QSl5U0FApda3FYUd2YtMWtvf3IktGxEKoVYoUKMluOD6RCp
         557z9awgo6GRJvHEHXBTbdYsnxrbcShg9I2EqdhLWxqeIcnanQ49RvoNh/ZgiMDbT36w
         U6nVZjrG14iWGifFVl1T+4xAGKxQdFTpnzSHH7BY+Tp1n2W7tqA5BC3pEVQ9zsX1oiiS
         CaGwjNQDP/d0wm2L5cNRErZcBsRg7tIWqHENw+6II2L8KCDk6Y8WXgn54UsyohUJxu3g
         QQxFoOBMBnciWqMjAaPXMUU/37ZFPLDGUB92Mp7Iwcv2Qk4x713n/UZ6/lxwcYJ0Yk4B
         djbg==
X-Forwarded-Encrypted: i=1; AJvYcCWNeuA0E148abjdHFgWMmRY+BeXSMrtWlkmE1Zl6wvNjuO8uArQP+t+5DrQH2Q2Y8zmctwlqPC5@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCRjcLyhR/3o+CsXl786ZeLI/1OZlTigTTMwdX0vISkmdtrPV
	vl1DP8QILBnSUcUjyshsNU1xg+Absijr3y6jfUq5X0vX5xJPhV4KNK5MNigFexQ0U0Jd6tNnARY
	o8BT2IVbLv8nTrjHVQxa0axLrHSy5d2EzodsKPnJhAjyWmAvgKxPMkjY=
X-Gm-Gg: ASbGncukluez8J3vIm4P0ubzo8kqdPY9OeUcwoCUXvzHxrQAG6BGjsNLPaZ1XQXWhJp
	wIKigha1leTJaBkjpCfskLKHqwr+XGZHSYgDfj8mU0KQ8P1KezjQCG0QHPtJpq2cnVtLVbjsnVA
	Oa7QZCg//lFiilZqEmxE41rc8VaRTPrC6OFjC6NVKZnKkS8ge8H7Bmh0i1Y+nQ8wywBkoW5Zyvp
	EMZOt2NQJ5He4sMtpOYuvbfE6dZTZJPDIsHrBjzazsqjnQTeyCdAb37wBgbCBHqyIbteGIMlDKZ
	ZDVOGNlZbWPm+qDr31Dv83s9CqUtoeKEbsvTRToMeQCzlai3NPk/73Ze
X-Received: by 2002:a17:90b:4b10:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-3030fea7630mr34272175a91.11.1742998183096;
        Wed, 26 Mar 2025 07:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMzeBEP4vk/5dY02h5nJIzj4llSMDx8Ecfe3gpOVEelgbpIBmabZiPiSqtNOthMzsCpegSHg==
X-Received: by 2002:a17:90b:4b10:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-3030fea7630mr34272143a91.11.1742998182581;
        Wed, 26 Mar 2025 07:09:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039e20e4dcsm205889a91.27.2025.03.26.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:09:42 -0700 (PDT)
Date: Wed, 26 Mar 2025 22:09:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/011: test to check out-of-space issue
Message-ID: <20250326140938.6ll7yeez6iwabvgi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250326120341.3641535-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326120341.3641535-1-chao@kernel.org>

On Wed, Mar 26, 2025 at 08:03:41PM +0800, Chao Yu wrote:
> This is a regression testcase to check whether we will handle
> out-of-space case correctly during fallocate() on pinned file
> once we disable checkpoint.
> 
> Testcase:
> 1. mount f2fs w/ checkpoint=disable option
> 2. create fragmented file data
> 3. set flag w/ pinned flag
> 4. fallocate space for pinned file, expects panic due to running
> out of space.
> 
> We should apply commit 48ea8b200414 ("f2fs: fix to avoid panic
> once fallocation fails for pinfile") to avoid system panic.
> Note that it only fix the issue for regular block device, problem
> still exist for zoned block device.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/011     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/011.out |  2 ++
>  2 files changed, 60 insertions(+)
>  create mode 100755 tests/f2fs/011
>  create mode 100644 tests/f2fs/011.out
> 
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> new file mode 100755
> index 00000000..1ece8fd0
> --- /dev/null
> +++ b/tests/f2fs/011
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/012
> +#
> +# This is a regression testcase to check whether we will handle
> +# out-of-space case correctly during fallocate() on pinned file
> +# once we disable checkpoint.
> +# 1. mount f2fs w/ checkpoint=disable option
> +# 2. create fragmented file data
> +# 3. set flag w/ pinned flag
> +# 4. fallocate space for pinned file, expects panic due to running
> +# out of space
> +# We should apply commit 48ea8b200414 ("f2fs: fix to avoid panic
> +# once fallocation fails for pinfile") to avoid system panic.
> +# Note that it only fix the issue for regular block device, problem
> +# still exist for zoned block device.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}

Default _cleanup does the same things, so above _cleanup can be removed.

> +
> +_fixed_by_kernel_commit 48ea8b200414 \
> +       "f2fs: fix to avoid panic once fallocation fails for pinfile"
> +
> +_require_scratch
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
> +_scratch_mount -o checkpoint=disable:10%
> +
> +pinfile=$SCRATCH_MNT/file
> +
> +# simulate fragment status in f2fs
> +for ((i=0;i<256;i++)) do
> +       dd if=/dev/zero of=$SCRATCH_MNT/$i bs=1M count=1 >>$seqres.full 2>&1

We'd like to use xfs_io when we can:

$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full

> +done
> +sync
> +
> +for ((i=0;i<256;i+=2)) do
> +       rm $SCRATCH_MNT/$i >> $seqres.full 2>&1

How about "rm -f $SCRATCH_MNT/$i" without ">> $seqres.full 2>&1" ?

> +done
> +sync
> +
> +touch $pinfile
> +$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
> +fallocate -l $((3*256*1024*1024)) $pinfile >> $seqres.full 2>&1

Same, we'd like to use xfs_io at first, due to it's already a necessary
running dependence of fstests.

$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
> new file mode 100644
> index 00000000..62e02519
> --- /dev/null
> +++ b/tests/f2fs/011.out
> @@ -0,0 +1,2 @@
> +QA output created by 011
> +Silence is golden
> -- 
> 2.49.0
> 

