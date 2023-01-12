Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3B8C54EBC
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbjALIl5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 03:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbjALIkv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 03:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0BA4EC98
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 00:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673512793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x38zJlCmxOjsNL5mAEZLNaMXuQxf0nCJ5l2pjBerv9Q=;
        b=MEvwW9b27LYxwtPh6VaVvqaMjbB8PvFYtKwWi2szhQ2Scddt0Xi6OvdjyVKp86MJzv1QHP
        IFhWQaLAhN6dBwX5m0jKOVXGDflK3UME8v/8cG+dwejKAayk7Fv1gqBj+g8fpZfgElfNLy
        UluoPMFg5J2dAR3q04QjBOtrFiPb34E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-qYFB0Ht1PpCBXZKbGIB81w-1; Thu, 12 Jan 2023 03:39:52 -0500
X-MC-Unique: qYFB0Ht1PpCBXZKbGIB81w-1
Received: by mail-pl1-f200.google.com with SMTP id w18-20020a170902e89200b00192e2fde1ceso12458115plg.20
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 00:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x38zJlCmxOjsNL5mAEZLNaMXuQxf0nCJ5l2pjBerv9Q=;
        b=HDkNHrPLKwuOR6kJvnXpW7QL/WbvRyBO/OL8s1P9LXtPvA3GpVOzGGfYK+oh7Y4gTC
         YiqhfQKJCLQAxPlNOijj3tf1stnaTC5KHYaOosBail8/XyxZYGwxCx9iwepy0g2cvRqX
         4A5wfOEC5Vgkb/iTVV88BSxy6jfSi4oi9P1P0mCUtabr7+5nXnDWPSOhGareYdRgvGq0
         uF1e35/884AYV+JRyilInwsguCTHb7PB2Qi0UtrIrk18iUruzF52/UsGv5iv4Q7aPP/C
         xP25gVf0KG69zFScyVT7OlxGkZy6EIxK2GA9pEYLohMWDX0XStjuy5oj2ocq9pJmOWap
         PJLA==
X-Gm-Message-State: AFqh2krctguBjoP2YIpEtHosdwBItBPoQ2DPcEGbVjw+3NvTFk8GKvxQ
        SzNsz7ZlAJ+NF1SzyHEENsg5XOL+SLzmXz35giumZW7alr2g7ZBKUkkndgv2hfRlbOTjmuhrxTn
        sItJODVu35H4VuhH2gg==
X-Received: by 2002:a17:902:d787:b0:194:5a6f:75b6 with SMTP id z7-20020a170902d78700b001945a6f75b6mr2492883ply.59.1673512791093;
        Thu, 12 Jan 2023 00:39:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSnkHVvuygb5gSTju1zdpfIei+YKhJCnCja1Nf4FffF6UJOv8LFDZVLHAJVQjj+5mXuQL3zg==
X-Received: by 2002:a17:902:d787:b0:194:5a6f:75b6 with SMTP id z7-20020a170902d78700b001945a6f75b6mr2492863ply.59.1673512790702;
        Thu, 12 Jan 2023 00:39:50 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00189d4c666c8sm11653450plg.153.2023.01.12.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:39:50 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:39:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/294: performance is unreasonably slow
Message-ID: <20230112083946.oqxbv37tchkp3e6q@zlang-mailbox>
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110224906.1171483-4-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 11, 2023 at 09:49:06AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> This creates a bunch of files in a dir, then deletes 97% of them
> attempting to leave 1 allocated inode per inode chunk so that they
> aren't freed. Performance is badly limited by task creation and
> destruction for each inode created. Fix this by using "echo -n >
> file" rather than touch so that the shell creates the empty files
> without needing to fork/exec a separate task for each creation.
> 
> This reduces runtime from 45s down to 15s.
> 
> Also add more debug with inode counts and internal superblock
> counter information for determining why this test may ENOSPC on the
> final creation loop.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---



>  tests/xfs/294 | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/294 b/tests/xfs/294
> index d381e2c85..1ce0d1cc5 100755
> --- a/tests/xfs/294
> +++ b/tests/xfs/294
> @@ -28,6 +28,13 @@ _require_test_program "punch-alternating"
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  
> +dump_freespace()
> +{
> +	df $SCRATCH_MNT
> +	df -i $SCRATCH_MNT
> +	$XFS_IO_PROG -rc "statfs -c" $SCRATCH_MNT
> +}
> +
>  # We want to mkfs with a very specific geometry
>  MKFS_OPTIONS=""
>  _scratch_mkfs "-d size=512m -n size=8192 -i size=1024" >> $seqres.full 2>&1 \
> @@ -37,7 +44,7 @@ _scratch_mount
>  # Make a ton of mostly-empty inode clusters so we can always
>  # make more inodes
>  mkdir $SCRATCH_MNT/tmp
> -for I in `seq 1 10000`; do touch $SCRATCH_MNT/tmp/$I; done
> +for I in `seq 1 10000`; do echo -n > $SCRATCH_MNT/tmp/$I; done

Make sense to me, thanks for this improvement.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  # These mostly-empty clusters will live here:
>  mkdir $SCRATCH_MNT/clusters
> @@ -50,7 +57,7 @@ rm -rf $SCRATCH_MNT/tmp
>  mkdir $SCRATCH_MNT/testdir
>  # roughly 20 chars per file
>  for I in `seq 1 100`; do
> -	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
> +	echo -n > $SCRATCH_MNT/testdir/12345678901234567890$I;
>  done
>  
>  # File to fragment:
> @@ -63,7 +70,7 @@ space=$(stat -f -c '%f * %S * 95 / 100' $SCRATCH_MNT | $BC_PROG)
>  $XFS_IO_PROG -f -c "falloc 0 $space" $SCRATCH_MNT/fillfile ||
>  	_fail "Could not allocate space"
>  
> -df -h $SCRATCH_MNT >> $seqres.full 2>&1
> +dump_freespace >> $seqres.full 2>&1
>  
>  # Fill remaining space; let this run to failure
>  dd if=/dev/zero of=$SCRATCH_MNT/spacefile1 oflag=direct >> $seqres.full 2>&1
> @@ -75,12 +82,16 @@ $here/src/punch-alternating $SCRATCH_MNT/fragfile >> $seqres.full 2>&1
>  # (and then some for good measure)
>  dd conv=fsync if=/dev/zero of=$SCRATCH_MNT/spacefile2 bs=1M count=64 >> $seqres.full 2>&1
>  
> +dump_freespace >> $seqres.full 2>&1
> +
>  # Now populate the directory so that it must allocate these
>  # fragmented blocks
>  for I in `seq 1 1400`; do
> -	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
> +	echo -n > $SCRATCH_MNT/testdir/12345678901234567890$I;
>  done
>  
> +dump_freespace >> $seqres.full 2>&1
> +
>  # Now traverse that ugly thing!
>  find $SCRATCH_MNT/testdir | sort | _filter_scratch | md5sum
>  
> -- 
> 2.38.1
> 

