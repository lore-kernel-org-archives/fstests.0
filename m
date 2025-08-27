Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117A2D543A
	for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312835; cv=none; b=GXVv5eE0CBqQKaHi4+KLTsYyjBgRIEhC1MChsGaPzNYdftefjhT8BMxO+E8VqCG/CsONYFsAeq199Pl/p0eM+zyTxkG1e3wqpEvJ5yExCA0UCpnEWV76RXWw2AZJ8c13RAPKHl39cf/puD2UZodQyfVdM8LFGf28yX3MV3ZEGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312835; c=relaxed/simple;
	bh=3DyqViW9SnsZpYfArz4gNl8m4ECPoFoV6uIDCOz6k4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAx09qMgaPtLlKJxOsHK6Xz2sK/yID/8Wg2m2YYR9BxjZL4JEL1u91eSW6Unso+U7dXfy8ZscZx3Abl66yeQsasuVWKAaS4dXFswTYOQJmXyZIGet6TXrQWELb0+Np5uzuuz6k8pKBqBYttfSsAdDslnZydusFqThizNVb3inp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jnx7VvG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jnx7VvG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756312832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dX9VvPl9xyx3qg69IKipIupVW77+weRrThJTx756bsw=;
	b=Jnx7VvG+Co5Y63sRclB70RzHB5ja22GDBHS+/gPYtIKiRV/rn8dQy98kZzVXAoB5x183jV
	1XnFwkKcPOKii7KyqIqjh3kEKwBLeEIfo6XpOXemMwz9h07W6oxWBByuXeqc6SVytSvPrc
	yCeqs0HWNq8pGXsda+44P7azwLklXlk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-wQ7CJYd1Mby5YZrDCbEMew-1; Wed, 27 Aug 2025 12:40:04 -0400
X-MC-Unique: wQ7CJYd1Mby5YZrDCbEMew-1
X-Mimecast-MFC-AGG-ID: wQ7CJYd1Mby5YZrDCbEMew_1756312803
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771ff6f1020so79124b3a.3
        for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 09:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312803; x=1756917603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX9VvPl9xyx3qg69IKipIupVW77+weRrThJTx756bsw=;
        b=Mw4w5aOrnTylWMRbc0wue9PB2c9SCta+HBLc8PlivVhKhwGu6wMYtpPqhKxJWzgfqK
         Trjst+tYNDi60MzLzUbpi8h3jlpZEJ6CZ50zHsMErHYlNN/W5b/PwAiHZislo4HJ4hsq
         EDm4txw4QrXFAxd807Vd9coL0Y+xDEHLL/flozQq0nBFqnqTfO46DcJrQwvwQe4XmFgu
         ObONjGnGqfQSrknb8LXP/RpTh3KEWhUpTmsvDFHzGsZuYYFJsgnMei4q4/9ZIryZgLOS
         rIE8z8sMk4V87CyDDrTJC7asa4Y3E17xOvkYvNsWE/lyvUuWCb87CKx9X01850zST8xI
         eoCw==
X-Forwarded-Encrypted: i=1; AJvYcCU5HrRO3+uTEsRh1Nbov+5fPeGBCRvs66kmuN3PqmMb4CTM1TXPWfhjBodkt8zKY3yjO8LxO7ki@vger.kernel.org
X-Gm-Message-State: AOJu0YyFExQc6u/8/lzIiHxCTzJTDaphF3Hw/fMUnZ5l2srrvxXmSt4M
	4OSKtEn0heOSpDXL8o6HLlRQ7dwiq3IWwU+jtb3rV4Zto6mXBZxVSMi9qwcM5hNiS5kwmiBxCqu
	2MFV0idSqF9FGB3ui0UVpVsUQkgBt5K9AW1jeKnMh1GLQfUxQU9qgGnkQGxGxSsgveVI=
X-Gm-Gg: ASbGncv+kyBO+I5L0P4tLeaYOQ0O81GioOitxNlODYXp92GylWZjpp51xbI7jbhGuD1
	Mn5WFb0lYSZ5nRrlDXMMa/m9zfPM1bTyR7/a4yT2TySgjGKCRDZDk8Rob7ia1busMEVFfAuSoOI
	KinMMMelAWcqTvohY7omaCOsnGsCWo/SNzyTf0KGoCxXFdachijQjacfYGMMrPfaXgyK8XSSrKR
	IYY8BLeBUzAM68NNiQryo6Z+E8Ylw9ko6RyF05qZy7CTkMGozLZHzt0ZhQY3J37D991LgWc2Wur
	Z3v530RidHvEENuQnDDJmLv7GzhydiyOGCal9bEZLiNDe/F2h2QofpHbgZrPaBYvS5GLj172irj
	/yzEA
X-Received: by 2002:a05:6a00:a22:b0:76e:3545:d64b with SMTP id d2e1a72fcca58-7702f9f094cmr25870317b3a.8.1756312803063;
        Wed, 27 Aug 2025 09:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvyTNoiSmHafTjwaeVDRFo0b8zO2Q9T0YV3zu+AFT0kujXDeMnVY0rcr4pZZzYr/3Fhb9UFQ==
X-Received: by 2002:a05:6a00:a22:b0:76e:3545:d64b with SMTP id d2e1a72fcca58-7702f9f094cmr25870285b3a.8.1756312802547;
        Wed, 27 Aug 2025 09:40:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771eaa6792dsm7810711b3a.48.2025.08.27.09.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:40:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 00:39:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: add a new test case to verify
 compressed read
Message-ID: <20250827163958.oarsi5vriw65aetp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250827014250.170552-1-wqu@suse.com>
 <20250827163010.wli3kz2nfmvl3w4a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827163010.wli3kz2nfmvl3w4a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Aug 28, 2025 at 12:30:10AM +0800, Zorro Lang wrote:
> On Wed, Aug 27, 2025 at 11:12:50AM +0930, Qu Wenruo wrote:
> > The new test case is a regression test related to the block size < page
> > size handling of compressed read.
> > 
> > The test case will only be triggered with 64K page size and 4K btrfs
> > block size.
> > I'm using aarch64 with 64K page size to trigger the regression.
> > 
> > The test case will create the following file layout:
> > 
> >   base:
> >   [0, 64K): Single compressed data extent at bytenr X.
> > 
> >   new:
> >   [0, 32K): Reflinked from base [32K, 64K)
> >   [32K, 60K): Reflinked from base [0, 28K)
> >   [60K, 64K): New 4K write
> > 
> >   The range [0, 32K) and [32K, 64K) are pointing to the same compressed
> >   data.
> > 
> >   The last 4K write is a special workaround. It is a block aligned
> >   write, thus it will create the folio but without reading out the
> >   remaing part.
> > 
> >   This is to avoid readahead path, which has the proper fix.
> >   We want single folio read without readahead.
> > 
> > Then output the file "new" just after the last 4K write, then cycle
> > mount and output the content again.
> > 
> > For patched kernel, or with 4K page sized system, the test will pass,
> > the resulted content will not change during mount cycles.
> > 
> > For unpatched kernel and with 64K page size, the test will fail, the
> > content after the write will be incorrect (the range [32K, 60K) will be
> > zero), but after a mount cycle the content is correct again.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v3:
> > - Fix the golden output which is generated by an unpatched kernel
> > 
> > v2:
> > - Remove the unnecessary sync inherited from the kernel fix
> > - Use _hexdump instead of open-coded od dumps
> > - Use the correct 'clone' group instead of 'reflink'
> > - Minor grammar fixes
> >   All thanks to Filipe.
> > ---
> 
> Hi Qu,
> 
> This patch is good to me, just a few picky points below:
> 
> >  tests/btrfs/337     | 55 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/337.out | 23 +++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> >  create mode 100755 tests/btrfs/337
> >  create mode 100644 tests/btrfs/337.out
> > 
> > diff --git a/tests/btrfs/337 b/tests/btrfs/337
> > new file mode 100755
> > index 00000000..9c409e4d
> > --- /dev/null
> > +++ b/tests/btrfs/337
> > @@ -0,0 +1,55 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test 337
> > +#
> > +# Test compressed read with shared extents, especially for bs < ps cases.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick compress clone
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +	"btrfs: fix corruption reading compressed range when block size is smaller than page size"
> > +
> > +. ./common/filter
> 
> Looks like you didn't use any helpers of common/filter in this case :)
> 
> > +. ./common/reflink
> > +
> > +_require_btrfs_support_sectorsize 4096
> > +_require_scratch_reflink
> > +
> > +# The layout used in the test case is all 4K based, and can only be reproduced
> > +# with page size larger than 4K.
> > +_scratch_mkfs -s 4k >> $seqres.full
> 
>  || _fail "...."
> 
> Fail the test if the mkfs fails.
> 
> > +_scratch_mount "-o compress"
> > +
> > +# Create the reflink source, which must be a compressed extent.
> > +$XFS_IO_PROG -f -c "pwrite -S 0x0f 0 32K" \
> > +		-c "pwrite -S 0xf0 32K 32K" \
> > +		$SCRATCH_MNT/base >> $seqres.full
> > +echo "Reflink source:"
> > +_hexdump $SCRATCH_MNT/base
> > +
> > +# Create the reflink dest, which reverses the order of the two 32K ranges.
> > +#
> > +# And do a further aligned write into the last block.
> > +# This write is to make sure the folio exists in filemap, so that we won't go
> > +# through the readahead path (which has the proper handling) for the folio.
> > +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/base 32K 0 32K" \
> > +		-c "reflink $SCRATCH_MNT/base 0 32K 32K" \
> > +		-c "pwrite 60K 4K" $SCRATCH_MNT/new >> $seqres.full
> > +
> > +# This will result an incorrect output for unpatched kernel.
> > +# The range [32K, 60K) will be zero due to incorrectly merged compressed read.
> > +echo "Before mount cycle:"
> > +_hexdump $SCRATCH_MNT/new
> > +
> > +_scratch_cycle_mount
> > +
> > +# This will go through readahead path, which has the proper handling, thus give
> > +# the correct content.
> > +echo "After mount cycle:"
> > +_hexdump $SCRATCH_MNT/new
> > +
> > +status=0
>    ^^^
> "_exit 0" does "status=0", so you can save this line.
> 
> Others looks good to me, with above changes:
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

These're simple enough changes, I've helped to change them, you don't need to
send one more version (except you hope to change more, please tell me :)

Thanks,
Zorro

> 
> > +_exit 0
> > diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> > new file mode 100644
> > index 00000000..cecbbbcf
> > --- /dev/null
> > +++ b/tests/btrfs/337.out
> > @@ -0,0 +1,23 @@
> > +QA output created by 337
> > +Reflink source:
> > +000000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> > +*
> > +008000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> > +*
> > +010000
> > +Before mount cycle:
> > +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> > +*
> > +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> > +*
> > +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > +*
> > +010000
> > +After mount cycle:
> > +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> > +*
> > +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> > +*
> > +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > +*
> > +010000
> > -- 
> > 2.49.0
> > 
> > 

