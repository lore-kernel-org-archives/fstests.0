Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9FCA0FE4
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Sep 2023 15:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjIAPth (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjIAPth (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2023 11:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824DE40
        for <fstests@vger.kernel.org>; Fri,  1 Sep 2023 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693583327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=neWqv7KmDP01bN2AFxKS77SR7f1A0nwtUDG3BRGa0qk=;
        b=TcLmzUkKttZP+V+N3NMQK31pJ82GCZ1h+Q+oVJkZtm6YhpkwKhQWqwqH+B5KVFFsO4pQYN
        zl8djgL3KYhVEbL31XWTsI6N47m3r+4caBdXaSwdfDScKMim4z4g5cmnDW12+o0alFBW+f
        aJhjJwa95kc3n4vLrOP8RS5Qcns06Fc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-jZ64d0E_Nru9OZXOmv7_Iw-1; Fri, 01 Sep 2023 11:48:46 -0400
X-MC-Unique: jZ64d0E_Nru9OZXOmv7_Iw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-57013c62b3dso2417136a12.2
        for <fstests@vger.kernel.org>; Fri, 01 Sep 2023 08:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583324; x=1694188124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neWqv7KmDP01bN2AFxKS77SR7f1A0nwtUDG3BRGa0qk=;
        b=ipdwK9T6eXV3FhQF3MZ0+Z4D4TwXzyNkBJJhuDMwp/DrOW94ATtvC3i2Yvdh2cXvRU
         oFRE2+LCaPnoriCybPiVnM3aocgcD/F/eVLBZ3PAdyAH4W3BL/zU2SMZiTIdxkw+jlYt
         rjVrv1bZo5h0jgGJmsycq5tAIJhlGQ2TUCTcLIPAffOZq9PPKfjld1mSYGVhrVS3icKs
         L21i5TsqFurv+ss47KkH5o5y5lANjr8w/lk69Cw5ckBBb2EaIWqKg29IbQvXAVy3V9QW
         mKK0h1Q3EwqC/Q5W5LF13nmLgWNfQw8F1FHtVDtvfMNbz4Ju9a+P0dKaUOniVouUICmF
         3Opg==
X-Gm-Message-State: AOJu0YxEvcZMnwiG+9znpX0RM7IUVxZJcKBtMBjuUc6GG7UrHNjxtTFq
        1d+MV6rxDudwxzqgqlhf3nMgrWVn5nmG/j8NHEkblR51dByHUynQrUO0JLobHBbXip4vXQd8CAK
        eWIQg/P6XNlCInLkudpxCr0i0LVdGBGY=
X-Received: by 2002:a05:6a20:158b:b0:118:e70:6f7d with SMTP id h11-20020a056a20158b00b001180e706f7dmr3496178pzj.10.1693583324714;
        Fri, 01 Sep 2023 08:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYW7ctEuphqSj3O0NtftDXi8dPy+5AKhwJ3JT/z+ZIuzT1flPOMsec0sA7jJEqKapTXOmrLg==
X-Received: by 2002:a05:6a20:158b:b0:118:e70:6f7d with SMTP id h11-20020a056a20158b00b001180e706f7dmr3496161pzj.10.1693583324350;
        Fri, 01 Sep 2023 08:48:44 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i15-20020a63a84f000000b005634343cd9esm2985102pgp.44.2023.09.01.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 08:48:43 -0700 (PDT)
Date:   Fri, 1 Sep 2023 23:48:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/353 should accomodate other pwrite
 behaviors
Message-ID: <20230901154840.vweyyglsmx47aw6c@zlang-mailbox>
References: <20230830125056.71299-1-bodonnel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125056.71299-1-bodonnel@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

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

If you hope to remove all output messages, we generally have a
"Silence is golden".

> -- 
> 2.41.0
> 

