Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61084CA73
	for <fstests@vger.kernel.org>; Sun,  3 Mar 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472500; cv=none; b=MaSR8XWuu9vIOcTcZiaKi2bBOeN059WdEMOTtLhZ0BaSqr2PnHaI1y7IF4HwRGWTaaM9JcNOFDGMPEpwZrhvorCm5g+aXsPGOYu5iWDlGUt0wrm0POJ2f+9SXj9G6xGpA8lFIt4wCpzLm3m4t7e0zff8h0MpQj+Obhe4y+dArCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472500; c=relaxed/simple;
	bh=5PlyVdKlLtGt3EncopBr0Wf6brpJK5ywvIy4MoZ9bFI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL+v9Qmqyo/Jz1UqQwKyfVjx5+y4Nd7+DRDrEporaodoSZvzr8flBDk86fnib6Vs7RKT9mF0PxKGUtAdkPTrdTN+x7gkwdmFBILf9Chvx3aAiNxN6QyLkL2Ao1zZo7qaptYgekBrBdljkwBwOGg1kLdn/8tTVMsPzVqDzB6snnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHyZYaKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHyZYaKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709472497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXfGPnOAXRwe3xwghwuzhuQwB/xFxJashKXfI+3yDak=;
	b=QHyZYaKRrcjnFw2Jr9z9T9h14LdlA9+Hny/9X3D6s1OuIeZMfNRocdihnNGkVS1fgBwsz0
	PpoJjtmF2ETgmfqt2FGBDReULUOlhQLR/a493BBqtiY5dF3burcM4khNYGgruTftfWgs2g
	d42/+vVrKLkJU8/4Gf9JG++xbax6b0s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369--oPTXffaMBub79dv8VR3Ig-1; Sun, 03 Mar 2024 08:28:14 -0500
X-MC-Unique: -oPTXffaMBub79dv8VR3Ig-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dccac85165so34576895ad.0
        for <fstests@vger.kernel.org>; Sun, 03 Mar 2024 05:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709472493; x=1710077293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXfGPnOAXRwe3xwghwuzhuQwB/xFxJashKXfI+3yDak=;
        b=bwrYdJ83quHRGNTFhwXXX6dGQAqe0mv5BODqFoyQ3SguwM02XWaa8zxUzAwQoUVDki
         BHsrnlmFWTn8Mb5D39E8u63GxS32RwwBJRsLYM9NkKHSoSA6WN90Nkg+Ey0LIB6XsuQb
         73HXqyiXQUPjY8QldqHRunDyR9m/quPV47xCMz4waSZf5Fgx6WdN+8DIbrt5d61Qc4gH
         Dj57utThbax7lLnkBpMkQD9CbBc2kXQQ1YLGMK8HAN0w6L/601dSzCsBuEULX3Y6GX5v
         Z3/gJ88t93QUa03ZQlD67KypNzCUyLtbxrf8F//yvOVdNMqh1mJr0l2z5u9Vnqw3xuHX
         z8vQ==
X-Gm-Message-State: AOJu0YwEj+KJ/WPWPOL6ohT81pIfDtzBmbIMVvG6RBBim9KwyQygfzQx
	cwJ50FPRw59Ncs2Rq76ZlonGJcWKzSQKSIR2ayEre76WF3BoyXbVcBiN1cCJDR5enjvMSRda6IC
	iA6TZfhAxE/r30B4/BoypV7RfTk0/quGJkMLfjYu/1PBqiCDRABUZEfoZi70QWRhNGUKrehWaOJ
	j/DhdLLQH638ETvbviQtGjnguK2Fo33CwhOX0DXw==
X-Received: by 2002:a17:902:e74d:b0:1dc:c0c8:6bfa with SMTP id p13-20020a170902e74d00b001dcc0c86bfamr7520629plf.17.1709472493640;
        Sun, 03 Mar 2024 05:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXvqc1GPha+f+iUZ1hdRp3GS6ZcmfP4/eOoCDRjplIbBvRnreRsOXkkhw9fomRtdOzib6RQA==
X-Received: by 2002:a17:902:e74d:b0:1dc:c0c8:6bfa with SMTP id p13-20020a170902e74d00b001dcc0c86bfamr7520608plf.17.1709472493128;
        Sun, 03 Mar 2024 05:28:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001dcfae01c63sm2766651plb.43.2024.03.03.05.28.12
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 05:28:12 -0800 (PST)
Date: Sun, 3 Mar 2024 21:28:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.03.03
Message-ID: <20240303132810.n7hvnglcea4arkal@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <65e4719a.050a0220.eb82c.d42fSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e4719a.050a0220.eb82c.d42fSMTPIN_ADDED_BROKEN@mx.google.com>

On Sun, Mar 03, 2024 at 08:48:10PM +0800, Zorro Lang wrote:
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2024.03.03 release.
> 
> Release Note:
> This's a release for btrfs testing mainly. There're 8 btrfs new test cases,
> (include btrfs/303 and btrfs/311 ~ 317), and some new helpers, new test
> groups, bug fixes and so on. Thanks for the reviewers and Anand Jain helped
> much.
> 
> There're also some bug fixes and updates for common/*, Makefile and some
> generic cases. More details refer to below. Thanks for all these contribution!

As some buddies hope to check/use the patches might be in next release. I pushed
my local "patches-in-queue" branch. This branch contains some patches under
my testing. But not all of them are acked, this's a testing branch, and might
be reconstructed sometimes. Feel free to check it if you need.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> The new head of the for-next branch is commit:
> 
> 9b6df9a01ac8 btrfs/016: fix a false alert due to xattrs mismatch
> 
> New commits ([N]ew, [U]pdate):
> 
> Anand Jain (10):
> [U]      [c5c8a2223881] common/rc: assign SCRATCH_DEV_POOL to an array
> [U]      [b89613e85fe2] btrfs: introduce tempfsid test group
> [U]      [257d00e13dca] btrfs: create a helper function, check_fsid(), to verify the tempfsid
> [N]      [e6c1d2ab76a9] btrfs: verify that subvolume mounts are unaffected by tempfsid
> [N]      [408376708514] btrfs: check if cloned device mounts with tempfsid
> [U]      [5673516f9824] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
> [U]      [3ec2d4378c6c] btrfs: introduce helper for creating cloned devices with mkfs
> [N]      [0a50ae6c2006] btrfs: verify tempfsid clones using mkfs
> [N]      [4af68c15504d] btrfs: validate send-receive operation with tempfsid.
> [N]      [a6c984e10159] btrfs: test tempfsid with device add, seed, and balance
> 
> Anthony Iliopoulos (2):
> [U]      [cc23dcb3ebe6] generic/68[12]: use the dir blocksize for xfs filesystems
> [U]      [28928ea7af86] generic/682: update and fix-up golden output
> 
> Filipe Manana (6):
> [N]      [faabc4852ad9] btrfs: test incremental send on sparse file with trailing hole
> [U]      [15c084fe1137] btrfs: require no nodatacow for tests that exercise compression
> [U]      [45d779c9d241] btrfs/173: make the test work when mounting with nodatacow
> [U]      [d9d267ada5a0] btrfs/299: skip test if we were mounted with nodatacow
> [U]      [07e9d3d39c3c] btrfs: require no nodatacow for tests that exercise read repair
> [U]      [3f740470e96b] generic/736: fix a buffer overflow in readdir-while-renames.c
> 
> Johannes Thumshirn (3):
> [U]      [43f4d620203e] filter.brtfs: add filter for conversion
> [U]      [fe6326040eb3] filter.btrfs: add filter for btrfs device add
> [N]      [8c9102789fec] btrfs: check conversion of zoned fileystems
> 
> Luis Chamberlain (1):
> [U]      [cb1f76a28453] common/config: fix CANON_DEVS=yes when file does not exist
> 
> Martin Jansa (1):
> [U]      [a8fbb364834f] tests/*/Makefile: make sure group.list DIRT exists before install
> 
> Qu Wenruo (4):
> [N]      [00989655e212] btrfs: validate inconsitent qgroup won't leak reserved data space
> [U]      [779ae21a305d] btrfs: btrfs/224 do not assign snapshot to a subvolume qgroup
> [U]      [662db2673538] btrfs: detect regular qgroup for older kernels correctly
> [U]      [9b6df9a01ac8] btrfs/016: fix a false alert due to xattrs mismatch
> 
> 
> Code Diffstat:
> 
>  common/btrfs                | 76 ++++++++++++++++++++++++++++++++++++-
>  common/config               |  2 +-
>  common/filter.btrfs         | 15 ++++++++
>  common/rc                   | 29 ++++++++++++--
>  doc/group-names.txt         |  1 +
>  src/readdir-while-renames.c | 10 ++++-
>  tests/btrfs/016             | 53 +++++++++++---------------
>  tests/btrfs/024             |  1 +
>  tests/btrfs/048             |  1 +
>  tests/btrfs/059             |  1 +
>  tests/btrfs/138             |  1 +
>  tests/btrfs/140             |  3 +-
>  tests/btrfs/141             |  2 +
>  tests/btrfs/157             |  2 +
>  tests/btrfs/158             |  2 +
>  tests/btrfs/173             |  5 +++
>  tests/btrfs/215             |  2 +
>  tests/btrfs/224             |  6 +--
>  tests/btrfs/234             |  1 +
>  tests/btrfs/265             |  2 +
>  tests/btrfs/266             |  2 +
>  tests/btrfs/267             |  2 +
>  tests/btrfs/268             |  2 +
>  tests/btrfs/269             |  2 +
>  tests/btrfs/281             |  1 +
>  tests/btrfs/289             |  2 +
>  tests/btrfs/299             |  3 ++
>  tests/btrfs/303             | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/303.out         | 24 ++++++++++++
>  tests/btrfs/311             | 87 ++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out         | 24 ++++++++++++
>  tests/btrfs/312             | 78 ++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/312.out         | 19 ++++++++++
>  tests/btrfs/313             | 52 +++++++++++++++++++++++++
>  tests/btrfs/313.out         | 16 ++++++++
>  tests/btrfs/314             | 78 ++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/314.out         | 23 ++++++++++++
>  tests/btrfs/315             | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/315.out         | 10 +++++
>  tests/btrfs/316             | 59 +++++++++++++++++++++++++++++
>  tests/btrfs/316.out         |  2 +
>  tests/btrfs/317             | 67 +++++++++++++++++++++++++++++++++
>  tests/btrfs/317.out         |  9 +++++
>  tests/btrfs/Makefile        |  2 +-
>  tests/ceph/Makefile         |  2 +-
>  tests/cifs/Makefile         |  2 +-
>  tests/ext4/Makefile         |  2 +-
>  tests/f2fs/Makefile         |  2 +-
>  tests/generic/681           |  2 +-
>  tests/generic/682           | 10 ++++-
>  tests/generic/682.out       |  2 +-
>  tests/generic/Makefile      |  2 +-
>  tests/nfs/Makefile          |  2 +-
>  tests/ocfs2/Makefile        |  2 +-
>  tests/overlay/Makefile      |  2 +-
>  tests/perf/Makefile         |  2 +-
>  tests/selftest/Makefile     |  2 +-
>  tests/shared/Makefile       |  2 +-
>  tests/tmpfs/Makefile        |  2 +-
>  tests/udf/Makefile          |  2 +-
>  tests/xfs/Makefile          |  2 +-
>  61 files changed, 942 insertions(+), 62 deletions(-)
> --
> Zorro Lang
> zlang@kernel.org


