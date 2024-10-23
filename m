Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C47487A7
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651074; cv=none; b=AbsvodYALox6IO1BGNVwvHG8bSHDuoE2OOkXHsQrVPnaWmWfTTp6dXXb3k/AV5Q6vdDQ/PSrIShJT/FnfwCMAA9iVym3fBkebEYVKlmw36JUpfhcGXe/b6GxP0Ku4RXsm9qDoykrvhOGmG5yCUprs49uPRZ1F3Qibh66dV0Ra4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651074; c=relaxed/simple;
	bh=8u+X1pM+AnUareZYK1zopcfQKW2ZsrJYrVhF1ZK/Qu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CopMry+XJdfApCbfWLMnTfM4SEptqsihN8Op7DIGFT2/0KulkCFl9UIWp1L6ITI15iq55bIc/VoXRA2eEObT8zEx5YlsfqT7Z6U3CokaTfaBUquJ+lIzSnpzNhi+k6/isytrJhZ68mDwCqi8XGXe605wGmfDRGitVRTc8v0mqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxOaKJnj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxOaKJnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729651072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMyxQC4PiUMFEM2SCPgl/rqbsfz60eDAxA3ZwDK2x48=;
	b=YxOaKJnjwp4TivYalJMxNv0KGbDPTI9/cemsiIn3RyVVB//TjcMX7+hkcbDKZhIcVoJQ9K
	PRqQWScQWShQfV+D5m4a84FIjSAUyrNrCNWeT4PG/BVwoep36LimZA9UNeT4phsejSiFQm
	1doGVXpAuNXsXEL+0vWEoQGITdZDO8w=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-EQBvD_F8No-ovyKmCOQ8fw-1; Tue, 22 Oct 2024 22:37:50 -0400
X-MC-Unique: EQBvD_F8No-ovyKmCOQ8fw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7ea7e2910c9so5028776a12.2
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 19:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729651069; x=1730255869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMyxQC4PiUMFEM2SCPgl/rqbsfz60eDAxA3ZwDK2x48=;
        b=Rtfq1ReKnajI6ziYQb9WWRFW0InBMrzzmiBu6FQwvSHIPRdLiBRt041Chg/ySm8HM9
         V7qXYdZLGea+g1TNNMQkuthhgvCDTmbNZkLBcm/jQop0xcVyygzncutO/wWV+mdOjd4V
         C1mKVt4bqKD4fF3wxNH6kLEq7AivVTbFYIFC1FuXaWl6ff64mTYRfabIphRVbe4hrnev
         V/5acQ6jTj+vtdc9b1Ac8zJvtbtRsjxhoG2z07vxAJvp/E7oFyKQVDd93RDyjlBpYWa+
         Mb14A/l8XmaYuBQmWdbr8HjQQXyRTTHYRsKyS2pV2j9OybtE3gtSZkOfzQxrtMZOaEOQ
         fpAQ==
X-Gm-Message-State: AOJu0YyPToeESvyGYmiqiw2ClU76ntlKWb5KBNmwMguDYXjZeS4VE+Uq
	aFAb+pUIPE/cfeHp7697wJHWqzxZIJhARdI+/jTWGhnkepBjX9+NR1GZ1AwsrjUBELOzv/o5BJP
	vBMM94q8Qk23liF/bPcf9wgrUeim2qS7S046V2qXlnkC4I/RoaL30SJK9oYr8VkPZxw==
X-Received: by 2002:a05:6a21:3414:b0:1d9:11d0:1214 with SMTP id adf61e73a8af0-1d978ad59fdmr1454006637.1.1729651068972;
        Tue, 22 Oct 2024 19:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWdRDqvMToqLfw5Irv/0qSGvhfnUU9U2RLhMRTuUG8XqtShRz3ifBOR0NkHjH/wVntXXwLdg==
X-Received: by 2002:a05:6a21:3414:b0:1d9:11d0:1214 with SMTP id adf61e73a8af0-1d978ad59fdmr1453988637.1.1729651068537;
        Tue, 22 Oct 2024 19:37:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313926sm5370452b3a.4.2024.10.22.19.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:37:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:37:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241023023744.nvnuavzus26gjdj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241015025106.3203676-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015025106.3203676-1-chao@kernel.org>

On Tue, Oct 15, 2024 at 10:51:05AM +0800, Chao Yu wrote:
> This is a regression test to check whether f2fs handles dirty
> data correctly when checkpoint is disabled, if lfs mode is on,
> it will trigger OPU for all overwritten data, this will cost
> free segments, so f2fs must account overwritten data as OPU
> data when calculating free space, otherwise, it may run out
> of free segments in f2fs' allocation function, resulting in
> panic.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/006     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/006.out |  6 ++++++
>  2 files changed, 58 insertions(+)
>  create mode 100755 tests/f2fs/006
>  create mode 100644 tests/f2fs/006.out
> 
> diff --git a/tests/f2fs/006 b/tests/f2fs/006
> new file mode 100755
> index 00000000..b359ef8f
> --- /dev/null
> +++ b/tests/f2fs/006
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/006
> +#
> +# This is a regression test to check whether f2fs handles dirty
> +# data correctly when checkpoint is disabled, if lfs mode is on,
> +# it will trigger OPU for all overwritten data, this will cost
> +# free segments, so f2fs must account overwritten data as OPU
> +# data when calculating free space, otherwise, it may run out
> +# of free segments in f2fs' allocation function, resulting in
> +# panic.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	rm -f $img
> +	_scratch_unmount >> $seqres.full
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_require_scratch
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +img=$SCRATCH_MNT/f2fs.img
> +mnt=$SCRATCH_MNT/f2fs.mnt
> +testfile=$mnt/testfile
> +
> +mkdir $mnt
> +dd if=/dev/zero of=$img bs=1M count=100 2>/dev/null
> +$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
> +sync
> +
> +# use mode=lfs to let f2fs always triggers OPU
> +mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt

Hi Chao,

Is the loop device necessary? What if use SCRATCH_DEV and SCRATCH_MNT directly?

Thanks,
Zorro

> +
> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
> +
> +# it may run out of free space of f2fs and hang kernel
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> +
> +mount -o remount,checkpoint=enable $mnt
> +umount $mnt
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> new file mode 100644
> index 00000000..a2c7ba48
> --- /dev/null
> +++ b/tests/f2fs/006.out
> @@ -0,0 +1,6 @@
> +QA output created by 006
> +50+0 records in
> +50+0 records out
> +dd: error writing '/mnt/scratch_f2fs/f2fs.mnt/testfile': No space left on device
> +3+0 records in
> +2+0 records out
> -- 
> 2.40.1
> 

