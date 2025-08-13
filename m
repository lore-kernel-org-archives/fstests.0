Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87A227B88
	for <fstests@vger.kernel.org>; Wed, 13 Aug 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098514; cv=none; b=STCILQ4nvabnNTUTjsOhVyhDEkuz18l8ODMHSxboYFexhJYbhRtH5vdvzSXA5TYAlrWkqsgaggSZUAVN4wJ306pPlcCSlgPgrgAsf+ywNodGSGTcCp8hOgG0zEb7bcH2u/v1bcJrb8nT7Axbou0uK82p45hG7NsMLqNApjfH8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098514; c=relaxed/simple;
	bh=jgx9/qEqYHmK4tUnaJq68gqDCIvN3A7HYYni9AFZstk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSpWJNjwNVF2Vk0iLLG/T6Of0h2RQGWZ83le3xpUa4GCOgnMEmtvLvGZQZsGKuciu85tK3MOl+gJ9sT3KQ199hXz6cyWnYTQj4dCoNtsAWezBmBNMftye+ZbBHb8qlvbR3VHCeStKBFfho4pLKc6MrUYLOVMWFpGfS+AbrahxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e69auS+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e69auS+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vppSvXKLvw9+Ui4UoKYJG/JyrX8LaLt0vJFChiD34HM=;
	b=e69auS+JnfSOV7xG7YU39jOubzUm4tAHCfZymDLVaigB/0YxgSo8b/DrAF6KSVol4zhsky
	X7RMQs1ESz5oArNHLU5FGQM0ANT/eQ3HNnMjfcWMBRf1OwqSh1Fkrpmj/hpGSY/msLPv0Q
	EVj0OB7ijVDOeCszkdonb/N1zIjj2cM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-uNQ6i4L8O0OaDKpYMpbtyQ-1; Wed, 13 Aug 2025 11:21:50 -0400
X-MC-Unique: uNQ6i4L8O0OaDKpYMpbtyQ-1
X-Mimecast-MFC-AGG-ID: uNQ6i4L8O0OaDKpYMpbtyQ_1755098510
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso12628655a12.0
        for <fstests@vger.kernel.org>; Wed, 13 Aug 2025 08:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098510; x=1755703310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vppSvXKLvw9+Ui4UoKYJG/JyrX8LaLt0vJFChiD34HM=;
        b=wYQbnq1BJIyy2nSK7WauBIXQWlTeeTPi8RL4UhhyRqCKRQY04AXGmjvwfimr/XHA4g
         uZNVNAvyx3GHtmYcnhvt1OYxd1CEyfGu5Fmj375XH5q4bEaXChu+nVV05kyk9zIJDSn3
         ozS2P8blCL3sonUpDAd5RvoD6jYX8y3F95sRDSUA8rJGhUAyf8b4J2Sgn57siLG+sy5u
         DbyoTLV73u/kXRo87phgtfqVMjnnUU48xqON7MpxMiv5cYhZRyf8yFQFplKnhR5+kpv0
         ZXPioEkT2PQTd7Q6sNpRGIXQo2z9bO9Z5NlgwZhLEqmtWdoaDx1BQJZ9GOj6sSFPu4H7
         uuIw==
X-Forwarded-Encrypted: i=1; AJvYcCXUYdxxY2G6wHPJ5ne6eJ3H5G+EJhNZMBv3NB5FN/MMz5LKUxqs9kwNFVN6lQvYuXjQlMwZ62le@vger.kernel.org
X-Gm-Message-State: AOJu0Yx167Iu7LI9FRbqslcyYiliPKBvVAv11+eG2bjzWYasJ4j/hQ6E
	6hztl27N8mP//brXJBfNI0XsRnh7kTl0N1KPqKDbsn+7k4e0O5o/YIxBpnuHYBoQLO0jaaFkqoK
	gp25cziOQG9/9otzrQaMDcoAapR8nXYs2hwjxWl/XmzJhoHtN2Um+Oej2rtM=
X-Gm-Gg: ASbGncuGb2hLYuACWQGIhJYTIJc7GN/Igo/8kw7dnZNFBpoggPcnUW+Pkn4ahqaHLl6
	f6+S1QNy5OkI/lhUtVOYdksMBuizznjeE/B5ZQ0dR+mAw26JGj42cxEckqfg4sL1aqts9zrM1TP
	uToDUDH1dAFdKuI5vRq0ukaVlzaVibcFLRXxtK9nB+O7slDkrvNrCDbldMNfeQnQ0+zHVP0tyzo
	8sydWcVjlF1W4Pbf8qfEPL467Qyv8eqvHgkzU0p3cqznLUdEBtN4mBcT0wnN2B29ja1ezMEL5wC
	K4TDB+NFGBMcxnSwKAQw5XaXRdv/DerJD0yH3i0PudQVmgHvvx3H8+SNxIDBcv5qDfqFjIkHTjz
	lvzFF
X-Received: by 2002:a17:902:f788:b0:240:8c85:4299 with SMTP id d9443c01a7336-2430d0ecd34mr54666445ad.17.1755098509676;
        Wed, 13 Aug 2025 08:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpiUgwY9i2kjNs5657ydUZHd9xLVsxNt5lmXGywsZPtuMbOEjG4FvW3Bxcvc6ijxBkZqf0AA==
X-Received: by 2002:a17:902:f788:b0:240:8c85:4299 with SMTP id d9443c01a7336-2430d0ecd34mr54665775ad.17.1755098509141;
        Wed, 13 Aug 2025 08:21:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977345sm327474455ad.108.2025.08.13.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:21:48 -0700 (PDT)
Date: Wed, 13 Aug 2025 23:21:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3] f2fs/019: do sanity check on mapping table
Message-ID: <20250813152144.usxshpwpy2pqlovi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
 <20250811094415.1053545-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811094415.1053545-2-chao@kernel.org>

On Mon, Aug 11, 2025 at 05:44:14PM +0800, Chao Yu wrote:
> This is a regression test:
> 1. create a file
> 2. write file to create a direct node at special offset
> 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
> 4. check whether f2fs kernel module will detect and report such
>    corruption in the fil
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/019     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/019.out |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/f2fs/019
>  create mode 100644 tests/f2fs/019.out
> 
> diff --git a/tests/f2fs/019 b/tests/f2fs/019
> new file mode 100755
> index 00000000..0a02eb2f
> --- /dev/null
> +++ b/tests/f2fs/019
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/019
> +#
> +# This is a regression test:
> +# 1. create a file
> +# 2. write file to create a direct node at special offset
> +# 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
> +# 4. check whether f2fs kernel module will detect and report such
> +#    corruption in the file
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw compress
> +
> +_cleanup()
> +{
> +	_scratch_mkfs >> $seqres.full

Why mkfs SCRATCH_DEV in _cleanup ?

> +}
> +
> +_fixed_by_kernel_commit 77de19b6867f \
> +	"f2fs: fix to avoid out-of-boundary access in dnode page"
> +
> +export MKFS_OPTIONS=""

Can you give it a comment about why we need to clean mkfs option at here?

> +_require_scratch

Oh, if this case tends to have a corrupted SCRATCH_DEV, you can use
_require_scratch_nocheck at here, don't need to mkfs in _cleanup.

> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +xfs_io -f -c "pwrite 3738M 1M" -c "fsync" $testfile >> $seqres.full
   ^^^^^^
$XFS_IO_PROG

> +
> +_scratch_unmount
> +
> +$F2FS_INJECT_PROG --node --mb addr --nid 5 --idx 937 --val 4 $SCRATCH_DEV >> $seqres.full
> +
> +_scratch_mount
> +xfs_io -c "pread 3700M 40M" $testfile
   ^^^^^^
$XFS_IO_PROG

> +_scratch_unmount
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/019.out b/tests/f2fs/019.out
> new file mode 100644
> index 00000000..2f7469e2
> --- /dev/null
> +++ b/tests/f2fs/019.out
> @@ -0,0 +1,2 @@
> +QA output created by 019
> +pread: Structure needs cleaning
> -- 
> 2.49.0
> 

