Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B2FC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Jul 2022 13:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiGGNPi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiGGNPi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2022 09:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23CA24BDD
        for <fstests@vger.kernel.org>; Thu,  7 Jul 2022 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657199735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9ABd6mlgp3Adb9c8fAO5KZ0B43Z0Vbyn0ZvENr/7/4=;
        b=ihdyxuq4GANDxVa9XWrZomEzIoH0QtrU7lcXqDtrHMK8j0ylDltfZLWO7ltk8LK/FfzM7q
        iSCCH/I6g9b1i5RSfQDdnhLJzVJNcEHR/zo2Mp2RQGgvGWHi2iqMIC+26fRyz/mAcU4vAj
        T933nZS6GyxC1Cinra5nqt/ZaBxYr3E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-nAyyfFe2ONqxTaig_Ihb9w-1; Thu, 07 Jul 2022 09:15:34 -0400
X-MC-Unique: nAyyfFe2ONqxTaig_Ihb9w-1
Received: by mail-qt1-f200.google.com with SMTP id fx12-20020a05622a4acc00b0031e98cb703cso1956762qtb.18
        for <fstests@vger.kernel.org>; Thu, 07 Jul 2022 06:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9ABd6mlgp3Adb9c8fAO5KZ0B43Z0Vbyn0ZvENr/7/4=;
        b=RrLOE7r1NcZsgHbO3vfaeHoS6CzoebwHkJOufsgqA/otc3Yw8efjx8AeZOtrbGl2kL
         qzF+/pArHV3AUqLDIjSG4GLyd2QWOL4geISj+u6+ZZApW7WsF2ybOi2MP25gMVD4KgsB
         hhH1mWxWTaxlz9fnfGbjrcn4xTnP3C9pmM0GEYsFij+TeS1MImJPjfXgNY7hn1ZeUob0
         PkE62iRSzrWLZbTxPX1FrF7XuTonfeZEi5oflMI70lt+y2Pu4iGb1se3PSlTQhmZEXIc
         X+zNhclxddfVw1hmvHAnP1gxhNa0LMZ4h9dX5XwZCTzhXQsYHrZSHjSWyRtkRNh8TTBS
         APug==
X-Gm-Message-State: AJIora8HBHMrN6SBH16sFhaTQMN2+P9p1VfsIyv2u1KsfxselqGAAI2b
        6dhhUkU3uM3IGMsF7gsofSrOSgtJu4TxXgmwVH5WvaUNPXhXaFRTUFIGhLz89ao1QIteleRLqqB
        5tH5NKHXGPN6qrNXnXQ==
X-Received: by 2002:ac8:7fc2:0:b0:318:291d:8f55 with SMTP id b2-20020ac87fc2000000b00318291d8f55mr37516567qtk.572.1657199733759;
        Thu, 07 Jul 2022 06:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twwe3raefw9KWNlHtT+WPDQBBIlgy5kyHmsZChsVNT0XAdtoID8CRqq1fFHJhxwDjuHUKZ8Q==
X-Received: by 2002:ac8:7fc2:0:b0:318:291d:8f55 with SMTP id b2-20020ac87fc2000000b00318291d8f55mr37516539qtk.572.1657199733385;
        Thu, 07 Jul 2022 06:15:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g6-20020ac842c6000000b00317ccc66971sm25925182qtm.52.2022.07.07.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:15:32 -0700 (PDT)
Date:   Thu, 7 Jul 2022 21:15:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/547: fix problems with realtime
Message-ID: <20220707131527.g73ablzdf7p7pmsu@zlang-mailbox>
References: <165705852280.2820493.17559217951744359102.stgit@magnolia>
 <165705853976.2820493.11634341636419465537.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165705853976.2820493.11634341636419465537.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 05, 2022 at 03:02:19PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test needs to fragment the free space on the data device so that
> each block added to the attr fork gets its own mapping.  If the test
> configuration sets up a rt device and rtinherit=1 on the root dir, the
> test will erroneously fragment space on the *realtime* volume.  When
> this happens, attr fork allocations are contiguous and get merged into
> fewer than 10 extents and the test fails.
> 
> Fix this test to force all allocations to be on the data device, and fix
> incorrect variable usage in the error messages.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/547 |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/tests/xfs/547 b/tests/xfs/547
> index 9d4216ca..60121eb9 100755
> --- a/tests/xfs/547
> +++ b/tests/xfs/547
> @@ -33,6 +33,10 @@ for nrext64 in 0 1; do
>  		      >> $seqres.full
>  	_scratch_mount >> $seqres.full
>  
> +	# Force data device extents so that we can fragment the free space
> +	# and force attr fork allocations to be non-contiguous
> +	_xfs_force_bdev data $SCRATCH_MNT
> +
>  	bsize=$(_get_file_block_size $SCRATCH_MNT)
>  
>  	testfile=$SCRATCH_MNT/testfile
> @@ -76,13 +80,15 @@ for nrext64 in 0 1; do
>  	acnt=$(_scratch_xfs_get_metadata_field core.naextents \
>  					       "path /$(basename $testfile)")
>  
> -	if (( $dcnt != 10 )); then
> -		echo "Invalid data fork extent count: $dextcnt"
> +	echo "nrext64: $nrext64 dcnt: $dcnt acnt: $acnt" >> $seqres.full
> +
> +	if [ -z "$dcnt" ] || (( $dcnt != 10 )); then

I'm wondering why we need to use bash ((...)) operator at here, is $dcnt
an expression? Can [ "$dcnt" != "10" ] help that?

Thanks,
Zorro

> +		echo "Invalid data fork extent count: $dcnt"
>  		exit 1
>  	fi
>  
> -	if (( $acnt < 10 )); then
> -		echo "Invalid attr fork extent count: $aextcnt"
> +	if [ -z "$acnt" ] || (( $acnt < 10 )); then
> +		echo "Invalid attr fork extent count: $acnt"
>  		exit 1
>  	fi
>  done
> 

