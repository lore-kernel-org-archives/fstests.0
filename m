Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E5EC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Jan 2022 02:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbiAUClV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Jan 2022 21:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348457AbiAUClU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Jan 2022 21:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642732879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJuReAjF5j37uF8H9Pf27hboT1IaAGGe94dxkufb4lU=;
        b=Sm0aVzsADdvAoDDKjw2rN6cR3Qyb/a1OpN6z8FcTKlkV9s+ahYxPS3PQ7+blyD2NP2bB08
        ik8w7hSUqGWISUqO/OTgBJig39LvK3o01CWwmWAb+Li4bcD5JTJ+Y/CdtNUne0BoJq0Fd3
        DuRdT9e29QIyVcroJ62ujOkS8KzG41o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-sWjsTUcPOOyf89z1Ti21Xg-1; Thu, 20 Jan 2022 21:41:18 -0500
X-MC-Unique: sWjsTUcPOOyf89z1Ti21Xg-1
Received: by mail-pg1-f197.google.com with SMTP id f18-20020a63dc52000000b0034d062c66a0so3818618pgj.17
        for <fstests@vger.kernel.org>; Thu, 20 Jan 2022 18:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CJuReAjF5j37uF8H9Pf27hboT1IaAGGe94dxkufb4lU=;
        b=fEwpb3YAz51WfqFBgokCYeQP1qcy67MSbhXe0QQIZ9QPY/sUv2FcFEhBoBJQAnllgp
         NG138GTU71v9a/1IoEKmyRoPsJbAzGiazUJpXooW6jtjpCYqbZoZtMDFWg9WvaXnRpQD
         7nrM6COox7F38P8tqIVk7F0+G3dQJ8JumLvBsT/uvXe7vXO84sL+QFNyxMzg4yDRn8RE
         vRGL7NQE/6NqLmcMPlUS1CNK3uo2cCvtjDnb4CTgNJxqBXHKZ5+DSLxpINC6eoiGpGn2
         VW1SUhSrDUXOcEXbHbMRxMCAcm22bTN+s3ASQxFAZtVfuO75EKHz0X6ZIqz2XHLhTQAx
         fStg==
X-Gm-Message-State: AOAM5338HLrK4bmKuNFlkR27WfKEpuTlHmz90/bq+S3NI2TyRiGDi77A
        MiSP87pCSP6AyjykD+HTpYWZmxJo4ilu/O4Iblt5jwvzo77AOqj6z5sFlvG4fyBzwOpPejHl2R+
        SNky/3sN1EVc3DIyWdA==
X-Received: by 2002:a17:903:22c3:b0:14a:8cf0:63b2 with SMTP id y3-20020a17090322c300b0014a8cf063b2mr2171107plg.148.1642732876728;
        Thu, 20 Jan 2022 18:41:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhDEkci/WSXrYGMjS1HSlOBYjql3A58Ey37K00wlqsbIg+aptp5BJM26kb2L1I6YHHBpUxag==
X-Received: by 2002:a17:903:22c3:b0:14a:8cf0:63b2 with SMTP id y3-20020a17090322c300b0014a8cf063b2mr2171093plg.148.1642732876383;
        Thu, 20 Jan 2022 18:41:16 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 14sm10033141pjh.45.2022.01.20.18.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 18:41:15 -0800 (PST)
Date:   Fri, 21 Jan 2022 10:41:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/107: fix formatting failures
Message-ID: <20220121024111.5q5yebvml2x4ur2u@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <20220120004944.GD13514@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120004944.GD13514@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 19, 2022 at 04:49:44PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Zorro Lang reported that the _scratch_mkfs_sized call in the new xfs/107
> fstest sometimes fails on more exotic storage due to insufficient log
> size on account of raid stripes, etc.   These are side effects of the
> filesystem being too small.
> 
> Change the filesystem size to 256M to avoid these problems, and change
> the allocstale parameters to use the same file size (16M) as before.
> Given that ALLOCSP produces stale disk contents pretty quickly this
> shouldn't affect the test runtime too much.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Oh, I didn't notice that the xfs/107 has been merged :-P
This patch is good to me, and it fixes two "data/log space too small"
issues on my side.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/107 |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/107 b/tests/xfs/107
> index 6034dbc2..577094b2 100755
> --- a/tests/xfs/107
> +++ b/tests/xfs/107
> @@ -22,7 +22,10 @@ _require_test
>  _require_scratch
>  _require_test_program allocstale
>  
> -size_mb=32
> +# Create a 256MB filesystem to avoid running into mkfs problems with too-small
> +# filesystems.
> +size_mb=256
> +
>  # Write a known pattern to the disk so that we can detect stale disk blocks
>  # being mapped into the file.  In the test author's experience, the bug will
>  # reproduce within the first 500KB's worth of ALLOCSP calls, so running up
> @@ -39,9 +42,10 @@ _scratch_mount
>  _xfs_force_bdev data $SCRATCH_MNT
>  testfile=$SCRATCH_MNT/a
>  
> -# Allow the test program to expand the file to consume half the free space.
> +# Allow the test program to expand the file to 32MB.  If we can't find any
> +# stale blocks at that point, the kernel has probably been patched.
>  blksz=$(_get_file_block_size $SCRATCH_MNT)
> -iterations=$(( (size_mb / 2) * 1048576 / blksz))
> +iterations=$(( (size_mb / 16) * 1048576 / blksz))
>  echo "Setting up $iterations runs for block size $blksz" >> $seqres.full
>  
>  # Run reproducer program and dump file contents if we see stale data.  Full
> 

