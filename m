Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB7C433FE
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Nov 2022 05:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKAFXR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Nov 2022 01:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFXP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Nov 2022 01:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4817062
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667280135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VG6ijif+/S920VObUBglHfPEbxM5EjXOWbtoaK7H22U=;
        b=b+lBfxO8c9OYaPZBuuD7hHZ3dGMu/tTs4gJyYU4QBPb5fHLO3bENvJ0RZZktzsVJcWWKBL
        1HaTmWAnBVDsVVFsbU/aZ7j16nHeXSHVkKNsabh86b5zDwEoS9YwTT2YnOlHej3U7H2c4b
        yispXaBaD4cGtZWQt2pySOVXXXfRu04=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-HX4ykeb8Ovu5HV2OhMGmdA-1; Tue, 01 Nov 2022 01:22:12 -0400
X-MC-Unique: HX4ykeb8Ovu5HV2OhMGmdA-1
Received: by mail-pg1-f197.google.com with SMTP id f19-20020a63f113000000b0046fde69a09dso1555113pgi.10
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 22:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG6ijif+/S920VObUBglHfPEbxM5EjXOWbtoaK7H22U=;
        b=T0leWjYTXESoHlzX9upfOJVdF4ZsA0wOh+cCHRmpReMhgO2B3Z664rVFKoEDFP9TwZ
         ExSNWTh1sGuF5xWii1PyVlOAYuqPlOjDy/1bQ+qvT3eQyS8qFQ+y77zk6mVnFhD9i438
         qDTu5Zl2e+e8r9pEJ54AqlVgGV1BMY87iQ3VRln1aX3bt5nmb0shslVudvh784r08Dd5
         /E0D4XRH6ktQfjS5qhtfUL+me8sbLSC0CgqOA3GEqNiJNaPMKMdxF4gU28izFIXTuo1n
         e68AZE36OUxLBkUEwUxedw/DaObTEVGk1DHD47VTaZpx/BfpWuDQJIkR5gkzkGVzQnrn
         uMnw==
X-Gm-Message-State: ACrzQf3oSZAztMNWNEg+dTGMhpetehg8/1w0mz7x3fRbxxBT+zP+6QRp
        2ced8K2N3LIULavxaZ+JUUrR75B5OkLnPu7ebZxU0pLWGem8i621UMtRqnQOzPunxh5cDMPtX7H
        G3rXhF0GFyawEQ2KXLg==
X-Received: by 2002:a17:903:2489:b0:187:3a59:570a with SMTP id p9-20020a170903248900b001873a59570amr694124plw.35.1667280130560;
        Mon, 31 Oct 2022 22:22:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68wJKSryy9/8JQ05+UgJGVRSK/EoZ5IUs+i+3bDqmtYnqFaNYVrBloxtYVQpX7tcT86WGWMA==
X-Received: by 2002:a17:903:2489:b0:187:3a59:570a with SMTP id p9-20020a170903248900b001873a59570amr694101plw.35.1667280130207;
        Mon, 31 Oct 2022 22:22:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78f27000000b0056bb36c047asm5537976pfr.105.2022.10.31.22.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:22:09 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:22:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/3] btrfs: test fiemap reports extent as not shared
 after COWing it in snapshot
Message-ID: <20221101052205.kq5o6pv66uw3pusg@zlang-mailbox>
References: <cover.1667214081.git.fdmanana@suse.com>
 <e5ae81c52ccbd5245014564b6fbe370ec33c966b.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ae81c52ccbd5245014564b6fbe370ec33c966b.1667214081.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 31, 2022 at 11:11:21AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we have a large file, with file extent items spanning several
> leaves in the fs tree, and that is shared due to a snapshot, if we COW one
> of the extents, doing a fiemap will report the respective file range as
> not shared.
> 
> This exercises the processing of delayed references for metadata extents
> in the backref walking code, used by fiemap to determine if an extent is
> shared.
> 
> This used to fail until very recently and was fixed by the following
> kernel commit that landed in 6.1-rc2:
> 
>   943553ef9b51 (""btrfs: fix processing of delayed tree block refs during backref walking")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/280     | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/280.out | 21 +++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100755 tests/btrfs/280
>  create mode 100644 tests/btrfs/280.out
> 
> diff --git a/tests/btrfs/280 b/tests/btrfs/280
> new file mode 100755
> index 00000000..06ef221e
> --- /dev/null
> +++ b/tests/btrfs/280
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 280
> +#
> +# Test that if we have a large file, with file extent items spanning several
> +# leaves in the fs tree, and that is shared due to a snapshot, if we COW one of
> +# the extents, doing a fiemap will report the respective file range as not
> +# shared.
> +#
> +# This exercises the processing of delayed references for metadata extents in
> +# the backref walking code, used by fiemap to determine if an extent is shared.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress snapshot fiemap
> +
> +. ./common/filter
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "fiemap"
> +
> +_fixed_by_kernel_commit 943553ef9b51 \
> +	"btrfs: fix processing of delayed tree block refs during backref walking"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +# We use compression because it's a very quick way to create a file with a very
> +# large number of extents (compression limits the maximum extent size to 128K)
> +# and while using very little disk space.
> +_scratch_mount -o compress
> +
> +# A 128M file full of compressed extents results in a fs tree with a heigth
> +# of 2 (root at level 1), so we'll end up with tree block references in the
> +# extent tree (if the root was a leaf, we would have only data references).
> +$XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Create a RW snapshot of the default subvolume.
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +
> +echo
> +echo "File foo fiemap before COWing extent:"
> +echo
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
> +
> +echo
> +echo "Overwriting file range [120M, 120M + 128K) in the snapshot"
> +echo
> +$XFS_IO_PROG -c "pwrite -b 128K 120M 128K" $SCRATCH_MNT/snap/foo | _filter_xfs_io
> +# Now fsync the file to force COWing the extent and the path from the root of
> +# the snapshot tree down to the leaf where the extent is at.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/snap/foo
> +
> +echo
> +echo "File foo fiemap after COWing extent in the snapshot:"
> +echo
> +# Now we should have all extents marked as shared except the 128K extent in the
> +# file range [120M, 120M + 128K).
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
> new file mode 100644
> index 00000000..c3f82966
> --- /dev/null
> +++ b/tests/btrfs/280.out
> @@ -0,0 +1,21 @@
> +QA output created by 280
> +wrote 134217728/134217728 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +
> +File foo fiemap before COWing extent:
> +
> +0: [0..261887]: shared
> +1: [261888..262143]: shared|last
> +
> +Overwriting file range [120M, 120M + 128K) in the snapshot
> +
> +wrote 131072/131072 bytes at offset 125829120
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +File foo fiemap after COWing extent in the snapshot:
> +
> +0: [0..245759]: shared
> +1: [245760..246015]: none
> +2: [246016..261887]: shared
> +3: [261888..262143]: shared|last
> -- 
> 2.35.1
> 

