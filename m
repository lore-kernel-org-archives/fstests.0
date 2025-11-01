Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6E15D1
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762010638; cv=none; b=ay3e6mFUQN1Ebs5AEFid4PLMG8xVoG1PJgnphYivTV2Fj1nqUACp2dOqKBQjwsAWjwhKDSqslAMTOq1eZNLx4GwnPSkTLUmkUmUsg+IM0vltMXiTQN23ECx5058IWeUcEiEyc6mtsMvr6oGLw4Jz+v7LtNlHspROMCG0JGrfCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762010638; c=relaxed/simple;
	bh=sNJtfMuYPVUBeREqlZOdvrHc0jMp5mMTVgOdBnWOwDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+O1Jb5say8p7QCPe6rn4m/PgD3XjRXl2+CI+DzzmlQnvTgDlLsGBxv0n3A7F5LIXMMcjFt8HekeXSYkQlBr3Sae+ate4QDx5avnF6GOqxyLW/1BkDEAYMzlFhShpLfIPMbTUfJNmuWZJvhekg6lErUXS5Wr6srMdIEbJ4iUwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANmqfzaY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbJ6yIXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANmqfzaY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbJ6yIXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762010635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyPXImxXazHny8jsMFSxmes8gpi0WI65WL50eQDN24s=;
	b=ANmqfzaYKkKre2+pgXrhC8JV9HOrDDpidCMJraIss02lRrRTAuYHC7kfdmViZRR8UZ87a7
	vTbQGXhcVUkF0B8GfVuwHNGPakzBOeg8aRkCs4v8AGo9DQwFt6Ad6cs1GaAdHuI8n1Cw5D
	dOCIAO1vhskiF3fLJbxhg8KS2bIBpNE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-LFXmMk5ZNm2xjvZ8Du3pdQ-1; Sat, 01 Nov 2025 11:23:53 -0400
X-MC-Unique: LFXmMk5ZNm2xjvZ8Du3pdQ-1
X-Mimecast-MFC-AGG-ID: LFXmMk5ZNm2xjvZ8Du3pdQ_1762010632
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso2200971b3a.1
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762010632; x=1762615432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyPXImxXazHny8jsMFSxmes8gpi0WI65WL50eQDN24s=;
        b=JbJ6yIXxq555iocEYj9oGxswApkUneSOAVuMzdA/5/4BuBXsSNyj/S+9O5hsRXNODd
         099jpAWcv9WxnMii3/3o1QWECNcuSTsujws1RKojRCmORFw9HzraoFED+x/hhbgatb3I
         I2Iqt3wakk7B2TgBoQvAjGqLY5j9MTe/gVA0ibkUIkJfHG5ow+EdyT+ot2/pQGIQ775w
         FAcbes50HnGeYAEdG5fKbQX1I0LYy/MDhbZKjbCB6p3Pfs9LJUkQvE35D+kS9zdA7pLt
         c+jN7KIm+aBfdI8xTsNyyEl+UKQDZoCYQweErlPycrgCXq5xKhWw07yITTf+Cu7KdtUf
         mbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762010632; x=1762615432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyPXImxXazHny8jsMFSxmes8gpi0WI65WL50eQDN24s=;
        b=D5fLVKuPPxZinfRds3HBw8MYp+CEyblgoXQmA+5u1j+IhoWxzh67bwQcJWpdRDhtKY
         E0ZjbWxbFTA0WKkKAPYwxTWqvuNJ8YzY+RgRKZY0foocMBZEcWMm/qWHxSE8pfLx6i7v
         VGadFaiDgmjxjC5lUKkUu1YxVlOsSQEmRGkNjHcUCuRSeAF2kouSfJdsLPHCofHCbssT
         Dlwm/l2dId1+aS/flSRnqIv5QHAjpfnC7APcEFkh8seJr4fqsryLcX7+0zyOX3mj6GlO
         8NIbnNb5OWK8DHuFBwQucygYDjrAP8P0i2PYSLlXpGWpIVhrCbt9ERT2vP2WbGxokOAL
         gqCg==
X-Forwarded-Encrypted: i=1; AJvYcCUBoyftfCskaYsxRbQtmBG5HXqS+AHpQlSFVe1G20JS1XrLlFaYhP3i3MjjWQM0iPjnk4HzlphQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+ju/v7PllH5BxQ7xcuWquGYwQ9tJofcjOpJNozs8K9sNcRhs
	37Jc+Q9TgZCr3Yn7PpAH//VU8ddTKlROZ2G3Zif5b5mMBkIApioB2KL4BSv1uoUIAXsfpKKHO7Z
	7Q3mGBwKL4wJPBe7gxo5wvI6WVFh5CeZWiDgg16ifjdPjoH9Dul7kGAVARJA=
X-Gm-Gg: ASbGncugFioYhmRF97ak2xqKAEzSL9c5Mqr4YL+tiW3F9vyS/wgrTbvdX8c5G32PT0C
	RBzTxPEqOBpr5ZTt7vJ+aBc45xJRMjSIHhUdvRtJ7HGRyCmD7C/IGVoA/ienhsy6k+677tzDcbY
	sC3vrPPNaIZhjKGOaA3cWJeWAyntw4WNLKCLjEUEtGKMSqksEsOTJZoY8f8Y7Sz2QlO+NfCELPt
	2hz5OLkicpufoFTgTDSWCdOF/jT3rnGvLIelQuEychfEOSkMrIpH8tThhFESrIs2nz/UGXXAu8c
	Kc1Xa9CBejpXg2pIBTunf4tLETB2BWohinADAJiZmPmAAsBzscN9xmiRrm72JHfZZhjKzV+oaBb
	GNBVbPel3jcAaiPjKjznpmUXwPleB01/R9sWZZsU=
X-Received: by 2002:a05:6a00:18a4:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-7a756661b37mr8405027b3a.5.1762010631931;
        Sat, 01 Nov 2025 08:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuIfUpwBy66icUgvx39wGiE1kn8eJTe87Qes/ptbUXK70Hhx4gY1O87feEAvMGGwDRNPrRxg==
X-Received: by 2002:a05:6a00:18a4:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-7a756661b37mr8405010b3a.5.1762010631392;
        Sat, 01 Nov 2025 08:23:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d9261c1fsm5517125b3a.30.2025.11.01.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:23:50 -0700 (PDT)
Date: Sat, 1 Nov 2025 23:23:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/023: test sanity check condition w/ error injection
Message-ID: <20251101152055.35zyuql6li2zzny7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251029115413.1085987-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029115413.1085987-1-chao@kernel.org>

On Wed, Oct 29, 2025 at 07:54:13PM +0800, Chao Yu wrote:
> After commit 5c1768b67250 ("f2fs: fix to do sanity check correctly on
> i_inline_xattr_size"), f2fs should handle corrupted i_inline_xattr_size
> correctly, let's add this regression testcase to check that.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Hi Chao,

Thanks for new test case for f2fs. Some review points as below :)

>  tests/f2fs/023     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/023.out |  2 ++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tests/f2fs/023
>  create mode 100644 tests/f2fs/023.out
> 
> diff --git a/tests/f2fs/023 b/tests/f2fs/023
> new file mode 100755
> index 00000000..d1b7df32
> --- /dev/null
> +++ b/tests/f2fs/023
> @@ -0,0 +1,44 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu <chao@kernel.org>
> +#
> +# FS QA Test No. f2fs/023
> +#
> +# This testcase tries to inject fault into inode.i_inline_xattr_size,
> +# and check whether sanity check of f2fs can handle fault correctly.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_fixed_by_kernel_commit 5c1768b67250 \
> +        "f2fs: fix to do sanity check correctly on i_inline_xattr_size"
> +
> +_require_scratch_nocheck
> +_require_inject_f2fs_command node i_inline
> +_require_inject_f2fs_command node i_inline_xattr_size
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +# remove all mkfs options to avoid layout change of on-disk inode
> +export MKFS_OPTIONS=""
> +
> +_scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full

As you use specific mkfs options, so better to _fail "..." if mkfs fails.

> +_scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
> +touch $testfile
> +_scratch_unmount
> +
> +# inject .i_inline field: clear F2FS_EXTRA_ATTR bit
> +$F2FS_INJECT_PROG --node --mb i_inline --nid 4 --val 0x1 $SCRATCH_DEV \
> +		>>$seqres.full || _fail "failed to inject i_inline"
> +
> +# inject .i_inline_xattr_size field from 512 to 2048
> +$F2FS_INJECT_PROG --node --mb i_inline_xattr_size --nid 4 --val 2048 $SCRATCH_DEV \
> +		>>$seqres.full || _fail "failed to inject i_inline_xattr_size"

I found my system doesn't support i_inline_xattr_size,

  # inject.f2fs -V
 inject.f2fs 1.16.0 (2025-08-12)

I tried to removed above "_require_inject_f2fs_command node i_inline_xattr_size",
but I found this test didn't exit from above _fail. The .full file got:

  [inject_inode:833] unknown or unsupported member "i_inline_xattr_size"

So are you sure the $F2FS_INJECT_PROG return error if "failed to inject i_inline_xattr_size" :)

> +
> +_scratch_mount
> +
> +getfattr -n user.test "$testfile" 2>&1 | awk -F ': ' '/Structure needs cleaning/ { print $NF }'

As you need "user" attribute, so you need "_require_attrs" (. ./common/attr), also
the test group should have "attr".

If you don't need _getfattr, please use $GETFATTR_PROG at least.

And how about replace the "awk" with "_filter_scratch" (. ./common/filter)

Thanks,
Zorro

> +
> +status=0
> +exit
> diff --git a/tests/f2fs/023.out b/tests/f2fs/023.out
> new file mode 100644
> index 00000000..7f16f33f
> --- /dev/null
> +++ b/tests/f2fs/023.out
> @@ -0,0 +1,2 @@
> +QA output created by 023
> +Structure needs cleaning
> -- 
> 2.49.0
> 

