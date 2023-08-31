Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476FC83F2E
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Aug 2023 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjHaQrA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHaQrA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2023 12:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D311A124
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2023 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693500368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iphPG/G9Gy4xm7DqdV4zrqWUp4ZNMxept5Xy+NlZyi0=;
        b=J4Vxqsr6chtl7BQfa0PGJApFvTl8uSMyWCS2nW/CUlakUfX7zTh1Kq9JC3c5Bs79XzI1ru
        aZQBR5iFGQtxZeM3OXM3CDscOlLrRtpxKKuzOcXD86mDj1aEKs2LQ/kxpxjjAvZWuuaBwx
        9UAwT9lGAzLQALX/XpUGKne7Ko7qJNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-2UyPCQ4mPCOQN5fS50BL6Q-1; Thu, 31 Aug 2023 12:46:04 -0400
X-MC-Unique: 2UyPCQ4mPCOQN5fS50BL6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 380FC101AA4E;
        Thu, 31 Aug 2023 16:46:04 +0000 (UTC)
Received: from redhat.com (unknown [10.22.34.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0137A492C14;
        Thu, 31 Aug 2023 16:46:03 +0000 (UTC)
Date:   Thu, 31 Aug 2023 11:46:02 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org, quwenruo.btrfs@gmx.com
Subject: Re: [PATCH] fstests: generic/353 should accomodate other pwrite
 behaviors
Message-ID: <ZPDDyqyqSmI6dVDQ@redhat.com>
References: <20230830125056.71299-1-bodonnel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125056.71299-1-bodonnel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

cc Qu Wenruo

On Wed, Aug 30, 2023 at 07:50:56AM -0500, Bill O'Donnell wrote:
> xfs_io pwrite issues a series of block size writes, but there is no
> guarantee that the resulting extent(s) will be singular or contiguous.
> This behavior is acceptable, but the test is flawed in that it expects
> a single extent for a pwrite.
> 
> Modify test to use actual blocksize for pwrite and reflink. Also
> modify it to accommodate pwrite and reflink that produce different
> mapping results.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
>  tests/generic/353     | 27 ++++++++++++++-------------
>  tests/generic/353.out | 14 --------------
>  2 files changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/generic/353 b/tests/generic/353
> index 9a1471bd..03b038a6 100755
> --- a/tests/generic/353
> +++ b/tests/generic/353
> @@ -29,31 +29,32 @@ _require_xfs_io_command "fiemap"
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> -blocksize=64k
> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> +
>  file1="$SCRATCH_MNT/file1"
>  file2="$SCRATCH_MNT/file2"
> +extmap1="$SCRATCH_MNT/extmap1"
> +extmap2="$SCRATCH_MNT/extmap2"
>  
>  # write the initial file
> -_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 | _filter_xfs_io
> +_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 > /dev/null
>  
>  # reflink initial file
> -_reflink_range $file1 0 $file2 0 $blocksize | _filter_xfs_io
> +_reflink_range $file1 0 $file2 0 $blocksize > /dev/null
>  
>  # check their fiemap to make sure it's correct
> -echo "before sync:"
> -echo "$file1" | _filter_scratch
> -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
> -echo "$file2" | _filter_scratch
> -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
> +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
> +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
> +
> +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps before sync"
>  
>  # sync and recheck, to make sure the fiemap doesn't change just
>  # due to sync
>  sync
> -echo "after sync:"
> -echo "$file1" | _filter_scratch
> -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
> -echo "$file2" | _filter_scratch
> -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
> +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
> +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
> +
> +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps after sync"
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/353.out b/tests/generic/353.out
> index 4f6e0b92..86cece4f 100644
> --- a/tests/generic/353.out
> +++ b/tests/generic/353.out
> @@ -1,15 +1 @@
>  QA output created by 353
> -wrote 65536/65536 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -linked 65536/65536 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -before sync:
> -SCRATCH_MNT/file1
> -0: [0..127]: shared|last
> -SCRATCH_MNT/file2
> -0: [0..127]: shared|last
> -after sync:
> -SCRATCH_MNT/file1
> -0: [0..127]: shared|last
> -SCRATCH_MNT/file2
> -0: [0..127]: shared|last
> -- 
> 2.41.0
> 

