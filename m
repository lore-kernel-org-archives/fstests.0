Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A3279DCD
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914584; cv=none; b=oCXTwLyM1y6Eu0oD1IWv7ttkVfLfX1RAqo3FF5Kgqj62OREjb1ADfXVTN6RRugpM5kcwwTXC75pz5kYNy5czicjWF3in8PpebCenVixyHYnUBjlB6J0/3Vga/ZBW7F4fj5OAeTnOVpuT7d/uD0Btj4bIikfn1bhOZcsM+Ku50JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914584; c=relaxed/simple;
	bh=qRU48z8Rsy6HUVUFw6Ou0xs+okGEeiy2yjg2N1ql3qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxzawnFVPppSdPMVCFaqiFRxuDoVzvjwrrtYR48PRrmmQp0bmPfLv8rIqeNLaaBege3unRszT+yuazRUjl9UsTN+dqV/1LiEbeZRyYcdFHyqmMbSfZ/S+mjquK+OKvrtBt5h2hEKbQXI43o0eVrATblOcRlvM1wFexZ9WJwmTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GejJcXRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GejJcXRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758914582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQl5M6mAfM0DP6T6mNMjMr+kt77iQkZGSlvQMLNUDwI=;
	b=GejJcXRvpdyMUOm4/QnNkQAuPl3ATelbF2XocG94LHyckXPMil8sFHs9Hsx0RdbKTmAvRG
	i7u1pe8GA7kpiDY3uxj793h/iuz10IVIgXqQwT+XgAFWAkN11iIFDRsvb3vNXpdNhGuMvN
	lyHR+/X11FzvPxrNo0MDGxSlZYa7xBs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-IMDhKA3zMlS3M4zc_qzOwg-1; Fri, 26 Sep 2025 15:23:00 -0400
X-MC-Unique: IMDhKA3zMlS3M4zc_qzOwg-1
X-Mimecast-MFC-AGG-ID: IMDhKA3zMlS3M4zc_qzOwg_1758914580
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269af520712so31151525ad.2
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 12:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758914579; x=1759519379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQl5M6mAfM0DP6T6mNMjMr+kt77iQkZGSlvQMLNUDwI=;
        b=L7yIikKaSYnMNCwQIhDQluynlMVGyTRzU48+CT56DBy971kljd8gLFUHyTzWRVWDDh
         EeiVXW7bgKMo8M8idCDGkfS231y8cYZGDKAFfvJzVmvMU49KzJMvr0LtEThxa65UsIIK
         JpedxE6KZCwenR6oI/sGdiKMqKTUsyANShlAhesXB0krCTyqly1xTE2de+ga/0xicZJI
         Qk3macJRfZ2SE5781gFFeO4cHNiJdngovpaAj/4xRC2/BpRP0L+nHJJwrYBKfp+1BbOM
         ZCJ1vI5+OgRrLRuQlbDLobT549ngnIIuuE3Ru1x4ddWCr80LZl5PkXgtmU0lI0wa7/8P
         FrRw==
X-Forwarded-Encrypted: i=1; AJvYcCVjjvZcGLVHTUTFIFIRks3Olrl0CSr06Kw86hOhuvEkzAyJHtR8Ljr/nyH2HCHe1DTkFoKDAUCn@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuIJGjtQljUze/04132pSYkc5CVoQBUzZs17qNhNRfkxEkE04
	wsNZL3btDkdCBrKtKxBnP98dGUPuBAkEJaXAIs1pgK52aBAyhFxlCXhFq6/0g7hHgsn5o3SDdPi
	nJ/6CoIL9zYKK4sElmmSru6cAD5wBk9kB5iE+SW0wG1pcdMx3ylWmuIOeTms=
X-Gm-Gg: ASbGncs+ns+5W8oBrZ0DPJZeuOLh9zPt+kGIf+m57ok2fgC1TTvNjoFUHSMNqtwY9lE
	m+B419+d6ReY9WQS4ALPc2Zw9a4c0DvacU8uNVa1uhZTZGN/wXsn81q6X0MZAb471h7EevEM1GZ
	SnPBfhQBgzfhNJYjnmNSYHMHpAYPtAg8e+kx5ZRvklS2NrhxsrSLdaqGjmcDNomRnenijkLKbYh
	/AGomieslvQpasG8m3Bh+dKbYgZrXmr0Cou83rcKIMSlq9h4iUa7Sgc4n4hYzq1lUPcec21+pG8
	DFB35uASCiX+AJ7CjHckhLKcyDJg2vKZSzqDPLhNmKdjgo6NBO7GAXQLP9c0JNIbrkWV20nkqpD
	dbU94
X-Received: by 2002:a17:903:46c3:b0:246:7a43:3f84 with SMTP id d9443c01a7336-27ed4d882d9mr97777195ad.5.1758914579592;
        Fri, 26 Sep 2025 12:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkbt1BdFZV77XbMIioAMBObBqcjsfxvcRi9OG3sFQqZUyXS2psw6BsWhbO7Mp/MA7b8DW0sw==
X-Received: by 2002:a17:903:46c3:b0:246:7a43:3f84 with SMTP id d9443c01a7336-27ed4d882d9mr97776985ad.5.1758914579227;
        Fri, 26 Sep 2025 12:22:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6997ae3sm62325585ad.106.2025.09.26.12.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:22:58 -0700 (PDT)
Date: Sat, 27 Sep 2025 03:22:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs/022: do sanity check on footer of non inode
 dnode
Message-ID: <20250926192254.djrwx55itz422yft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250901020331.2171502-1-chao@kernel.org>
 <20250901020331.2171502-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901020331.2171502-2-chao@kernel.org>

On Mon, Sep 01, 2025 at 10:03:31AM +0800, Chao Yu wrote:
> This is a regression test:
> 1. create foo & bar
> 2. write 8M data to foo
> 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
> 4. fpunch in foo w/ specified range
> 
> If we haven't applied kernel patch ("f2fs: fix to do sanity check on
> node footer for non inode dnode"), f2fs may missed to do sanity check
> on corrupted dnode, result in panic in step 4).
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/022     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/022.out |  2 ++
>  2 files changed, 54 insertions(+)
>  create mode 100755 tests/f2fs/022
>  create mode 100644 tests/f2fs/022.out
> 
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> new file mode 100755
> index 00000000..a5e19a71
> --- /dev/null
> +++ b/tests/f2fs/022
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/022
> +#
> +# This is a regression test:
> +# 1. create foo & bar
> +# 2. write 8M data to foo
> +# 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
> +# 4. fpunch in foo w/ specified range
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +. ./common/attr
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to do sanity check on node footer for non inode dnode"
> +
> +_require_scratch_nocheck
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_xfs_io_command "fpunch"
> +_require_kernel_config CONFIG_F2FS_CHECK_FS

Looks like the CONFIG_F2FS_CHECK_FS is a necessary condition to reproduce
that bug, right? I'm wondering is there a better way to check if CONFIG_F2FS_CHECK_FS
is enabled, likes reading someone file in /sys or what ever else? Checking kernel config
isn't always a recommended way, except no better idea :)

> +
> +# remove all mkfs options to avoid layout change of on-disk inode
> +export MKFS_OPTIONS=""
> +
> +foo_path=$SCRATCH_MNT/foo
> +bar_path=$SCRATCH_MNT/bar
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +touch $foo_path
> +touch $bar_path
> +$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
> +sync
> +foo_ino=`stat -c '%i' $foo_path`
> +bar_ino=`stat -c '%i' $bar_path`
> +_scratch_unmount
> +
> +# inject foo inode to replace i_nid[0] w/ to bar ino
> +$F2FS_INJECT_PROG --node --mb i_nid --nid $foo_ino --idx 0 --val $bar_ino $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"
> +
> +_scratch_mount
> +# expect to trigger panic
> +$XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
> +_scratch_unmount
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
> new file mode 100644
> index 00000000..5307e3d7
> --- /dev/null
> +++ b/tests/f2fs/022.out
> @@ -0,0 +1,2 @@
> +QA output created by 022
> +fallocate: Structure needs cleaning
> -- 
> 2.49.0
> 

