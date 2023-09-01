Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E7CCA0FF3
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Sep 2023 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbjIATJH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Sep 2023 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIATJH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2023 15:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD6EE72
        for <fstests@vger.kernel.org>; Fri,  1 Sep 2023 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693595298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QBxlQOEKlrGB+KsqdXab5YaWrxm9eLQ6OFAGzxD/Oo=;
        b=jRd2uoq99JEr9q15+7Y3uvmw/5BiDdzSOXsr65aGiwBUXn8UoqmLGVrffgcL6JT0Wf4s7p
        R+cOvipXOcZNuFdwAqbMpzFjY0vfRcuY7i/hQG0I/xhrDre5KY3YGaowd7jjpBiFKBoTWB
        6qdt4PE12SutBO1clWjAR+smxPc+lyE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-VftuMoZaMNyySpmCp1U8Tw-1; Fri, 01 Sep 2023 15:08:07 -0400
X-MC-Unique: VftuMoZaMNyySpmCp1U8Tw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-56c379a8250so2672443a12.0
        for <fstests@vger.kernel.org>; Fri, 01 Sep 2023 12:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693595286; x=1694200086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QBxlQOEKlrGB+KsqdXab5YaWrxm9eLQ6OFAGzxD/Oo=;
        b=Ydw1mtIVbVIGP4d2SpmhuWG8kbv5nOLL3iraixEyquKjqqD9InrgJTzkTJXBpa6F7J
         kwl76EzM96/RZgycAH2cl1bcXAEzVvsaCj+9UEt6ukCb8YD4uZO2a+GIgG0GXiRlMciS
         ck6cbtdxiDetG1qQF2R1O5coyW9wt7DidzSVRSgVxVhsxUQjKTueBMu1Vq/p3pe7dq7a
         NyHwJDiTXNKfyZ4QMYT8g5saXxgXUVaNoNvkjhCBYiSqGx5i2lamseDAnQ/+f6CS1/Ei
         BkcMUk736CV7WLhj22KbNEnpGp3MYaqnC1kDOxAS58apj+qUczJm12zk14NlDsPwFHU8
         D8aQ==
X-Gm-Message-State: AOJu0YyX8+UDbuJE33ycQhVxfplRNch5kAhElo8Ed8caRsymi+U+74no
        w+0tRqYCtt9XXTCHiPgMtG/Dm2alMU/rr7kpCOi/0wu9DtG0GoCh8hnQkk1+IfbPtb+wBwrM16W
        2XtB7R7IrSSAICgzqxooaKvTadecbybU=
X-Received: by 2002:a17:903:41c4:b0:1c0:c86a:5425 with SMTP id u4-20020a17090341c400b001c0c86a5425mr4952418ple.19.1693595286074;
        Fri, 01 Sep 2023 12:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh6zqtDyMg94DjGM19x/JaA8nVEVRIQLedb+5Qq1URb1o4E6tTqMt68eYcP9xFKDxnLzv7pA==
X-Received: by 2002:a17:903:41c4:b0:1c0:c86a:5425 with SMTP id u4-20020a17090341c400b001c0c86a5425mr4952393ple.19.1693595285777;
        Fri, 01 Sep 2023 12:08:05 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001b80760fd04sm3358614pln.112.2023.09.01.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 12:08:05 -0700 (PDT)
Date:   Sat, 2 Sep 2023 03:08:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/559: adapt to kernels that use large folios for
 writes
Message-ID: <20230901190802.zrttyndmri3rgekm@zlang-mailbox>
References: <169335021210.3517899.17576674846994173943.stgit@frogsfrogsfrogs>
 <169335022920.3517899.399149462227894457.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169335022920.3517899.399149462227894457.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 29, 2023 at 04:03:49PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The write invalidation code in iomap can only be triggered for writes
> that span multiple folios.  If the kernel reports a huge page size,
> scale up the write size.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/559 |   29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/559 b/tests/xfs/559
> index cffe5045a5..64fc16ebfd 100755
> --- a/tests/xfs/559
> +++ b/tests/xfs/559
> @@ -42,11 +42,38 @@ $XFS_IO_PROG -c 'chattr -x' $SCRATCH_MNT &> $seqres.full
>  _require_pagecache_access $SCRATCH_MNT
>  
>  blocks=10
> -blksz=$(_get_page_size)
> +
> +# If this kernel advertises huge page support, it's possible that it could be
> +# using large folios for the page cache writes.  It is necessary to write
> +# multiple folios (large or regular) to triggering the write invalidation,
> +# so we'll scale the test write size accordingly.
> +blksz=$(_get_hugepagesize)

Isn't _require_hugepages needed if _get_hugepagesize is used?

Thanks,
Zorro

> +base_pagesize=$(_get_page_size)
> +test -z "$blksz" && blksz=${base_pagesize}
>  filesz=$((blocks * blksz))
>  dirty_offset=$(( filesz - 1 ))
>  write_len=$(( ( (blocks - 1) * blksz) + 1 ))
>  
> +# The write invalidation that we're testing below can only occur as part of
> +# a single large write.  The kernel limits writes to one base page less than
> +# 2GiB to prevent lengthy IOs and integer overflows.  If the block size is so
> +# huge (e.g. 512M huge pages on arm64) that we'd exceed that, reduce the number
> +# of blocks to get us under the limit.
> +max_writesize=$((2147483647 - base_pagesize))
> +if ((write_len > max_writesize)); then
> +	blocks=$(( ( (max_writesize - 1) / blksz) + 1))
> +	# We need at least three blocks in the file to test invalidation
> +	# between writes to multiple folios.  If we drop below that,
> +	# reconfigure ourselves with base pages and hope for the best.
> +	if ((blocks < 3)); then
> +		blksz=$base_pagesize
> +		blocks=10
> +	fi
> +	filesz=$((blocks * blksz))
> +	dirty_offset=$(( filesz - 1 ))
> +	write_len=$(( ( (blocks - 1) * blksz) + 1 ))
> +fi
> +
>  # Create a large file with a large unwritten range.
>  $XFS_IO_PROG -f -c "falloc 0 $filesz" $SCRATCH_MNT/file >> $seqres.full
>  
> 

