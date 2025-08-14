Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80D2550D8
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206330; cv=none; b=PZFe8A+e3HOeI8Fjc7j34+5kzrzxZxjpmrUz7v7OxHtXECa5zU7rbCCBPNx2WKa0NFI4nCScsrbegvhExpubm25+dh3VJhL2ebt1Ic524R1XSF2HasVV1SYWHvjz8vlHnUwnfRNmOa5cn6RV2Lg4wGFLKkoMpOObdjLCXHY5McM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206330; c=relaxed/simple;
	bh=Gv6m5j11kdlZxMYeYjZuYpTIOIxhiwyVscUi981El8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmgHhoir02eQG4ur2L7/VagiazVQeylB0Yo+5wBB/sBYerE1lnIwVLotMRkt5lI9tsivPIEC/evp1u3znUZ1BzLVf7H/vBL5lZmv6SsgwOIxFxdpCjCYT5evCrPNfAY15uhE6DIiFGO4hEviiJgHHye1wC/YR3QF++vY4TkHlFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX4UewNd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX4UewNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755206326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZuTUdKc/I1Yb/5k2Ky1Puj44H2eYVrFSE0veEL1CdM=;
	b=CX4UewNdcQiLYz+BdykXuvaiVwJIwPctiLoEvETV3F9wL1xBfOI1RN/kzeZwL5s4oI9oRa
	eCycgkZ2IGCe3Equ/5YD2PPt8qfF4J8gBOBGIz5vsk69jloPaDHoRtd2DuUQGfed2b0npf
	M2EguXGHTxMIDNS4EVaN1b6RFNAOkzM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-bYe2w6shMPu2hl61WKFEWw-1; Thu, 14 Aug 2025 17:18:45 -0400
X-MC-Unique: bYe2w6shMPu2hl61WKFEWw-1
X-Mimecast-MFC-AGG-ID: bYe2w6shMPu2hl61WKFEWw_1755206324
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso17479975ad.0
        for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 14:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206324; x=1755811124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZuTUdKc/I1Yb/5k2Ky1Puj44H2eYVrFSE0veEL1CdM=;
        b=A5EcuG0bVCXFecEf7bCYXjRDazRICizEG8nKxW6bi715NpWIUpubHjLSjkHDsSI8Ab
         uQIiQOhrpqOa2N4x6ytdJ61mKiTcCJfIxU4fBKkUQNOr5G4D8lQNi/IY+2Gkw40c0QVK
         KYxLEYK108ZDWAOPI7lzuYfl8/qenG9jYg9tieurwVhHkTBsbwAcQiFSmxTTwHygOfjZ
         ZfKF8osmQB1N88uiRSJH+p0dpF1C67TPV2kAdNNEBvur7iXygGv8MgIEEg11vGZj//V3
         cpQ/k6YxkBI4IJgOTayyjohX0U2O4et26C9DSR40pUxDWt+e5W2Xvx4a5RdbbBCI0kTh
         FaQg==
X-Forwarded-Encrypted: i=1; AJvYcCWeG1sjCeGkhSblCMzcVPbiviBzTHbTIAz/rPcNeZDUGo9gI6RJ5SQgNDRr9j1L0HbWL18z2z0f@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhw2YNx+45gWKYc4immenTBxJWCzJxlYUULAOE+auG4fmoL9GY
	Bm3Yjq0S0vjV35kewJpf8pj57lBe8qJ85Eaz96DbiHD2BMeFzx/UojXZxcJyoCwvohUEYfSslN8
	aC7A9nhPuv4NSGFjyEJfhFwkwEsoGVoqXNuPSQ/hFswmM+NR79qmuYA+HD48=
X-Gm-Gg: ASbGncvSyKui9ub6AK+l7AUjq8km7DgQBZQWFDGX7PipP3+d77KtiuPjqIiFrkABuFW
	98E3tcMO86jcOoa1bbP9BUz5HiiTfKO16N+pHql3riPpGgEuKwjzzpr5d7sphyHdB3GodyTUoa+
	6k8O0Gl5uq4RbsOk82G3h6t6mp6zACPyX2o0WfH3rKFKd85gbzzbm68UKwKgyOMKUCTfIasBHdj
	lA6gz7HqwOMLAHc1fOSVlfgJsHi6cB9f5RfZOXX+CtBtKgF4+HHuI24CUBMt0CJOBJQBuF2rsI+
	Qybcu72cLQkc+Y7fOuupgFFZ87jrw73TOTnpw4nOFMhKW34lkYnPTHxBNPISPdS3lphscV6PTE/
	f4iMs
X-Received: by 2002:a17:903:1b23:b0:240:5c75:4d48 with SMTP id d9443c01a7336-2445c678809mr52849745ad.25.1755206323800;
        Thu, 14 Aug 2025 14:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSWyGijicnIQK/ZKF7aBW005jkVYKVn8+7B9/kz03OKnKt9shCIH+cyeaBgS1Lj2jTB+Uy5Q==
X-Received: by 2002:a17:903:1b23:b0:240:5c75:4d48 with SMTP id d9443c01a7336-2445c678809mr52849545ad.25.1755206323459;
        Thu, 14 Aug 2025 14:18:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm363513915ad.159.2025.08.14.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:18:43 -0700 (PDT)
Date: Fri, 15 Aug 2025 05:18:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] f2fs/020: do sanity check on i_xattr_nid
Message-ID: <20250814211838.64o3q3jurbxvwp3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250814090712.2119455-1-chao@kernel.org>
 <20250814090712.2119455-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814090712.2119455-3-chao@kernel.org>

On Thu, Aug 14, 2025 at 05:07:12PM +0800, Chao Yu wrote:
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
> - use _require_scratch_nocheck instead of _require_scratch
> - add missing _require_attrs user
> - add comments for why exporting MKFS_OPTIONS=""
>  tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/020.out |  2 ++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/f2fs/020
>  create mode 100644 tests/f2fs/020.out
> 
> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> new file mode 100755
> index 00000000..7ce1f92f
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
> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
> +
> +_scratch_mount
> +# may potentially trigger a deadlock w/ double inode_lock on parent's inode
> +mkdir $testdir/dir >> $seqres.full 2>&1
> +_scratch_unmount

Can you provide a test result to prove this test case trigger a failure
on general kernel (not debug kernel). If it can, then this version is good
to me :)

Thanks,
Zorro

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

