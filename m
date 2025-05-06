Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224472618
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560749; cv=none; b=aslm4gYpz1R3D5ePS64ZvjNvg1qM34L1eHPxQKcjxul8k/2p40NTvTBVirq05yvUcrVwwGkvfvmbDwAhw9o74ldFJCfr2d1AA1ofiUx0wweTNeMadkehZBVxPaFzoOj0X4f+z17TB5o6mHHCBnmrHPsYFjTZAmV9am6cd9ApkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560749; c=relaxed/simple;
	bh=JbSCQsjRcT+jwXPcpjjQNlt6hZvTKgAziBUyXoBselA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHEbou3qDB9biCSmNuQOsLkpK9+zbiVZD6M2uBnmo6I/R3ZsFVAfsVtcNpUXlUfhe6jFZ7JPDUM+GHsjTfHSxu+WlVTyINM7um66heX3QAJAWKZjRxL00EWfzpjOpEE4Ld1Mt3Blfc0Vh7T4lkI8JH/hiF9FWIf3SHlMSo4o3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LITKiDu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LITKiDu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746560746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+jxwcjxfxStn75+Bbmsu4HeZVlz6QrNxuBaWj1jWtxQ=;
	b=LITKiDu5R7yY/ozR7jrFBXKjrdUxyU+RhGrO2+U20QnXoqsefLa/8XF6ssIleDFfPMWhVX
	9xFq3qyQxGWP32kW7/J3wEEJTR37S6PMWqr5OD/Aq45cmGYekF5+VLlTZsUGrnA4Sjml6U
	e3sQ5if9jxnH4w8FyeNA/VRm3k2lS6I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-cpK3ZqTTPZarmshEt51iHw-1; Tue, 06 May 2025 15:45:45 -0400
X-MC-Unique: cpK3ZqTTPZarmshEt51iHw-1
X-Mimecast-MFC-AGG-ID: cpK3ZqTTPZarmshEt51iHw_1746560745
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7370e73f690so6693042b3a.3
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 12:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560745; x=1747165545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jxwcjxfxStn75+Bbmsu4HeZVlz6QrNxuBaWj1jWtxQ=;
        b=lUokAI/IwgCDtJcz053hlyRhS/icIPGEk9D05KycqZDQ5vrI7NUQQK5UMSvFXE9CJA
         NQMjlDHX+7CI9L+CJsFfrSOOHK8t+O7y4gWO4vdyxVZgB6JUkiVpgE7t1MItblCpQUvm
         V4G7yy6fTcSAfGoz4yNLyfXePlyUgQZvEz/iqJmQUeuEWsf3ntWBst49q07z+upDrWpm
         Wqie0tF7Jss7/MgJhJYArHaiUAKQb61sTdluxj1tBWEdwHnDKBR/zqJkc/4YDd5Gzhmi
         14LDe2HHkusnAzIm+mgrS/uvaFsX2NWr8Ou6E8krJoNx/TRTa2ILRE94BkRdcAjryzCi
         x5hA==
X-Forwarded-Encrypted: i=1; AJvYcCWz7X7uRbfF04grDT0nkSaPTTIvT6MbgCusJFcnigy5mrVHGFN/XsCDMtAuorAc9ZvYk9/kdAv4@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEgvHTG7Yw6cjiaQ1emtP/3pNZAaQTj84eYzisZ6GpDNn/CpW
	4SQ82fIC9nWcpD/Zp1m87aFi/x3LANOFQah8uI6s2IyZyGk+FmObwUrOhNJexzKVndAOgFu3EUB
	XbSH6t4kyo9woeL1NUE2xql7VtwmpMMLe9z9evcZm57HL+wdTFtpV7yQ=
X-Gm-Gg: ASbGncvNuxwNXhpy9d93h/0QwBbghEGtvXEyOkIBfljSTBL5iTDq3HKJSgVrygFw9mU
	Hk8pb55PXViHJIQpil3DybQzSYJdKGfrqhnp5IRBr2YXTIJADpbfe/rudv7dikAZ5HSzgjFNTxm
	FeNhqpyrppYjgzqMUJxTmPpaBDEyj3cKoC/e8akdjV22FZQzfqQGE26VA/lgZcx8ohVdRAcNssX
	zNKIq2X4Z5SgBNEfrquoZk0O65brecDQstWP3iEsv8BhW701Bm5qhWC77HWTB100Jj4zWlUj6B8
	O6R6rEX15ctigirfeOGWrC6WnLpqmeW2Ed/OovbFvfruzFhiQ3Jy
X-Received: by 2002:a05:6a00:ab0d:b0:73b:ef0a:f9dc with SMTP id d2e1a72fcca58-7409cedc7d8mr573797b3a.4.1746560744791;
        Tue, 06 May 2025 12:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6+3BD2CzoQHKGWWt5caIb2pdgKCjbZ3DgVGCkUgZRwx+Kn6oYUUvEOyJh7fN/5OxTmolt4w==
X-Received: by 2002:a05:6a00:ab0d:b0:73b:ef0a:f9dc with SMTP id d2e1a72fcca58-7409cedc7d8mr573771b3a.4.1746560744433;
        Tue, 06 May 2025 12:45:44 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590631a7sm9348025b3a.152.2025.05.06.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:45:44 -0700 (PDT)
Date: Wed, 7 May 2025 03:45:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/15] xfs: add a test for writeback after close
Message-ID: <20250506194539.u7scbp4rsipibza6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-8-hch@lst.de>

On Thu, May 01, 2025 at 08:42:44AM -0500, Christoph Hellwig wrote:
> Test that files written back after closing are packed tightly instead of
> using up open zone resources.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/4206     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4206.out |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100755 tests/xfs/4206
>  create mode 100644 tests/xfs/4206.out
> 
> diff --git a/tests/xfs/4206 b/tests/xfs/4206
> new file mode 100755
> index 000000000000..63e6aebeaeec
> --- /dev/null
> +++ b/tests/xfs/4206
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4206
> +#
> +# Test that data is packed tighly for writeback after the files were
> +# closed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zone
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount >/dev/null 2>&1

Same, is this unmount necessary?

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +
> +_filter_rgno()

If this filter is useful for 1+ case, how about moving it to common/filter?
Or remove the "_" prefix of a local function.

> +{
> +	# the rg number is in column 4 of xfs_bmap output
> +	perl -ne '
> +		$rg = (split /\s+/)[4] ;
> +		if ($rg =~ /\d+/) {print "$rg "} ;
> +	'
> +}
> +
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +_scratch_mount
> +_require_xfs_scratch_zoned
> +
> +# Create a bunch of small files
> +for i in `seq 1 100`; do
> +	file=$SCRATCH_MNT/$i
> +
> +	$XFS_IO_PROG -f -c 'pwrite 0 8k' $file >>$seqres.full
> +done
> +
> +sync
> +
> +# Check that all small files are placed together
> +short_rg=`xfs_bmap -v $SCRATCH_MNT/1 | _filter_rgno`
> +for i in `seq 2 100`; do
> +	file=$SCRATCH_MNT/$i
> +	rg=`xfs_bmap -v $file | _filter_rgno`
> +	if [ "${rg}" != "${short_rg}" ]; then
> +		echo "RG mismatch for file $i: $short_rg/$rg"
> +	fi
> +done
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4206.out b/tests/xfs/4206.out
> new file mode 100644
> index 000000000000..4835b5053ae5
> --- /dev/null
> +++ b/tests/xfs/4206.out
> @@ -0,0 +1 @@
> +QA output created by 4206
> -- 
> 2.47.2
> 
> 

