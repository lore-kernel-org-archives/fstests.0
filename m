Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C10FC61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Feb 2023 10:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjBBKBr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBBKBq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Feb 2023 05:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472B87D38
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 02:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675332063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6preaN4oNzu5Iz6A29/PYbhEwVkGirMlrifW4Dp290=;
        b=HTpYadBxmDzfKLczZhpapXsv7nGW7ZhgVLuZgxfclQfZ+p+CrQhMHOYdM+JBtxixXzARns
        O435lk1B5gKfKAXOk/xCvNtWD8iSfQaUIXopK+QgOPZ6eH8XyLVOl5XfOz1aoFIy99bToU
        k2o0lymNMZizjVV1eZK2NfD6G+SMdqk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-itcietRhMdOtVfUZ0_PJJw-1; Thu, 02 Feb 2023 05:01:02 -0500
X-MC-Unique: itcietRhMdOtVfUZ0_PJJw-1
Received: by mail-pf1-f199.google.com with SMTP id a18-20020a62bd12000000b0056e7b61ec78so746371pff.17
        for <fstests@vger.kernel.org>; Thu, 02 Feb 2023 02:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6preaN4oNzu5Iz6A29/PYbhEwVkGirMlrifW4Dp290=;
        b=g5O6d920K8TrAr+yT4aypGuFf+L8hkphk/jdByY779w0UsZKOgBDw4BJYOVvmbFrcz
         oqajYXm2GNZNu5NebDEpFqJwG52hA89OzQ2Y2jtx+ZK2mFXzGTxtnxcIkY6xIDRKdQ+4
         BvlpScRy974sB0+JR10rLoMlwN4FrPPrbIrtaElsFcZQBhXRLAMSnl3a8qeh/eqSl+6r
         liBVgfIBsD/4C7CQbktP3S6p5I46OKMOweXMaTbkBsiM6C8S+LyA5ptq3KrM0IJxlsGu
         Zo0xM7ou2QmySOnVDYQV3ZWUopq+a/OIHccUxY7D5xe5v6wx64KYunH32bNXNn+Fa0YJ
         m/kQ==
X-Gm-Message-State: AO0yUKVgJhBB59QghXIIb9M+nsyXspkIEEmapAZqZeGdcZUvAQgW0yGz
        GHW8mhgyH/4vkfqTyv7IDEcy2XiSLrv2XESvDQ8rL133QEU33GI/rVzofkcAuwlbvoJ6LYldYjX
        QtfAUB1jBnvTKS1Ex1Q==
X-Received: by 2002:a17:90b:1e50:b0:230:3af9:17e with SMTP id pi16-20020a17090b1e5000b002303af9017emr1389450pjb.15.1675332061512;
        Thu, 02 Feb 2023 02:01:01 -0800 (PST)
X-Google-Smtp-Source: AK7set+o/EbWHQVexAoaMWd4damJtnZMoZnzElOaloKlyyigJIG4LXBA+s9iXpX3JY/Usqnz0LF+1g==
X-Received: by 2002:a17:90b:1e50:b0:230:3af9:17e with SMTP id pi16-20020a17090b1e5000b002303af9017emr1389439pjb.15.1675332061193;
        Thu, 02 Feb 2023 02:01:01 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c34-20020a17090a492500b0022941908b80sm2771288pjh.47.2023.02.02.02.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:01:00 -0800 (PST)
Date:   Thu, 2 Feb 2023 18:00:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/500: skip this test if formatting fails
Message-ID: <20230202100057.hooqqf2mdinhaaj6@zlang-mailbox>
References: <167521268927.2382722.13701066927653225895.stgit@magnolia>
 <167521270079.2382722.2799074346773170090.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167521270079.2382722.2799074346773170090.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 31, 2023 at 04:51:40PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This testcase exercises what happens when we race a filesystem
> perforing discard operations against a thin provisioning device that has
> run out of space.  To constrain runtime, it creates a 128M thinp volume
> and formats it.
> 
> However, if that initial format fails because (say) the 128M volume is
> too small, then the test fails.  This is really a case of test
> preconditions not being satisfied, so let's make the test _notrun when
> this happens.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/dmthin     |    7 ++++-
>  common/rc         |   80 +++++++++++++++++++++++++++--------------------------
>  tests/generic/500 |    3 +-
>  3 files changed, 48 insertions(+), 42 deletions(-)
> 
> 
> diff --git a/common/dmthin b/common/dmthin
> index 91147e47ac..7107d50804 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -234,5 +234,10 @@ _dmthin_mount()
>  _dmthin_mkfs()
>  {
>  	_scratch_options mkfs
> -	_mkfs_dev $SCRATCH_OPTIONS $@ $DMTHIN_VOL_DEV
> +	_mkfs_dev $SCRATCH_OPTIONS "$@" $DMTHIN_VOL_DEV

This patch adds quote marks to $@, that an extra change. So I hope to know if
this change fix something wrong or you just felt it's better to have?

If this part has a good explanation, others good to me, then I'd like to give
it:

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +}
> +_dmthin_try_mkfs()
> +{
> +	_scratch_options mkfs
> +	_try_mkfs_dev $SCRATCH_OPTIONS "$@" $DMTHIN_VOL_DEV
>  }
> diff --git a/common/rc b/common/rc
> index 36eb90e1f1..376a0138b4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -604,49 +604,49 @@ _test_mkfs()
>      esac
>  }
>  
> +_try_mkfs_dev()
> +{
> +    case $FSTYP in
> +    nfs*)
> +	# do nothing for nfs
> +	;;
> +    9p)
> +	# do nothing for 9p
> +	;;
> +    fuse)
> +	# do nothing for fuse
> +	;;
> +    virtiofs)
> +	# do nothing for virtiofs
> +	;;
> +    overlay)
> +	# do nothing for overlay
> +	;;
> +    pvfs2)
> +	# do nothing for pvfs2
> +	;;
> +    udf)
> +        $MKFS_UDF_PROG $MKFS_OPTIONS $*
> +	;;
> +    btrfs)
> +        $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
> +	;;
> +    ext2|ext3|ext4)
> +	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
> +	;;
> +    xfs)
> +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
> +	;;
> +    *)
> +	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $*
> +	;;
> +    esac
> +}
> +
>  _mkfs_dev()
>  {
>      local tmp=`mktemp -u`
> -    case $FSTYP in
> -    nfs*)
> -	# do nothing for nfs
> -	;;
> -    9p)
> -	# do nothing for 9p
> -	;;
> -    fuse)
> -	# do nothing for fuse
> -	;;
> -    virtiofs)
> -	# do nothing for virtiofs
> -	;;
> -    overlay)
> -	# do nothing for overlay
> -	;;
> -    pvfs2)
> -	# do nothing for pvfs2
> -	;;
> -    udf)
> -        $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
> -	;;
> -    btrfs)
> -        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
> -	;;
> -    ext2|ext3|ext4)
> -	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* \
> -		2>$tmp.mkfserr 1>$tmp.mkfsstd
> -	;;
> -    xfs)
> -	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* \
> -		2>$tmp.mkfserr 1>$tmp.mkfsstd
> -	;;
> -    *)
> -	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
> -		2>$tmp.mkfserr 1>$tmp.mkfsstd
> -	;;
> -    esac
> -
> -    if [ $? -ne 0 ]; then
> +    if ! _try_mkfs_dev "$@" 2>$tmp.mkfserr 1>$tmp.mkfsstd; then
>  	# output stored mkfs output
>  	cat $tmp.mkfserr >&2
>  	cat $tmp.mkfsstd
> diff --git a/tests/generic/500 b/tests/generic/500
> index bc84d219fa..1151c8f234 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -58,7 +58,8 @@ CLUSTER_SIZE=$((64 * 1024 / 512))		# 64K
>  
>  _dmthin_init $BACKING_SIZE $VIRTUAL_SIZE $CLUSTER_SIZE 0
>  _dmthin_set_fail
> -_dmthin_mkfs
> +_dmthin_try_mkfs >> $seqres.full 2>&1 || \
> +	_notrun "Could not format small thinp filesystem for test"
>  _dmthin_mount
>  
>  # There're two bugs at here, one is dm-thin bug, the other is filesystem
> 

