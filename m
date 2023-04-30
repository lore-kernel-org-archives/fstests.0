Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF6C77B73
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Apr 2023 06:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjD3GNK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Apr 2023 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD3GNJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Apr 2023 02:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB830136
        for <fstests@vger.kernel.org>; Sat, 29 Apr 2023 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682835136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iuUwEdnRrntIc0Z4ah0ISSnM+aDL2u6eQFMKMVQ0OU=;
        b=A/RPtgouR/1NkRNhX0mrbG2+eRND7PVqPDnSjNrQlehY6bf89xSH5lBCWKx3hVaAFYg3SG
        x0FIDvQ7qp7HUzT+THo9brMJoIDc3A5UnLUNQBBpD+6RNqqST370cjYJSYe0Pf+KZdoMVQ
        ct7fOcDRUR/J5+YLGqPmurhnRvCcFEQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-unIaX1sXP-eVrymIBb1x5A-1; Sun, 30 Apr 2023 02:12:14 -0400
X-MC-Unique: unIaX1sXP-eVrymIBb1x5A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-24dfafd26cbso23345a91.1
        for <fstests@vger.kernel.org>; Sat, 29 Apr 2023 23:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682835134; x=1685427134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iuUwEdnRrntIc0Z4ah0ISSnM+aDL2u6eQFMKMVQ0OU=;
        b=My11L8RPTWl7565YtnuCvKsSweJIVwfqnyMHuZFKbDhkEtR0+SufZNfFbqHRKpqP7b
         pQh+urHT87vEFNPZDfGY+8ajbSMuu3iO5OUIxH4PuidpgyOSZ5RGCaaqYFPcJgXTKCrS
         JDuZ1l1GnCbb6kgvz71jVGQceh8blZ3kYIRss1y8Lcayzw2ixehb+MIUch/7t7CHC8me
         J3cmV9o8x97CZa/NpWKvPnInUfgfF8GR5q7oJhhzJlNw0VmNxTHHDluAGjju8vb5u1Mu
         CymGYmToS5QqqZfbCo0ApgoQfvCijMDT3PBDtwYuduUBU4iAEU1wEoGdLr1MASJs1N25
         QblA==
X-Gm-Message-State: AC+VfDzUUfbRkuFq9vbEqUia4iTwtOAdbHbQFNyS2Ed0gZM7IePQRieU
        Fd8Wq1Z6vViS3dS0oZJ/wk+Yc2ULgly4Nok9Q8QZRyyW125kEot9lY4Bw+hT5ImaFZqaJ91UTx7
        ZSwfqwhB40CGdnVzz4Q==
X-Received: by 2002:a17:90b:8c6:b0:247:6ec8:7e93 with SMTP id ds6-20020a17090b08c600b002476ec87e93mr10808180pjb.33.1682835133680;
        Sat, 29 Apr 2023 23:12:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZFbFLGQpyZqk887mtcwOHCVYPbgpjVWPyEdFbqh87qzZpxjP6lDvRMYMTdtn3ebF2DRvB6Q==
X-Received: by 2002:a17:90b:8c6:b0:247:6ec8:7e93 with SMTP id ds6-20020a17090b08c600b002476ec87e93mr10808165pjb.33.1682835133263;
        Sat, 29 Apr 2023 23:12:13 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id lk6-20020a17090b33c600b0024702e5dda0sm17321238pjb.39.2023.04.29.23.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 23:12:12 -0700 (PDT)
Date:   Sun, 30 Apr 2023 14:12:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 7/6] Doc changes for afs
Message-ID: <20230430061207.jrl3s63v2n5qzzqr@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <1185265.1682712377@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1185265.1682712377@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 28, 2023 at 09:06:17PM +0100, David Howells wrote:
>     
> Documentation changes for afs.
>     
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---

This patch looks good.

>  README                 |    3 ++-
>  README.config-sections |    7 +++++++
>  common/rc              |    4 +++-
>  doc/testing-afs.txt    |   36 ++++++++++++++++++++++++++++++++++++

Hmm... In the past, fs specific docs are in README.* (e.g. README.overlay).
But I think it's time to move those README.* docs to doc/ directory. I'll
tidy the doc/ later.

Welcome more suggestions from others.

For this one ...

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  4 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 4ee877a9..7eb6ac1b 100644
> --- a/README
> +++ b/README
> @@ -291,9 +291,10 @@ Running tests:
>      - If you want to run all tests regardless of what group they are in
>        (including dangerous tests), use the "all" group: ./check -g all
>      - To randomize test order: ./check -r [test(s)]
> -    - You can explicitly specify NFS/CIFS/OVERLAY, otherwise
> +    - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
>        the filesystem type will be autodetected from $TEST_DEV:
>          - for running nfs tests: ./check -nfs [test(s)]
> +        - for running afs tests: ./check -afs [test(s)]
>          - for running cifs/smb3 tests: ./check -cifs [test(s)]
>          - for overlay tests: ./check -overlay [test(s)]
>            The TEST and SCRATCH partitions should be pre-formatted
> diff --git a/README.config-sections b/README.config-sections
> index 4f1a4dc6..a42d9d7b 100644
> --- a/README.config-sections
> +++ b/README.config-sections
> @@ -128,3 +128,10 @@ TEST_DIR=/mnt/gluster/test
>  TEST_DEV=192.168.1.1:testvol
>  SCRATCH_MNT=/mnt/gluster/scratch
>  SCRATCH_DEV=192.168.1.1:scratchvol
> +
> +[afs]
> +FSTYP=afs
> +TEST_DEV=%example.com:xfstest.test
> +TEST_DIR=/mnt/xfstest.test
> +SCRATCH_DEV=%example.com:xfstest.scratch
> +SCRATCH_MNT=/mnt/xfstest.scratch
> diff --git a/common/rc b/common/rc
> index 4dfc3301..e3805fcf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1617,9 +1617,11 @@ _require_scratch_nocheck()
>  		fi
>  		;;
>  	afs)
> +		# We only support RW volumes (marked with a '%')
> +		# We don't support RO volumes (marked with a '#')
>  		echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> -			_notrun "this test requires a valid \$SCRATCH_DEV"
> +			_notrun "this test requires a valid \$SCRATCH_DEV (must be a RW volume)"
>  		fi
>  		if [ ! -d "$SCRATCH_MNT" ]; then
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
> diff --git a/doc/testing-afs.txt b/doc/testing-afs.txt
> new file mode 100644
> index 00000000..75ed1331
> --- /dev/null
> +++ b/doc/testing-afs.txt
> @@ -0,0 +1,36 @@
> +				 ===========
> +				 TESTING AFS
> +				 ===========
> +
> +xfstests can be used with the Linux kernel AFS filesystem (kafs).  kafs mounts
> +each volume as a separate volume and, as such, allows them to be individually
> +mounted on arbitrary paths.  This allows xfstests to be easily configured to
> +use specific volumes.  This doesn't work with OpenAFS, say, as that operates
> +with everything in a single superblock.
> +
> +xfstests requires that the volumes specified by forced to use RW volumes by
> +prefixing the mount device with '%' rather than '#' as per the format of a
> +mountpoint string:
> +
> +	%<volume>
> +
> +using the workstation cell, or:
> +
> +	%<cell>:<volume>
> +
> +using an explicit cell.
> +
> +For example:
> +
> +	FSTYP=afs
> +	TEST_DEV=%example.com:xfstest.test
> +	TEST_DIR=/mnt/xfstest.test
> +	SCRATCH_DEV=%example.com:xfstest.scratch
> +	SCRATCH_MNT=/mnt/xfstest.scratch
> +
> +will use the xfstest.test and xfstest.scratch volumes located in the
> +example.com cell.
> +
> +
> +Note that AFS in general and kafs in particular lack a number of features that
> +can be tested for and so a lot of tests will be skipped.
> 

