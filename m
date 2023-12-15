Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A803010A
	for <fstests@vger.kernel.org>; Fri, 15 Dec 2023 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhpMEQUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702661509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXHL8f9pyOa4dJRx4lsaX80MC0Z5YuSe1frD+xaf1/w=;
	b=VhpMEQUMpo3zjg5bJKl3vSzhm5dzrWy1u7pCtDVOYSlStzzfyZihhgK8C/5r+/GSNkvOJT
	/zFoNCy7uHdJ21bx8MFVFEW+ZC+qj7XB6s3bLb2GZFX1Do+CVHVTJpRBIsU/ZETzP2/wMB
	9WV8ItsnI00MHfX6ADCh9KCCrRNLpfg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Zg32jBthMqucdKxBwZa_Nw-1; Fri, 15 Dec 2023 12:31:47 -0500
X-MC-Unique: Zg32jBthMqucdKxBwZa_Nw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6a04d3a8bso507063a12.2
        for <fstests@vger.kernel.org>; Fri, 15 Dec 2023 09:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661506; x=1703266306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXHL8f9pyOa4dJRx4lsaX80MC0Z5YuSe1frD+xaf1/w=;
        b=GDsdxKrhoEccfg3Xf4gfhhSjGv4d4AZyMfoCd0RyJ06yvN6KPYe2TyptvF4454FZ+x
         je6Hm5Bo/MKxPBHnTM+MmMtlHvjgYJqqGoKqtW/Rj3rVMqxPvd+uBAM3mnon0vNO8xpw
         tCA+LXSAtbm8xDvvS07JMxsO+AnFeglHSuwvYJ+C/vi75OHiXoff3tBU5O+3P494y9HZ
         kjti1WEOKAjv3C6AC5KK7MOPy1DQeWGkf44Aokk5jIAFwA3XCsefPcwCZk0fuUqaT3dX
         nI2jvBEJja+FoAWYfUDGEziiqZl65wBzzHkPYwyzAXyJacPQetV29JI67aMAftg/aDJn
         BOKg==
X-Gm-Message-State: AOJu0YwKTAgM/ujj2wy1OYa691JDHvoMO8nB77Rxd2LbUthBO4Njxecn
	C2dBWpHZBVathtwk6CUm4V9Bbtspf8TUdJNnlWDhPAAIqZ/HJnU13W8U9+63x8EGAtRtheNy687
	/r88K3d7GRAhOs/D2aA==
X-Received: by 2002:a05:6a20:e110:b0:193:fc1b:2a18 with SMTP id kr16-20020a056a20e11000b00193fc1b2a18mr516905pzb.30.1702661506581;
        Fri, 15 Dec 2023 09:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpISmciFqiv8BHLeZTD1mfdieMqWsYpf2KaELlupU1L+SXhIB3y+1BcloNEgM82uHGfvNEzg==
X-Received: by 2002:a05:6a20:e110:b0:193:fc1b:2a18 with SMTP id kr16-20020a056a20e11000b00193fc1b2a18mr516896pzb.30.1702661506259;
        Fri, 15 Dec 2023 09:31:46 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ga23-20020a17090b039700b0028b0a4e4b7asm3600887pjb.40.2023.12.15.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:31:45 -0800 (PST)
Date: Sat, 16 Dec 2023 01:31:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/new: drop caches while freeze
Message-ID: <20231215173141.g5qrvcgo2p3hjbo4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <CADJHv_t4fzLjNBfabTSVgSW8QAjq7V=s_wW7cOJ8UPo+t9vdNw@mail.gmail.com>
 <20231215115505.1826465-1-jencce.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215115505.1826465-1-jencce.kernel@gmail.com>

On Fri, Dec 15, 2023 at 07:55:05PM +0800, Murphy Zhou wrote:
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
> v2:
>   re-number to 738
>   mkfs and mount scratch in the begining
>   create more files and comment why
>   unfreeze in cleanup

This version looks better to me. I'll merge this patch with a few of
small changes. Thanks for this new coverage!

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/generic/738     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/738.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/738
>  create mode 100644 tests/generic/738.out
> 
> diff --git a/tests/generic/738 b/tests/generic/738
> new file mode 100755
> index 00000000..9f1f9d6b
> --- /dev/null
> +++ b/tests/generic/738
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 738
> +#
> +# Test possible deadlock of umount and reclaim memory
> +# when there are EOF blocks in files.
> +#
> +. ./common/preamble
> +_begin_fstest freeze auto quick
> +
> +_cleanup()
> +{
> +	xfs_freeze -u $SCRATCH_MNT
> +	wait
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_supported_fs generic
> +_require_scratch
> +_require_freeze
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +create_eof_block_file()
> +{
> +	# Create several EOF blocks in the new file
> +	for j in $(seq 1 5); do
> +		cat $SCRATCH_MNT/testfile >> $1
> +	done
> +}
> +
> +$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/testfile >> $seqres.full
> +
> +# Create enough files to make sure there is enough cache
> +for i in $(seq 0 1024); do
> +	create_eof_block_file $SCRATCH_MNT/$i
> +done
> +
> +sync
> +
> +xfs_freeze -f $SCRATCH_MNT
> +
> +# This will hang if bug reproduces
> +echo 3 > /proc/sys/vm/drop_caches &
> +
> +# Wait a while before exiting and unfreezing.
> +sleep 3
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/738.out b/tests/generic/738.out
> new file mode 100644
> index 00000000..5719515a
> --- /dev/null
> +++ b/tests/generic/738.out
> @@ -0,0 +1,2 @@
> +QA output created by 738
> +Silence is golden
> -- 
> 2.31.1
> 

