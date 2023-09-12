Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ADACA0EC3
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Sep 2023 12:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjILMnJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjILMnI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Sep 2023 08:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6555610DB
        for <fstests@vger.kernel.org>; Tue, 12 Sep 2023 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694522539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XB79g2I4zFZC3MShaA5qbCmENyBAAsWWia57WAA50A=;
        b=EcWUk3j5/2aHRbP1VJ08aZwo6vitH8SofQufBCaAlG7SqCKwEl51N1C6VA+o8iUY71wzUQ
        WBKitQQWNdcSaFsr/PQyZbtaJmNHefXkDbDP0eNNKgEVXHvRMJZcqHZEfBmA3EgRneceiN
        bC7xcK9BOtWZD3EuqQV1qnxtzaaLpdg=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-zlzvg_fgMSiZwyZg77XZEg-1; Tue, 12 Sep 2023 08:42:18 -0400
X-MC-Unique: zlzvg_fgMSiZwyZg77XZEg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1c0ed186cf5so6907390fac.1
        for <fstests@vger.kernel.org>; Tue, 12 Sep 2023 05:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522537; x=1695127337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XB79g2I4zFZC3MShaA5qbCmENyBAAsWWia57WAA50A=;
        b=Kzmz/w7RyumgC0aQTNvbl0yeYPEkOYnHRbE4qSBvvoy/kV8oyk24zrImTCrk9ETcvV
         vguBDVFHdxDZq6Awe68TtO4/nv6lHJLx4uZJd5aBr6wcC43mCOhbJDjSWgw6K3dxYxiK
         WqjGJH5uZYFNRJwoLi43CVMbn8jsmAFs0OrDwjPZkBlBp3COcdQxPEpX9WCt9ogFUb42
         f23w+pKh/L0DdW4WixjaJh7qcJpGTxYt4Ul+wwl4kKvUHJOCa2AGsWDqpRWLqrCLxHo8
         ZFp3nR9Y1Zt2fdnvRQrpUSFeAit+CMOkEv6yXXO4VJEWhJqf9CKppXhpcEn1QY+diEJt
         m58A==
X-Gm-Message-State: AOJu0Yxut8KHsa/2VlwtxPWZwBXagIhg/Ek3HTDmSIJQjpf1V3UtCYnq
        1yHyCeMdHNuBJ9j/Q1VtaI1sERJFEd7chmvfncnIw4S5dGdu0I06zBQ2ib1B6gzbklaI2KXACIB
        Uh1ZtI9lrOXlFUVKx2w==
X-Received: by 2002:a05:6870:42c8:b0:1c4:e139:33e with SMTP id z8-20020a05687042c800b001c4e139033emr13052282oah.59.1694522537262;
        Tue, 12 Sep 2023 05:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt6QyYAi04Q0ZlID6aBE3nKqQODqQHNB/CFoVz4tmo4ZxefVDiBEKtpirywOT+j8ZQj5DXaw==
X-Received: by 2002:a05:6870:42c8:b0:1c4:e139:33e with SMTP id z8-20020a05687042c800b001c4e139033emr13052268oah.59.1694522536977;
        Tue, 12 Sep 2023 05:42:16 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a656aa2000000b00577af6f8090sm784312pgu.86.2023.09.12.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:42:16 -0700 (PDT)
Date:   Tue, 12 Sep 2023 20:42:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH] common/rc: make _get_max_file_size find file size on
 mount point
Message-ID: <20230912124213.q5irip4lbhoasg5i@zlang-mailbox>
References: <20230911200617.777985-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911200617.777985-1-aalbersh@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 11, 2023 at 10:06:17PM +0200, Andrey Albershteyn wrote:
> Currently, _get_max_file_size finds max file size on $TEST_DIR.
> The tests/generic/692 uses this function to detect file size and
> then tries to create a file on $SCRATCH_MNT.
> 
> This works fine when test and scratch filesystems have the same
> block size. However, it will fail if they differ, for example, TEST
> is 4k and SCRATCH is 1k (file will be too big).

I thought we generally use same mkfs options on TEST_DEV and SCRATCH_DEV.
If you'd like to test 1k blocksize ext4, shouldn't you make 1k blocksize
ext4 on TEST_DEV before testing.

Thanks,
Zorro

> 
> Found this by running generic/692 on ext4 with -b 1024.
> 
> Make _get_max_file_size accept mount point on which to detect max
> file size.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  common/rc         | 8 +++++++-
>  tests/generic/299 | 2 +-
>  tests/generic/485 | 2 +-
>  tests/generic/692 | 2 +-
>  4 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 68d2ad04..d17ec73a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4809,7 +4809,13 @@ _require_scratch_feature()
>  # be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
>  _get_max_file_size()
>  {
> -	local testfile=$TEST_DIR/maxfilesize.$seq
> +	if [ -z $1 ] || [ ! -d $1 ]; then
> +		echo "Missing mount point argument for _get_max_file_size"
> +		exit 1
> +	fi
> +
> +	local mnt=$1
> +	local testfile=$mnt/maxfilesize.$seq
>  	local l=0
>  	local r=9223372036854775807 # LLONG_MAX
>  
> diff --git a/tests/generic/299 b/tests/generic/299
> index d8ecff53..0cd12202 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -30,7 +30,7 @@ NUM_JOBS=$((4*LOAD_FACTOR))
>  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
>  FILE_SIZE=$((BLK_DEV_SIZE * 512))
>  
> -max_file_size=$(_get_max_file_size)
> +max_file_size=$(_get_max_file_size $TEST_DIR)
>  if [ $max_file_size -lt $FILE_SIZE ]; then
>  	FILE_SIZE=$max_file_size
>  fi
> diff --git a/tests/generic/485 b/tests/generic/485
> index 3f7749ff..8bab450b 100755
> --- a/tests/generic/485
> +++ b/tests/generic/485
> @@ -30,7 +30,7 @@ _require_xfs_io_command "finsert"
>  _require_xfs_io_command "truncate"
>  
>  block_size=$(_get_file_block_size $TEST_DIR)
> -max_file_size=$(_get_max_file_size)
> +max_file_size=$(_get_max_file_size $TEST_DIR)
>  max_blocks=$((max_file_size / block_size))
>  testfile=$TEST_DIR/testfile.$seq
>  
> diff --git a/tests/generic/692 b/tests/generic/692
> index 95f6ec04..3fb8ac01 100755
> --- a/tests/generic/692
> +++ b/tests/generic/692
> @@ -40,7 +40,7 @@ _scratch_mount
>  
>  fsv_file=$SCRATCH_MNT/file.fsv
>  
> -max_sz=$(_get_max_file_size)
> +max_sz=$(_get_max_file_size $SCRATCH_MNT)
>  _fsv_scratch_begin_subtest "way too big: fail on first merkle block"
>  truncate -s $max_sz $fsv_file
>  _fsv_enable $fsv_file |& _filter_scratch
> -- 
> 2.40.1
> 

