Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD628CF7C
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270771; cv=none; b=Dtt81fxWsP+GbQEdrNgfB3CXQvnjC4ZpmrSbwFBPPuYpy2vkM+hTZbtt8SOmPImYLBPPN8y0xer1LAYr1NyZwu2NHq9ypaZms1UgBLR77HCCiMImGhEqvidx3qCMBuE01uu2jIhWQzC829nl4Yk7yDiNKtRJw1TjtV/mxazMJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270771; c=relaxed/simple;
	bh=7vftkpwArnqBlE9KecB2scJyW0Mj/1inAfGuxIRcm3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsOnDTllHu3fkgw9p66ao84eOOMnVBHWffchca7V9RB2YHLXbIBYtAf2DKUjvhbZeGjTFGq5xblzg1voExnSVI5JRt/Wi940ikmBbvAWQLRgoUFSCaDNDhq+R/Bz0cenEkpeU7oIFu5qa4+OB1+ffcKjJIuU2m9puR3l6i/KAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlTTUKHe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlTTUKHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755270768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeHxPsOig0zq82Ip7ldGqrEnK4Cwkx6P0lsmqFquHlc=;
	b=SlTTUKHeMCa/U8ip0Y7A0z48S9TmX6MX0UP1gxuxD7lz8gsS/WqJRkTGDHvsHvvRSBnpYh
	zDnFUVqioHD744p8yvMmMAAJzR4yNTbgRaogTx06pTxiyxsteOMq6cXd6xuVy3SUKfy4Ln
	HGlWkELMhnNnKfZ72SX6xuVK0qwafys=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-VfggxNfRMHKT_e84SB3Sqw-1; Fri, 15 Aug 2025 11:12:46 -0400
X-MC-Unique: VfggxNfRMHKT_e84SB3Sqw-1
X-Mimecast-MFC-AGG-ID: VfggxNfRMHKT_e84SB3Sqw_1755270766
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e6c74eso2190736a91.3
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270766; x=1755875566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeHxPsOig0zq82Ip7ldGqrEnK4Cwkx6P0lsmqFquHlc=;
        b=KKqosT1N+IsMcQLlSsTzZGysYtn9R2PBIf7Hx1mLJlj4RJZfWOSoc/yqVpNo3qQ+iI
         AX6uXk8adUb+ikHhWOR4lpPdOO0QJvpeZtl6eiPScUYLucszMTdgSSQ5GBK/oUMnDONz
         iYx9bO8SLnVF79k3ftMxIv8rTWntmy5CMdhREuMDlJk3HLK2GZe8k7YCPjSqGRMu6CP6
         d34MH5c3juRtxPNdIUAIAHl7WIuV6svE9xRReL9NhtIIfONxWknEapWAZbDHm2H4elV9
         bA6i2wJKghTcYOr4qEiagwYD2VC0TL8asNi2lMBPaxH/oq00LFBOcpnBZbK2tZnZxh7H
         xcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr5Hm/7fsGupBgBh0ONidhKQTW+aceZB8LD+jVFteEyBLJUvXd9UAlSMNUUfVh6evBn/o/dho/@vger.kernel.org
X-Gm-Message-State: AOJu0YxlE3kvv/mSXicOCBpd+GvDDT/jSiUB+3mYdVWFwA7IY2SAiOKp
	/eJXESUqJLLwAfJEljT3RrCoHAgqJzbpm0r1b+6Aq33rm/2Df2G3xR7GmBwMtFlFPdcqU9yRWFs
	GqOfRTJQSMKGjk+5PD51PwIXdbrZ0EGZLGz3ANwh/4K7FCmmVP+KWRXXTf44=
X-Gm-Gg: ASbGncvuKMNvcgy6NkqXGYgL0nH6zIO5Um7P3RJuVTq9HTLelasjb87tHoGEoI0Ncrk
	TONyY9IgXfNfwkTTQOL5hkEqrkeBtzrdlqBVoSm92w2/qBl0VEQ3Ya/1MOuhQNFhM5YzyzV9TJC
	LPgbQ9OX6s7oqlHZJhfq1sheJpMF+Dko3xlmEnDba+dg8Ufru9mVHZU+bp1fewSaDcNU7Gi8AdZ
	zbiJMzhHE0ssbzKSZNlF49nbJRTAIXV2l3jz9f9axbDZzvC91s2hgzLBEkO/dyUTtfZ5ztBLXzR
	9j1tsga9yhOThmFr7fagox9jyyrtOo1MzH+aqdpLy7N7By6az2wWTtOi1eJhF9nggGmje/3weJ9
	WFGwl
X-Received: by 2002:a17:90b:2548:b0:313:2206:adf1 with SMTP id 98e67ed59e1d1-32341df94admr3269695a91.4.1755270765747;
        Fri, 15 Aug 2025 08:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7v6PSFJAR5zXC93og3/f7pOCFGskft2rwSzaDJTPWViTsIYikPsKRuiWduvDK08Vax94rog==
X-Received: by 2002:a17:90b:2548:b0:313:2206:adf1 with SMTP id 98e67ed59e1d1-32341df94admr3269654a91.4.1755270765220;
        Fri, 15 Aug 2025 08:12:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331127c96sm4587523a91.19.2025.08.15.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:12:44 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:12:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] f2fs/020: do sanity check on i_xattr_nid
Message-ID: <20250815151240.aie4fcudoglxvlh5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250814090712.2119455-1-chao@kernel.org>
 <20250814090712.2119455-3-chao@kernel.org>
 <20250814211838.64o3q3jurbxvwp3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <40587d4a-44a2-4d82-9f9f-2934c52aba87@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40587d4a-44a2-4d82-9f9f-2934c52aba87@kernel.org>

On Fri, Aug 15, 2025 at 04:02:12PM +0800, Chao Yu wrote:
> On 8/15/25 05:18, Zorro Lang wrote:
> > On Thu, Aug 14, 2025 at 05:07:12PM +0800, Chao Yu wrote:
> >> This is a regression test:
> >> 1. create directory
> >> 2. add a new xattr entry to create xattr node
> >> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> >> 4. check whether f2fs kernel module will detect and report such
> >>    corruption in the file
> >>
> >> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >> v3:
> >> - use _require_scratch_nocheck instead of _require_scratch
> >> - add missing _require_attrs user
> >> - add comments for why exporting MKFS_OPTIONS=""
> >>  tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/f2fs/020.out |  2 ++
> >>  2 files changed, 53 insertions(+)
> >>  create mode 100755 tests/f2fs/020
> >>  create mode 100644 tests/f2fs/020.out
> >>
> >> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> >> new file mode 100755
> >> index 00000000..7ce1f92f
> >> --- /dev/null
> >> +++ b/tests/f2fs/020
> >> @@ -0,0 +1,51 @@
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
> >> +. ./common/attr
> >> +
> >> +_fixed_by_kernel_commit 061cf3a84bde \
> >> +	"f2fs: fix to do sanity check on ino and xnid"
> >> +
> >> +_require_scratch_nocheck
> >> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> >> +_require_attrs user
> >> +
> >> +# remove all mkfs options to avoid layout change of on-disk inode
> >> +export MKFS_OPTIONS=""
> >> +
> >> +testdir=$SCRATCH_MNT/testdir
> >> +
> >> +_scratch_mkfs >> $seqres.full
> >> +_scratch_mount "-o user_xattr,noinline_xattr"
> >> +
> >> +mkdir $testdir
> >> +# add a new xattr entry to create xattr node
> >> +$SETFATTR_PROG -n user.abc -v 123 $testdir
> >> +
> >> +_scratch_unmount
> >> +
> >> +# inject i_xattr_nid w/ nid of inode node
> >> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
> 
> Zorro, I missed one thing, this testcase relies on a f2fs-tools patch, please apply
> this before running the testcase.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=2174461cdd0a22edc5e7d172605bff4740582438
> 
> Do I need to create a _require_* function for f2fs to verify whether f2fs-tools
> support the required feature or not?

Actually for further f2fs testing (depends on injection), we'd better to have related
functions, you can refer to:

_require_xfs_db_command

Or more xfs_db related functions in common/xfs if you need.

If you don't want to add this _require_ function in this patch (this's not the only
one f2fs case uses inject.f2fs), I think you can send another patchset to do that
later (just let this case fails on old f2fs temporarily :).

Thanks,
Zorro

> 
> >> +
> >> +_scratch_mount
> 
> Oh, I may missed to add "-o acl,user_xattr" here.
> 
> >> +# may potentially trigger a deadlock w/ double inode_lock on parent's inode
> >> +mkdir $testdir/dir >> $seqres.full 2>&1
> >> +_scratch_unmount
> > 
> > Can you provide a test result to prove this test case trigger a failure
> > on general kernel (not debug kernel). If it can, then this version is good
> > to me :)
> 
> Well, expectation is it will hang kernel, so that the f2fs/020 will stop here
> once we encounter the issue.
> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
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

