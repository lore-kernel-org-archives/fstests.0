Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158B46BF
	for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742950579; cv=none; b=pare0+VvWWo2Ow4Gvuc6L6ZCIOhIk6nbbEhQVMv91VWMagUje/+10bR9JfULjg4CIZZCC7CcrV4x7DQkAzpQ03u3v3JPO/66bovdhuirdb+uAUweoweyOGFKUqkGMwPyxOkS17syHL6BZZp7Mw+Ckq91oJw1ZNXEe2wL/RxiomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742950579; c=relaxed/simple;
	bh=xPIxHuPwHmT8aSy6yn7dQFHiFzpgeFlwIvEaas5I21c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+xJGR/ZzYvFpPtxWiOHy4XkzyOF2P+AoYsd4IZ07qqZlEeUE9p/GcfnTib8rYEw4kZnfjDTdhEyheGjTuKtCtP8CqqihQJOv2cEpjfd35DF4jnOydudIUqD6Wr4ygeKcJiS/8LBYsQmbqM4CzOzxSmLr4qExRX8OpQ+U1wbe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cnn/Ewba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cnn/Ewba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742950576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/K6SdQgOzXbljSbaFexcMPY4TGlD97ZZ0DCXd5kKlOE=;
	b=Cnn/EwbaR7jOIpbOuOnGzgLjhEHcu7vfC4rAXiCJ9EbTnfS0EFTRI0f0QndLx7D90pvOO2
	dIcE0zaG1aQ8ZJ/95qoaOdDkqxqra1Wqn9qEVzq2xmb0GIAoxwYSVihlngw5QXO5eFpHfW
	OMxY26sjcbX1p+nCEdj8YuuNL83RMFw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-NMIQZquxOEC2kck5cGdwow-1; Tue, 25 Mar 2025 20:56:15 -0400
X-MC-Unique: NMIQZquxOEC2kck5cGdwow-1
X-Mimecast-MFC-AGG-ID: NMIQZquxOEC2kck5cGdwow_1742950574
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a7aceeaso98505625ad.0
        for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 17:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742950574; x=1743555374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K6SdQgOzXbljSbaFexcMPY4TGlD97ZZ0DCXd5kKlOE=;
        b=cPDHaaNhYnSA3rCCNe3u+ZYJ/nHZ2mIzk3mkySnKrEbAueqNT2+NqJAfrYizkmriFQ
         4LWRkBN2EBhFiUKEX9ZXNu0pLjuh6lzA4fEsD0aBWBb+LnhjNYSffzFXVsda86d0/Eb8
         6zhty+9sp7WQ5ew8x70lcKhdPLONbY3PINmcy2Q+HqBIaT4aqGhEjU2twwxnJtJ8O2T6
         c8ECVZ1ES6WRVYZ7RmJ5oBArSkmv6V/jG3KS5ATc9zT9yUMoP03j5YQf3ya/SA3kwkqf
         l65rN/cgQPKJ2Xs96GCBkWdzI3LnhAQ/0ncxzZOi0ZIq1ARO2ZPGb8Bm2DH5ed369R6Y
         QJnw==
X-Forwarded-Encrypted: i=1; AJvYcCUALEnEWyAp9L7lkemxIig7WLGo2GZg72reKHoVcFjsqZVxmPQnhnmEYUXC7hPV6mpA9rJnKvpZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9k/HMyIf8VZQRqPlC0YauEjb7d/t1tTNDquzVH2R4d4TPp0q
	+ukoC6xEeFhBee8OoHxTFqfMk6cwWWVawEWjFFoXayFB6jSe1e8n4FMP0Pq22ro915guGGOv7vI
	aCwoScyygT2ftOO6XqVpWTNMFa1gPNLrrRdekD2KadLC3dHyYPtVBD9I=
X-Gm-Gg: ASbGncsMQivgkOCHdBbVZnzY2ISwUDR+VJ+IbNUOz6VJofMrMMQnBBDASzk+IHlYIhp
	qRE/nL0KMyL3I4NjDm6+Dqnad85O/DCDvrvlTA+DR0LCAjJXKUI6AhSzZFsXrZYnGttw1ljtURi
	x9jdCdU5XjSFYjUERqjlOsjjqab72fbuqPZoSuT0Km1Xg0GgRABM3kupFvhZR80qeXgAMXufKPw
	wXX8XOaUXrdY8P3YvCBi8hh2d4VI6XQUUd5/9SI0iVmmo+d1rFmZAxVOh52h+4xBOwx11nmizPZ
	QLpOFjjal8bW2waZ7Y92EGctN34euBcfUYmda0UszeAZBJmRStCsrQox
X-Received: by 2002:a17:903:2ecb:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22780db101dmr319118185ad.22.1742950573813;
        Tue, 25 Mar 2025 17:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiom4y0E7ipbRr3hLdXuZPOncTeT9D36443uQvS5xvm68/hNHMJ/9AxSqb7DSpSFB4YNjMVA==
X-Received: by 2002:a17:903:2ecb:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22780db101dmr319117935ad.22.1742950573486;
        Tue, 25 Mar 2025 17:56:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f443asm97012375ad.228.2025.03.25.17.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:56:13 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:56:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daeho Jeong <daehojeong@google.com>,
	Jianan Huang <huangjianan@xiaomi.com>
Subject: Re: [PATCH v2] f2fs/010: test dirty status handling on database file
Message-ID: <20250326005609.zrgpfuycgtihmmym@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250325083428.3301950-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325083428.3301950-1-chao@kernel.org>

On Tue, Mar 25, 2025 at 04:34:28PM +0800, Chao Yu wrote:
> This is a regression testcase to check whether we will handle database
> inode dirty status correctly:
> 1. create a regular file, and write data into the file
> 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> 3. write transaction data to the file
> 4. rename the file
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> 6. drop caches in order to call f2fs_evict_inode()
> It expects kernel panic will gone after we apply commit 03511e936916
> ("f2fs: fix inconsistent dirty state of atomic file").
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Cc: Jianan Huang <huangjianan@xiaomi.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix to unset atomic_write_pid to avoid killing process w/ dummy pid value

This version is good to me, if no more review points from f2fs list, I'll merge
this version.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/010     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/010.out |  2 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/f2fs/010
>  create mode 100644 tests/f2fs/010.out
> 
> diff --git a/tests/f2fs/010 b/tests/f2fs/010
> new file mode 100755
> index 00000000..50e37817
> --- /dev/null
> +++ b/tests/f2fs/010
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/010
> +#
> +# This is a regression testcase to check whether we will handle database
> +# inode dirty status correctly:
> +# 1. create a regular file, and write data into the file
> +# 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> +# 3. write transaction data to the file
> +# 4. rename the file
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# 6. drop caches in order to call f2fs_evict_inode()
> +# It expects kernel panic will gone after we apply commit 03511e936916
> +# ("f2fs: fix inconsistent dirty state of atomic file").
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	[ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> +	wait
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_fixed_by_kernel_commit 03511e936916 \
> +	"f2fs: fix inconsistent dirty state of atomic file"
> +
> +_require_scratch
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +src_db=$SCRATCH_MNT/src.db
> +dst_db=$SCRATCH_MNT/dst.db
> +
> +# initialize database file
> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $src_db >> $seqres.full
> +
> +# sync filesystem to clear dirty inode
> +sync
> +
> +# start atomic_write on src.db database file and commit transaction after 3000ms
> +$F2FS_IO_PROG write 1 0 0 zero atomic_commit $src_db 3000 >> $seqres.full &
> +atomic_write_pid=$!
> +
> +# wait a moment to let atomic write starts
> +sleep 1
> +
> +# it will dirty inode when updating i_pino
> +mv $src_db $dst_db
> +
> +# wait for atomic_write commit completion
> +sleep 4
> +
> +# drop caches in order to call f2fs_evict_inode()
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +wait $atomic_write_pid
> +unset atomic_write_pid
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/010.out b/tests/f2fs/010.out
> new file mode 100644
> index 00000000..1d83a8d6
> --- /dev/null
> +++ b/tests/f2fs/010.out
> @@ -0,0 +1,2 @@
> +QA output created by 010
> +Silence is golden
> -- 
> 2.48.1
> 
> 

