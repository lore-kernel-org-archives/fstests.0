Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB617C96
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181705; cv=none; b=ZGdtHMtHNzPK+f+d9MI5BAwQQlia/UnoZW0/O93/PZT3K304/zPSMId4Yvj/gXpqnJwQvVHMhDW1CQLvdmAqzmdWSpCGWFzX6/9Ov56Ivxi4P7zhXLvSKenmQ4arFXznEtRK0rcB1ID/5HHJ/X/DGvrmsYA3UvS5Pp7fTuF/EFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181705; c=relaxed/simple;
	bh=2HNhxHiaeTOH3PNYSbWRlX1Q+NRZSSAWDwCdODbQ0N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2d1r5b8YnMiqEeBq8WIhP/5qtV3YJLOHrVgXlltv5TyUK0WLi+/7HmPuKldhK1dJ5vEx3vvC+xnaMDKXSJhZ/PU8pegquPv8TWkE5h18xh3/Fy/qlYgWml2e0qVhF2OpXkHkfIP0fxvt2CpXcQgJgqx6Lpo67RbqoGqCtN0/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goJRWkq/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goJRWkq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afQOoDJ7N3SKirkDmCB9Dck3TWY2wnsLXd8EeJ4bwDs=;
	b=goJRWkq/3s+6zAATBy7G/n3KFMn68MU/BsQ15Zo03uE/ruHDim3AS/2qAtBZkjYgCgNYXW
	XykkUnAE7WnLHlVE4982HLqtJMWdBdk+6SLoucfawGBy5ljrRTvZG95qeRiM4/f8c8rIKp
	Q/TP/z+PlemaPKNWYSpPCpO+dpo5pWU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-z85leuRAOd6eF2JBDLd7KA-1; Tue, 29 Oct 2024 02:01:40 -0400
X-MC-Unique: z85leuRAOd6eF2JBDLd7KA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2bb354e91so5073901a91.2
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 23:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181699; x=1730786499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afQOoDJ7N3SKirkDmCB9Dck3TWY2wnsLXd8EeJ4bwDs=;
        b=vZozqihl0nV/oBVi3Ao1LDidg3HQNghrPFZPz2ZA0jziqEf2DEcAQKFayIpJlpo8oT
         A4ozU1yiqlUnzC/BYP0i0wjDkua1dF3t381sL4hzQNWB5+y974EgLrFtTAbPYIK71tnW
         gGKOcGNW+w7wms/3ej42DNGOymr48nId8jhWFRhqkpmAvEdeUJsyaXUi8mOlgYIFbS8A
         WldFiw7INmKB6REDGPy84uw5zJC31ZG+sBrwgGasrw55Gfab0aNTMdDMa97xDM6jvBKJ
         P7VwC2pieI1vqihRfe+rGcDHq7Mjr2v2JpvLpNm8fFiEjRSYiJUqllUWqxiWZrl1OX7k
         NreA==
X-Gm-Message-State: AOJu0YzfNwkLDm+P7+R4+U8gqZ7cyBAEaCtBdyOtDpHmrcFNGVCcZTBV
	CJqXOWwYnOT+GHX5GHNmZTeKiQ/vo9o/RsGvTcGBXDCH3xhtT4y8mXUHg3ruokqlJXLEX/G0nLE
	9W6rP97bvYzRfrGH/8OFiKQvT14Z1Y9V0Bkvu9FwfiHb/cJVfLnG7AjBD895AnNQpZg==
X-Received: by 2002:a05:6a20:c707:b0:1cf:2862:beca with SMTP id adf61e73a8af0-1d9a842cf55mr15174366637.13.1730181699143;
        Mon, 28 Oct 2024 23:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT/RaPPWGXzVGTz8uaTr5OcTky+S4jQ0Mm8SEsOTGrLL8EvLwGLnPV2wIcbB/D8qD34c63MA==
X-Received: by 2002:a05:6a20:c707:b0:1cf:2862:beca with SMTP id adf61e73a8af0-1d9a842cf55mr15174339637.13.1730181698556;
        Mon, 28 Oct 2024 23:01:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cb06sm6701897b3a.115.2024.10.28.23.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:01:38 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:01:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH v2] f2fs/005: add testcase to check checkpoint disabling
 functionality
Message-ID: <20241029060134.wkqprpmnju2k77yl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241028141700.1786745-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028141700.1786745-1-chao@kernel.org>

On Mon, Oct 28, 2024 at 10:17:00PM +0800, Chao Yu wrote:
> This patch introduce a regression test to check whether f2fs handles
> dirty inode correctly when checkpoint is disabled in a corner case,
> it may hang umount before the bug is fixed.
> 
> Cc: Qi Han <hanqi@vivo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add _fixed_by_kernel_commit()
> - use _scratch_mkfs_sized() rather than formating size-specified

This test looks good to me, if no more review points from f2fs list, I'll
merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> loop device
> - code cleanup
>  tests/f2fs/005     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/005.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/f2fs/005
>  create mode 100644 tests/f2fs/005.out
> 
> diff --git a/tests/f2fs/005 b/tests/f2fs/005
> new file mode 100755
> index 00000000..a817d51a
> --- /dev/null
> +++ b/tests/f2fs/005
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/005
> +#
> +# This is a regression test to check whether f2fs handles dirty
> +# inode correctly when checkpoint is disabled, it may hang umount
> +# before the bug is fixed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."
> +
> +_require_scratch
> +_scratch_mkfs_sized $((1024*1024*50)) >> $seqres.full
> +
> +# use mode=lfs to let f2fs always triggers OPU
> +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +tmpfile=$SCRATCH_MNT/tmpfile
> +tmpdir=$SCRATCH_MNT/tmpdir
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
> +_scratch_mount -o remount,checkpoint=enable
> +
> +# it may hang umount if tmpdir is still dirty during evict()
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/005.out b/tests/f2fs/005.out
> new file mode 100644
> index 00000000..a5027f12
> --- /dev/null
> +++ b/tests/f2fs/005.out
> @@ -0,0 +1,2 @@
> +QA output created by 005
> +Silence is golden
> -- 
> 2.40.1
> 

