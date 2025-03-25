Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E0B666
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742865544; cv=none; b=MA+B186JPZ6SeeI4CeIFvnCsgJoUlg0lC9yielnNgAO7eRNCFqsfZdVP5BCfduq4iv8tIBVzc1wPuPq7OUgXY2H6fZLM2ce6bxbmLYHuoQ5gv/EJ9GUl7N4UFpXnUPtBsXbSVwXJazlmneEaINKSlK6kEnPx5XaJO2cOwp1Z3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742865544; c=relaxed/simple;
	bh=xq0PeV8mbZfAOI8yGLKIAYwtnbFy/lvBu3jMJSQ1p2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDTDL55IHAz29/wh9WIiU05Jwy2RNCyr5Kykd4qkl7C8IbUl0lnJU2qz/wwyn4Ik3I0DrWdTGuNM5/1Dv1iNkraO8clPcIL215viwIRhZ+8IkPAmR3lK3Ex+zNqdCuH4eOskMLkNPFabuEkZ/USvKe+9cmdDvOkgJYEl9SBXQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cj+6aFVU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj+6aFVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742865541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QeXy7bC9ytkDSw1rq/sYqAEDub4dZTXCLp5YKB3fW6I=;
	b=cj+6aFVU2/zRpNQVUJvoaVnXHzaFtZY9/5C6kHk92W0SvUHe9Q+1x7e68fIbwRRBPsH33T
	nrH5t7EhDOgc2Q9/FqhX/wq0HKfybuTvNC4tyPKJLx4F8J8wkLD7VCshHQMHNQ31jmbhLA
	deOacnNjGNg64FEg4bwW8ri+OnFhNqE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-RMq_s-G_Pb-v0FCFmHT4bg-1; Mon, 24 Mar 2025 21:19:00 -0400
X-MC-Unique: RMq_s-G_Pb-v0FCFmHT4bg-1
X-Mimecast-MFC-AGG-ID: RMq_s-G_Pb-v0FCFmHT4bg_1742865539
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2240a960f9cso80874345ad.0
        for <fstests@vger.kernel.org>; Mon, 24 Mar 2025 18:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742865539; x=1743470339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeXy7bC9ytkDSw1rq/sYqAEDub4dZTXCLp5YKB3fW6I=;
        b=mEcCvxu4FTwR/gtYeuh56ZiZnFqtdH3OvDbeFAa6FQYH79RNh+M+FYh7bJBcZvsJOD
         L0O9ayUxGCD9MOCrS4rZMVPf7yODxbQoJdMtLBAekrwQHLbbQY3n4Ik1zJ/arhPp095w
         OVC0wCCyie0iZpF58NFZWeb5GYsDsE1NK+t38vyUnORjLWPl5L6ljpeMWDDZLhxMgcAl
         rRK/6BTTeI5TEmKcqBfa74B0IFewxA0rvAlwTDYMyNOq/a6/xu9RSgx2iG3fQeauA2tk
         1WKV7+fVZNUUKT6WnjwFdagFkO6JUFrZs7Yfbe1YMJ4F6tCuMu3grUsx+3/XUPGnX57k
         iQBg==
X-Forwarded-Encrypted: i=1; AJvYcCUhBzgLWu5o4wVxdp+B4hNcfZNNIDYbu9D2tKypEoYq9K0yp6KBcKzHdZTdh0RU4APESBEQSE/m@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgZ5asAvcIVpZKqovkidnEx6CDCEN6qRXVJacM7AwEckpZK7W
	8r1sYr6T/zTA1FtzUxR5GhVwMAsxROfeZLUEHAZkunjgIwUp8zfPn51RnEZJac2gezvnxsVYW7W
	lxKvcx3bnehB3ISr+WLt+AP6HwraTGaafF2PdNaj0rlksRQotbymXHIFO0zVD1Uui4g==
X-Gm-Gg: ASbGncuuNaS+ggJypAHzSRg+dqp95ECpoKUu2hYXQHss0DbvW6p9C9oKu9Na7ZfM9nG
	2mvE5Jm1Ub5nE8r+sXWSo1+l7EkM5DuQuSgTY1//NhJ9r0mfzpJzSnpCXJo1JnVZZ/tFcqxcB/4
	Ou25gRH06OVbrf7QggEDYOnyNqijhE1OjdgNsINsRqMizzE9pG/fiWXlfHerTHY4+tZ8U0orka+
	9A9C+ha1oCq7TCO5EFwChBdXOcqtDaaKwzFnyOR/5KIfv84nPN3lmVFdIzR624ywf5An1SrzETV
	OFTUdaqkpdTOlWRkKbq+nfPDHA8J/IBrdPll2XcJOIOkRMRzg2WWbkjY
X-Received: by 2002:a05:6a00:1826:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-73905a139fbmr19006177b3a.17.1742865538624;
        Mon, 24 Mar 2025 18:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEO9+WpdOEqQ7A5ng1Den/8MVf0K7JGB87AUqqAfvuRXdpcuQlUXrUFU2gmgqgHSlO0EUdvg==
X-Received: by 2002:a05:6a00:1826:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-73905a139fbmr19006150b3a.17.1742865538048;
        Mon, 24 Mar 2025 18:18:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618abc9sm8736336b3a.165.2025.03.24.18.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 18:18:57 -0700 (PDT)
Date: Tue, 25 Mar 2025 09:18:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daeho Jeong <daehojeong@google.com>,
	Jianan Huang <huangjianan@xiaomi.com>
Subject: Re: [PATCH] f2fs/010: test dirty status handling on database file
Message-ID: <20250325011854.svncwerxilkimg5j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250324123836.3098377-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324123836.3098377-1-chao@kernel.org>

On Mon, Mar 24, 2025 at 08:38:36PM +0800, Chao Yu wrote:
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
>  tests/f2fs/010     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/010.out |  2 ++
>  2 files changed, 70 insertions(+)
>  create mode 100755 tests/f2fs/010
>  create mode 100644 tests/f2fs/010.out
> 
> diff --git a/tests/f2fs/010 b/tests/f2fs/010
> new file mode 100755
> index 00000000..360c09b9
> --- /dev/null
> +++ b/tests/f2fs/010
> @@ -0,0 +1,68 @@
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
> +	kill -9 $atomic_write_pid > /dev/null 2>&1

[ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid

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

So after this line, the $atomic_write_pid has been released. If so, how about:

unset atomic_write_pid

And then in _cleanup function .... (see above)

Others look good to me,

Thanks,
Zorro

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

