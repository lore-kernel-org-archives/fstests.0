Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4324101F7
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009070; cv=none; b=mYpLuAJSjxeEHvsvm8xc90pyOlVH52J2FsXsIo7VhNxOXlxgt89vzDLlfCX12eQvRJ5nIM0pQiurpqskyPdz0aaDaPod4iUjTxnQwjvYyx3K9XjNHE2aFKYlINMnn4+br9TnrwYgHwv6Ystgb/0K94miCfBoKgOWVXq1pv4uPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009070; c=relaxed/simple;
	bh=zhym4V3QLC3FhxmcOHlBYu8Q02nV5K3w2MoesOEjYQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r77TU+wYcqcmZ8Yeb0qT+qppPk4+NiyYYGszsFobx60R9bECcpcv5x97n0PUAqv436pc/G4g5C5JuPh4LXcHPasT2iOrcFjHlE03sqEXetPrWhz3PQpvPo0uAR8LroSnpwMo1BxtSMQoLY8liKENp3ne7Otce7KMvbdYVeELiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvyR01gk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvyR01gk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722009067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vUe8WBzhVNUTbGuEKEiUGRjCXOwWhRVYd1zRCdAMIa4=;
	b=TvyR01gkE7HtLrft02cOUYtFEI/w8cV1CpW7wp3F24NUdwKrNqj4EJnWB23L/81PiolpY5
	Z8nthVj4utdkBcXp1CD5gD0UtdZDl5J+SRafWPKwnz6OKXEug3WsmPSz23c3g6OcFCDnqL
	RNmzdkau4VahUikBfrW9/kST9NZtMnM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-TAhl2hllMEuY5BoGe4k2Ww-1; Fri, 26 Jul 2024 11:51:06 -0400
X-MC-Unique: TAhl2hllMEuY5BoGe4k2Ww-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2610eec2f54so1538403fac.2
        for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 08:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722009065; x=1722613865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUe8WBzhVNUTbGuEKEiUGRjCXOwWhRVYd1zRCdAMIa4=;
        b=YLk4ujuDXA7jm0q0B3bfDKp+6+N+n/35XbryYd4tu6WBliYlLXWv3BJLCkjUCya54r
         7+bQeyfO96Q9ZqxJZwJ9WLqMSkWE9YAPc65yQIPMYuSKRD53Xg0fF48IuC3hFE0i+qdM
         N3IHCC6dZz9oQZnFOSeh5n4ozfych8TLbzxIhQS9Ka+md1zhclzz3h91JCwaLMrJDjw9
         IJVXG3X+CuQ0jVM+KFDEjbYlMHB9f+58HM11WAEBAr9Pvm5zENNmZ4xK1OPZ0xeM6E5O
         FvfSyi0gRd75gz1r+/f7OrYs5RxbubBdLcy4y2hugPXQmRAxHDiYH90G59Y0kXfXY1hg
         U1Bw==
X-Gm-Message-State: AOJu0Yzpdo8bAC126mE0fA10LABxLXXFNTvlAFuZh0lWe8NsCcF6DHBh
	skOJvFrWqgCp30ResOR/KPr3HVycH1uczn5zP2jCK143Yo1p3i4SeXEpdqv9Ar/xXnDFb1lFe23
	8P/hZyiMcxsD7zR5x7ldUXbfYt2bv6aVq3lUZybrCRKRBtK5VkPnnQhE=
X-Received: by 2002:a05:6870:63a5:b0:260:3fb2:b724 with SMTP id 586e51a60fabf-267d4f3d56bmr203292fac.46.1722009065019;
        Fri, 26 Jul 2024 08:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZjTUe5XYn9eBAZR2mG1GkilCRfiYxPW2RbqYKjlh7798lnpx3rWpPDm/AEqikjek6jntYzA==
X-Received: by 2002:a05:6870:63a5:b0:260:3fb2:b724 with SMTP id 586e51a60fabf-267d4f3d56bmr203268fac.46.1722009064673;
        Fri, 26 Jul 2024 08:51:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874c32sm2957831b3a.173.2024.07.26.08.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:51:04 -0700 (PDT)
Date: Fri, 26 Jul 2024 23:51:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v2] f2fs: test for race condition in between atomic_write
 and dio
Message-ID: <20240726155101.uop5do6hl3vvjnit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240720074540.3303154-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720074540.3303154-1-chao@kernel.org>

On Sat, Jul 20, 2024 at 03:45:40PM +0800, Chao Yu wrote:
> Test that we will simulate sqlite atomic write logic w/ below steps:
> 1. create a regular file, and initialize it w/ 0xff data
> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> 3. write transaction data
> 4. trigger direct read/write IO to check whether it fails or not
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> This is a regression test to check handling of race condition in
> between atomic_write and direct IO.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add kill&wait in _clean() to avoid umount failure
> - some cleanups
> - use exported helpler
>  tests/f2fs/004     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/004.out |  3 +++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/f2fs/004
>  create mode 100644 tests/f2fs/004.out
> 
> diff --git a/tests/f2fs/004 b/tests/f2fs/004
> new file mode 100755
> index 00000000..d71e99ea
> --- /dev/null
> +++ b/tests/f2fs/004
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/004
> +#
> +# Test that we will simulate race case in between sqlite atomic write
> +# and direct IO w/ below steps:
> +# 1. create a regular file, and initialize it w/ 0xff data
> +# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> +# 3. write transaction data
> +# 4. trigger direct read/write IO to check whether it fails or not
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# This is a regression test to check handling of race condition in
> +# between atomic_write and direct IO.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +_cleanup()
> +{
> +	kill -9 $atomic_write_pid > /dev/null 2>&1
> +	wait > /dev/null 2>&1

This version is good to me, same things as your last patch. I'll change
it when I merge this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +}
> +
> +_require_scratch
> +_require_odirect
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +dbfile=$SCRATCH_MNT/dbfile
> +
> +# start atomic_write on dbfile & write data to dbfile
> +touch $dbfile
> +$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
> +atomic_write_pid=$!
> +
> +# simulate concurrent direct read/write IO
> +$XFS_IO_PROG -d -c "pread 0 128k" $dbfile
> +$XFS_IO_PROG -d -c "pwrite 0 128k" $dbfile
> +
> +# wait for atomic_write commit completion
> +sleep 5
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/004.out b/tests/f2fs/004.out
> new file mode 100644
> index 00000000..3af79541
> --- /dev/null
> +++ b/tests/f2fs/004.out
> @@ -0,0 +1,3 @@
> +QA output created by 004
> +pread: Operation not supported
> +pwrite: Operation not supported
> -- 
> 2.40.1
> 

