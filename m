Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319B319876
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206165; cv=none; b=Uw9R2kdN+RThq0jwgzybp/cOuUjrVgiEr4HPnCDA/lMTyInIVJgZNmTHQ/KBV9nTRh0lePDrPCs9a70HBRqTcqOUHavKP2bMBWcWOz2lpz43c/yL3gSIWUMRprY72uyR9Czy7CDynTJuBFuSehNWyh52S+xZnUPCT5jkqt86/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206165; c=relaxed/simple;
	bh=fw5WOLzPGShWRyFJ4RntR1OGpIEgV+avRm72YvHBPGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWV+I1mYWliorhbY+1Z/XgFAb/b07M24VCYyXVKfKV+v0vbCaDgjXngrTIby8wJuF+s1xyEpGP48lmrW8w06xmiMmPgjPoUIvnGdVF38Kh/MlS9/4yvqWXDxn7WKvaz6gLoMWsOYdho8P13uKBPZwMgywzWk9yQA31O3Gg0i6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1C6/NXE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1C6/NXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755206162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMdTCwlysy6xreHQRz5jmjj6KgJdkNqFidZkpPK734c=;
	b=B1C6/NXEJ+bedayCwA9nDv3EPNICE+vpYsp/v6J5fdXDV9xYDUnI4AlXQKAXIZ47VxthEI
	vmV3u5UD/lOFsTze/dA/WDLz4bTgiAgN1YvzPfveeDFNtxohx9jS3b5Ihrq6X4J5fb49NT
	vx91hLfd5YXql0/PLSBq+VQ9De+FOOg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-xPWvnYQ5NVOxAlm_Cr4qzA-1; Thu, 14 Aug 2025 17:16:01 -0400
X-MC-Unique: xPWvnYQ5NVOxAlm_Cr4qzA-1
X-Mimecast-MFC-AGG-ID: xPWvnYQ5NVOxAlm_Cr4qzA_1755206160
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eab5baaso1088502b3a.2
        for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 14:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206160; x=1755810960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMdTCwlysy6xreHQRz5jmjj6KgJdkNqFidZkpPK734c=;
        b=TuWMxDR6KxGEWy5KI8+g115F2eBwHJS0eeWubszhRYym2NcAVcyW9EvZFERr0mbLkE
         0RwdBhySp1RNgui2iexg+Ezrvp8qZbmCWz7GHZrmgV5eZia2HNT7E2YIFbdyU60vDeTc
         +Mghkj240FN7+TCawcqDEUz+Lix6MgxgKlyC2MAzJIse94uLzVbHjJb5DZ9/Trs1muaX
         3aYIkz5Tmv7cmpeyeRzyl1ErdxaPko1LTXuxOcIRsLN9qu39Uie3/OIfH/wacVrgwkAW
         X40qN1uZaHAEq0I4GCkN6cWaPim01Ui9j+qD4NZiDchWBiVkAssEn8XsgW0t6B66X/ke
         FpvA==
X-Forwarded-Encrypted: i=1; AJvYcCVj2kbhTZXZtwW6B0B+eHt+Txz7IZjSpXjTT/g3jca1+202NYIDtohk/D4mQ/PBu4RKGg+AX8u1@vger.kernel.org
X-Gm-Message-State: AOJu0YyonuCdkdAN3cMFm1yNm5/67tddOi5G5CF1RtCLkZLZn5rIIMaC
	BB6arZ2GuwW0/4rlEGu9DgQj5AV4B4GZ5710ypAyG5RINKm2p+79mk5DtyHXKd0QFamhmVdHmR0
	l8gvJNfHxyrZsI/Enzt+D1nXAPnlsGyUcSrojxPmJQjSfoVKVtf9mE183gxViw96TvDI=
X-Gm-Gg: ASbGncv4hKYq27I8qocm5RC3FRfWgYEVTgnVcXNVJgWTx6TJAj5ocIBpPDi8NrJgVh2
	uB52UlwAYwRDXlwzobisg3fp5KJQ7lX3nnLXgApkX340ee9X/hsyzjaySZYjHaIxU+uIQ2liutl
	ug3Uk3aavQ/FuLpEPkbE5vJpXFxxmHeRjC71gsiLGHOCnl364NKLDa3MboTmJFkDsSVWzNXdcVc
	UQtazgmepEOJ67rmwt1mkLvSBeS0tOECE+BfHlahXSmkqG8WyhSHk0cxVj5gQ5i2ZNVO+cCyJs3
	KRimwjoNEQxk1KP46hAQEljERMranpJnAqGvpytLI/WdX+9mqG0Fj3QkyBb30TSIXV6mBER5mwc
	Loua7
X-Received: by 2002:a05:6a00:4f88:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-76e2fd81e4bmr6662718b3a.16.1755206160174;
        Thu, 14 Aug 2025 14:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjDWZdoybujOkmDsFKuadpWF234b1I5kCtJywZV7uVSmUeB1zkU78BvFCdXWYN6bA5ygNYJA==
X-Received: by 2002:a05:6a00:4f88:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-76e2fd81e4bmr6662686b3a.16.1755206159764;
        Thu, 14 Aug 2025 14:15:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdc8c7661sm32942344b3a.76.2025.08.14.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:15:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 05:15:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 2/3] f2fs/019: do sanity check on mapping table
Message-ID: <20250814211555.wytxo2qrq33gkadq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250814090712.2119455-1-chao@kernel.org>
 <20250814090712.2119455-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814090712.2119455-2-chao@kernel.org>

On Thu, Aug 14, 2025 at 05:07:11PM +0800, Chao Yu wrote:
> This is a regression test:
> 1. create a file
> 2. write file to create a direct node at special offset
> 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
> 4. check whether f2fs kernel module will detect and report such
>    corruption in the fil
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

This version looks good to me, thanks for this new test coverage :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> v2:
> - use _require_scratch_nocheck instead of _require_scratch
> - use $XFS_IO_PROG instead of xfs_io
> - add comments for why exporting MKFS_OPTIONS=""
>  tests/f2fs/019     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/019.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/f2fs/019
>  create mode 100644 tests/f2fs/019.out
> 
> diff --git a/tests/f2fs/019 b/tests/f2fs/019
> new file mode 100755
> index 00000000..2307bd96
> --- /dev/null
> +++ b/tests/f2fs/019
> @@ -0,0 +1,42 @@
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
> +_begin_fstest auto quick rw
> +
> +_fixed_by_kernel_commit 77de19b6867f \
> +	"f2fs: fix to avoid out-of-boundary access in dnode page"
> +
> +_require_scratch_nocheck
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +# remove all mkfs options to avoid layout change of on-disk inode
> +export MKFS_OPTIONS=""
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -c "pwrite 3738M 1M" -c "fsync" $testfile >> $seqres.full
> +
> +_scratch_unmount
> +
> +$F2FS_INJECT_PROG --node --mb addr --nid 5 --idx 937 --val 4 $SCRATCH_DEV >> $seqres.full
> +
> +_scratch_mount
> +$XFS_IO_PROG -c "pread 3700M 40M" $testfile
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

