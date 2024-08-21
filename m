Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C71D131A
	for <fstests@vger.kernel.org>; Wed, 21 Aug 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266022; cv=none; b=KFxbCTOhdjalPpBUQUgYvyaIjj1T9hT9ck1GtSy4EpjrdD44D+SXENTElw5SjIwLBX13ACOFHwFIBZuyWunkKPLIv15h32yrFGg8oWWAdVnWKpl+c5D44mOpQ4YT3mT6k51JdGXROWHLdEvNj2NCwUL5pI/IQKY4E/LoSf6qWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266022; c=relaxed/simple;
	bh=W9Hyq6Il41NvtHVMGjlZLIU+xP8f0gf2RcjpKVRqm80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itq2/dLCP8JyoPoyhLeB/hXIp/1qzOaEbHZ3Re925APIXN7SQOccxA2WpWZLlznYRnxrHRv8bYcpLK4NeJ0mO/mxlMJkE+/Qa6/KcEkMngKYGgi6kf79dFu6lyV1eTX4TCU9gXMDk7myp96NqMQUAwXU+bM/FPDpt7cgu8EQh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0zLGIgs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0zLGIgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724266019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3HwX0urRRVamqrd2OG6BEVxWEdfk5MbvAIpPHwQ/pM=;
	b=Q0zLGIgsAilvYgClj4e10o/ypExBsTSwr5jAUmasDkKVs+oLl9tmhHQg0tXBjX+KdPz50h
	NweZ/IM3uS4327xz1N7JM3JtNECOwrlemFOUIPes0ucVip/BPr3QGaDzFm0FHcuPX2Lpkn
	0oMMmTWph3Yrac/dgH3s7XGRkMgz/NM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-BR5rVmSKMpqmhcDwa7SJHA-1; Wed, 21 Aug 2024 14:46:58 -0400
X-MC-Unique: BR5rVmSKMpqmhcDwa7SJHA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-713ca4e7af3so6602226b3a.1
        for <fstests@vger.kernel.org>; Wed, 21 Aug 2024 11:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724266017; x=1724870817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3HwX0urRRVamqrd2OG6BEVxWEdfk5MbvAIpPHwQ/pM=;
        b=DmeKCV/6JDzAF3LsNkfOT6MlRavq9RnXGxsEtvA7SHtWVfGDh9HUhL70lNOSOFrXvM
         GeZ7YJEVIip8QRAnldTJC0hSQxbxw1zOtDaX4mAGRg2293/Y5MXvnWyGZGDxCBclMtyb
         fY74lEiMdU72XBOJJwff2no1cKO9d+quo/MfwyH5ffFt8ijjVWbxv2oWJiD6UPP7va8n
         vZTK/hAmeLPzVXWO91Oan99w3lEnQJtNSVDRb0zMWt6yzzaHTPZsCaT2WnfvOqQmcqgU
         ziuJY93YuE5Nq52MknWdhNlywvNCkWP6eGZvR9aw4tHQ/GfpFDrebuENbY4nPYG+aNlW
         EoXA==
X-Gm-Message-State: AOJu0YzOmIYDM07JUs9lomN4VLUsinh5KijPn1x2H4l/HB49XBxR2sP1
	2vKv8onUsO2vI9EL55Cgu4Mkx/6wh+1FWKqd9HmEfwMQZ+Ffr1mZJzj1qUKNzJ4XjOlHPbcCA/Q
	7I6tAs4IJ4PNPQoQEsajMky+EGEAGWgAGT1WsEtp6T21+aaSKKigqbwo=
X-Received: by 2002:a05:6a00:4b10:b0:714:2069:d90e with SMTP id d2e1a72fcca58-7142354ccd6mr3761372b3a.26.1724266017411;
        Wed, 21 Aug 2024 11:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTVQbwYr3xDyB+2yy0tUVPKts85eVqVshKQfM1kr1bAaaAiv7Zipo+038I6s5nWX1sKWBFyA==
X-Received: by 2002:a05:6a00:4b10:b0:714:2069:d90e with SMTP id d2e1a72fcca58-7142354ccd6mr3761345b3a.26.1724266016909;
        Wed, 21 Aug 2024 11:46:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714209bf529sm1958615b3a.160.2024.08.21.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:46:56 -0700 (PDT)
Date: Thu, 22 Aug 2024 02:46:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH fstests v2] generic/755: test that inode's ctime is
 updated on unlink
Message-ID: <20240821184653.dbwzyp2tiblsmkzw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240820-master-v2-1-41703dddcc32@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-master-v2-1-41703dddcc32@kernel.org>

On Tue, Aug 20, 2024 at 03:48:25PM -0400, Jeff Layton wrote:
> I recently found and fixed a bug in btrfs where it wasn't updating the
> citme on the target inode when unlinking [1]. Add a fstest for this.
> 
> [1]: https://lore.kernel.org/linux-btrfs/20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> HCH suggested I roll a fstest for this problem that I found in btrfs the
> other day. This just creates a file and a hardlink to it, statx's it and
> then unlinks the hardlink and statx's it again. The ctimes are then
> compared.
> ---
> Changes in v2:
> - Turn it into a shell script.
> - Link to v1: https://lore.kernel.org/r/20240813-master-v1-1-862678cc4000@kernel.org
> ---
>  tests/generic/755     | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/755.out |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/tests/generic/755 b/tests/generic/755
> new file mode 100755
> index 000000000000..68da3b20073f
> --- /dev/null
> +++ b/tests/generic/755
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
> +#
> +# FS QA Test No. 755
> +#
> +# Create a file, stat it and then unlink it. Does the ctime of the
> +# target inode change?
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_test
> +_require_test_program unlink-ctime
                         ^^^^
This V2 shouldn't require this program, it's cause this case _notrun directly.
The 3bc2ac2f8f0b ("btrfs: update target inode's ctime on unlink") has been merged,

I'll remove this "_require_test_program" line, and add:
[ "$FSTYP = btrfs"] && _fixed_by_kernel_commit 3bc2ac2f8f0b \
	"btrfs: update target inode's ctime on unlink"

when I merge this patch. Others looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +testfile="$TEST_DIR/unlink-ctime1.$$"
> +testlink="$TEST_DIR/unlink-ctime2.$$"
> +
> +rm -f $testfile $testlink
> +touch $testfile
> +ln $testfile $testlink
> +
> +time1=$(stat -c "%Z" $testfile)
> +
> +sleep 2
> +unlink $testlink
> +
> +time2=$(stat -c "%Z" $testfile)
> +
> +unlink $testfile
> +
> +if [ $time1 -eq $time2 ]; then
> +	echo "Target's ctime did not change after unlink!"
> +fi
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/755.out b/tests/generic/755.out
> new file mode 100644
> index 000000000000..7c9ea51cd298
> --- /dev/null
> +++ b/tests/generic/755.out
> @@ -0,0 +1,2 @@
> +QA output created by 755
> +Silence is golden
> 
> ---
> base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
> change-id: 20240813-master-e3b46de630bd
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 

