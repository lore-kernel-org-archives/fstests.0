Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05169C38A02
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Oct 2022 03:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3D1c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 29 Oct 2022 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ3D1b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Oct 2022 23:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EABE2BDD
        for <fstests@vger.kernel.org>; Sat, 29 Oct 2022 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667100395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhENmxrdv21/LQQZ+n4qR4rHVXnbqDCp4cEUdYB5Vi0=;
        b=GZjn8rKyLVXCYahIj2kex2PdkXx2pcrz0fQLOBbVZlemJCBGSXX7fBlvcQ9N0zpBrDdfAv
        0aVpDBbp8aNo1XWawOvr+SwsgDobl2wGm2FUN4lFTXMJWnD5gGV+HBJPNwOLtx57eNb2OR
        GRLJrHd6+L18bZPyQDRgMe/c7WqMT38=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-wAGUusASN76VAjDReX3o-g-1; Sat, 29 Oct 2022 23:26:32 -0400
X-MC-Unique: wAGUusASN76VAjDReX3o-g-1
Received: by mail-qk1-f198.google.com with SMTP id de21-20020a05620a371500b006eed31abb72so6664449qkb.6
        for <fstests@vger.kernel.org>; Sat, 29 Oct 2022 20:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhENmxrdv21/LQQZ+n4qR4rHVXnbqDCp4cEUdYB5Vi0=;
        b=oVk/e566iIv/U272BRZHVl0C5yTj2hGLzQCE/+8/AM2K611TNQ6DkycdXkpbBlMPKl
         Eiko/z1GTZgOxX6CKLXb6KufAYi0mqgrTqLk/vRO/P/pO+wFKMgT5z/YaphpuRJ4wObX
         cNI+Q2e0jaVJ+L9hCC/tPFPkqLqL5mGDv8bmApx/1nJAjDJJQGAzWDlb8Udpas3ALjrd
         5OnXelEWU0aPsW3cBFXKH3dhQ7wk1ti4Wn/w19eeE4J5gXmlpTu0GMFKI9c9LiAomQTq
         h4NMvB9/3AnrzEgDgseDCDKD1QkPsBl8Tbo9OYu+esFD/Uo9EchSiFi7EsBfuQtB/nS+
         h+OQ==
X-Gm-Message-State: ACrzQf0aLKCj9dq36Vx6bIxYNPLBF2NgW8etR/ET+YY3jj/PCAVjZpbo
        gCdR883ruxIiRkRb2adMXDIrmDNjYdWEBQc/MvID84vYfiShtKHr3RsfBvat4v0fEE5TKAa9Vgs
        M6mSLuffsu1W+z+WqLw==
X-Received: by 2002:a05:620a:1a9c:b0:6ee:8edc:ab47 with SMTP id bl28-20020a05620a1a9c00b006ee8edcab47mr4801593qkb.575.1667100391894;
        Sat, 29 Oct 2022 20:26:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7z0ditu3+ZHE0V8w/E03gavqCFhUVs/gBp03Zo15wMDCfrCiClBnLUdnZspaLbgmjOoAvyAQ==
X-Received: by 2002:a05:620a:1a9c:b0:6ee:8edc:ab47 with SMTP id bl28-20020a05620a1a9c00b006ee8edcab47mr4801587qkb.575.1667100391586;
        Sat, 29 Oct 2022 20:26:31 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bp11-20020a05620a458b00b006ce3f1af120sm2220825qkb.44.2022.10.29.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 20:26:30 -0700 (PDT)
Date:   Sun, 30 Oct 2022 11:26:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Make test and scratch devices use the
 same mount options
Message-ID: <20221030032626.i6hv5m6rlor6fxbc@zlang-mailbox>
References: <1666867852-134-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666867852-134-1-git-send-email-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 27, 2022 at 10:50:52AM +0000, Xiao Yang wrote:
> Some cases(e.g. generic/519) check commands/features on test device but
> do tests on scratch device.  If some mount options can impact the check
> result, these cases may throw error instead if not run when we use
> different mount options for test and scratch devices.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---

This patch makes sense to me.

Actually I'm a little curious about the history of _test_mount_opts() function,
so I tried to check the commit log of fstests, then I found this function was
brought in by 0e9141e49d4a ("common: add cifs support").

This commit set MOUNT_OPTIONS and TEST_FS_MOUNT_OPTS same, then later patches
(which trys to support a new fs) update mount_opts() but sometimes don't
update _test_mount_opts(). I don't know if they're intended. From my narrow
knowledge I think TEST_FS_MOUNT_OPTS and MOUNT_OPTS should keep consistent, if
no specific setup. And the log history shows that we've tried to fix their
inconsistent problems by some patches. E.g.
  adf56068 ("common/config: add acl and user_xattr support for TEST_DEV")
  643c6850 ("common/config: honor NFS_MOUNT_OPTIONS in _test_mount_opts")

I think even if someone fs really need a different default TEST_FS_MOUNT_OPTS,
we can change it in _test_mount_opts, or let them same.

I gave this patch a little testing, but I can't test it on all fs we support.
So I'll keep this patch a week, if anyone has any review points, please feel
free to reply this email. If no, I'd like to give it my RVB at first.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  common/config | 65 +++++++++++++++++++--------------------------------
>  1 file changed, 24 insertions(+), 41 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 5eaae447..6f428eae 100644
> --- a/common/config
> +++ b/common/config
> @@ -334,89 +334,72 @@ if [ "$FSTYP" == "xfs" ]; then
>  	export XFS_MKFS_HAS_NO_META_SUPPORT
>  fi
>  
> -_mount_opts()
> +_common_mount_opts()
>  {
>  	case $FSTYP in
>  	9p)
> -		export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
> +		echo $PLAN9_MOUNT_OPTIONS
>  		;;
>  	xfs)
> -		export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
> +		echo $XFS_MOUNT_OPTIONS
>  		;;
>  	udf)
> -		export MOUNT_OPTIONS=$UDF_MOUNT_OPTIONS
> +		echo $UDF_MOUNT_OPTIONS
>  		;;
>  	nfs)
> -		export MOUNT_OPTIONS=$NFS_MOUNT_OPTIONS
> +		echo $NFS_MOUNT_OPTIONS
>  		;;
>  	cifs)
> -		export MOUNT_OPTIONS=$CIFS_MOUNT_OPTIONS
> +		echo $CIFS_MOUNT_OPTIONS
>  		;;
>  	ceph)
> -		export MOUNT_OPTIONS=$CEPHFS_MOUNT_OPTIONS
> +		echo $CEPHFS_MOUNT_OPTIONS
>  		;;
>  	glusterfs)
> -		export MOUNT_OPTIONS=$GLUSTERFS_MOUNT_OPTIONS
> +		echo $GLUSTERFS_MOUNT_OPTIONS
>  		;;
>  	overlay)
> -		export MOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
> +		echo $OVERLAY_MOUNT_OPTIONS
>  		;;
>  	ext2|ext3|ext4|ext4dev)
>  		# acls & xattrs aren't turned on by default on ext$FOO
> -		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> +		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
>  		;;
>  	f2fs)
> -		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
> +		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
>  		;;
>  	reiserfs)
>  		# acls & xattrs aren't turned on by default on reiserfs
> -		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
> +		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
>  		;;
>         reiser4)
> -               # acls & xattrs aren't supported by reiser4
> -               export MOUNT_OPTIONS=$REISER4_MOUNT_OPTIONS
> -               ;;
> +		# acls & xattrs aren't supported by reiser4
> +		echo $REISER4_MOUNT_OPTIONS
> +		;;
>  	gfs2)
>  		# acls aren't turned on by default on gfs2
> -		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
> +		echo "-o acl $GFS2_MOUNT_OPTIONS"
>  		;;
>  	tmpfs)
>  		# We need to specify the size at mount, use 1G by default
> -		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
> +		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
>  		;;
>  	ubifs)
> -		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
> +		echo $UBIFS_MOUNT_OPTIONS
>  		;;
>  	*)
>  		;;
>  	esac
>  }
>  
> +_mount_opts()
> +{
> +	export MOUNT_OPTIONS=$(_common_mount_opts)
> +}
> +
>  _test_mount_opts()
>  {
> -	case $FSTYP in
> -	9p)
> -		export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
> -		;;
> -	cifs)
> -		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
> -		;;
> -	ceph)
> -		export TEST_FS_MOUNT_OPTS=$CEPHFS_MOUNT_OPTIONS
> -		;;
> -	nfs)
> -		export TEST_FS_MOUNT_OPTS=$NFS_MOUNT_OPTIONS
> -		;;
> -	glusterfs)
> -		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
> -		;;
> -	ext2|ext3|ext4|ext4dev)
> -		# acls & xattrs aren't turned on by default on older ext$FOO
> -		export TEST_FS_MOUNT_OPTS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> -		;;
> -	*)
> -		;;
> -	esac
> +	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
>  }
>  
>  _mkfs_opts()
> -- 
> 2.34.1
> 

