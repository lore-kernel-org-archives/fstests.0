Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4437E591
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059464; cv=none; b=TImSlCvSJoEC9YAC4+TDga7QmIADd310eqDyy5eC5XfbsU+rOlCfCp7k9ezPF9WQP/cPGmyTRyz3WrTODmCMm2RTybSa9w7aS1jCkjR9IEYKVmFTNzJFcpUvJ6YrBmy0u9m2S+J3DPe6+WeBMnfe+zsQmjfiU2V7NFauvFS4o4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059464; c=relaxed/simple;
	bh=pzmxwVuvoSSYFFVmP88R8uOIq5u2t5HHV2EEDRnmVRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHROxb3MfOkalMwt9WFsNy/pVaDqrFa/wIiEQgQCDI3f6Y/Fxlm+mEiFFeL/pgV0xEedtZiuixhUXTlTyvByWvxxLiBc3HzjBjoJyMKRl8zITKtDVNE0fbDqLRPcWtTz6FtdIzdgLw0qANetgpxUs1EH/lOpdBtQPuBFLN6PMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUv2uV7z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUv2uV7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726059461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42UBd9l+dbHJUEuLxMsw7r6IM5ISFs2Gf1FrqpsMXRk=;
	b=hUv2uV7znRUMxo74JjGoPnSAEVHvCEb6g23XyyS+SJOYy0V+WinH9rsyMXiFTOK2HeiJdQ
	6CUmYT0WUbpTeiUu6R+12hzZPUhyGB7HZiq+KvqGSagL39JjArbL5mYMztvK562oMKxmwZ
	aJ/KME4Oy5BFHdZ4mtmAi7UtUkl6doE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-MtrkXlf2OhS9MhsDXS2jog-1; Wed, 11 Sep 2024 08:57:40 -0400
X-MC-Unique: MtrkXlf2OhS9MhsDXS2jog-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-206f9b1bc52so20620115ad.0
        for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 05:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059459; x=1726664259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42UBd9l+dbHJUEuLxMsw7r6IM5ISFs2Gf1FrqpsMXRk=;
        b=YnxVJYuj/rB+dQOv7ido3hVmqTVq+CAeelU6zaCSh4sL+7WzB6FRO8TxiHuHhHVF06
         xFtHTHfViGEI3omhQ+1k8Hf18YJeKPp6rP+klgG+IEgk7fLQ6bOXoy8395V5us6e3JRR
         by2ZGmIsmxkJwhwc6Ul0GWWD/FhmFfWkZoE+ufhF5wezC74V923uA5Bzx0Q5308Whp6w
         V5JvdrNnztUyvp4kB0/t3aD1F1icOPSgGqGxkCsg4JY1b0ZN6IUQ5bgquTiYcX65SL/7
         eZNBAtIgJ2dSl4LNsXI53qlVYP5mgAt0Kwc/e7yceR504G7Jo+tSMK57bB/cC/BPyUuT
         EkEQ==
X-Gm-Message-State: AOJu0YxGrpGX6XE0Gs9zfO7tbUWONyAdQwWH4L+n5P2LT+L/32KjFdNM
	lgU/fpuFBBg6p2q6yhwprYNBBLXjEMEr9n2POCkExGRIRRMfUKrCBz4Bmuctwbl8Vh4egArdXSh
	7ocfobNDovJxvtPajk8fNB6iNmzM3T5FhuKPC5tsXv750ZHUS6DYW1VU=
X-Received: by 2002:a17:902:e74c:b0:205:9220:aa37 with SMTP id d9443c01a7336-207521ad0d8mr37591875ad.22.1726059458972;
        Wed, 11 Sep 2024 05:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPKrkSnt8ixXe93KamK3+5XexCYDakY3RtkQKQ3w6K7C6+fLqifZQ5eyWkhe3xP2idXuRGCg==
X-Received: by 2002:a17:902:e74c:b0:205:9220:aa37 with SMTP id d9443c01a7336-207521ad0d8mr37591545ad.22.1726059458375;
        Wed, 11 Sep 2024 05:57:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eef2d5sm62993175ad.134.2024.09.11.05.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:57:38 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:57:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: fstests@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
	junxiao.bi@oracle.com
Subject: Re: [PATCH] ext4: Regression test for corruption during on-line
 resize
Message-ID: <20240911125734.44wtifmoyvd74ptq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240911102045.71870-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911102045.71870-1-srivathsa.d.dara@oracle.com>

On Wed, Sep 11, 2024 at 10:20:45AM +0000, Srivathsa Dara wrote:
> Regression test for:
> 	a6b3bfe176e8 ext4: fix corruption during on-line resize
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>  tests/ext4/060     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/060.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/ext4/060
>  create mode 100644 tests/ext4/060.out
> 
> diff --git a/tests/ext4/060 b/tests/ext4/060
> new file mode 100755
> index 00000000..440748ea
> --- /dev/null
> +++ b/tests/ext4/060
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 060
> +#
> +# This test ensures that kernel avoids FS corruption while online
> +# resizing an ext4 filesystem with disabled resize_inode feature.
> +#
> +# The commit a6b3bfe176e8 ("ext4: fix corruption during on-line resize")
> +# stops the corruption.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto resize quick
> +
> +_supported_fs ext4
> +_fixed_by_kernel_commit a6b3bfe176e8 \
> +	"ext4: fix corruption during on-line resize"
> +
> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_command "$E2FSCK_PROG" e2fsck
> +_require_scratch_size_nocheck $((9* 1024 * 1024))
> +
> +# Initialize an EXT4 filesystem with the resize_inode feature disabled,
> +# and a size of 128MiB less than 8GiB, i.e., short of 1 block group in
> +# an 8GiB filesystem.
> +
> +dev_size=$((8* 1024 * 1024 * 1024 - 128 * 1024 * 1024))
> +MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1

Just for sure, is the 8G fs size a necessary requirement to reproduce the bug?
Is it related with the block size (e.g. different blocksize need different fs
size for testing)?

> +
> +_scratch_mount
> +
> +# Perform online-resize
> +$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
> +
> +$E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "Filesystem corrupted"

Do you want to test online resize or online fsck or both? (Does ext4 support online fsck?)

> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/ext4/060.out b/tests/ext4/060.out
> new file mode 100644
> index 00000000..8ffce4de
> --- /dev/null
> +++ b/tests/ext4/060.out
> @@ -0,0 +1,2 @@
> +QA output created by 060
> +Silence is golden
> -- 
> 2.39.3
> 
> 

