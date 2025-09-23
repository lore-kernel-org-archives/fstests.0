Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743730F943
	for <fstests@vger.kernel.org>; Tue, 23 Sep 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643757; cv=none; b=Ut1Sq8v7fB8kU3Gx5GYmhdu6N+U3BbKY9HX4aapHLV/NVqGH6ggjJx+g97N6rdRGnOS2OFPrsvK6GWMO7hbNgTMWzCXmrqGtzl/cyFPMJZCPybOtW2qvb1Vwh6f59cBL1f/gD6qGEYmeEtv+LnLyfBu+lWMyQDwDT429F8EtZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643757; c=relaxed/simple;
	bh=AoFvGMfkzlYTY4XcmhZ6GjRRNwyayuTKGq8KTQImh8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9G9JWPhPBr4y2ncM2/1skdNU2tk93iyj6HrN8qrmXPh9y4XK69naqiVpK41iO6/4k4/pxpAk/7U0kuiebtEWoPU4FD8qsKoVRG8GrfIb5phjwvtxTEmLsOwIGiKA5P5AL+U7fTrg4FTQoT89rKFIAFoltIacDwFzAzW+viVWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESWy2uQ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESWy2uQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758643752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5vd0aC3s/m2gc3mlU8i8eR04/f2eUNWS80Cftv0iH4=;
	b=ESWy2uQ7yABcFx4hLs7mmnetS8Eitn0xOMPzCUGnDhwZ27r9OJvSTKSX24yYyrs3rT8uMn
	qY6Svem7TjHIk5+e+twYPaVjAq4v7pzHZNLKHiPcWFYAXUnWf/oOio/Zl7VqZ2y3s0wlKN
	Bu3Zk6ZRcopnUjZFHqam+3kjulbTHKQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-4-SpF2QEPweTmsFMso0y7A-1; Tue, 23 Sep 2025 12:09:11 -0400
X-MC-Unique: 4-SpF2QEPweTmsFMso0y7A-1
X-Mimecast-MFC-AGG-ID: 4-SpF2QEPweTmsFMso0y7A_1758643750
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f28552927so48583365e9.2
        for <fstests@vger.kernel.org>; Tue, 23 Sep 2025 09:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643750; x=1759248550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5vd0aC3s/m2gc3mlU8i8eR04/f2eUNWS80Cftv0iH4=;
        b=WMJEo82cN/saKh/eNqzBIfb5+ozMzwsty5GrZT+gS20wQgE6nWHi37dk0RUd4+zEbY
         kZWy73BUuw4ic39j6e3DpVQxsEssWyrYC99flv62SIeBROKVpG44Ck4k/yPrn8ZqNEOd
         8+8RO+r+N0KCyaMPce7P1pNWrcgFWM+OJWPJ7pkbMt3XU7+KLwK//dhdGHpK7WVVfTEF
         pj1vboR58wiNn4i6uu/FjYMoR4dniYdPGOSupXkStKHXd+2qCqMhx/zfFSSg2TeIMXEV
         jUzoFQUJWeWA/N4IXB+2GYcoYHxGwvvqDG0PxiTfLNTnz178CrC+7tGriu8qy6ctGiZo
         /PRg==
X-Gm-Message-State: AOJu0YwZ62dbcbqs8UTlx4nwQG33AQGSNDVlI2qrFtzuGnjwuMTIAftH
	BttU4piN0oAnBBIF4+Tf6wI1NS2EEMJXPfO9PtGre7BQH0IYLKdIYa7NZVMM2fGMHQvlarywIDr
	cXuKidduMRtceMTRUvoOQe8CwUODU4emz+wrOMXbZ3hiofMX8ZCu7BVmljJvbHLR1LV5/iQnZpv
	WulrEWa2aROc0ENtfXfP8twASUWFooqw83yRNW5B23/A==
X-Gm-Gg: ASbGncs0L0GLPXpCV5RnMKrsoZZWYCj2VQm9+Igo2tEZvFu8+RiOtaaQ6t7KZnDAWT9
	kTFCgUM7JgRPYC4cAk/jDKsAb+RBP1iFc7+Mkq300KlmOy1a8pD7rZxU/y56d0e5J6MiDkjSnzD
	tovN2/7qEfsMvxSV5eb2E/dnC+CPctwagNkbw2cRj7jK8Fb5Bw67s+SHeH7THsXRIM+caXrBHd0
	iu3FozXE2UGKEOyWYha4K37/SApEho8XS7SMLNwQ7QKRp+LBpIMtX3bECheFaIEHoUXr6wId/tZ
	G6zq0TZhIA1mEQAZEbYl+cIedXaDD6jN
X-Received: by 2002:a05:6000:26cd:b0:3e5:f1e2:6789 with SMTP id ffacd0b85a97d-405cc9ed076mr2638309f8f.59.1758643749815;
        Tue, 23 Sep 2025 09:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk7KWuOxdWQwJk5j2Bm+7Bbm1XrYxeHAGuZKX2fTAdLyAS+6cxLl7cEeEhDWv5BsKh9XHIlA==
X-Received: by 2002:a05:6000:26cd:b0:3e5:f1e2:6789 with SMTP id ffacd0b85a97d-405cc9ed076mr2638277f8f.59.1758643749305;
        Tue, 23 Sep 2025 09:09:09 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm26265729f8f.55.2025.09.23.09.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:09:08 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:09:07 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <3dzhysyljtiwafvtnqf4fd5vrb6rdqfohx3l2lvfb5xpcbwikk@tdcmhjpitqll>
References: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
 <20250909-xattrat-syscall-v3-2-9ba483144789@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-xattrat-syscall-v3-2-9ba483144789@kernel.org>

On 2025-09-09 17:25:57, Andrey Albershteyn wrote:
> Add a test to test basic functionality of file_getattr() and
> file_setattr() syscalls. Most of the work is done in file_attr
> utility.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/2000     | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/2000.out |  37 +++++++++++++++++
>  2 files changed, 146 insertions(+)
> 
> diff --git a/tests/generic/2000 b/tests/generic/2000
> new file mode 100755
> index 000000000000..b03e9697bb14
> --- /dev/null
> +++ b/tests/generic/2000
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 2000
> +#
> +# Test file_getattr/file_setattr syscalls
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +. ./common/filter
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_test_program "af_unix"
> +_require_test_program "file_attr"
> +_require_symlinks
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +file_attr () {
> +	$here/src/file_attr $*
> +}
> +
> +create_af_unix () {
> +	$here/src/af_unix $* || echo af_unix failed
> +}
> +
> +projectdir=$SCRATCH_MNT/prj
> +
> +# Create normal files and special files
> +mkdir $projectdir
> +mkfifo $projectdir/fifo
> +mknod $projectdir/chardev c 1 1
> +mknod $projectdir/blockdev b 1 1
> +create_af_unix $projectdir/socket
> +touch $projectdir/foo
> +ln -s $projectdir/foo $projectdir/symlink
> +touch $projectdir/bar
> +ln -s $projectdir/bar $projectdir/broken-symlink
> +rm -f $projectdir/bar
> +
> +echo "Error codes"
> +# wrong AT_ flags
> +file_attr --get --invalid-at $projectdir ./foo
> +file_attr --set --invalid-at $projectdir ./foo
> +# wrong fsxattr size (too big, too small)
> +file_attr --get --too-big-arg $projectdir ./foo
> +file_attr --get --too-small-arg $projectdir ./foo
> +file_attr --set --too-big-arg $projectdir ./foo
> +file_attr --set --too-small-arg $projectdir ./foo
> +# out of fsx_xflags mask
> +file_attr --set --new-fsx-flag $projectdir ./foo
> +
> +echo "Initial attributes state"
> +file_attr --get $projectdir | _filter_scratch
> +file_attr --get $projectdir ./fifo
> +file_attr --get $projectdir ./chardev
> +file_attr --get $projectdir ./blockdev
> +file_attr --get $projectdir ./socket
> +file_attr --get $projectdir ./foo
> +file_attr --get $projectdir ./symlink
> +
> +echo "Set FS_XFLAG_NODUMP (d)"
> +file_attr --set --set-nodump $projectdir
> +file_attr --set --set-nodump $projectdir ./fifo
> +file_attr --set --set-nodump $projectdir ./chardev
> +file_attr --set --set-nodump $projectdir ./blockdev
> +file_attr --set --set-nodump $projectdir ./socket
> +file_attr --set --set-nodump $projectdir ./foo
> +file_attr --set --set-nodump $projectdir ./symlink
> +
> +echo "Read attributes"
> +file_attr --get $projectdir | _filter_scratch
> +file_attr --get $projectdir ./fifo
> +file_attr --get $projectdir ./chardev
> +file_attr --get $projectdir ./blockdev
> +file_attr --get $projectdir ./socket
> +file_attr --get $projectdir ./foo
> +file_attr --get $projectdir ./symlink
> +
> +echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
> +file_attr --set --set-nodump $projectdir ./broken-symlink
> +file_attr --get $projectdir ./broken-symlink
> +
> +file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
> +file_attr --get --no-follow $projectdir ./broken-symlink
> +
> +cd $SCRATCH_MNT
> +touch ./foo2
> +echo "Initial state of foo2"
> +file_attr --get --at-cwd ./foo2
> +echo "Set attribute relative to AT_FDCWD"
> +file_attr --set --at-cwd --set-nodump ./foo2
> +file_attr --get --at-cwd ./foo2
> +
> +echo "Set attribute on AT_FDCWD"
> +mkdir ./bar
> +file_attr --get --at-cwd ./bar
> +cd ./bar
> +file_attr --set --at-cwd --set-nodump ""
> +file_attr --get --at-cwd .
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/2000.out b/tests/generic/2000.out
> new file mode 100644
> index 000000000000..11b1fcbb630b
> --- /dev/null
> +++ b/tests/generic/2000.out
> @@ -0,0 +1,37 @@
> +QA output created by 2000
> +Error codes
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Argument list too long
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Argument list too long
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not set fsxattr on ./foo: Invalid argument
> +Initial attributes state
> +----------------- SCRATCH_MNT/prj 

hmm, this needs to filter out ------X standing for extended
attributes, this test will fail if selinux is enabled for example

I will send another revision soon

-- 
- Andrey

