Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130741C5D44
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559978; cv=none; b=XnUgYayenX0oQq56OJR/UYJvivVttau3UGjqnm/B7DSje/j3bHFno/SV5Nj1HxvCMmcWtzb2NrjXE0OgFZ3784IJxNFdtGQFYphzikAgurJH8oyrOxIdIYiErGWPaGB5Wzh+7vYvjbi8s+KZLMFXKvOMnj5b5M3mzN8CBy//eIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559978; c=relaxed/simple;
	bh=LvObEHWsQF7hF5FIl1fkRgo6awFX8wq3UZYuzJX8o1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCHOM30GvezqznR0y4vrKw4Idso7FGIMi+OUJOOb/2RTujxfANgHyefIlu7SjSQrc5LFYZ12cH/NvvShjKL5fISdFiGyalQNB/J0R0AH0QBagtBWIPmuYZvNwZqCDwMsNgT8wqps4TzjLH6NoulM08LeySI3hzUbhcku99wMBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmsOvY7+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmsOvY7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746559976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rS96Ut7wQKZkL1iY8HQWTUupzrZlbLDUMN2/a/FXfg=;
	b=OmsOvY7+4z2TEYTgW3sXeft1Lz9H6W+sxTjFFqL+tBj8e8O5s1B1D2WQFzFloJl8svZr6A
	iUznuiuGJlf9V7YFpvRHRpVEbJ2QZkQlX6af3l0gLZ9FmfTiqeozqgwT2qXdPmFrwW86tr
	HTKwCo5qE/ptTJ7xzX5Hz/1V2P4+FBE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-PMaOBZm3OiOwscxGBcaG1w-1; Tue, 06 May 2025 15:32:52 -0400
X-MC-Unique: PMaOBZm3OiOwscxGBcaG1w-1
X-Mimecast-MFC-AGG-ID: PMaOBZm3OiOwscxGBcaG1w_1746559972
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736b431ee0dso4452656b3a.0
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 12:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746559971; x=1747164771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rS96Ut7wQKZkL1iY8HQWTUupzrZlbLDUMN2/a/FXfg=;
        b=pP6IlYbmReBhjpCgVC90EDaf/zeb/UMVArPeKscDEulBNc5lbji5xIUXVhoyMZR7ju
         4XIA7kRyyke5yKfxb/6zFuGkhzZHv4n6FF8nsiRU0ul0ZVWGxdOe/E396xZI7so+jQUA
         uWJCE/C0YHUHV3Ue36v5IfzYCwChRkgqpaPz0xePIndUod61zcJExqxQH1bEtFaC8dpV
         K32ZCIR29WjTwSFMFl5nD3jM57+TrxRH1ZqhFG6ZHk1nmgjnFkMBSy2+Xv1W8qejGF+V
         OcHNpKDgxFHPeVYVjMnevcGTzopqlzpu83hRkcvyTQZwvJgtXdRwVH1gSv9WPn2AaITV
         WCPw==
X-Forwarded-Encrypted: i=1; AJvYcCV2aBRkni2BCEdmFdjeXfM05y3XE8sUlgVEdkBlk0dGKPmRk9vYYsDWZtIwd3VGbQaV2VKkrAdA@vger.kernel.org
X-Gm-Message-State: AOJu0YwcM9B7x6bPW+m732i5surHCQ8wC7jI/pIRjGVCxU1gbhcBcODW
	YwUf+xvc4q9mt9Ua5c2uiohK5fFahj7/28vvbClDsVPNDW6ccIWThSkIN2tQwxaUp1QX/epV+uE
	thCYvUHMlACHhWKACR5/oMHbsWVqYpEDlPJmKZ/9I6nWnI1oMor8uzz0=
X-Gm-Gg: ASbGncvSIm3PmXzXh1xsr3GKwrB5WZUt3Eo0I83G47LWpXQbnH/e3bCl2BmDvwvILVI
	iYkbyiuoYi48qW3S/95B5RT2KZWr+A6FmjzTOan+lVrtrbbzJtlAzvtmzXkWlpDpSZtvzUiugI/
	JWCQPviA6TCkYXF8V5H83+HsHjTIdSJkJalVLnuhVVWevI8z2ivKHZqD8EVzoJ0zwwkW0GILABI
	IoK3vbnwMqWh0IWzPldOnvoHy5zhvZQoE0MpwbZaBwLTY7IcBwHxpBjo2cIbNV3cZKieY4I7UV/
	9kNRei7PiBdizfcaWdSB1KliuTkEtfmT7uP5IxKBzyyI6dcZih+O
X-Received: by 2002:a05:6a20:438d:b0:1f5:6e71:e45 with SMTP id adf61e73a8af0-2148d01196emr582953637.27.1746559971708;
        Tue, 06 May 2025 12:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg0YCgxHV0BEAyMABjhQdsZGlqhgZpNpKUUikDx04PLugplHWPn9yp+GvNCpQXlk7HvoLoMQ==
X-Received: by 2002:a05:6a20:438d:b0:1f5:6e71:e45 with SMTP id adf61e73a8af0-2148d01196emr582925637.27.1746559971296;
        Tue, 06 May 2025 12:32:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058b7e30esm9338522b3a.0.2025.05.06.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:32:50 -0700 (PDT)
Date: Wed, 7 May 2025 03:32:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/15] xfs: add a test for zoned block accounting after
 remount
Message-ID: <20250506193246.hc2xtgxibh7osztb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-3-hch@lst.de>

On Thu, May 01, 2025 at 08:42:39AM -0500, Christoph Hellwig wrote:
> Test for a problem with an earlier version of the zoned XFS mount code
> where freeded blocks in an open zone weren't properly accounted for.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/4201     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4201.out |  6 ++++++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/xfs/4201
>  create mode 100644 tests/xfs/4201.out
> 
> diff --git a/tests/xfs/4201 b/tests/xfs/4201
> new file mode 100755
> index 000000000000..5367291f3e87
> --- /dev/null
> +++ b/tests/xfs/4201
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4201
> +#
> +# Regression test for mount time accounting of an open zone with freed blocks.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick zone
> +
> +_require_scratch
> +_require_odirect
> +
> +tmp=`mktemp -d`

Why not use "$tmp" directly, it's defined in _begin_fstest?

> +
> +_cleanup()
> +{
> +	rm -rf $tmp

Then we can save this specific _cleanup.

> +}
> +
> +#
> +# Create a 256MB file system.  This is picked as the lowest common zone size
> +# to ensure both files are placed into the same zone.
> +#
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +dd if=/dev/zero of=$SCRATCH_MNT/test1 oflag=direct conv=fsync bs=1M count=32
> +dd if=/dev/zero of=$SCRATCH_MNT/test2 oflag=direct conv=fsync bs=1M count=32
> +rm $SCRATCH_MNT/test1
> +
> +# let delayed inode deactivate do its work
> +sleep 1
> +df -h $SCRATCH_MNT > $tmp/df.old

then use $tmp.df.old and ..

> +
> +_scratch_cycle_mount
> +
> +echo "Check that df output matches after remount"
> +df -h $SCRATCH_MNT > $tmp/df.new
> +diff -u $tmp/df.old $tmp/df.new

$tmp.df.new

Thanks,
Zorro

> +
> +_scratch_unmount
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4201.out b/tests/xfs/4201.out
> new file mode 100644
> index 000000000000..4cff86d90b0f
> --- /dev/null
> +++ b/tests/xfs/4201.out
> @@ -0,0 +1,6 @@
> +QA output created by 4201
> +32+0 records in
> +32+0 records out
> +32+0 records in
> +32+0 records out
> +Check that df output matches after remount
> -- 
> 2.47.2
> 

