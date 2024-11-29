Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513940BE5
	for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732849361; cv=none; b=BY4FlqIIjd0IPIIRMmmyt5t8zj6qiQ7eN341r+x5vf/bycDHtwg3aCq3tr1LxcBrzgUpAeT1N2WQdkSK+8VGZeCtN3py0W6S3bunjhf5TUW6wuKsNnEEWBvRuQcQ0rRIh4//3iJjvicgaQm5Q8m7KOnrQ5UzOW+1rZxRg/svLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732849361; c=relaxed/simple;
	bh=Ru/S1gnJgzVmapMKWTwKUSY7A4MbH2NXxoMc3RgiZC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2SzqpQnz9nY9tP+HajQ//6sbxVK7IrYc6lOixRcjXYfazkN4H79DYcU0H5unxyA0Wh1IMmPOltPVFt4FnEc5Oxyi2AYDACWQgP32A+gDmbox9rgNLOGL36nf55Vk8Pk4lb7CHpSMoWieNeNG89mHgE4QpHTaBUDp34fqXEPKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOXPfs6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOXPfs6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732849358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3598O+mrmct5Rme66ad1fwz1vmhIJZlgukJ/lu+XE1c=;
	b=EOXPfs6ch5R8yjw7CNdfU9Sblsz3SwlH/v1eSgcGzbxERrBAEQvAX0LClan8VMiFC3y3oI
	8JRz93LO8mILky16BoM2Nr60hU9LISm+Ykp2o/fUyr2xfs64IGDbtb7DRY52FWTi2vS4Xc
	kzc7WXQ2ZDWOJwd4liah0BfVNYWzI5s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-bbbqoh2kOxiw68uIofFzSg-1; Thu, 28 Nov 2024 22:02:37 -0500
X-MC-Unique: bbbqoh2kOxiw68uIofFzSg-1
X-Mimecast-MFC-AGG-ID: bbbqoh2kOxiw68uIofFzSg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21507b32383so14745955ad.3
        for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 19:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732849356; x=1733454156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3598O+mrmct5Rme66ad1fwz1vmhIJZlgukJ/lu+XE1c=;
        b=jz7/BeJPrwv72658EB2wjeGPajQxYwZ7FD3OG+EKaJANEloe8tCn6VG1RFceghjDrm
         KF60B916CoxtTE0WcG9GzKIn1hFEVE2Vy/Oggald2TDTx0MSJ+vjQ59STmGdq1DJ6otB
         DhoPhWBIqyfiYNt+nDbMIS4qAVLH/8RMONNhcwPqgiBQ4S/y2Jchm9nIN0UPN3bKm3fT
         WHDN/aMchFGKmgWfP4SO0mb0077vMjuqFYnavBhrhn5AdyEb1fcAoG399XA59UAA94G1
         5kBcmznw+wC24QWiptUrxgyLXrbUdqthGf2k72R/yEBSeWHceknNgDDgt7QMuughoWw+
         TJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAXPnWCR3WgLBPCTIOMZwuiAmJ9fWgByH2IgoB/I7sNVrSL5sCFNEXQDF+/g9dovc4vqEHGCpD@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNDD1WtfSoDmWueXrUGTzurxOPJZCgkT2maUu0SOvx2qW3sWz
	NB/8+TnAwUPfm8wmkJ6w/AKvQ5Jogy9pcwEnNY4RkvwqsETr3/QWk4iX9ThMDp99CmoB/v8zEcg
	4a+dH3NUGusenQO0SGPIOQx8PtSfGxOlYWR6S1iJokMeOZ8BmeZcfdSE=
X-Gm-Gg: ASbGncsLpmyOG4BGoKGnZ/goXJktybdEg4tPw/PtC6c6aVWs/Mx6O2MlabTZnDDsKlu
	sTFsXv1uC9AZvyPbHPz2m0EJ8mqSJ8SO6ur0zltjDdI8MqOc6V0n7CidvTkkkECH5UE/2rEORS/
	oua7LNVdEpeVVr4AHLLQAEePhy7DdeFs9z0mPvS/GE8eDeBYcNNhTMKbF272/Wd6BGT8ZBGdhFC
	3HUOYMj+SX+YOMoKC8QvgIEG8qdYG5gA3KiIqkbZj2Ah7h+/w1EIVaLgCju5qxZwWbvZWswIv1o
	uxqcGz/rDr77N/E=
X-Received: by 2002:a17:902:b716:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21501d6133cmr107671245ad.46.1732849355790;
        Thu, 28 Nov 2024 19:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvD5TXLCe71UaDrJq1GGeOtZ8xGevhR9mglqwIqZSiRUSBJMx/ONK3ajl4WZNGQ1HhKYdVuA==
X-Received: by 2002:a17:902:b716:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21501d6133cmr107670905ad.46.1732849355403;
        Thu, 28 Nov 2024 19:02:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152191b524sm20815935ad.111.2024.11.28.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 19:02:34 -0800 (PST)
Date: Fri, 29 Nov 2024 11:02:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/327: add a test case to verify inline extent data
 read
Message-ID: <20241129030231.shgqx4ot4vbnht7w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241115091926.101742-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115091926.101742-1-wqu@suse.com>

On Fri, Nov 15, 2024 at 07:49:26PM +1030, Qu Wenruo wrote:
> [BUG]
> When developing sector size < page size handling for btrfs, I'm hitting
> a data corruption, which is only possible with the following out-of-tree
> patches:
> 
>   btrfs: allow inline data extents creation if sector size < page size
>   btrfs: allow buffered write to skip full page if it's sector aligned
> 
> [CAUSE]
> Thankfully no upstream kernels are affected, even if some one is
> mounting a btrfs created by x86_64 with inlined data extents, they won't
> hit the corruption.
> 
> The root cause is that when reading inline extents, we zero out the
> whole remaining range until folio end.
> 
> This means such zeroing out can cover ranges that is dirtied but not yet
> written back, thus lead to data corruption.
> 
> This needs all the following conditions to be met:
> 
> - Sector size < page size
>   So no x86_64 is affected. The most common users should be Asahi Linux.
>   But they are safe due to the next two conditions.
> 
> - Inline data extents are present
>   For sector size < page size cases, we do not allow creating new inline
>   data extents but only reading it.
> 
>   But even all above cases are met by using a x86_64 created btrfs with
>   inlined data extents, the next point will still save us.
> 
> - Partial uptodate folios are allowed
>   This requires the out-of-tree patch "btrfs: allow buffered write to skip
>   full page if it's sector aligned", or buffered write will read out the
>   whole folio before dirting any range.
> 
> So end users are completely safe.
> 
> [TEST CASE]
> The test case itself is pretty straightforward:
> 
> - Buffered write [0, 4k)
> - Drop all page cache
> - Buffered write [8k, 12k)
> - Verify the file content
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> For anyone who wants to verify the failure, please fetch the following
> branch, and reset to commit 4df35fbb829dfbcf64a914e5c8f652d9a3ad5227
> ("btrfs: allow inline data extents creation if sector size < page
> size").
> 
>  https://github.com/adam900710/linux.git subpage
> 
> The top commit e7338d321bdf48e3b503c40e8eca7d7592709c83
> ("btrfs: fix inline data extent reads which zero out the remaining part") is the fix.
> ---
>  tests/btrfs/327     | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/327.out |  2 ++
>  2 files changed, 60 insertions(+)
>  create mode 100755 tests/btrfs/327
>  create mode 100644 tests/btrfs/327.out
> 
> diff --git a/tests/btrfs/327 b/tests/btrfs/327
> new file mode 100755
> index 00000000..72269fc7
> --- /dev/null
> +++ b/tests/btrfs/327
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 327
> +#
> +# Make sure reading inlined extents doesn't cause any corruption.
> +#
> +# This is a preventive test case inspired by btrfs/149, which can cause
> +# data corruption when the following out-of-tree patches are applied and
> +# the sector size is smaller than page size:
> +#
> +#  btrfs: allow inline data extents creation if sector size < page size
> +#  btrfs: allow buffered write to skip full page if it's sector aligned
> +#
> +# Thankfully no upstream kernel is affected.
> +
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +_require_scratch
> +
> +# We need 4K sector size support, especially this case can only be triggered
> +# with sector size < page size for now.
> +#
> +# We do not check the page size and not_run so far, as in the long term btrfs
> +# will support larger folios, then in that future 4K page size should be enough
> +# to trigger the bug.
> +_require_btrfs_support_sectorsize 4096
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount "-o compress,max_inline=4095"
> +
> +# Create one inlined data extent, only when using compression we can
> +# create an inlined data extent up to sectorsize.
> +# And for sector size < page size cases, we need the out-of-tree patch
> +# "btrfs: allow inline data extents creation if sector size < page size" to
> +# create such extent.
> +xfs_io -f -c "pwrite 0 4k" "$SCRATCH_MNT/foobar" > /dev/null

$XFS_IO_PROG

> +
> +# Drop the cache, we need to read out the above inlined data extent.
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +# Write into range [8k, 12k), with the out-of-tree patch "btrfs: allow
> +# buffered write to skip full page if it's sector aligned", such write will not
> +# trigger the read on the folio.
> +xfs_io -f -c "pwrite 8k 4k" "$SCRATCH_MNT/foobar" > /dev/null

$XFS_IO_PROG

> +
> +# Verify the checksum, for the affected devel branch, the read of inline extent
> +# will zero out all the remaining range of the folio, screwing up the content
> +# at [8K, 12k).
> +_md5_checksum "$SCRATCH_MNT/foobar"
> +
> +_scratch_unmount

This's not needed if it's not a necessary test step.

Others look good to me, if no more review points from btrfs list, I'll merge
this patch with above changes.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/327.out b/tests/btrfs/327.out
> new file mode 100644
> index 00000000..aebf8c72
> --- /dev/null
> +++ b/tests/btrfs/327.out
> @@ -0,0 +1,2 @@
> +QA output created by 327
> +277f3840b275c74d01e979ea9d75ac19
> -- 
> 2.46.0
> 
> 

