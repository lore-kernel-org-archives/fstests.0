Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07ED247287
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205845; cv=none; b=b1WtoiCQxPIChjYC2EcQYNchHBGuP54EtTKoLFMECgQHELAN6VHw4ioShGsp6KGdnxr3UE6H+O/0Xndub7f/OJABWHfhrbF5FdFKFgNddAnpmUTowDSPx0WSFJ4AkE4nun+hoqsXr8fxpiq4UDPRBTLb8c2GlH8bKCwG+/gBK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205845; c=relaxed/simple;
	bh=XvVTx7FRz653OdphJRP8atbym25j9taCyVTePrT+fdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3W6WtfvB2UoEjMbJpeIBHc/erwnEf6bFK760IsWEEby1n3vL8X81ZGTAa4uy1g5c3tU7rYs56ujKG5VPVALd/rAdz4DxcUctDGrj6C8JQ2E/oIZAHBHBm933NbUEojv74w07+aG9dzaoPsD/SgGiMFQSijsCIHtdMnasvFY1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUBksLVw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUBksLVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755205842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M1p6iASRLcGUGil+NJHdLdUeyP1HO0f2x6yFT+1wUto=;
	b=BUBksLVwy1amjWu2WHzKQGqfh23aC/LnwnY1S7HXb1bk8eb/zQpcQY+qy4WXgfwl+hrudt
	TOt10KsjHbPF1ne7oHCIXIqkAaoTcTDuvQ0wFwm7oifFjlPDLUijcAGou9a/1KO0+3HtHj
	Fkwlz07KdZcjXFWuj4Dt8x46yq3xhHQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-HWsYuJZVP-myHGcuyUmn8w-1; Thu, 14 Aug 2025 17:10:41 -0400
X-MC-Unique: HWsYuJZVP-myHGcuyUmn8w-1
X-Mimecast-MFC-AGG-ID: HWsYuJZVP-myHGcuyUmn8w_1755205840
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323267bf596so1326070a91.1
        for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 14:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755205840; x=1755810640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1p6iASRLcGUGil+NJHdLdUeyP1HO0f2x6yFT+1wUto=;
        b=ul9grYbYnu2gTW6eDKvPp+7bcaCaa4CPxaORMwPKxyhUj2oUKmj638V/Zyc7lII4BU
         oQIcW9lPW7aYFiKuteFh/OZ9NWVPJ7sUJ2ussr4DDknqcfdaMxu/b0vttjpOxaEd7ubL
         XHLi1FpyJCzkJvCZ8XUz663u7Io6y71A3kDOV0e1HSh3ma/Zk1oI8MLOvXd+AOcV/qhN
         +D03QC5lQa9ZVXSW1Fl401MurMTmCV2aPE8fddNslQzmeXVDoS82B3nap6+TUKmSaZTb
         itSzDRm53RGVaTZ8QUvcrjAjLlwpCl20ATJGwUEemVASDeg46u4mmIl5jqcPKwM4dV8f
         uSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiQdxyp/8Z99hnlXafKWPj9FXjJZayYC5lZxOmWsINc+6CPXGCUs8Inqr5HQUuqkXMsRazCQWg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//UfxsAdFqpCkE63iiRPT+jfgHrpAeHrVKa+P+pYsA38e3+Ko
	CR6fZLIvg6FBVFBaRzNzCfcfpUVXuZuwxVkqopB7natNTtlxeYSfFPCQRhwJJEuYgJyUt5h6UvL
	EeEjOzQpu9CFzncnr4RgmKPCdy96rjeE+ITbz/HRieZHu3Qdupxjo4RD4Ua8=
X-Gm-Gg: ASbGncvknzi6lV/Hymr5yRLVfUIfCxhuu5TpWb4Rdb+AJCLD8cvYO5w1NK5iXMU7KZP
	EH0ozlDCr9ZYEZzUJsdXTws6uuMTIuo1MKrL8ZggsbTsI7spQIBYWgPABc8am6XeRU7zQXo4IDa
	eyzSYGpCkVKIlxRF+acY+evHS5AUeKuvtmQmlPRhl4ETyCmm54pd4WDmnCQw/+uXcBGr7kh7A+Y
	pHb0VpwlWfWYCpuZ/EFdNMJhs7OtM65ZVeig3M3weS/4Hd+l7GTDCurTrlJVCM2IIi1T/V7cAFK
	BRCQ3q0wa7MLOqmI1vLDsAeHb1XjBU+S3fc4qsmDgKoLg9uDQdfxEluilR4McngrsD+4+OEndue
	jfxNl
X-Received: by 2002:a17:90b:4cc3:b0:313:f9fc:7213 with SMTP id 98e67ed59e1d1-32327a52000mr6942050a91.21.1755205840187;
        Thu, 14 Aug 2025 14:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsCbXWyKdDjP0tP1qpujrL82MSjEjK5m9kMdVMb8Cjh6VfAngt41evmn0Tc9j5eHhMZeB0SA==
X-Received: by 2002:a17:90b:4cc3:b0:313:f9fc:7213 with SMTP id 98e67ed59e1d1-32327a52000mr6942023a91.21.1755205839765;
        Thu, 14 Aug 2025 14:10:39 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f8329asm2838253a91.3.2025.08.14.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:10:39 -0700 (PDT)
Date: Fri, 15 Aug 2025 05:10:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] f2fs/020: do sanity check on i_xattr_nid
Message-ID: <20250814211035.3eqltmi4wkuxuhq7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
 <20250811094415.1053545-3-chao@kernel.org>
 <20250813153407.b2ldb3u3zuw4ckbs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <580b6314-4c79-404c-b8cc-c3d416bc09e8@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580b6314-4c79-404c-b8cc-c3d416bc09e8@kernel.org>

On Thu, Aug 14, 2025 at 03:54:59PM +0800, Chao Yu wrote:
> On 8/13/25 23:34, Zorro Lang wrote:
> > On Mon, Aug 11, 2025 at 05:44:15PM +0800, Chao Yu wrote:
> >> This is a regression test:
> >> 1. create directory
> >> 2. add a new xattr entry to create xattr node
> >> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> >> 4. check whether f2fs kernel module will detect and report such
> >>    corruption in the file
> >>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  tests/f2fs/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/f2fs/020.out |  2 ++
> >>  2 files changed, 52 insertions(+)
> >>  create mode 100755 tests/f2fs/020
> >>  create mode 100644 tests/f2fs/020.out
> >>
> >> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> >> new file mode 100755
> >> index 00000000..a6a08c8f
> >> --- /dev/null
> >> +++ b/tests/f2fs/020
> >> @@ -0,0 +1,50 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> >> +#
> >> +# FS QA Test No. f2fs/020
> >> +#
> >> +# This is a regression test:
> >> +# 1. create directory
> >> +# 2. add a new xattr entry to create xattr node
> >> +# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> >> +# 4. check whether f2fs kernel module will detect and report such
> >> +#    corruption in the file
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick rw
> >> +
> >> +_cleanup()
> >> +{
> >> +	_scratch_mkfs >> $seqres.full
> >> +}
> >> +
> >> +_fixed_by_kernel_commit 061cf3a84bde \
> >> +	"f2fs: fix to do sanity check on ino and xnid"
> >> +
> >> +export MKFS_OPTIONS=""
> >> +_require_scratch
> > 
> > Same review points with patch 2/3, 
> > 
> >> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> >> +
> >> +testdir=$SCRATCH_MNT/testdir
> >> +
> >> +_scratch_mkfs >> $seqres.full
> >> +_scratch_mount "-o user_xattr,noinline_xattr"
> >> +
> >> +mkdir $testdir
> >> +# add a new xattr entry to create xattr node
> >> +setfattr -n user.abc -v 123 $testdir
> > 
> > You can call `_require_attrs user` at first, then use "$SETFATTR_PROG"
> 
> Okay, will update them in v2.
> 
> > 
> >> +
> >> +_scratch_unmount
> >> +
> >> +# inject i_xattr_nid w/ nid of inode node
> >> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
> >> +
> >> +_scratch_mount
> >> +mkdir $testdir/dir >> $seqres.full 2>&1
> > 
> > May I ask what kind of failure will this case hit, if there's the bug?
> 
> Bug like syzbot reported, you can check the details in below commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=061cf3a84bde

So you hope to trigger a test failure by something likes:

"generic/361       _check_dmesg: something found in dmesg"

?

Did you try that, if it can fail this test on general kernel?

Thanks,
Zorro

> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> >> +_scratch_unmount
> >> +
> >> +echo "Silence is golden"
> >> +
> >> +status=0
> >> +exit
> >> diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
> >> new file mode 100644
> >> index 00000000..20d7944e
> >> --- /dev/null
> >> +++ b/tests/f2fs/020.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 020
> >> +Silence is golden
> >> -- 
> >> 2.49.0
> >>
> > 
> 

