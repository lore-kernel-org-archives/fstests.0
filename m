Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C272111
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614201; cv=none; b=icr5DF6iCWV2/dYnAJK8XaVvLbzn88yMxT4mguzfbCl8/B0gx+tV1/pLg/OaUfVD055H5GqeCkm6PdWMUwf3qaAUWhPPfpygQAHeN2o2MOfq50npiOhn9i0hqbEXKQiGFAgMI0sV2q/InkTNlmD7xDc3R4Fl78l9gwoB9X1im3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614201; c=relaxed/simple;
	bh=pgyDlU+HuoTFtRD8r40s0JeLKdaI6KxOLjUj2+rJAoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmU5/BjalLhbuq4Bb/hm4hCy/pLDQw8YHysO2y/nN7Mmf39ccRUAj7g64MAmLkjSlMUqzLEPndjpi6BQRi1G6WIJ9K1PvRS2DUCtlzQy0/V9gBl5/lUTtf84i8RsOHGy9rUrRtu52u2dRATd5XVDk255LbZjt6ksxmRy+T37kYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYUGw0O3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYUGw0O3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734614199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgTSPlQ4pTnYXaSlJ1+e0g++IEsaPHjITweA2so9mKo=;
	b=AYUGw0O3y+fTF1rXHuMQSEFbvXMzj0E1Db0wYwpr8ofunZd1Q2fLARRjJ0h/O3Dant9H/E
	m4AqEmOQwLiwzSRnMFUGMsBNTvCT3zwuhOA23IwlL408vC4X52JX5US3r/wuOWwMewfh6E
	l6OCsivOy4B0SdTo9r0YElLynPsAiho=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-mFTUKo0XPZmbnNiSO-BmsQ-1; Thu, 19 Dec 2024 08:16:37 -0500
X-MC-Unique: mFTUKo0XPZmbnNiSO-BmsQ-1
X-Mimecast-MFC-AGG-ID: mFTUKo0XPZmbnNiSO-BmsQ
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7f8af3950ecso531727a12.3
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 05:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734614197; x=1735218997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgTSPlQ4pTnYXaSlJ1+e0g++IEsaPHjITweA2so9mKo=;
        b=L163ztYLt2Nbm33ACfmJ8T/nLeInKHl/6gqC13Qv3ODu5gfmeCBKdCgejryovBU/Oz
         0ZQrEoGP2Ry8TRhYbvnDU4EYs0sTDp7NYRFidBuB6wM2HXLZdy4VOgfhpq2dpErJnSJj
         LMEJVCWHuaYF8cVHK+X7FFwPh9g+bFpuoyBlv0nGjiXOLQ1CMsM31nmgeYhzb7uqsxE1
         iwcMqo2MgUtMMbRi6M++f3rgdQ1sxEpmOjXLqnGFFnRADwuF9rxpy3XyPq89IMDHZWQf
         rHY+/8su8NDLfGioqMLmzk4rvjbjN/zn54s/7qZBinndePpjMIFK0qCtUiI1MyWQNSzQ
         O/qg==
X-Forwarded-Encrypted: i=1; AJvYcCX+F6vhqHnS6UTBEJHdOW94PQK8e6LxQl9GNi03WOc2B9JNbHE5fjyo3HU7gP5A3Ls4J3hU3VZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6+CaEq7sICuhBiOQ78dz/QFhfA6VzBneoqUcWSno9RcqdKQn
	pT/0vgnIO4T7m4llrFzheLMLlL3FsCuzmC+MHT1GAZrUjUkYpOYdTUtuDFNtvI6lHtfUmR2X7a5
	bKReL2nZcM1gYoI64vuTgDzzNdyWqiVv/Y5N0xQmcvh/JyLOgKETTm/4=
X-Gm-Gg: ASbGncvwJCJGk2Ks2vnf2tQQQnZPW4iVoz+fNu/kE+NNSp/+n/dTJzzC/wEe2W1uyiK
	0gydjQSGKHL2L5MyrMQG+Sj5G29Yn+sBGBjzIxFmf4BQImn8ye774wSyhjQ2qcXDlTafbbvaXXx
	fAqI0V9zCi9hgQajusM50AZUR9LT4UEfgmEDIrw/f/GupLPcg15g6yKHM1zGuyoki2ukxQzBNuA
	SReIOEq5QTGs7iAhLS0UZFMEYOd0ecFe1H6jfouwL8sRld0ZA4VXsWLOjr1xEMdEAl6HNiiYNvB
	2G3NEsqOn01Wja7efxAiZA==
X-Received: by 2002:a17:90b:4d10:b0:2ee:a04b:92ce with SMTP id 98e67ed59e1d1-2f2e937d3bemr8683664a91.32.1734614196677;
        Thu, 19 Dec 2024 05:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiJyhimSfQYKLnJFO4KuaDEoaeSum0Lil+WV0fbIZTQqlqIAboyy2JdTyDdyUnmJMPwr19Qg==
X-Received: by 2002:a17:90b:4d10:b0:2ee:a04b:92ce with SMTP id 98e67ed59e1d1-2f2e937d3bemr8683637a91.32.1734614196340;
        Thu, 19 Dec 2024 05:16:36 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm1316744a91.51.2024.12.19.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 05:16:35 -0800 (PST)
Date: Thu, 19 Dec 2024 21:16:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/008: test snapshot creation/deletion on lvm device
Message-ID: <20241219131631.6imqcwg7zxcm6hj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241202114307.2747-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202114307.2747-1-chao@kernel.org>

On Mon, Dec 02, 2024 at 07:43:07PM +0800, Chao Yu wrote:
> This patch introduce a regression testcase to check whether
> f2fs can handle discard correctly once underlying lvm device
> changes to not support discard after user creates snapshot
> on it.
> 
> Related bug was fixed by commit bc8aeb04fd80 ("f2fs: fix to
> drop all discards after creating snapshot on lvm device")
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/008     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/008.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/f2fs/008
>  create mode 100644 tests/f2fs/008.out
> 
> diff --git a/tests/f2fs/008 b/tests/f2fs/008
> new file mode 100755
> index 00000000..a9a3f263
> --- /dev/null
> +++ b/tests/f2fs/008
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/008
> +#
> +# This is a regression test to check whether f2fs can handle
> +# discard correctly once underlying lvm device changes to not
> +# support discard after user creates snapshot on it.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_fixed_by_kernel_commit bc8aeb04fd80 \
> +        "f2fs: fix to drop all discards after creating snapshot on lvm device"
> +
> +_require_scratch_nolvm
> +_require_block_device $SCRATCH_DEV
> +_require_command "$LVM_PROG" lvm
> +
> +lvname=lv_$sed
> +vgname=vg_$Sseg

What's "$sed" and "$Sseg", I didn't find the definition of them.

> +testfile=$SCRATCH_MNT/testfile
> +
> +_cleanup()
> +{

  _unmount $SCRATCH_MNT >>$seqres.full 2>&1

for this test might be interrupted.

> +	$LVM_PROG lvremove -f /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
> +	$LVM_PROG lvremove -f /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> +	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
> +	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1

"-ff" might be better for cleanup.

According to 5f7a66b6dc4c ("fstests: use udevadm wait in preference to settle"), Dave
recommend doing below command after above lines:

  _udev_wait --removed /dev/mapper/$vgname-$lvname

Then, don't forget the default cleanup steps:

  cd /
  rm -f $tmp.*

> +}
> +
> +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1

Also according to 5f7a66b6dc4c ("fstests: use udevadm wait in preference to settle"),
Dave recommend using a:
  _udev_wait /dev/mapper/$vgname-$lvname

> +
> +$MKFS_F2FS_PROG /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1

"-f" to force overwrite ? Or use _mkfs_dev? But _mkfs_dev doesn't has a f2f2
specific line, maybe you'd like to write one.

> +mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1

_mount

> +
> +dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
> +sync
> +rm $testfile

"-f" ?

> +sync
> +
> +# create a snapshot on lvm device
> +$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> +umount $SCRATCH_MNT

Move this line to _cleanup, to always try to do it before removing lvm.

> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/008.out b/tests/f2fs/008.out
> new file mode 100644
> index 00000000..dd68d5a4
> --- /dev/null
> +++ b/tests/f2fs/008.out
> @@ -0,0 +1,2 @@
> +QA output created by 008
> +Silence is golden
> -- 
> 2.40.1
> 

