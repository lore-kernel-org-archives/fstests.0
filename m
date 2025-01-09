Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7671199FA2
	for <fstests@vger.kernel.org>; Thu,  9 Jan 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446767; cv=none; b=r9QH9Uou5jlW4g/swEKwaba+sQ+gGYTqL4foU9dy4oYJEIBOxcdwasnpy0DHZbTvR2Y7TOQAnPmxky/uIOoImEGt/P3fu4Ith3RQR56t2MDpC8pSMLfsT+HHFw+HGHIxmA2kCTHjH5frFir0o4XPXvA0YvZ1g9MvpXuLy8AbrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446767; c=relaxed/simple;
	bh=mDRgJuIFRng3hmlsm/4ED0AEjd2kOpo2NzQ9qtXi+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svc4bXT0MJioFbYK89HmbJk7KLLfO/zn4FTesOcieadNEAR14YKn1LwB8QAx+7FXixAncsXSpUjV0hprMfZJWOaxsSd7apasA+oSoKld254hIcz0Y5vaH7l8CtY/ujZUqM7u7Rd08Yk7roTxuuefgRXj4AM6WnYndCWSDHMeyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyF5p9Bd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyF5p9Bd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736446762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lfJmIra0ne6TmR+G1rnLUESQEt4RTuCy0vegz6T9XIc=;
	b=GyF5p9Bd27Q7KlOBEsYNYst7/2via8LqsoyEH7NemDjDCoEWVcNdmFzjojRzLYNaoefJ+p
	Ydd+kl0nOiz7t+ksGCFy46LtwhPdOxERCyWLVv8yvXWt+kQcmcN2vOT+O85B2UB1SJbnAe
	5qCMdinPDRi/d+d7063/HiM7waKRUS8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ecHRa4P5MIWeFC2-C565nA-1; Thu, 09 Jan 2025 13:19:21 -0500
X-MC-Unique: ecHRa4P5MIWeFC2-C565nA-1
X-Mimecast-MFC-AGG-ID: ecHRa4P5MIWeFC2-C565nA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so2086636a91.0
        for <fstests@vger.kernel.org>; Thu, 09 Jan 2025 10:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736446760; x=1737051560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfJmIra0ne6TmR+G1rnLUESQEt4RTuCy0vegz6T9XIc=;
        b=v/8bqkIVlKkkWZNhRieue8O7sw8lv9LINRhzVVGhYi7cmDTatRWkbCw2r5hmk27Lnl
         3sbeIQc1a+XFOJ3dHxRH2b9RybZrsQakcSMdjJ5n+U1yvSIgjnrdJovlAWsfj0lcEU7o
         b6UGaev56VSQxPXbUBUelSdokaUV+WY/K9OYAXtitz0uZtMUfcdoI64lXEAEWSckHIup
         ngOTFyuXdsElmJpWvSYekSR1HSzp7CqzcNVM8tiFvQk+kKLsv1FzTDolJi7cSPFilDhm
         VBSa2hGH0tLzWWTd1qhbnz1UESeD5cgy6K/8guU7r0DYl0F3+2DLuDmGyjSBHk0LrrtQ
         UscA==
X-Gm-Message-State: AOJu0YzzWLXcn4JyLG4qNmMSA0wCTacw6j8tIzys6jy9nPG6QsJEE+tb
	W8/QAcgKFKIpEyYFowNyTzpQ4d6e1SLjRAmBp2sSFt2FOYdJZE3yn1DULs+pysl9XjmjPcMmtFS
	7RC8uyCkc9lQWvRjaa9u5dwYzKqctOLj7WOoN++YlYO7N2ANHhwCLWB8=
X-Gm-Gg: ASbGncsXDrHZjSbjtAkqYX3YhhGSDJBiYihDIR3P8eR7KoSM7J/Unm0yvFn+eamcJQf
	QSIm3vk/2alJ+43D2Bs8qQ/znQ9pf4dV2hS7QzHhBX5XSPUTf3XFV9nfSCwBW0EzimiZM4YPNU8
	7dVuQKtZlvHrUDD7NtVkcpIuxVIZsgWH1VNLguxYo/51R2WpcOALc6Ki3R7BPAG7PbCBZHvEd7Y
	IfQpLE3AmfjoWVjnnem15jug1ucQJR8+Mz93XH1koAC03hsqkz0azxJlpMXlks/dhdtyuq1Ywjn
	Pi/BiGxW2n/xazUO1WaF9w==
X-Received: by 2002:a17:90b:3d09:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f548f33baemr10916219a91.13.1736446760115;
        Thu, 09 Jan 2025 10:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOY5fNCvK6mHVj7nIEA5eP+vmjWIUdzctq4BbMz+IQYvvcswifKbIGEbRsFy1lGlU1r9VIlA==
X-Received: by 2002:a17:90b:3d09:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f548f33baemr10916179a91.13.1736446759726;
        Thu, 09 Jan 2025 10:19:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad2basm3959447a91.24.2025.01.09.10.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 10:19:19 -0800 (PST)
Date: Fri, 10 Jan 2025 02:19:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
	ojaswin@linux.ibm.com, djwong@kernel.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v3] generic: add a partial pages zeroing out test
Message-ID: <20250109181914.xffhgu2x75eh4m2u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>

On Wed, Jan 08, 2025 at 04:44:07PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Add a new test which is expanded upon generic/567, this test performs a
> zeroing range test that spans two partial pages to cover this case, and
> also generalize it to work for non-4k page sizes.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v3:
>  - Put the verifyfile in $SCRATCH_MNT and remove the overriding
>    _cleanup.
>  - Correct the test name.
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v2: https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> 
>  tests/generic/758     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..bf0a342b
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. 758
> +#
> +# Test mapped writes against zero-range to ensure we get the data
> +# correctly written. This can expose data corruption bugs on filesystems
> +# where the block size is smaller than the page size.
> +#
> +# (generic/567 is a similar test but for punch hole.)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zero
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$SCRATCH_MNT/verifyfile
> +testfile=$SCRATCH_MNT/testfile
> +
> +pagesz=$(getconf PAGE_SIZE)

There's a common helper "_get_page_size" to do this.

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_dump_files()
> +{
> +	echo "---- testfile ----"
> +	_hexdump $testfile
> +	echo "---- verifyfile --"
> +	_hexdump $verifyfile
> +}
> +
> +# Build verify file, the data in this file should be consistent with
> +# that in the test file.
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +		$verifyfile | _filter_xfs_io >> /dev/null
                                             ????????
                                             >> $seqres.full ?

> +
> +# Zero out straddling two pages to check that the mapped write after the
> +# range-zeroing are correctly handled.
> +$XFS_IO_PROG -t -f \
> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +	-c "mmap -rw 0 $((pagesz * 3))" \
> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "close"      \
> +$testfile | _filter_xfs_io > $seqres.full
                              ^^
                              >> $seqres.full

I'll help to make above tiny changes when I merge it, others looks good
to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +echo "==== Pre-Remount ==="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match pre-remount."
> +	_dump_files
> +fi
> +_scratch_cycle_mount
> +echo "==== Post-Remount =="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match post-remount."
> +	_dump_files
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..d01c1959
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,3 @@
> +QA output created by 758
> +==== Pre-Remount ===
> +==== Post-Remount ==
> -- 
> 2.39.2
> 

