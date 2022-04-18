Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B3C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 04:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiDREgi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiDREgh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 00:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E565E13E9C
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650256436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRXNGBGc3tndzr/5O7D51F2CqhV+ZHydJ3oHdYwQPSs=;
        b=OkBkXH2k4OK41gtrmG8mJyMhp7KkNsARstcw5sKA0l4HbaNLwVaAcEgUiP01nomUG0SdGI
        GmKd/6Df6v24TjAZAV1cMsZm8YYcN9w95jsH21GMQp7iJ437TDQaSx/5eG9EOpxlR9amAK
        kcAEYHmWGVQ/8iDltmeXUTNMXD3v0PA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-VrgYNUJYOm2ohQom3gEOyg-1; Mon, 18 Apr 2022 00:33:54 -0400
X-MC-Unique: VrgYNUJYOm2ohQom3gEOyg-1
Received: by mail-qv1-f72.google.com with SMTP id es4-20020a056214192400b004461a0b8e91so10388869qvb.14
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 21:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XRXNGBGc3tndzr/5O7D51F2CqhV+ZHydJ3oHdYwQPSs=;
        b=7rY19ObRh6+1XBkwLSL5UxtWHZbE2/ixR/TE6p/qwUfrb6pR552TN0hqHIDnjiUowg
         QUXftZQp8S9KA4+oAYOyjJPrB4qktRDYcmHqtD1LLzzaTgLvUm5egBFzR0wdvtESCBz+
         /LOpmSQie9vi4vVoONfo7FaV0QJ1KCV0IC6aDDGDCE+dXfS3NtyzgKaNiuo0qfdg+AwQ
         3r2bhECh5EwVKjfUAwQzK0aeNNFgfieB7R/hKlYUOGsMFNqyji8a/sa1CIdhOekvP/gu
         CZtlbsQKbzQOJFC14eJtWFEQsLj6m8fi30dgOLCns+O4AtGlj8yR/LpPFVFj+kRWJjno
         mj8w==
X-Gm-Message-State: AOAM532pmiTHf6gFHQKXRjb1mVbeMS1uGfHc/mwkApoOw2PS8QpJDqNf
        lyZusizd39EswLObfarFnQj4uAxQDD4zpBkPb6pw/7vclC4wE/I8KMbRTe4LnxavauobjFCA/rW
        VZ8eFmtOmfVl2isoKng==
X-Received: by 2002:a05:622a:3d2:b0:2ee:646b:c4c2 with SMTP id k18-20020a05622a03d200b002ee646bc4c2mr5945409qtx.606.1650256434088;
        Sun, 17 Apr 2022 21:33:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAZ7RtqUkhmZcJ4UI+ypk8HiWEXIGBfTnH6N0TQU7DfoJNUe5Sl9URnZCadeV3UUzUl425Cg==
X-Received: by 2002:a05:622a:3d2:b0:2ee:646b:c4c2 with SMTP id k18-20020a05622a03d200b002ee646bc4c2mr5945404qtx.606.1650256433825;
        Sun, 17 Apr 2022 21:33:53 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c28-20020a05620a269c00b0069e8a1950fdsm1939582qkp.22.2022.04.17.21.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 21:33:53 -0700 (PDT)
Date:   Mon, 18 Apr 2022 12:33:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] common: support black listing fs in _supported_fs()
Message-ID: <20220418043346.6ibbo5wsoovbyc6z@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
References: <20220417174023.3244263-1-amir73il@gmail.com>
 <20220417174023.3244263-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417174023.3244263-2-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 17, 2022 at 08:40:21PM +0300, Amir Goldstein wrote:
> For example:
> _supported_fs ^xfs
> 
> There is no need to specify "generic" when using a block list
> "all other fs are supported" is implied.
> 
> Converted some generic tests that open code this condition without
> emitting a meaningful reason.
> 
> More generic test like generic/186,187 could use a block list, but
> were not converted because they emit some meaningful reason:
>   _notrun "Can't fragment free space on btrfs."
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

At first, I'd like to take more time to hear discussion from others. I'll
leave personal review point to each patch, welcome more opinions :)
...

This feature is good to me. But I'd strongly recommend that don't *abuse*
it, except we have a definite reason to count a fs out entirely.

The best way to _notrun a case is by detecting a specified feature/behavior
is supported or not. Judge by kernel/package version is worse. Skipping a
fs entirely without proper reason is the worst.

The generic cases trys to open for all known/unknown filesystems at first,
so before a fs maintainer/devel clearly make sure they don't/no way to accept
this test, we'd better to give them chance to have a try, not count them out
from beginning.

Thanks,
Zorro

>  common/rc         | 30 ++++++++++++++++++++----------
>  tests/generic/500 |  3 +--
>  tests/generic/631 |  3 +--
>  tests/generic/679 |  3 +--
>  4 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 17629801..1d37dcbd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1572,19 +1572,29 @@ _fail()
>  
>  # tests whether $FSTYP is one of the supported filesystems for a test
>  #
> -_supported_fs()
> +_check_supported_fs()
>  {
> -    local f
> +	local res=1
> +	local f
>  
> -    for f
> -    do
> -	if [ "$f" = "$FSTYP" -o "$f" = "generic" ]
> -	then
> -	    return
> -	fi
> -    done
> +	for f; do
> +		# ^FS means black listed fs
> +		if [ "$f" = "^$FSTYP" ]; then
> +			return 1
> +		elif [ "$f" = "generic" ] || [[ "$f" == "^"* ]]; then
> +			# ^FS implies "generic ^FS"
> +			res=0
> +		elif [ "$f" = "$FSTYP" ]; then
> +			return 0
> +		fi
> +	done
> +	return $res
> +}
>  
> -    _notrun "not suitable for this filesystem type: $FSTYP"
> +_supported_fs()
> +{
> +	_check_supported_fs $* || \
> +		_notrun "not suitable for this filesystem type: $FSTYP"
>  }
>  
>  # check if a FS on a device is mounted
> diff --git a/tests/generic/500 b/tests/generic/500
> index 0be59934..bc84d219 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -35,7 +35,6 @@ _cleanup()
>  . ./common/dmthin
>  
>  # real QA test starts here
> -_supported_fs generic
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>  
> @@ -43,7 +42,7 @@ _require_dm_target thin-pool
>  # and since we've filled the thinp device it'll return EIO, which will make
>  # btrfs flip read only, making it fail this test when it just won't work right
>  # for us in the first place.
> -test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
> +_supported_fs ^btrfs
>  
>  # Require underlying device support discard
>  _scratch_mkfs >>$seqres.full 2>&1
> diff --git a/tests/generic/631 b/tests/generic/631
> index 4996bce7..219f7a05 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -36,10 +36,9 @@ _cleanup()
>  . ./common/attr
>  
>  # real QA test starts here
> -_supported_fs generic
>  _require_scratch
>  _require_attrs trusted
> -test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
> +_supported_fs ^overlay
>  _require_extra_fs overlay
>  
>  _scratch_mkfs >> $seqres.full
> diff --git a/tests/generic/679 b/tests/generic/679
> index 440f0c08..c32d42b9 100755
> --- a/tests/generic/679
> +++ b/tests/generic/679
> @@ -17,7 +17,6 @@ _begin_fstest auto quick prealloc
>  
>  # real QA test starts here
>  
> -_supported_fs generic
>  _require_scratch
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fiemap"
> @@ -26,7 +25,7 @@ _require_xfs_io_command "fiemap"
>  #
>  #   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/
>  #
> -[ $FSTYP == "xfs" ] && _notrun "test not valid for xfs"
> +_supported_fs ^xfs
>  
>  rm -f $seqres.full
>  
> -- 
> 2.35.1
> 

