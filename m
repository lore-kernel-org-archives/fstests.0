Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172C1F4717
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560586; cv=none; b=NJW0XTC/Me2Uw4fl23D6WjsQrb7Zs1cEqIpekd9fcV12yRtLAVZdQ4siOX9mnSQkANjR3EVbThOHiGPj4YIo54qnqCMGUlu+kq50HHfaIZSCwfV750hB0cnoQ1JucNp9oX2aGAgc7r/W4n3IW1+ugFdkW3BjxdvNjzEvelBskao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560586; c=relaxed/simple;
	bh=aDHnmJoUM+mK/o5/vIQ8b+YC+F5PBeV7QWtqiLwxwQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCnX8zzTpdfERXL8BIOHt9gJiS34XjAPjXY5/4bhRhFGWmjmmVz7IbXNI4REQp0bMa3fuzDTsJAW7M5Pko+1sySpoxfiXL+1lTnd3+p+gA/0iA2bmNaf0oHYj8dkKoMiCdC0B2R2u7JeK0+Tf/dNjKiPf1E+zFAlK7JOsvogg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxkfHCpx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxkfHCpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746560583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3KE5pGkvRI7NimGve0sFl4yhasEooOR6ozOlBx/sWA=;
	b=BxkfHCpxKHyl49F1Oc3EzzuX2mMfbLO2HFVPJNHGamEAyBjcmif1qZb39hxpPgXZi7y4/p
	zh65hM0dcY5enafUPOO6BTcj988FShKJpqS+GslbHYGotjwlIZpOuQWqeDV+40boklBbPa
	t22ZGiAGD13CML6O81wq36PQVnoY9mw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-nlIbw14cONiEKG3fDJylUA-1; Tue, 06 May 2025 15:43:02 -0400
X-MC-Unique: nlIbw14cONiEKG3fDJylUA-1
X-Mimecast-MFC-AGG-ID: nlIbw14cONiEKG3fDJylUA_1746560581
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7377139d8b1so4478283b3a.0
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 12:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560581; x=1747165381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3KE5pGkvRI7NimGve0sFl4yhasEooOR6ozOlBx/sWA=;
        b=vUqNnGT3ortbcbnlYDbGMlvZAIyXKwW2ysMdK826JdrPyJ+ZKv2PVhL5MEcUpz53d8
         RFwEK3mTkpTb4mgX91+YDikGamMKbcz4D2xYp1/RZgILCWQ+b7XzxZP0BlHMzRPPsIBW
         ehEASW53gbpR08+hldOO9ErUsJOzdqRElbPhhvAU19W2kKxkxpOnVD2Qc2aB8130rPIg
         SXbELIOLh+mvkKSJp/w1yNIyXRiKSP4fwc59rCGbfP6nCgt+potTnUv9++nYLcwRgfOO
         18airvPCUa1YQrBRBZ/3fX8aYwskr8HX50R6XfARv9w4pjGO4akBuV6+ywB+3rGh4741
         JXbw==
X-Forwarded-Encrypted: i=1; AJvYcCWYPmMjscr6HGO2AGKvMbyurytAAdKQrkOPhpge14RYwUS5WZcUcQZNIhOH11UDTNY8axDcdPJl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw99gLm/MDLvCByfGDNveop/ed6t5w1Ti67qdBgKRycbsqg9a0
	4g79pH+MnOFFJJJksNeiUKD1G/Ru6TtYaHnEEzTuNNF1Jp9m1FGrmXC4EnHeIWhlvkc9Enm3o7S
	jGZW4fexhMtxuhvMGz83lXl14PWQiFys7Ef5WpWoiqcjKrAA8cTIT+a8=
X-Gm-Gg: ASbGncsdJGBo2dmhamuzbWqxSD8m2u8wE8gWaTAJkKdH5VnSqxwQrn/RRvU2BlZf5G2
	M6Rs9ZQp6wOWqao295J2aka1Pb2NT0O5XP+2mGpcB9eDG8KpqM4QKVtq8QYm3KKD66Hap+Dadad
	l/ZmQ58wktDCknaiP2Gom4tewHpajwUeGSud5q5h+Sk+9vqDQ5qcmujumVuEQ18Ro6IQaHj/Xsb
	1lrKqWG7Y6zX+QvtxSQP7QwAsY7dRl6MHk+NVcaSRc9azay3wYMBCzLqXzoZbcjp3kgby1WdhYi
	CfHsvb1LsC/f8mlLHbbB7YTJFpsv0tWJaueRkeXVQdBwD1Tbs4F0
X-Received: by 2002:a05:6a00:3001:b0:740:5977:7efd with SMTP id d2e1a72fcca58-7409cf479c9mr455915b3a.13.1746560580966;
        Tue, 06 May 2025 12:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIiGovGX/Kbdz9RCfFjRyJiPUy11sU6RtZW3tj1F5CKYvo9uvO1wtwDRAsGQgA2jzXMB/49Q==
X-Received: by 2002:a05:6a00:3001:b0:740:5977:7efd with SMTP id d2e1a72fcca58-7409cf479c9mr455890b3a.13.1746560580594;
        Tue, 06 May 2025 12:43:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905d011sm9321301b3a.121.2025.05.06.12.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:43:00 -0700 (PDT)
Date: Wed, 7 May 2025 03:42:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/15] xfs: add a test for write lifetime hints
Message-ID: <20250506194255.5hny5vgfe7ct647i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-7-hch@lst.de>

On Thu, May 01, 2025 at 08:42:43AM -0500, Christoph Hellwig wrote:
> Test that the zone allocator actually places by temperature bucket.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/4205     | 105 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4205.out |   4 ++
>  2 files changed, 109 insertions(+)
>  create mode 100755 tests/xfs/4205
>  create mode 100644 tests/xfs/4205.out
> 
> diff --git a/tests/xfs/4205 b/tests/xfs/4205
> new file mode 100755
> index 000000000000..be508806ec0a
> --- /dev/null
> +++ b/tests/xfs/4205
> @@ -0,0 +1,105 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4205
> +#
> +# Test data placement by write hints.
> +#
> +. ./common/preamble
> +_begin_fstest auto rw zone
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount >/dev/null 2>&1

Is this unmount necessary here? If not, this _cleanup can be removed.

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +
> +_filter_rgno()
> +{
> +	# the rg number is in column 4 of xfs_bmap output
> +	perl -ne '
> +		$rg = (split /\s+/)[4] ;
> +		if ($rg =~ /\d+/) {print "$rg "} ;
> +	'
> +}
> +
> +_test_placement()

I think we don't remind using "_" prefix for local function of each test case :)

> +{
> +	xfs_io_opts=$1
> +
> +	_scratch_mkfs_xfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_require_xfs_scratch_zoned 3
> +
> +	# Create a bunch of files for the three major temperature buckets
> +	for i in `seq 1 100`; do
> +		for hint in "short" "medium" "long"; do
> +			file=$SCRATCH_MNT/$hint.$i
> +
> +			touch $file
> +			$here/src/rw_hint $file $hint
> +			$XFS_IO_PROG ${xfs_io_opts} \
> +				-c 'pwrite 0 1m' \
> +				$file >>$seqres.full
> +		done
> +	done
> +
> +	sync
> +
> +	# Check that all short lifetime files are placed together
> +	short_rg=`xfs_bmap -v $SCRATCH_MNT/short.1 | _filter_rgno`
> +	for i in `seq 2 100`; do
> +		file=$SCRATCH_MNT/short.$i
> +		rg=`xfs_bmap -v $file | _filter_rgno`
> +		if [ "${rg}" != "${short_rg}" ]; then
> +			echo "short RG mismatch for file $i: $short_rg/$rg"
> +		fi
> +	done
> +
> +	# Check that all medium lifetime files are placed together,
> +	# but not in the short RG
> +	medium_rg=`xfs_bmap -v $SCRATCH_MNT/medium.1 | _filter_rgno`
> +	if [ "${medium}" == "${short_rg}" ]; then
> +		echo "medium rg == short_rg"
> +	fi
> +	for i in `seq 2 100`; do
> +		file=$SCRATCH_MNT/medium.$i
> +		rg=`xfs_bmap -v $file | _filter_rgno`
> +		if [ "${rg}" != "${medium_rg}" ]; then
> +			echo "medium RG mismatch for file $i: $medium_rg/$rg"
> +		fi
> +	done
> +
> +	# Check that none of the long lifetime files are colocated with
> +	# short and medium ones
> +	for i in `seq 1 100`; do
> +		file=$SCRATCH_MNT/long.$i
> +		rg=`xfs_bmap -v $file | _filter_rgno`
> +		if [ "${rg}" == "${short_rg}" ]; then
> +			echo "long file $i placed into short RG "
> +		fi
> +		if [ "${rg}" == "${medium_rg}" ]; then
> +			echo "long file $i placed into medium RG"
> +		fi
> +	done
> +
> +	_scratch_unmount
> +}
> +
> +echo "Testing buffered I/O:"
> +_test_placement ""
> +
> +echo "Testing synchronous buffered I/O:"
> +_test_placement "-s"
> +
> +echo "Testing direct I/O:"
> +_test_placement "-d"
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4205.out b/tests/xfs/4205.out
> new file mode 100644
> index 000000000000..3331e361a36d
> --- /dev/null
> +++ b/tests/xfs/4205.out
> @@ -0,0 +1,4 @@
> +QA output created by 4205
> +Testing buffered I/O:
> +Testing synchronous buffered I/O:
> +Testing direct I/O:
> -- 
> 2.47.2
> 

