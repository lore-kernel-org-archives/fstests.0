Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD626306D2E
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272435; cv=none; b=NS42eF0UByzhkZI4pCOg/JXQ6Uf+x1jN90f+14oCV5Ubkzy/0J9nXXYKEYwbQ/FGE+tCbAvjm9IjIFdSp8jMNgdwzrqVMHLzYAoCvjpS/nqBDyZNELGPSULSSZtC+TmK1yAVPdqqKFcB7ECcgii79Bwzd0yHm6YB1a5BO/3AUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272435; c=relaxed/simple;
	bh=Hz3ByH8ecKRmkZY0fYjdTcKQAlpSkacBEAfXECW2CpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCCKPVX0WyRdRmT26g3c5cO8t7HsImXYWiOJG3jYQX0WSmXQ5Jh8nXE7Ra4HvACyS0vxf1YbFIsnPFf5EceM6m3P++0n/3ojKvG0yjGGbFa0/1xIxoym5YGhVSmHP3X98kNS+iPIYqlKd/hAt0cjASclwrVDtuRQlDdAAXFz/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5T0okcl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5T0okcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755272432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h2shLWe0BUVvsKwtzCIiYcr9t5BEPaphZXfmxyJe3R0=;
	b=Y5T0okcl4hdGFP40mCNS18w5m+Zh4uqhzDLduA/img0Ti7tsJWQKEuyUPbY8L9+LeHqnGE
	M/oM7QpU1JEjsGkP7++napIevdc7eVavJwTxUlcUwNbQRdkg5wWvFXmOBr+JxqTPIfK0Pn
	Z4WNNYWuuiXnb6PRw+4cqva8Pebp0Ps=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-nJkmshUsMaax2dFxftvfxA-1; Fri, 15 Aug 2025 11:40:31 -0400
X-MC-Unique: nJkmshUsMaax2dFxftvfxA-1
X-Mimecast-MFC-AGG-ID: nJkmshUsMaax2dFxftvfxA_1755272430
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47253319b8so906403a12.3
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272430; x=1755877230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2shLWe0BUVvsKwtzCIiYcr9t5BEPaphZXfmxyJe3R0=;
        b=l+yhFEPY+9Q4LiHpuqbHqgAlDV4RsNO0Og3UiBumIXSvPnHB8aGfQX2EtHdQ1nBJ3t
         i7FTNNIxa7cadUx3nGCz1OiCPNn//62bMkUx72cej/7Hda3t4LMl+BoUE/Px6MIEPLay
         XDQCm5kCYT2egmSFXWPRb+AivaHYWUIOePOvFESaeAqc7zf8my6gkui12OEm2hUQNs3+
         L1gL5HtZGcmQ2y59jr3XE+v+K4EcoSfryUg9SLczDEdxLov8ozo1W7B7yD9qBoLiIlsk
         /Exoi6ScafsMej/SniVAr4BaJjlHMMubo0OoxBF2+x+5GMyD9eDbADFTGauSAjpTNm14
         L5HA==
X-Forwarded-Encrypted: i=1; AJvYcCX7vGyOOMjDq/gexPvPZ6nQIeK9gTTl+AthRpnO8QdcVAqVbXyRE467d/QgLgsCf/LT1JCQvMjF@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSOBUrXX5nYpNk/jrBDY9mIDjdVb/0AcYn13kAXih8d/0R0A7
	cb02W3p6tSByuY7oeoWaxRsNKnPEKjYp4cYIW8BUTp5wIBln9sy4iP1+xPI4ddY0AElZjCBr0k7
	vAXm9MypNgRMtfObSa3J6mDwWkD0aNgvty/lM0C4Jxvwo6DBF7dk2u4G2eu5fmIifFbk=
X-Gm-Gg: ASbGncslzYbOzaKBuCzhUp6W2cV+t9WObLrY5A8/Durx4PCeqimesCj9umi9/CeCODc
	7iAM5LY8D3Sqiyt5SHx76XpL3KiVCJ9deDLV/B5y7FadnBZLHIIw1Em+6sqduK0GYX0A1IJFi0b
	fc9NV6S9BGCslvaniBpRfIhqRVxs9wnYAd3vCPm/x0JjD+zYH23iO0lWGeJCqPox3sbkhW9LCpY
	HgZVISu3te6FiBAOUT0zq494C+gLFM6YoA0xuFvDOQrYoS04B1oIAjE4T/aTcmclkQVktgn97gV
	m1ZXq/JTBofRPqbpQMriSswnq3CnUFkulWxORq6HGNrASE0AZsl1ck/9laEXH+yGV3QZ+N2hmYL
	cdtLq
X-Received: by 2002:a17:903:46cb:b0:242:accd:bbe8 with SMTP id d9443c01a7336-2446d86b233mr36532965ad.36.1755272429986;
        Fri, 15 Aug 2025 08:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpG2P8TCPc/yq2zXXGVka9uGeMsSuVQPEBzLFlufmsjARUsak3MTv6Hk5VgKCF9aqaahyycA==
X-Received: by 2002:a17:903:46cb:b0:242:accd:bbe8 with SMTP id d9443c01a7336-2446d86b233mr36532615ad.36.1755272429565;
        Fri, 15 Aug 2025 08:40:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ef62sm16642255ad.6.2025.08.15.08.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:40:28 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:40:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 3/3] f2fs/020: do sanity check on i_xattr_nid
Message-ID: <20250815154024.kwpudb7uz4mt2nhr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250815081405.2523015-1-chao@kernel.org>
 <20250815081405.2523015-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815081405.2523015-3-chao@kernel.org>

On Fri, Aug 15, 2025 at 04:14:05PM +0800, Chao Yu wrote:
> This is a regression test:
> 1. create directory
> 2. add a new xattr entry to create xattr node
> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> 4. check whether f2fs kernel module will detect and report such
>    corruption in the file
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - fix mount option
> - check return value of inject.f2fs
>  tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/020.out |  2 ++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/f2fs/020
>  create mode 100644 tests/f2fs/020.out
> 
> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> new file mode 100755
> index 00000000..38bc6582
> --- /dev/null
> +++ b/tests/f2fs/020
> @@ -0,0 +1,51 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/020
> +#
> +# This is a regression test:
> +# 1. create directory
> +# 2. add a new xattr entry to create xattr node
> +# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> +# 4. check whether f2fs kernel module will detect and report such
> +#    corruption in the file
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +. ./common/attr
> +
> +_fixed_by_kernel_commit 061cf3a84bde \
> +	"f2fs: fix to do sanity check on ino and xnid"
> +
> +_require_scratch_nocheck
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_attrs user
> +
> +# remove all mkfs options to avoid layout change of on-disk inode
> +export MKFS_OPTIONS=""
> +
> +testdir=$SCRATCH_MNT/testdir
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount "-o user_xattr,noinline_xattr"
> +
> +mkdir $testdir
> +# add a new xattr entry to create xattr node
> +$SETFATTR_PROG -n user.abc -v 123 $testdir
> +
> +_scratch_unmount
> +
> +# inject i_xattr_nid w/ nid of inode node
> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"

If you'd like to deal with that _require_inject_f2fs_command (what ever name) things
in another separated patchset, this patch is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +_scratch_mount "-o acl,user_xattr"
> +# may potentially trigger a deadlock w/ double inode_lock on parent's inode
> +mkdir $testdir/dir >> $seqres.full 2>&1
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
> new file mode 100644
> index 00000000..20d7944e
> --- /dev/null
> +++ b/tests/f2fs/020.out
> @@ -0,0 +1,2 @@
> +QA output created by 020
> +Silence is golden
> -- 
> 2.49.0
> 

