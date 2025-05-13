Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD57E9
	for <fstests@vger.kernel.org>; Tue, 13 May 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117830; cv=none; b=WUImaRBD1nda4rae6oJ9128T/iqPGkVFdYLFUXZq1tZwwHeQRaNkEiWLxToFNbEzyzFJi5YXZIld6t9hDHbuzuihm6YjdtGSzg315TPWG9bd2R5l+El92Vwd1CuEO5F4VG5MZ3o/wYWtogphUN+BtxXcY626hnBTZchmAcEsHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117830; c=relaxed/simple;
	bh=r2KFiQRVige9nDSW/WzYxuDzzgVwSSMbD/KuXsDmdMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaBJ/MZzF8ZQuszgL4ZoLiACNzx3kZzno6NxzD9bEqYEGm/b6GnwKeMk9cXMQ77qR6QORGZP7JlQzCqKWO4dJezh+7hWGOQipDvZLIIwqVPX7OBzdNRoyTHJt6CkbLLOroONjjNDKe1LE2dGZb4nD9dG6BUqsKtuOBWEFY4ao+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsSHiJjD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsSHiJjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747117827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUV/Ffk7DVBmw0rYl7ApHOAXVBazwYa38LSpmJcHTsw=;
	b=GsSHiJjDwVFwfu75vtYaKfVJsKsYvC+2J7TSKBQhB2Y3xcE8YBEI7CubqtQDkhFA+YIN2P
	QUBS/T4EtGu2rIh7UxHM0hzWP4bCT30jeOloNI7JTsL4ULBaBrF2GQ1+o76D3fD0Vz6tfH
	K869R7cJLhp4jHse2lc/Xe0J5G2LN0I=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-ODPP6vAkNR-TFZzJL6MYGw-1; Tue, 13 May 2025 02:30:26 -0400
X-MC-Unique: ODPP6vAkNR-TFZzJL6MYGw-1
X-Mimecast-MFC-AGG-ID: ODPP6vAkNR-TFZzJL6MYGw_1747117825
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7375e2642b4so3867391b3a.2
        for <fstests@vger.kernel.org>; Mon, 12 May 2025 23:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747117825; x=1747722625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUV/Ffk7DVBmw0rYl7ApHOAXVBazwYa38LSpmJcHTsw=;
        b=uFotI2krsFtKyqWE5Xfh5rE+Jz2LlEE58wAAksUypQTYAj7jNilpTw40uAUum/r3hm
         gWLZVFYqW3Ck5l4kFlGDD/4PTsXJ5ZH8xo1L3Y6boecvKbSLf8yMNPDSc2tsqHg5DWlV
         65WLTRpJiP19VQUY6AkfYQnRNAABGwgRrVDco9Iu0xvxLHbN4ImV+f0h7J0YNCRdkgw9
         +j4He12Ysasi3bHppERxBc3+JKIzzbMPKWGQfJhBLvoUWOGDjR8N+l9smzwLDNR5be3F
         j6Yjv1LRhFabB6l0SqxuwWAIHJj1kMX8Gm1xVHwL85Zxr3vHr3tH+NYVZZbzQQousj14
         ScfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLs36kApYIfRB6cOsLXvAlg9XXvQDsxFwIvY/CSX7C3S84DY2Gw69oXScTbSnAiOPCb65JU/M@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5yZM5rxqPKVRLmBuYjcvw7pHm/KXwO5+ZOPNd1K2EbsgqmH9
	CmdFdccGlKn99sVZaoVuO41T9LlI0AAvE1bsscnL/RGuMcgKWEeGD+8Iat1BYWv3HP/nDENTxF3
	mug5K5LvsVP3L/9T05QS+dyvAeyCylP73ngjYIrb7hYwjsilPrRyo4uE=
X-Gm-Gg: ASbGncszhh9YH2f2UocpMNLmKuGS8PKjilCwVsUG2h39kv56NUnMO9PhJ7qPwrzxlE7
	iJr7h4c0W5A8YbaHd69tfT609fzWvBwnVlzkiUyNSlcmVNu9l4P+j2PPG4RR49ZprKkBnrlPHyp
	U+oQEqS2lgwC8ccK5kcUI1Mm6Dau4l7vhy/oCgJsyrB4k57s8TBMGBTc4UG9MckvLlAitzR/f1H
	WPaMT2wVNDK+d8TyORH+C/hkKB1zPWtJUdKQ9v8Yoz/MUoe8hPzYp5OJt2RShnEr7a7MemIFPWD
	Dxtqp15noevSDv+MV5XrzJVFd4rSo8/GNeamG6gxwYLPTUJQbx6I
X-Received: by 2002:a05:6a00:450a:b0:740:41e4:e761 with SMTP id d2e1a72fcca58-7423c07be27mr20644003b3a.22.1747117825291;
        Mon, 12 May 2025 23:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDFuuZY2PwrySlH/2oK0Yn5HS5Wp2PGUYA4rNBV+IKvQrjNHdTw/yDK8BhopSSQasR4RMhFg==
X-Received: by 2002:a05:6a00:450a:b0:740:41e4:e761 with SMTP id d2e1a72fcca58-7423c07be27mr20643961b3a.22.1747117824917;
        Mon, 12 May 2025 23:30:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704025sm7383795b3a.13.2025.05.12.23.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 23:30:24 -0700 (PDT)
Date: Tue, 13 May 2025 14:30:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs/013: test to check potential corruption on
 atomic_write file
Message-ID: <20250513063019.afppmskz4nom54ua@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509060754.1677062-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509060754.1677062-1-chao@kernel.org>

On Fri, May 09, 2025 at 02:07:54PM +0800, Chao Yu wrote:
> This is a regression testcase to check whether we will handle database
> inode dirty status correctly:
> 1. mount f2fs image w/ timeout fault injection option
> 2. create a regular file, and write data into the file
> 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> 4. write transaction data to the file
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> 6. meanwhile loop call fsync in parallel
> Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
> file"), database file may become corrupted after atomic write while
> there is concurrent dirty inode flush in background.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - fix typo: s/relis/relies

This version is good to me, thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/013     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/013.out |  2 ++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/f2fs/013
>  create mode 100644 tests/f2fs/013.out
> 
> diff --git a/tests/f2fs/013 b/tests/f2fs/013
> new file mode 100755
> index 00000000..80ed2702
> --- /dev/null
> +++ b/tests/f2fs/013
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/013
> +#
> +# This is a regression testcase to check whether we will handle database
> +# inode dirty status correctly:
> +# 1. mount f2fs image w/ timeout fault injection option
> +# 2. create a regular file, and write data into the file
> +# 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> +# 4. write transaction data to the file
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# 6. meanwhile loop call fsync in parallel
> +# Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
> +# file"), database file may become corrupted after atomic write while
> +# there is concurrent dirty inode flush in background.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +_cleanup()
> +{
> +	[ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> +	wait
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_fixed_by_kernel_commit f098aeba04c9 \
> +	"f2fs: fix to avoid atomicity corruption of atomic file"
> +
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +# note that it relies on FAULT_TIMEOUT fault injection support in f2fs
> +_scratch_mount "-o fault_injection=1,fault_type=4194304" >> $seqres.full
> +
> +dbfile=$SCRATCH_MNT/file.db
> +
> +# initialize database file
> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $dbfile >> $seqres.full
> +
> +# sync filesystem to clear dirty inode
> +sync
> +
> +# start atomic_write on src.db database file and commit transaction
> +$F2FS_IO_PROG write 1 0 2 zero atomic_commit $dbfile >> $seqres.full &
> +atomic_write_pid=$!
> +
> +# call fsync to flush dirty inode of database file in parallel
> +for ((j=0;j<1000;j++)) do
> +	$F2FS_IO_PROG fsync $dbfile >> $seqres.full
> +done
> +
> +wait $atomic_write_pid
> +unset atomic_write_pid
> +
> +# flush dirty data and drop cache
> +sync
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +stat $dbfile -c %s
> +
> +rm $dbfile
> +sync
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
> new file mode 100644
> index 00000000..d9271f75
> --- /dev/null
> +++ b/tests/f2fs/013.out
> @@ -0,0 +1,2 @@
> +QA output created by 013
> +8192
> -- 
> 2.49.0
> 
> 

