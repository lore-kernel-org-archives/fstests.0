Return-Path: <SRS0=Q9mn=YL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA0CA9EA0
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6B5222C3
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 09:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBYTmxPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391167AbfJRJPt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:15:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44284 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRJPs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Oct 2019 05:15:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so3473427pfn.11
        for <fstests@vger.kernel.org>; Fri, 18 Oct 2019 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WST3IHmB4Yaq0s+j7mfZWbA/H08o+3ozNzjBE/vWdQg=;
        b=vBYTmxPnm1QbaJzCVBCm2zqLKKQMj4NzOSQN617kxPffI4E9ovSG6fNsMm9XIhrnQg
         1+44mCRhEG76+Lc/oljHqo/XDQd7DQoW+Tl45M4Bno0jOE85OiQqH6Z0ljJ9hySvAt9O
         zZEXEB3VzRWNH4KUZxGB3YyXQuFHWVb58OhVH4HumnsH0LWsLFanBqeuJEX6oRRsH4po
         9YHsyRZGatl5+TGIALi8CAIdOV48/azJVwvmxpVD/9Mi/ywHX6R9WyX9NyFYxuzfMtYB
         Qa8XkmSw9Z00CeAKlw365+WWFcaDXNRdySH6Pwb/HYg3QiFkH3QT03/Gbrzpmn2PlRvT
         rs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WST3IHmB4Yaq0s+j7mfZWbA/H08o+3ozNzjBE/vWdQg=;
        b=WZN2tcqJi9qZKCgKugI4v+WmzfeU/esne34fj02NZL27ySobFNkGfrLPchg7cem1qs
         NDRlvaW/1LUWsef8Kmdcv9itjzH8j8fSzz7m8SdpPdcrat5u1VxEdviU5WnsSAddGTm2
         4+8Qfh8RYYaIytzcwckyAK01mxTlvsflpw9jBIhvnbySfY7B6R5+K7pPAIujA2EkGusx
         VGi7Y6xYYqYAxogHn0tL95/5eZcJFxTl9RezcpiM54XDhDnk9IeG0jXAknqMRf/LNyPg
         9O4tav9rOkOZnzcW/4igIqZPa+3ihYYuka8AHO9eDGEi8Mrh3Bfy68oNEKLpI10v1jeC
         qO/A==
X-Gm-Message-State: APjAAAWUES0ipPMIeEyo9PlPaclnWMw9DaH2L4Qn/r121CwboEfSZkPc
        Mw0LMAFjxloYY4HCIa4fCcU=
X-Google-Smtp-Source: APXvYqxqOr0nstkbI/aEAXqa5KaeTluLOPohRLJOpCxo90mBDSx8DAj5nn9X1Zv9v8E4A4Ol0ypfVw==
X-Received: by 2002:a17:90a:c24a:: with SMTP id d10mr9858349pjx.124.1571390146162;
        Fri, 18 Oct 2019 02:15:46 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id a8sm5147006pff.5.2019.10.18.02.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:15:45 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:15:38 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     QI Fuli <qi.fuli@fujitsu.com>
Cc:     fstests@vger.kernel.org, virtio-fs@redhat.com,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] fstests: Add virtio-fs shared file system
 support
Message-ID: <20191018091533.GM2622@desktop>
References: <20191015083228.13475-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015083228.13475-1-qi.fuli@fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 15, 2019 at 05:32:28PM +0900, QI Fuli wrote:
> This patch adds support for virtio-fs shared file system that lets
> virtual machines access a directory tree on the host.
> 
> To run xfstests on it, first, start virtiofsd daemon in host:
>  ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu0 -o source=$DIR0 -o cache=always
>  ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu1 -o source=$DIR1 -o cache=always
> 
> second, launch QEMU with:
>  -chardev socket,id=char0,path=/tmp/vhostqemu0
>  -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs0
>  -chardev socket,id=char1,path=/tmp/vhostqemu1
>  -device vhost-user-fs-pci,queue-size=1024,chardev=char1,tag=myfs1
>  -m 8G
>  -object memory-backend-file,id=mem,size=8G,mem-path=/dev/shm,share=on
>  -numa node,memdev=mem
> 
> then, inside the VM run xfstests with:
>  export TEST_DEV=myfs0
>  export TEST_DIR=$TESTDIR
>  export SCRATCH_DEV=myfs1
>  export SCRATCH_MNT=$SCRATCHMNT
>  export MOUNT_OPTIONS=""
>  export TEST_FS_MOUNT_OPTS=""
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>

Looks good to me, thanks for the patch!

Eryu

> ---
>  check         |  2 ++
>  common/config |  4 ++--
>  common/rc     | 18 +++++++++++++++---
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/check b/check
> index c7f1dc5e..2e148e57 100755
> --- a/check
> +++ b/check
> @@ -56,6 +56,7 @@ check options
>      -glusterfs		test GlusterFS
>      -cifs		test CIFS
>      -9p			test 9p
> +    -virtiofs		test virtiofs
>      -overlay		test overlay
>      -pvfs2		test PVFS2
>      -tmpfs		test TMPFS
> @@ -268,6 +269,7 @@ while [ $# -gt 0 ]; do
>  	-glusterfs)	FSTYP=glusterfs ;;
>  	-cifs)		FSTYP=cifs ;;
>  	-9p)		FSTYP=9p ;;
> +	-virtiofs)	FSTYP=virtiofs ;;
>  	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
>  	-pvfs2)		FSTYP=pvfs2 ;;
>  	-tmpfs)		FSTYP=tmpfs ;;
> diff --git a/common/config b/common/config
> index a0d58bde..2cb0202a 100644
> --- a/common/config
> +++ b/common/config
> @@ -480,8 +480,8 @@ _check_device()
>  	fi
>  
>  	case "$FSTYP" in
> -	9p|tmpfs)
> -		# 9p mount tags are just plain strings, so anything is allowed
> +	9p|tmpfs|virtiofs)
> +		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
>  		# tmpfs doesn't use mount source, ignore
>  		;;
>  	overlay)
> diff --git a/common/rc b/common/rc
> index cfaabf10..3d5c8b23 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -603,6 +603,9 @@ _test_mkfs()
>      9p)
>  	# do nothing for 9p
>  	;;
> +    virtiofs)
> +	# do nothing for virtiofs
> +	;;
>      ceph)
>  	# do nothing for ceph
>  	;;
> @@ -640,6 +643,9 @@ _mkfs_dev()
>      9p)
>  	# do nothing for 9p
>  	;;
> +    virtiofs)
> +	# do nothing for virtiofs
> +	;;
>      overlay)
>  	# do nothing for overlay
>  	;;
> @@ -704,7 +710,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p)
> +	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -1467,7 +1473,7 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> -	9p)
> +	9p|virtiofs)
>  		if [ -z "$SCRATCH_DEV" ]; then
>  			_notrun "this test requires a valid \$SCRATCH_DEV"
>  		fi
> @@ -1591,7 +1597,7 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> -	9p)
> +	9p|virtiofs)
>  		if [ -z "$TEST_DEV" ]; then
>  			_notrun "this test requires a valid \$TEST_DEV"
>  		fi
> @@ -2686,6 +2692,9 @@ _check_test_fs()
>      9p)
>  	# no way to check consistency for 9p
>  	;;
> +    virtiofs)
> +	# no way to check consistency for virtiofs
> +	;;
>      ceph)
>  	# no way to check consistency for CephFS
>  	;;
> @@ -2744,6 +2753,9 @@ _check_scratch_fs()
>      9p)
>  	# no way to check consistency for 9p
>  	;;
> +    virtiofs)
> +	# no way to check consistency for virtiofs
> +	;;
>      ceph)
>  	# no way to check consistency for CephFS
>  	;;
> -- 
> 2.20.1
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
