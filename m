Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDA2DCC06
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010742; cv=none; b=TGMcT/FhijvMSULtDBk7XtNWt+67kXynoMAiloT/qncXtdcIMhSf81UEcnxmPYrdZ0QwIbupT4Nmffv5cmBCx04JctFdBpS/INAi9cPApBHxlcAsLbd2HYcOP85YUDNKh+opzNSoiE1TE7Kgxye3K3dJ2fgoHMvvQb7RuDCYYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010742; c=relaxed/simple;
	bh=Uiu1qmMAaHWD6dTekwuV9gPxajMcCO8lGetlLAek/bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/B5KBa/sB085YIBguR4fPirvGf/qQuPgQQqXHV90hSB9jy8DitQVtuy4PLRFx/qcm+V0QwRe2LirKetVp8aXmzLeRuXsz1EsvA3KiDVOoHSYQRq6oc9eY0DnZNX9hv1ixGrUjAmdeNZdsYEIzSi/3cQfgPl5sEBD/kztnFDrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoxpfPeI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoxpfPeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748010737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsOrD6RccmXcmvSNUP2aWZDRJP25W6EDJHGI6Pg7wu8=;
	b=OoxpfPeIrioM2IMPnlUlR+s0BzqzrqjnRKOenbR671+HmgMIgi9RZtoYfVH9lMypdpza6v
	EnVh4n7uFiWTyJjvD213rfBwGqvj/CV2lfaA9batpFYSYnPJnzBINjbXYE+OYidk+SinY7
	oNR9fpfmpW77rdycWtpKWHdXUsv16Co=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-1F-GJjJoNhe-QwdxkzRhVg-1; Fri, 23 May 2025 10:32:16 -0400
X-MC-Unique: 1F-GJjJoNhe-QwdxkzRhVg-1
X-Mimecast-MFC-AGG-ID: 1F-GJjJoNhe-QwdxkzRhVg_1748010735
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742c620e236so8360b3a.1
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010735; x=1748615535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsOrD6RccmXcmvSNUP2aWZDRJP25W6EDJHGI6Pg7wu8=;
        b=O7DdcSe8vFDPxhtFLo7slCc6HuCzWiAeYObSWZ1gnrvvF8skpLXm+FISUHkgujKoQY
         SyW4zz2a7R9bjAJ+kw2jAD8tYyUDxtsi6Rm26AgE3RgH8Hr9a4ejwHdlECebpkUEyZ+K
         QL3yRs0QXsMl1TiP8argM9RIVtZ7GUcmY27EZhIpQsKvyWPdhoIDXP+EAzgX0K/HdLj7
         WEg7aovhu3KwVk6NBjTgB17VwJtRYkMhii5WSeYRF8RMe5QIMRheKkNNXsteDf3BpSNR
         PE6FxkK2Ck35mEgxo9rjRwPX6txrfOyF1wKgnCiXFIqyQPz8jnOlhqvwvMzD55hwiyhb
         ZFFg==
X-Forwarded-Encrypted: i=1; AJvYcCXoRo6TrRHkF4uRXLUebygGups7chbgGGaX2kjQ4kvIegjYCfhV8cqPhSTfPnAY+6mx83jjZpdN@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+/CvNNXRTLr7lrbxt6QiIfvEM98mXaPiPtmOhGOaFofnzqRf
	72K+qk+7RfE7tn9nWsI5Y4fh+x3TW7Ppsu54y4tiVuUXGrzUc+9LmXGgjSOpOS/JAa7oniCZHpG
	aCGuPmdb5Ur0hG6XS4cv06Lx1NtqVcFSW4KIC3ZImp/OHYYU5TZU/rmDSYWo=
X-Gm-Gg: ASbGncuImfRi2MxcTTX4seW1nTkZapWT4kKOdzE0FzOmzjd1Kwt2qMjobUU6UA0uFDk
	d14DhFvd7EZbXxPbS+zIg1WCTFEdAnoEypjXcW4r2gXi2sPbj3f6Z1Kr4LJAIoqdQfNnZFZKge2
	nXRpUcycv4Pa2s3o67VZqzHKutRX5VPc74s7+9TaZ6uwXMYQEczhQRBKOTr0pD7VJYJLq9jqx43
	jxmMQsieKWz999aUe00DzYFD6e0j4H1FARUI/23QcObs/xpEOoHqxa00ZYTvDhd6znv89PuI3wL
	wgyMD+KhDW4i9yqQa869L1kGsHGF16Vg3+D7OdLm6hEaWqvEtmCo
X-Received: by 2002:a05:6a21:3a88:b0:1fe:5921:44f2 with SMTP id adf61e73a8af0-2187a1e9a59mr4126336637.20.1748010735252;
        Fri, 23 May 2025 07:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERLFBCTWvy4eb9i8rksVbHGn7Ov3OtaO4PtznXFR9FSNiLkX8sQ5gs6+g8xhWnVirotFdSFw==
X-Received: by 2002:a05:6a21:3a88:b0:1fe:5921:44f2 with SMTP id adf61e73a8af0-2187a1e9a59mr4126293637.20.1748010734863;
        Fri, 23 May 2025 07:32:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970b7b0sm13271884b3a.51.2025.05.23.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:32:14 -0700 (PDT)
Date: Fri, 23 May 2025 22:32:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chunhai Guo <guochunhai@vivo.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, chao@kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/014: test for missing 'trimmed' flag issue
Message-ID: <20250523143210.zxrj3prdqbtizwou@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250522075706.1604641-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522075706.1604641-1-guochunhai@vivo.com>

On Thu, May 22, 2025 at 01:57:06AM -0600, Chunhai Guo wrote:
> This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> properly set after performing the following steps:
> 1. mount the f2fs filesystem
> 2. create a file, write data to it, then delete the file
> 3. unmount the filesystem
> 4. verify that the 'trimmed' flag is set in the checkpoint state
> 
> We should apply the commit ("f2fs: fix missing discard for active
> segments") to resolve the issue where the 'trimmed' flag is missing.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---

This test case looks good to me, just a few picky review points as below:

> v2:
>   - Skip this test case if discard is not supported.
>   - Renumber this test case from 012 to 014.
> v1:
>   https://lore.kernel.org/linux-f2fs-devel/20250521064952.1373690-1-guochunhai@vivo.com/
> ---
>  tests/f2fs/014     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/014.out |  2 ++
>  2 files changed, 43 insertions(+)
>  create mode 100755 tests/f2fs/014
>  create mode 100644 tests/f2fs/014.out
> 
> diff --git a/tests/f2fs/014 b/tests/f2fs/014
> new file mode 100755
> index 000000000000..f72d53e65292
> --- /dev/null
> +++ b/tests/f2fs/014
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Guo Chunhai.  All Rights Reserved.

You're using a enterprise mail address -- @vivo.com, so I'm just wondering
your the Copyright should be yourself or your company?

> +#
> +# FS QA Test No. f2fs/014
> +#
> +# This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> +# properly set after performing the following steps:
> +# 1. mount the f2fs filesystem
> +# 2. create a file, write data to it, then delete the file
> +# 3. unmount the filesystem
> +# 4. verify that the 'trimmed' flag is set in the checkpoint state
> +# We should apply the commit ("f2fs: fix missing discard for active
> +# segments") to resolve the issue where the 'trimmed' flag is missing.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick

Do we need to add this case to "trim" test group, as you always metion
"trimmed" in comment :)

> +
> +_fixed_by_kernel_commit 21263d035ff2 \
> +	"f2fs: fix missing discard for active segments"
> +
> +_require_scratch
> +_require_xfs_io_command "pwrite"

This line isn't wrong, but I think you can save this line, due to the "pwrite"
is always there.

Others look good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_require_command "$DUMP_F2FS_PROG" dump.f2fs
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +_require_batched_discard $SCRATCH_MNT
> +
> +foo=$SCRATCH_MNT/foo
> +$XFS_IO_PROG -c "pwrite 0 1m" -c "fsync" -f $foo >> $seqres.full
> +sync
> +
> +rm $foo
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +$DUMP_F2FS_PROG $SCRATCH_DEV | grep "checkpoint state" | grep -o trimmed
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/014.out b/tests/f2fs/014.out
> new file mode 100644
> index 000000000000..cb0c9447d675
> --- /dev/null
> +++ b/tests/f2fs/014.out
> @@ -0,0 +1,2 @@
> +QA output created by 014
> +trimmed
> -- 
> 2.34.1
> 
> 

