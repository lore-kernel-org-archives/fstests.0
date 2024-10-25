Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345A1BC5C
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829487; cv=none; b=qnNYFQYzQW/cdIaYMZ7BOjEcdfhAUYiMCnuFbZK/bSyTlHVUUp8taNTuPq4Ldkee4KH9sjpDYY63BbQZs/isOC1lPrEeqPbmAmAv4N922KfDsnN+n/qvbS8vuCzF2NTD0nuxLkHhawfIuz5K3aIFY1DP6FUp3YgTodKNeD9LQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829487; c=relaxed/simple;
	bh=Zqj8Wi+rVSHkP3an0/0Gy+pcrta4+2LdxPGEgSZkP5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDEHFwOqQhUCUDLrP9wK+PY4XhxVXfAltgygeAXLVZn4GhTKNIJyoPi3/EV8N85j9qae+CwT/sS0QEd6OGy+XhCmMgcT/5wXgoEhxJBOS7zyzpajH7vqAPh6CBNNHck+yz+7s/YD5fbMfDELRB46v6WyIvFwdXCDnM8dgQt1FuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E14iR4XF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E14iR4XF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729829484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3C6auYKzVKIpEFES/i+1K0CJmzvBwKiBfR6b6wIFhXE=;
	b=E14iR4XFXqABFrQpogdWfgMTrrBWz5z7bl0TwzoTBlcpaiyZ/9FiEvjHH4Qu9OVo5Rs0Z+
	DA3NSIZpMXyGqASr1encPExU2+vZEUaIvjST68JsmKI2shu/8ZpQtpT44jo4moZeP1KWRa
	DBhpHiQtWY9CCblc3DaIA/wFmv8EtBE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Jofu3p8rM1uXE0a74bCbpw-1; Fri, 25 Oct 2024 00:11:21 -0400
X-MC-Unique: Jofu3p8rM1uXE0a74bCbpw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e33e5fc515so1640376a91.1
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 21:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729829480; x=1730434280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C6auYKzVKIpEFES/i+1K0CJmzvBwKiBfR6b6wIFhXE=;
        b=Eu5bksc0EqHWY9ejA5JPnuteXBT9ce5GBzCnrK6iQdl6aD7229cYCJWQuz4BS1sLyd
         6UApr1FOVi2I70K5SdrJEuJHEj7nCY/ehdnEM3Ac5j5BdTiR96AI2nJtQ/bN3XNEQenn
         kEVlH8qh0kbwxnZMQQv2yXc9z4tpiUEA+3RpwQOROYZHmrezzNdrFQ6YSEGXZDIrKcxJ
         tR3BJmnNNitfSIGia+V3aNPdYqSV5iJ3wNGSlqsqhVXGRlP2rxhnR9k9G6s77fNIzPNs
         uwYHOH1gIVDGrAOIXn3qkA9H4V2/y7Cc25zI5JncmGmn88e68AXFubf0bdEdOFP7H5qL
         pE7Q==
X-Gm-Message-State: AOJu0YzEzvG9JNpqwdYTDpRUqaTyn5rawcgMut42I8a0d94z8+ertUOU
	m6nKWrEAfdSnrB5PU2dde2HM4j7xE8ljy/2FcVIHOALtUv9cmr1pVOw1Pwb4a1XGxX2JbD9gdcw
	BUq1P2UiQ1zvQMRCI0+0ssys4+3IHaQiO6aYjMQa1TCckgjTYi2KXhPYT10a5y+PGqg==
X-Received: by 2002:a17:90a:d512:b0:2e0:921a:3383 with SMTP id 98e67ed59e1d1-2e76b5bbd39mr9869280a91.1.1729829480530;
        Thu, 24 Oct 2024 21:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtLxfla3FbB1McVSJoKWugUU11IDzU9KFpry60sKdXTkr7/Qylp9lAFDxB9cSVApc4jHKOjg==
X-Received: by 2002:a17:90a:d512:b0:2e0:921a:3383 with SMTP id 98e67ed59e1d1-2e76b5bbd39mr9869267a91.1.1729829480205;
        Thu, 24 Oct 2024 21:11:20 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3749154sm322326a91.46.2024.10.24.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 21:11:19 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:11:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH] f2fs/005: add testcase to check checkpoint disabling
 functionality
Message-ID: <20241025041115.fmv2wt7qy6s55hip@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241012101501.377899-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012101501.377899-1-chao@kernel.org>

On Sat, Oct 12, 2024 at 06:15:01PM +0800, Chao Yu wrote:
> This patch introduce a regression test to check whether f2fs handles
> dirty inode correctly when checkpoint is disabled in a corner case,
> it may hang umount before the bug is fixed.
> 
> Cc: Qi Han <hanqi@vivo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/005     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/005.out |  1 +
>  2 files changed, 60 insertions(+)
>  create mode 100755 tests/f2fs/005
>  create mode 100644 tests/f2fs/005.out
> 
> diff --git a/tests/f2fs/005 b/tests/f2fs/005
> new file mode 100755
> index 00000000..4faf1bb9
> --- /dev/null
> +++ b/tests/f2fs/005
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/005
> +#
> +# This is a regression test to check whether f2fs handles dirty
> +# inode correctly when checkpoint is disabled, it may hang umount
> +# before the bug is fixed.

Is this a duplicated test of another patch from you?

https://lore.kernel.org/fstests/20241025034413.5s6ecilfgqcoeudt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#t

Or just similar?

If this's a different test ...(see below)

> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	rm -f $img
> +	rmdir $mnt
> +	_scratch_unmount >> $seqres.full
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_require_scratch
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +img=$SCRATCH_MNT/f2fs.img
> +mnt=$SCRATCH_MNT/f2fs.mnt
> +testfile=$mnt/testfile
> +tmpfile=$mnt/tmpfile
> +tmpdir=$mnt/tmpdir
> +
> +mkdir $mnt
> +dd if=/dev/zero of=$img bs=1M count=50 2>/dev/null
> +$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
> +sync
> +
> +# use mode=lfs to let f2fs always triggers OPU
> +mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt

You can use _scratch_mkfs_sized, don't need a loop device.
And without the loop device, above _cleanup is not needed either.

> +
> +dd if=/dev/zero of=$testfile bs=1M count=5 2>/dev/null
> +mkdir $tmpdir
> +touch $tmpfile
> +sync
> +
> +# it dirties tmpdir inode by updating ctime,
> +# but it doesn't moving the inode to gdirty_list.
> +mv $tmpfile $tmpdir
> +
> +# it runs out of free segment
> +dd if=/dev/zero of=$testfile bs=1M count=5 conv=notrunc conv=fsync 2>/dev/null
> +
> +mount -o remount,checkpoint=enable $mnt
> +
> +# it may hang umount if tmpdir is still dirty during evict()
> +umount $mnt
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/005.out b/tests/f2fs/005.out
> new file mode 100644
> index 00000000..caa3c880
> --- /dev/null
> +++ b/tests/f2fs/005.out
> @@ -0,0 +1 @@
> +QA output created by 005

If nothing output, please:

echo "Silence is golden"

Thanks,
Zorro

> -- 
> 2.40.1
> 

