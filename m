Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15769A927
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067501; cv=none; b=Hx74JWN6ZMRM5yBS9UM7Pl0sxDZwMl+1pM50a6bZrTGDJMCW8i1oYUTSZQPR+QGmo1L++MEixnlUbqqVTpSMeJjVqQJ1vLtwUVu7llUnPE/5YcXuuTF2mss3GJH70QaGkjB5kXwgl+qCXEWhdtJCthU/iEKHBkJrieMmGsJYl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067501; c=relaxed/simple;
	bh=aK1FwrYLvI8mi0RMOERTwz1F7uoDNcYfzu2w5OfZkJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGuY2FJlDlNWMMoHiVBRt5n9+ywopsAAPqIw3VNYU/F1M66kQPVTle9Vnx/PmbKmWYJ5aaNw1p6Wqs6yDsF71qBWClB0fsG9h0KxfrwQomipZBzK3BdTTtbjgBdwGztUWZyu9yzK4AcUlhvU+RTkcMigLXhdGCWTfNYnVfjsEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNj5g5iF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNj5g5iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759067498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9JpqdLLT9z1M051j1qXRqMQ5SMaqtTYMmpk/UjNV5Q=;
	b=bNj5g5iFgwHHcYKZLQI7xjBzWlgjy5He2yFKaKTinmPWchGSN0Qj/QIXWbETsIKDNmt7kA
	KUCaMKvjZPLtLKL3DCJ8O6QE+YbNq/+dZo7tPiTzlKU5vep+Vqjj/IXGEdk61hp6oyy66R
	/+/hsrNJed3KX2s28Z/q4H5e6xrPSqQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-CdkhVhqpN4yfsOWqD5FF3w-1; Sun, 28 Sep 2025 09:51:35 -0400
X-MC-Unique: CdkhVhqpN4yfsOWqD5FF3w-1
X-Mimecast-MFC-AGG-ID: CdkhVhqpN4yfsOWqD5FF3w_1759067494
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5529da7771so2789238a12.0
        for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 06:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759067494; x=1759672294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9JpqdLLT9z1M051j1qXRqMQ5SMaqtTYMmpk/UjNV5Q=;
        b=bF2HvPyq25cPIEKAXMAcbVHhm/D+JgirRdwXraTBXbAicFOPNXeNosh1pFJfUPj82p
         8BSHbXYQRAzw3fXhuYAnBoF26hWrEykYk1KsWBs+Hb0AodjlB+rWXcqojEUYGyIpVRYT
         7yISZiEyy8vGkYUkbPMXeo4ZIvrb6AnJCPFRQxBU2bcb0YifEWQ+Mg1aNHkyaiOFLyl7
         nJSvFktX6PqV51l7Cj/HAD5BpS3l908t28i7IN9SRpQSCGqyURKvq5F3Y9RZFoaun2Ne
         Hy2MH53AKOgIoLArh2f7FJPkM4a05JsHV9uSTqUw1t49xgnMFuQrbvShApL6j+EN7Rze
         +T7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPm2TNLV5avAz/ECGPZZQqRKTzNltQNmKOVjwGQi181e+T6ysAJyHSHRKuquHpSTA78bJykKXt@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpqEA80tC5Z95+AQO8n0pFy4cXc9tbI/8+YxoJ2PsGgEvl+Nm
	1VvRQpN39L9K3EZF0FhIcDiqMols14guYQVl/+lwRtGP1E4xoSFQPQwWbSOpfQULoQdF6KS6YX0
	Mk0tzCn6lxOm7L3JlYnGX50tY204TgJoBksyqZhk+lErV5VCQ4aExvtO/79s=
X-Gm-Gg: ASbGnct8PXnWZnH6kHn6llAfOnoYSyn/Il0np097MC3zkSgtdkP5dMbRY7dgu+cceFk
	YOMnq2taaWIl/LLKGpIj2DgEKowciNoMmiMTxwYLBvCE5RNlhVu8yH0ug6SDoF10zPWPtbp68OI
	iS05z9lNzDtBuWJy3PZCi7HIjYNoYsHcszGe+UvlAKN5OuTeOs6ZTVoOUx/pZl1ZFqDWbW7s6IG
	YaIFXy0jguIwPTDDQkj7EpQM4wEiCVCs70MeGYq3G4zVJ74l9PIXBzDAlhKUrrj+f1mBPQE6A8I
	76ByxxwCrHXSszSpqelTmbcPqVUcUv8Uqy8NzgztXvRkZut0pL5o1IiXwzpb5Yw2hHYUDdUNyoy
	nCvUp
X-Received: by 2002:a05:6a21:e098:b0:24d:38c:26bd with SMTP id adf61e73a8af0-2e7d1ff0a57mr18099761637.43.1759067493896;
        Sun, 28 Sep 2025 06:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg04/G4NfqhTpCpCPdtRAQV4uvWVXc/77oQZV+4Ld5cvDuBuQgZe2sLsXaxO5UGEano05WVA==
X-Received: by 2002:a05:6a21:e098:b0:24d:38c:26bd with SMTP id adf61e73a8af0-2e7d1ff0a57mr18099734637.43.1759067493381;
        Sun, 28 Sep 2025 06:51:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c279f8sm8916171b3a.98.2025.09.28.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 06:51:33 -0700 (PDT)
Date: Sun, 28 Sep 2025 21:51:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 2/2] f2fs/022: do sanity check on footer of non inode
 dnode
Message-ID: <20250928135128.s57p4hj6y223gvf7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250928083442.7955-1-chao@kernel.org>
 <20250928083442.7955-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928083442.7955-2-chao@kernel.org>

On Sun, Sep 28, 2025 at 04:34:42PM +0800, Chao Yu wrote:
> This is a regression test:
> 1. create foo & bar
> 2. write 8M data to foo
> 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
> 4. fpunch in foo w/ specified range
> 
> If we haven't applied kernel patch ("f2fs: fix to do sanity check on
> node footer for non inode dnode"), f2fs may missed to do sanity check
> on corrupted dnode, result in panic or deadloop in step 4).
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - remove "_require_kernel_config CONFIG_F2FS_CHECK_FS"
> - update comments a bit

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/022     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/022.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/f2fs/022
>  create mode 100644 tests/f2fs/022.out
> 
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> new file mode 100755
> index 00000000..ed3b4f2b
> --- /dev/null
> +++ b/tests/f2fs/022
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/022
> +#
> +# This is a regression test:
> +# 1. create foo & bar
> +# 2. write 8M data to foo
> +# 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
> +# 4. fpunch in foo w/ specified range
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +. ./common/attr
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to do sanity check on node footer for non inode dnode"
> +
> +_require_scratch_nocheck
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +# remove all mkfs options to avoid layout change of on-disk inode
> +export MKFS_OPTIONS=""
> +
> +foo_path=$SCARTCH_MNT/foo
> +bar_path=$SCARTCH_MNT/bar
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +touch $foo_path
> +touch $bar_path
> +$XFS_IO_PROG $foo_path -c "pwrite 0 8M"
> +sync
> +foo_ino=`stat -c '%i' $foo_path`
> +bar_ino=`stat -c '%i' $bar_path`
> +_scratch_unmount
> +
> +# inject foo inode to replace i_nid[0] w/ to bar ino
> +$F2FS_INJECT_PROG --node --mb i_nid --nid $foo_ino --idx 0 --val $bar_ino $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"
> +
> +_scratch_mount
> +
> +# if CONFIG_F2FS_CHECK_FS is enabled, it will trigger a kernel panic,
> +# otherwise, it will enter a deadloop.
> +$XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
> new file mode 100644
> index 00000000..394c6a7c
> --- /dev/null
> +++ b/tests/f2fs/022.out
> @@ -0,0 +1,2 @@
> +QA output created by 022
> +Silence is golden
> -- 
> 2.40.1
> 

