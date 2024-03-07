Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC031332B3
	for <fstests@vger.kernel.org>; Thu,  7 Mar 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839229; cv=none; b=tBVQatbjjPdxQ44tZFaMniodBT3xlZ0ySldXcxXDMY77fxXpKfNjNsSdYRlSqF0kyM2oBB7YWzfAVRHpM3mpcBLZlisCnkp1Qmds0yokhkECLVsgeTvlR+1Hp7h92gCiddHI5saAau0tq8VLZNS1QMAOTYIrVZWPm5ONe7Vv3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839229; c=relaxed/simple;
	bh=DPvJrwfnPv3YPwnEanxIx6W+5VuN9Ynlbda5G4URcOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USTr0QzPgQ9zMt9qY2guyILCMniAZu+/WUS9O5YKD96kII5XAH0hJyX1/klS58XHZv+pI9t3Tu9SWkEDYQ3mLgeUPTWFjGE/AncmEZgjPGkWXPUeNeqQe68IdgkWgpYkeYG+8o9Db5fSJwdcp5BPJaNC2MmEsb0/6ku2VzMCpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHIWvcTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHIWvcTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709839225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9WfbMpoFUorDCUZ5uauUsNbFVkULWkKKGarWRB9V6xY=;
	b=hHIWvcTl0v5WZYA3kRA+o7vWFPaZNsw7dMn6U+ZYTp6+0hfk7ZkdiH6oSkPbhPKbeoZsSA
	5ITkVpPa521y1ZCtDIz09md1VOSurniu1sW/HPO9dUN8owwMol224Y2y/mVIuYVrG+Ak+i
	TNcjK58fkpfMDN21IqbdeAsiVomlHVw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-cBOki19aNA-Q35H34eXhZQ-1; Thu, 07 Mar 2024 14:20:23 -0500
X-MC-Unique: cBOki19aNA-Q35H34eXhZQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e5c81df328so981473b3a.3
        for <fstests@vger.kernel.org>; Thu, 07 Mar 2024 11:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839222; x=1710444022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WfbMpoFUorDCUZ5uauUsNbFVkULWkKKGarWRB9V6xY=;
        b=vGk0KatauepfwKvhO0M/IQwAWbo2uJkRYYaWgghS4hpr9qatWLKUO9QQRv1MDCTs2T
         6JJMJY/H1njqCw2wQp2Z3snrPJDpZPsfYfW13aVr+4lbBTB4L56CWn4JSTGfL1nM3Oul
         tO+BEyEMe186Sdfjd1l7psLnBctt4taKwuCl/zwr3JQtr/oMV+ZfLisqraVtIDmyiWjl
         vIKUF2c/2HdyQd/9T4T99IGwZPKTp5Oqfk+TimhZl5GrB3rW5hVhA2kSPsptt/JByUPg
         Wn5xslA6sdbB6pS3y1EXl1WPuwYnNlIxExhLR3MR7jQIlIvNT6VrSBT0UzEnG1Vh4HsJ
         gdTQ==
X-Gm-Message-State: AOJu0YxLuelwwOa8nJU/3Lo8wLQ3THoL02ZlatvD+aJvfMU/IC2IjfZ5
	hNrfIU0aMubb+GND5p2Yf1Nk2fBoj3CN2QCNfeKevRNcp0IfgKHfOvRKV1tLXZIIpGGct2grBSN
	DPnX0KJH6YN/+o74I2do2irJbERkkbGqPmwjTaEWMgExoKAlvTT178oSiVb4GQdmVxw==
X-Received: by 2002:a05:6a00:1707:b0:6e5:9698:84a8 with SMTP id h7-20020a056a00170700b006e5969884a8mr20013777pfc.27.1709839221935;
        Thu, 07 Mar 2024 11:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBLrJUDQedIIht44YpoNSNMgffGU1eT2NUFatBePDFFigzDh6WW36BGHWk73fSVAfgQ6+1mA==
X-Received: by 2002:a05:6a00:1707:b0:6e5:9698:84a8 with SMTP id h7-20020a056a00170700b006e5969884a8mr20013754pfc.27.1709839221360;
        Thu, 07 Mar 2024 11:20:21 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fx14-20020a056a00820e00b006e632056c40sm5977671pfb.0.2024.03.07.11.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:20:21 -0800 (PST)
Date: Fri, 8 Mar 2024 03:20:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
Message-ID: <20240307192017.4lxymyxhplysad4i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>

On Thu, Mar 07, 2024 at 06:20:24PM +0530, Anand Jain wrote:
> When a flakey device is configured, we have access to both the physical
> device and the DM flaky device. Ensure that when the flakey device is
> configured, the physical device mount fails.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/318     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/318.out |  3 +++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/btrfs/318
>  create mode 100644 tests/btrfs/318.out
> 
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> new file mode 100755
> index 000000000000..015950fbd93c
> --- /dev/null
> +++ b/tests/btrfs/318
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 318
> +#
> +# Create multiple device nodes with the same device try mount
> +#
> +. ./common/preamble
> +_begin_fstest auto volume tempfsid
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	umount $extra_mnt &> /dev/null
> +	rm -rf $extra_mnt &> /dev/null
> +	_unmount_flakey
> +	_cleanup_flakey
> + 	cd /
> + 	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs btrfs

BTW, what cause it have to be a btrfs specific test case? I didn't any
btrfs specific operations below, can you explain the reason?

Thanks,
Zorro

> +_require_scratch
> +_require_dm_target flakey
> +
> +_scratch_mkfs >> $seqres.full
> +_init_flakey
> +
> +_mount_flakey
> +extra_mnt=$TEST_DIR/extra_mnt
> +rm -rf $extra_mnt
> +mkdir -p $extra_mnt
> +_mount $SCRATCH_DEV $extra_mnt 2>&1 | _filter_testdir_and_scratch
> +
> +_flakey_drop_and_remount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
> new file mode 100644
> index 000000000000..5cdbea8c4b2a
> --- /dev/null
> +++ b/tests/btrfs/318.out
> @@ -0,0 +1,3 @@
> +QA output created by 318
> +mount: TEST_DIR/extra_mnt: wrong fs type, bad option, bad superblock on SCRATCH_DEV, missing codepage or helper program, or other error.
> +       dmesg(1) may have more information after failed mount system call.
> -- 
> 2.39.3
> 
> 

