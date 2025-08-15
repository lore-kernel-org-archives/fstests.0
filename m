Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66A1607A4
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273737; cv=none; b=Bj4ycQJ06abd3noQyO/cc4epg/JGm6XPDaBL9BMbVQvOvanRL0uMOCa4zrq0PQlv/eLkjfJrEeed4soHRjExeWKpcqIGPO4n/Xd4HFdWwsEgbQ7RcMZ6mlfKsWu2sipwK5sQwZ8WXTzc/xxfe+wvnAl5cE4ov44fG+JyZWMpZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273737; c=relaxed/simple;
	bh=W8aIaegSld6dNbmNXHaXEH81veDHh/LPcjov5CMqUgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+rEwx0P13Dfa6bdZLDiRzKMAo+IRwFj8WEWfpYrng1hf4dT2nfHikStM94kWejwrFTI+Dl5YhRg6v/KaO/gCcgIy60J6fGuSSGhHn1wSrHX7qU8Roz/rxhRZCV/hCAA43Yyf68V1IFz+rhv/hiIa1eY+2KNWiG7zz647mlAJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUTcIeXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUTcIeXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7trs0stmb5KqYgODGI7WyrTJCu0r4CTNIU7M/XCXio=;
	b=GUTcIeXkA0YmRLkzMwl8QqmL3fvpV5QNGR+z4IhSDHD/081LCxNvrAsp9YP8F9q2bD+iAn
	xO2PHeNxPuzNrUaj65YYTpySbT4gHjo5sgOIm+TJZn5TPASxdvzEw9vKYcbdgUc1QvWdc+
	rlB4UchC3aXmQJnQ822CNE7+L8+LpVM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-_ggglUyoPXOZn3rB9Fftyw-1; Fri, 15 Aug 2025 12:02:13 -0400
X-MC-Unique: _ggglUyoPXOZn3rB9Fftyw-1
X-Mimecast-MFC-AGG-ID: _ggglUyoPXOZn3rB9Fftyw_1755273732
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458297be0so43763595ad.3
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 09:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273732; x=1755878532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7trs0stmb5KqYgODGI7WyrTJCu0r4CTNIU7M/XCXio=;
        b=J1I4ZhtTfhEUwnGCh1RSicpF6+0JNYrTxvtAKdTkI3NJqFQ0s5BAGpRfAyc5RWzxEj
         3ZzaOAKADJmlNUOAxet1VSSQJrS6XmR7eCfq+tzOf2ZO6ZoxPoVhcYnQU63a4ypnYh+n
         IDMYhoyt5H1DHRbKZMRSr7SGo4HWPXCKwkDqlaHm4Th7VXB9IoAfNz9xX6gsNzeWakRz
         4TjPeku8rOcMN8pSJmVmyjX9MDELKNPjm5LLQyDa14T5YIoQMEKJIpIjeRaBef0QZhPV
         hT/TCmzw5eFRTLhgCjG/+jAFk4RzRuyNSvqEc3WqX47jKnh8gbEYhODvfcDRO401UWMH
         F9xw==
X-Forwarded-Encrypted: i=1; AJvYcCVMYUepnjT6KP53UZqvjrsuAwhSJxp5XelasRmHu7baIJcNQhblz01zeCMH20J2B5ViD7uTin6C@vger.kernel.org
X-Gm-Message-State: AOJu0YyySpDQF6U28n7LrZug+SwCAseVid22/A3ByYqrUieCsTaeoLpY
	Lp9lRIHi2jeMaKv7li3ezz+aQl6Tizq7ZIe7u6R1cZYUW8uk+mkHTJHeKMeUoAyb8FvdUW9KXaK
	077UneUtemRCin+cTcpdc/4169begkNXTpB3CSqeiEWPERns6FKxjqc+7VpF6dEPvV+A=
X-Gm-Gg: ASbGncs7DWd/wOpC1KXEksXxQd9nukGs0io9N+pQ/JZCkZemOkDUPJ7ZNNreOe45h5L
	qBKniDXWcOhAQaP9rCIcEL1Jq7U0bmIZyb63qB3nFW5lHYj02xm4kwZ6+DyQHtB4AVpmjTEPwBp
	VpqIZmSbjV/L6TiTzfXODERcbpFTubEg7zwl79dwUdv5tDG7bJQ3WAi/m008lyyQkIBPMB1vsER
	uIfwMeg0A+5jCg5jxnxb3LnP1tRKBzmTJae6M8OpwmfXpmURaBo/U7331cOK87zxOir8Vl4tX/P
	sTpPj9LVnrvD8173ZlIRxoWdvFicYx8Jhm8ALHndVJdDaBdRTFslnXjrq4vcciIg6DQH6hXOfi+
	L6dGA
X-Received: by 2002:a17:903:3546:b0:244:6b46:287b with SMTP id d9443c01a7336-2446d7a5b6fmr33199415ad.20.1755273731484;
        Fri, 15 Aug 2025 09:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWeB8r38bxKL+3gG+wc/E7BAZULHmVH4TEvNnC6Tj8Mxi0vNbgzc0GGqMf6qiNZnTgEnLfDQ==
X-Received: by 2002:a17:903:3546:b0:244:6b46:287b with SMTP id d9443c01a7336-2446d7a5b6fmr33198945ad.20.1755273730935;
        Fri, 15 Aug 2025 09:02:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cae02e7sm17248085ad.39.2025.08.15.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:02:10 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:02:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 3/3] f2fs/017: test mount options for zoned device
Message-ID: <20250815160206.ncfua6yvrwopk4hg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250804114016.2734919-1-chao@kernel.org>
 <20250804114016.2734919-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804114016.2734919-3-chao@kernel.org>

On Mon, Aug 04, 2025 at 07:40:16PM +0800, Chao Yu wrote:
> As f2fs changes to use new mount APIs, let's add a new testcase
> to check mount result for special mount options for zoned device
> and their combinations, in order to detect any inconsistency during
> mount.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/017     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/017.out | 21 +++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/f2fs/017
>  create mode 100644 tests/f2fs/017.out
> 
> diff --git a/tests/f2fs/017 b/tests/f2fs/017
> new file mode 100755
> index 00000000..cdf42fc8
> --- /dev/null
> +++ b/tests/f2fs/017
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/017
> +#
> +# This testcase tries to check stability of mount result
> +# w/ mount options for zoned device and their combination.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +
> +_require_zoned_device "$TEST_DEV"
> +_test_unmount >> $seqres.full 2>&1
> +
> +options=(
> +#	mount_option			mkfs_option
> +	"background_gc=on"		"blkzone"		\
> +	"background_gc=off"		"blkzone"		\
> +	"background_gc=sync"		"blkzone"		\
> +	"mode=adaptive"			"blkzone"		\
> +	"mode=lfs"			"blkzone"		\
> +	"mode=fragment:segment"		"blkzone"		\
> +	"mode=fragment:block"		"blkzone"		\
> +	"discard_unit=block"		"blkzone"		\
> +	"discard_unit=segment"		"blkzone"		\
> +	"discard_unit=section"		"blkzone"		\
> +)
> +
> +for ((i=0;i<${#options[@]};i=i+2))
> +do
> +	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
> +	_test_mkfs "-m" >> $seqres.full || _fail "mkfs failed"
> +	_test_mount "-o ${options[$i]}" >> $seqres.full 2>&1
> +	echo $?
> +	_test_unmount >> $seqres.full 2>&1
> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/017.out b/tests/f2fs/017.out
> new file mode 100644
> index 00000000..c260e0b1
> --- /dev/null
> +++ b/tests/f2fs/017.out
> @@ -0,0 +1,21 @@
> +QA output created by 017
> +Option#0: background_gc=on : blkzone
> +0
> +Option#2: background_gc=off : blkzone
> +32
> +Option#4: background_gc=sync : blkzone
> +0
> +Option#6: mode=adaptive : blkzone
> +32
> +Option#8: mode=lfs : blkzone
> +0
> +Option#10: mode=fragment:segment : blkzone
> +32
> +Option#12: mode=fragment:block : blkzone
> +32
> +Option#14: discard_unit=block : blkzone
> +0
> +Option#16: discard_unit=segment : blkzone
> +0
> +Option#18: discard_unit=section : blkzone
> +0
> -- 
> 2.49.0
> 

