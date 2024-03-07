Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815E12EBF6
	for <fstests@vger.kernel.org>; Thu,  7 Mar 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823554; cv=none; b=Jg1rgb3D0PpxD6HcrdDWkyG+6ErTCH5+G3XvvgT4/i/4V0BFoFd3VhkGanUs1C5r9Div01mgVTTzPwVsP1cB+ypW+hcjDHwE+UCN1/O5EhOUGgH/Uk8/eGeK3jCQZWgHmj1nBypigd4vnJNnq7xebhPmqnRV5oN5pBfx8xBuUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823554; c=relaxed/simple;
	bh=fmRqBEVV40Yjjz3PTXDmYJrKgLsAdYWHBdPb6XnDVig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKQEM5TRb0Y8R6ghaVVLC3rlrnCXpMwqx3xMZn0qbb8NvpRJUpMYN4pynyehoi9NAN7YQToxgeSGt4bI3sisrEnWc+KL88Tcem8eygKCtYO7nfk1noOONGlF5CL70Hv8q4ROgLpR1O4pkQrGkCu6RNdNFdHpwaDDKaFHdS4a5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnIBkW+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnIBkW+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709823552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AOKrFzi4NM/z9oNoC48caJkwObGeU/CqSl0/584WbI=;
	b=VnIBkW+kLz8+YaoXfdVONwSZxCxvYVxpNoDaqxEwMp7sAnob78MXt7ooZMjTt3Zh/KrSV+
	KzCI/rV/0q+XNJBk/2+PS6mfdDavZLHAh7ceTHp56M4RfshbOH9c5YQhZhcTXOCgfi1Igu
	7u0vS8E1m5QeJMDRoAujCA5UWEhEmSk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-QXQ10yY5NuaCnyJ9gbNkOg-1; Thu, 07 Mar 2024 09:59:10 -0500
X-MC-Unique: QXQ10yY5NuaCnyJ9gbNkOg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so711201a12.0
        for <fstests@vger.kernel.org>; Thu, 07 Mar 2024 06:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709823550; x=1710428350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AOKrFzi4NM/z9oNoC48caJkwObGeU/CqSl0/584WbI=;
        b=IX6Zeeg0pgIhwIE94pt11TaPq1+ovYLHBDF1NLcv33C6VVuLquPpS1ZEskBEslzeQ3
         75utxqqMmu9ZO5i72J2jL4cR2ajxstWPPjqS0R5jAcRqWLujmyNxpXdeuE3bKYZ3iq3u
         CAOzVGl0NI40XcYj5UlkYHKu6Vmn4DqDZCNGVm4l4ayXcE7vUUbGotFMS5AQIN8eRDNA
         dqM4lX71TCqgVPeS2/t1r5Zkx/ltGstMa/H+8ToiRNTpMfsSk/tIdpb5Ukg5cBxS3vqJ
         oMqiR1l6ZoojySSUWsSwAwxAsPemPBppcF7Yu1IVUihrxFYTNI0QKz+w+pMn10TdDpL1
         CFtA==
X-Gm-Message-State: AOJu0Yz+M91rPL3ju4jnATur2IiTMTcnwVky5WNMiEhst7PqTd9Fhky7
	UApnJ7trAYr4DFQugl+1W2jt8t3udcj3DNIH8ykH/zzQ+sCujBQj8yB40+gLQJY14Y/90mLcb45
	IWUKuSAC2xQjD5CWibVwMn+5netTreGGPABq9En90d1VHXapl09cKV3c=
X-Received: by 2002:a05:6a20:d396:b0:1a1:6dac:5ce0 with SMTP id iq22-20020a056a20d39600b001a16dac5ce0mr3204149pzb.16.1709823549583;
        Thu, 07 Mar 2024 06:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMJLJ09xLLkPEFGmwTDNyphDURUkSvySpNrP2FrSI7rjKCoGrFjLfhzXbR0yL8hfXer8+ApQ==
X-Received: by 2002:a05:6a20:d396:b0:1a1:6dac:5ce0 with SMTP id iq22-20020a056a20d39600b001a16dac5ce0mr3204123pzb.16.1709823549077;
        Thu, 07 Mar 2024 06:59:09 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o133-20020a62cd8b000000b006e06aaf5e58sm13171374pfg.34.2024.03.07.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:59:08 -0800 (PST)
Date: Thu, 7 Mar 2024 22:59:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
Message-ID: <20240307145905.izlzrjjugg34ksdu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

May I ask why it's a "tempfsid" related test?

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	umount $extra_mnt &> /dev/null
> +	rm -rf $extra_mnt &> /dev/null

The "&> /dev/null" isn't needed, if you use "-f" for rm

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
> +_require_scratch
> +_require_dm_target flakey
> +
> +_scratch_mkfs >> $seqres.full
> +_init_flakey
> +
> +_mount_flakey
> +extra_mnt=$TEST_DIR/extra_mnt

_require_test ?

> +rm -rf $extra_mnt
> +mkdir -p $extra_mnt
> +_mount $SCRATCH_DEV $extra_mnt 2>&1 | _filter_testdir_and_scratch

Recommend calling "_filter_error_mount" too

Thanks,
Zorro

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

