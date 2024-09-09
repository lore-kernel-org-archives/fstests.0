Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7751B140A
	for <fstests@vger.kernel.org>; Mon,  9 Sep 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868902; cv=none; b=p+56OZ/tZ3NeZHQGf8Z1W06P/oAaqa9q3uGi+zy1r7DpJJfAWXsAE3Aypa+5lAr9g5eaullYi0gO+wWrUahghbvN4a1MBb7HkyVWDVP8zcU4sxsbKbhs3c0lgFLne/8VqxfZqdXMRFY8zs2BnoYgRiAQgn2+suu4gaOOCMRdilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868902; c=relaxed/simple;
	bh=49KNpt/o7JI16q0Cdy0zhr3Zs/67PGiSVEM+e3ibCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYtCj22bKamEcndH5d5WqDXmrbvhktooVbw9HHOq/ak3wrzKWuHu/mWASf3q2R18oy9hxm/W7xUqBawcgNEbtSTCCfruA54Zq8xwvbt3Hu3oJjEHoOBaXe5f5nErEM8Zbi+6DX87tDMD0FYS8CYX5RLMRcDf8G35ecVyQyiKd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR0jIvYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR0jIvYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725868898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AE9pigql2sRaucjKkuFUiX9JzxM4GCn+uAlTXcy1X3g=;
	b=eR0jIvYtm6f7fIOYsW0/Cf5nppcMugc5TT0vCa/S0UXNGDGorG1/4bhpIjOnOR5EubyLNJ
	t1XmJc33WSui/ZS4gTt8pgOW+sV0G9UEuEjr/5WHT8A4weEgAtPGWyyZ4pn+vozD3ayZBI
	52E49nmIOboqFUnDE4PMNv88H3q1Pxs=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-yks_lPg1NzOnrYG3col8eg-1; Mon, 09 Sep 2024 04:01:37 -0400
X-MC-Unique: yks_lPg1NzOnrYG3col8eg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-277f9af7500so3663084fac.0
        for <fstests@vger.kernel.org>; Mon, 09 Sep 2024 01:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868896; x=1726473696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE9pigql2sRaucjKkuFUiX9JzxM4GCn+uAlTXcy1X3g=;
        b=cozj5sOHWfWZEFCzCASuAmdbBDokaqBifG3AF0hRlMcTpE8GvlXsgKPCLR14y7qRii
         ycguVOEgUInrRayoKb6bsin0k9qgvJo4+5YxsyJDb4YIfVzwe4aDDTB6ZRokVbP496xm
         5HyArcNCC+UrFyKMGeKqFxLI27MnIj4+LNRCepLXyZz3a/giINVJR65yU/zdbD6E57jy
         Zuw2RBmBmBFZVpwW2xgi9fvuqI1YaWt7CTb+R4ZB/nTgklnDQ2LI7b3/6pKahJgg5Sxd
         uwOojS1A5D0TYt7/UEVGJxlrN0XRWIxIx/kuOLVG3ii+OUiFzwEAWA0lsOL93sOu1kVZ
         JleA==
X-Gm-Message-State: AOJu0YxLqPeqEQsLbT1wl6vds8Q6UuUWCPhi1xKQiJ6nptsz/lqk5GS5
	CKjndQT9S0HKjCVqghjOurC3D2xzaXqkBMP+LXdLaL1eXLIzmdI/0VMaVJ346BBAgoRQLUXWv70
	fb+kbW4gRS/EUEPoGax5CbM7AQPrZKvoI77bsQGFTCx3t1ce2Y7lmnDRYBkqtPoHOGg==
X-Received: by 2002:a05:6870:970d:b0:278:3de:c8de with SMTP id 586e51a60fabf-27b9db2fd83mr3502405fac.24.1725868896390;
        Mon, 09 Sep 2024 01:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMuG6YQ9rt2WbdhbTBJ3YtyzbOsR47y4gXbGQghHbf/tVjBBcNWrQh3TrdpQom3F13LVCoOQ==
X-Received: by 2002:a05:6870:970d:b0:278:3de:c8de with SMTP id 586e51a60fabf-27b9db2fd83mr3502378fac.24.1725868895993;
        Mon, 09 Sep 2024 01:01:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823736324sm2828256a12.18.2024.09.09.01.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:01:35 -0700 (PDT)
Date: Mon, 9 Sep 2024 16:01:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: fstests@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [RFC PATCH] generic: test negative timespecs are accurate
Message-ID: <20240909080132.4wliimcb2y4bt7u3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240907154527.604864-2-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907154527.604864-2-hi@alyssa.is>

On Sat, Sep 07, 2024 at 05:45:28PM +0200, Alyssa Ross wrote:
> Link: https://github.com/koverstreet/bcachefs/issues/743

Great, a bcachefs regression test case :)

Can you add a bit more details in commit log, not only a link.

> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
> This is an adapted version of generic/258, but it tests that the stored 
> timestamp is accurate to the second, rather than just testing the 
> timestamp remains negative.  I created a new test rather than just
> making 258 more precise, because I understand that there may be
> filesystems that don't store timestamps that accurately by design.
> As an example, I've heard that FAT only has 2 second precision, so this
> patch is an RFC because I'm not sure how I should write a _require
> function (if at all) that restricts the test to filesystems that are
> expected to be able to do this.
> 
>  tests/generic/363     | 26 ++++++++++++++++++++++++++
>  tests/generic/363.out |  2 ++

The g/363 has been taken, please rebase to latest for-next branch.
You can use `xfstests/tools/mvtest generic/363 generic/365` to change
the case number, before rebasing.

>  2 files changed, 28 insertions(+)
>  create mode 100755 tests/generic/363
>  create mode 100644 tests/generic/363.out
> 
> diff --git a/tests/generic/363 b/tests/generic/363
> new file mode 100755
> index 00000000..50459d01
> --- /dev/null
> +++ b/tests/generic/363
> @@ -0,0 +1,26 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2011 Red Hat, Inc.  All Rights Reserved.
> +# Copyright (c) 2024 Alyssa Ross.  All Rights Reserved.
> +#
> +# FS QA Test 363
> +#
> +# Test timestamps prior to epoch with nanosecond components are
> +# accurate to the second.
> +# bcachefs was slightly off.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick bigtime
> +

As this's a bcachefs regression test:
https://lore.kernel.org/linux-bcachefs/20240907160024.605850-3-hi@alyssa.is/

So better to mark as:
if [ "$FSTYP" = "bcachefs" ];then
	_fixed_by_kernel_commit xxxxxxxxxxxx "bcachefs: Fix negative timespecs"
fi
(replace the xxxxxxx if it's merged on mainline linux)

Others looks good to me, with above changes, I'd like to

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_require_test
> +_require_negative_timestamps
> +
> +TESTFILE=$TEST_DIR/timestamp-test.txt
> +
> +# Create a file with a timestamp prior to the epoch
> +touch -d "1969-07-20T03:55:59.750000000+0100" $TESTFILE
> +stat -c %X $TESTFILE
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/363.out b/tests/generic/363.out
> new file mode 100644
> index 00000000..052bacfd
> --- /dev/null
> +++ b/tests/generic/363.out
> @@ -0,0 +1,2 @@
> +QA output created by 363
> +-14245441
> -- 
> 2.45.2
> 
> 

