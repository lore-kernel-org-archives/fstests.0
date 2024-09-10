Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DB187859
	for <fstests@vger.kernel.org>; Tue, 10 Sep 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958679; cv=none; b=B7QapdoJYp5N8aXSQD7x+sdCcl7dNJkWK8FULfZJZxlBJTTxrBe3/qv13mARUczmHG2HPFvP3xtedgIJcyygDD1dqy7Ktn2akmwPUXvvWBahqPHkZiTuhrnMX+Jnq0WCO57gshA1tycu9cX0q5hENC2DoeMyXoPC4fRE1sRF7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958679; c=relaxed/simple;
	bh=IsEmsvFeVX8DIJBC90yytIThBQHwz1fY8VpsXf7i13s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTzDgG6GgJ90HYV3M/kPxDh/MRB/6aZgAdBgURLuArsk2S9es+Z7aWDDlHtl7KsBe/dVYgudkW9tmPT8XXBx01G0C3jxzmqtIAeNXGlIfsEyvTlSF5fN9S/kMUoRv6+O2E2NkVY03zSpGFghgfPZYFcQjNBLhEvpJxd65TNoQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+Nd+LYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+Nd+LYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725958675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gN705/aJssiQyERZ3MXMUcDHR8iN1Usw3Gyoe7gp/Ig=;
	b=F+Nd+LYZ/VyanIsRPuEXB8iXPGD0C2V68a4XTGKYMOOyWGFfGfKnT7nQeWlY5ZU+3CTtgw
	LtBmi5x03BT9GVrij81trOiifazW4ouO+1OhYXEGQkgyewoAuis0AUPw9bedNu2MHXgj9J
	aXKVs9B4mibFyDcIINXYhUkcr1gkFwg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-CS3tWEQ6MDiAYuhAvbagGg-1; Tue, 10 Sep 2024 04:57:54 -0400
X-MC-Unique: CS3tWEQ6MDiAYuhAvbagGg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d8dd20d0ddso7017661a91.1
        for <fstests@vger.kernel.org>; Tue, 10 Sep 2024 01:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958673; x=1726563473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN705/aJssiQyERZ3MXMUcDHR8iN1Usw3Gyoe7gp/Ig=;
        b=Qv69vJafx8Id0CBLz4PGQb3Qurar2C4jmcSRLPkCCbc80KUfkmQ4dIwc4G8EoeV1ku
         I1V4FJt2bdr4hOZ0BVgNpyOIpZa2I5WJnLvHG1R31fJcNUxujQ2Ss1sc/Njgxl4yk4hJ
         sljJzS0Iorz9OtF5jhubS9YlW7GsOjpyebGuoq2potGI4kHykR0h6tDxVL6XYy+ItUcq
         8BLXvy74DkuE09k9TsOnY/7vxQo3isadowJEsPQ+qXzCN4Ol2uIHUgL85lvcaUcxBbbN
         dOKPa/N7hpwDBBxr28/cK8+yKULh8nfGpTuKdkMByHIDB7nq5laOVPTn678JRRNF1j/T
         MdWg==
X-Forwarded-Encrypted: i=1; AJvYcCXkjX3EYCod1WizXrB8k33I+Vej3qjxOJq+MzWsYzmS5Mq26ECtgZqY3LPN0bFPZ0jpz0LXqC17@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6whTTwizy5gjqINNNlmBtakZbJnVIbPDODz+yA5yCaOr6nyVN
	247UorDf97Ke0pg9lO7boSmrucvVVh3N87ic7l5dvmrdBcSqM8w8u5cONdxEAKS6E508XIufq4P
	fbzQa1RHTM67buIALnr8BQZjE/uaT2gEExhVUjS+6wEaT+xJRviVNaWA=
X-Received: by 2002:a17:90a:ba96:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2db67181b2cmr3460538a91.3.1725958672886;
        Tue, 10 Sep 2024 01:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/ojzIDkzUEQHAthzP7MHQ2hXwA+IO45SQRXadI7eTdqsKzCXoXOT+b7IQt0qDOkc2xTWsOQ==
X-Received: by 2002:a17:90a:ba96:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2db67181b2cmr3460508a91.3.1725958672298;
        Tue, 10 Sep 2024 01:57:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c437dsm5842446a91.26.2024.09.10.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:57:51 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:57:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, djwong@kernel.org, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: test log recovery for extent frees right after
 growfs
Message-ID: <20240910085748.jcea37l665dxluge@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240910043127.3480554-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910043127.3480554-1-hch@lst.de>

On Tue, Sep 10, 2024 at 07:31:17AM +0300, Christoph Hellwig wrote:
> Reproduce a bug where log recovery fails when an unfinised extent free
> intent is in the same log as the growfs transaction that added the AG.

Which bug? If it's a regression test, can we have a _fixed_by_kernel_commit
to mark the known issue?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/1323     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1323.out | 14 +++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tests/xfs/1323
>  create mode 100644 tests/xfs/1323.out
> 
> diff --git a/tests/xfs/1323 b/tests/xfs/1323
> new file mode 100755
> index 000000000..a436510b0
> --- /dev/null
> +++ b/tests/xfs/1323
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024, Christoph Hellwig
> +#
> +# FS QA Test No. 1323
> +#
> +# Test that recovering an extfree item residing on a freshly grown AG works.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick growfs
> +
> +. ./common/filter
> +. ./common/inject
> +

_require_scratch

> +_require_xfs_io_error_injection "free_extent"
> +
> +_xfs_force_bdev data $SCRATCH_MNT

Don't you need to do this after below _scratch_mount ?

> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount > /dev/null 2>&1

SCRATCH_DEV will be unmounted at the end of each test, so this might not be needed.
If so, this whole _cleanup is not necessary.

> +	rm -rf $tmp.*
> +}
> +
> +echo "Format filesystem"
> +_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +echo "Fill file system"
> +dd if=/dev/zero of=$SCRATCH_MNT/filler1 bs=64k oflag=direct &>/dev/null
> +sync
> +dd if=/dev/zero of=$SCRATCH_MNT/filler2 bs=64k oflag=direct &>/dev/null
> +sync

There's a helper named _fill_fs() in common/populate, I'm not sure if
your above steps are necessary or can be replaced, just to confirm with
you.

> +
> +echo "Grow file system"
> +$XFS_GROWFS_PROG $SCRATCH_MNT >>$seqres.full

_require_command "$XFS_GROWFS_PROG" xfs_growfs

> +
> +echo "Create test files"
> +dd if=/dev/zero of=$SCRATCH_MNT/test1 bs=8M count=4 oflag=direct | \
> +	 _filter_dd
> +dd if=/dev/zero of=$SCRATCH_MNT/test2 bs=8M count=4 oflag=direct | \
> +	 _filter_dd
> +
> +echo "Inject error"
> +_scratch_inject_error "free_extent"
> +
> +echo "Remove test file"
> +rm $SCRATCH_MNT/test2

Is -f needed ?

Thanks,
Zorro

> +
> +echo "FS should be shut down, touch will fail"
> +touch $SCRATCH_MNT/test1 2>&1 | _filter_scratch
> +
> +echo "Remount to replay log"
> +_scratch_remount_dump_log >> $seqres.full
> +
> +echo "Done"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1323.out b/tests/xfs/1323.out
> new file mode 100644
> index 000000000..1740f9a1f
> --- /dev/null
> +++ b/tests/xfs/1323.out
> @@ -0,0 +1,14 @@
> +QA output created by 1323
> +Format filesystem
> +Fill file system
> +Grow file system
> +Create test files
> +4+0 records in
> +4+0 records out
> +4+0 records in
> +4+0 records out
> +Inject error
> +Remove test file
> +FS should be shut down, touch will fail
> +Remount to replay log
> +Done
> -- 
> 2.45.2
> 
> 

