Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A358CA0FEC
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Sep 2023 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbjIAThF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Sep 2023 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIAThE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2023 15:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A4210E0
        for <fstests@vger.kernel.org>; Fri,  1 Sep 2023 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693596976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olB9rlzeCl18BkZB9HsbK4exgRDNJOMVbe8vy/cuDac=;
        b=XzUZin0ofp1+9+56y2n/ApBGrjeU5cHdRQffffV7hUjMBYVs+19djxWoqe/FJejWRjUINe
        G8hmthORnkrb2HXURlu1RUkFQqFG8WP8jOZon/z13TtS3Ey1xPqoOqOWrtOxcFm6AFt05d
        /LgZeTLEnUdYSnl333Gj7r8jO+RfXbc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-A4unUEjpNQujINOApAdpDA-1; Fri, 01 Sep 2023 15:36:14 -0400
X-MC-Unique: A4unUEjpNQujINOApAdpDA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-56c3a952aaeso2502142a12.2
        for <fstests@vger.kernel.org>; Fri, 01 Sep 2023 12:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693596973; x=1694201773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olB9rlzeCl18BkZB9HsbK4exgRDNJOMVbe8vy/cuDac=;
        b=eYCGn9NxDtagKgwbxIs8JxyggCkljXP7ZROYjYHY1CzH9vYDEMkGBciCeXPMa1OZ+Q
         aAOMWHzNCRT4toJYfxZZb/Be/75un5u7whNSlayAhK30AgvNwLdOp3ukwMpGA3TmMLq9
         RcvCuKu8q3pwdc2NTn5+4l8iKeRQoFauTb9thGa//lUEZ4O47P8LdqeqCWUM0PvsU2hT
         lwcH32ixMHG5wuz0YwTKGyVutiEW2tDNs9mGyKx6t/7LnLcn0RhtqkMTG70rTRLafF19
         wI+0046jykaoyG9cBxhI6Q+G8Sccb8o2wYrT5eE0nz2y4MEDHv2vnStI9bmqSNF8Oo7n
         dbSQ==
X-Gm-Message-State: AOJu0Yx4PqXJDWMDiRBgqmWzkFLTwdDdi7xKMQ1O3iTXK4b1sJ1Yp5bf
        Ar2SqChzZAHzm3mffPlZ3GQ5f36h6Iczm4Pk/gJqlc+l+z7W7dlqCOm/j/9qNJnAawsjcG0NAHV
        XBUwk0oRVQl2cBMJD7hH7iplwNAkl5eE=
X-Received: by 2002:a17:902:c209:b0:1c0:d89e:9038 with SMTP id 9-20020a170902c20900b001c0d89e9038mr3341440pll.20.1693596973315;
        Fri, 01 Sep 2023 12:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECZTXyG2wQQDNne4XDTcR8++A+Hg9I+ZMv2maaq5F/8HlbS5tjgspq5QyMAa5Mo1fs79RgFA==
X-Received: by 2002:a17:902:c209:b0:1c0:d89e:9038 with SMTP id 9-20020a170902c20900b001c0d89e9038mr3341423pll.20.1693596972970;
        Fri, 01 Sep 2023 12:36:12 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001c0774d9327sm3326272plb.91.2023.09.01.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 12:36:12 -0700 (PDT)
Date:   Sat, 2 Sep 2023 03:36:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Message-ID: <20230901193609.yy7isx4pv6ax4g2k@zlang-mailbox>
References: <20230824234714.GA17900@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824234714.GA17900@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 24, 2023 at 04:47:14PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> I run fstests in a readonly container, and accidentally uninstalled the
> btrfsprogs package.  When I did, this test started faililng:
> 
> --- btrfs/282.out
> +++ btrfs/282.out.bad

I can't merge this patch, it fails:

  Applying: btrfs/282: skip test if /var/lib/btrfs isnt writable
  error: 282.out: does not exist in index
  Patch failed at 0001 btrfs/282: skip test if /var/lib/btrfs isnt writable
  ...

How can you generate this patch with btrfs/282.out.bad?

Thanks,
Zorro

> @@ -1,3 +1,7 @@
>  QA output created by 282
>  wrote 2147483648/2147483648 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> 
> Skip the test if /var/lib/btrfs isn't writable, or if /var/lib isn't
> writable, which means we cannot create /var/lib/btrfs.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/btrfs/282 |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> index 980262dcab..395e0626da 100755
> --- a/tests/btrfs/282
> +++ b/tests/btrfs/282
> @@ -19,6 +19,13 @@ _wants_kernel_commit eb3b50536642 \
>  # We want at least 5G for the scratch device.
>  _require_scratch_size $(( 5 * 1024 * 1024))
>  
> +# Make sure we can create scrub progress data file
> +if [ -e /var/lib/btrfs ]; then
> +	test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
> +else
> +	test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
> +fi
> +
>  _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount
>  
> 

