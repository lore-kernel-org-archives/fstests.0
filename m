Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCEBC433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jun 2022 13:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiFFNIL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiFFNIK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jun 2022 09:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BEF06FD1E
        for <fstests@vger.kernel.org>; Mon,  6 Jun 2022 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654520887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRuI38GAnyxOfTRdYiHaeYIc+j4lNAQ2cgwvK02ULE4=;
        b=GeA88DaYXMOxVkmHz+LhHlAv77Rc7h8Jbtwt/nozA6/bu4BryID27KoTKLf2weinTpAZaN
        XqDpbjQEkvKy+J6nCuMBYXtNCJcINHXwIAx5PO7d9MtF1amEBdJ9RB1BcGBvpHnWSaSjmj
        8fDQ9k3xVa5hl/HLHEUGd0/UWQRFIbM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-SUldrBReM_CsaItu96eEAQ-1; Mon, 06 Jun 2022 09:08:06 -0400
X-MC-Unique: SUldrBReM_CsaItu96eEAQ-1
Received: by mail-wm1-f69.google.com with SMTP id n15-20020a05600c4f8f00b0039c3e76d646so4326772wmq.7
        for <fstests@vger.kernel.org>; Mon, 06 Jun 2022 06:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRuI38GAnyxOfTRdYiHaeYIc+j4lNAQ2cgwvK02ULE4=;
        b=IT1FZ0CL1XryrB9J13hD3FwsuFRevSno1xojSO0djuiK0U1yQKLqHXAj25yIf3OYTe
         4i4hSHmd1Rhljr34n+c37Y0Qc9skTFk1fZyLKH6PQltGD96hFF0kOXXjOBe9lE3iGTKM
         khTFIHq81Mo1exQKdDch4sMXkyerR7PRBStfcalI06QRl1DpEHx7suVch9viLOBgZ5Sr
         EJJqtiIdCkpdR5wweZ1pgnsqRgWGF4a58D1922eLKOYMLSZ3aE/MXsMMErOIbxZ75c3h
         RZmLSh/965xAknF0BxGEuZMxrV7dZXgsLkz8i/nSyaOer2fwxGZCJj35LxopC/8bPERp
         VAXQ==
X-Gm-Message-State: AOAM533dk6lsbDyIj5lu/yZmAlKnWTTVn793pNDG3t1Q7/Qn3AQTfJxT
        p/nAUY3jbr6+hZerX/8hEImwgguFSpiMGhad4aQ5cx7VcW+8R3lSdVdKFw7ERnOvMtc5WMtiktU
        I6kvkiWWSoeoHfOPI
X-Received: by 2002:a05:6000:1111:b0:212:d9ea:8609 with SMTP id z17-20020a056000111100b00212d9ea8609mr20849875wrw.522.1654520884561;
        Mon, 06 Jun 2022 06:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5YzRugeG6nwVNNHc0SjZQr+8JZtag9ZDroZkaqYL3jbiP6UCPovgoX1TzWvYU6AEhrirKWA==
X-Received: by 2002:a05:6000:1111:b0:212:d9ea:8609 with SMTP id z17-20020a056000111100b00212d9ea8609mr20849836wrw.522.1654520884235;
        Mon, 06 Jun 2022 06:08:04 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d460a000000b0021552eebde6sm9093188wrq.32.2022.06.06.06.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:07:58 -0700 (PDT)
Date:   Mon, 6 Jun 2022 15:07:56 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/filter: filter out extra mount error output
Message-ID: <20220606130756.5yrgyhbo3fp37ipu@aalbersh.remote.csb>
References: <20220527121115.34358-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527121115.34358-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 27, 2022 at 08:11:15PM +0800, Zorro Lang wrote:
> The lastest mount command (from util-linux) merged below commit:
>   79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
> which brought in a new error output when mount fails, no matter
> ro/rw/busy mount fails.
> 
> That cause some cases (e.g. xfs/005) fail as:
>   mount: Structure needs cleaning
>          dmesg(1) may have more information after failed mount system call
> 
> More failed cases like generic/050, ext4/002, xfs/154, xfs/158 etc.
> Especially xfs/154 and xfs/158, need to change their _filter_scratch
> to _filter_error_mount.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Thanks the review points from Dave. This V2 turn to filter out the error in
> _filter_error/ro/busy_mount. And change xfs/154 and xfs/158 to use
> _filter_error_mount.
> 
> Thanks,
> Zorro
> 
>  common/filter     | 13 +++++++++++--
>  tests/xfs/154     |  2 +-
>  tests/xfs/154.out |  2 +-
>  tests/xfs/158     |  2 +-
>  tests/xfs/158.out |  2 +-
>  5 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index a6a42b7a..14f6a027 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -380,6 +380,8 @@ _filter_ending_dot()
>  # ancient:	   mount: cannot remount block device <device> read-write, is write-protected
>  # prior to v2.30:  mount: cannot remount <device> read-write, is write-protected
>  # v2.30 and later: mount: <mountpoint>: cannot remount <device> read-write, is write-protected.
> +# v2.38 and later:
> +# dmesg(1) may have more information after failed mount mount system call
>  #
>  # Now use _filter_ro_mount to unify all these differences across old & new
>  # util-linux versions. So the filtered format would be:
> @@ -412,7 +414,8 @@ _filter_ro_mount() {
>  		print "mount: cannot remount device read-write, is write-protected\n";
>  	} else {
>  		print "$_";
> -	}' | _filter_ending_dot
> +	}' | grep -v "dmesg(1) may have more information after failed mount" | \
> +	_filter_ending_dot
>  }
>  
>  # Filter a failed mount output due to EUCLEAN and USTALE, util-linux changed
> @@ -424,6 +427,8 @@ _filter_ro_mount() {
>  # mount: mount <device> on <mountpoint> failed: Structure needs cleaning
>  # v2.30 and later:
>  # mount: <mountpoint>: mount(2) system call failed: Structure needs cleaning.
> +# v2.38 and later:
> +# dmesg(1) may have more information after failed mount mount system call
>  #
>  # This is also true for ESTALE error. So let's remove all the changing parts
>  # and keep the 'prior to v2.21' format:
> @@ -431,7 +436,8 @@ _filter_ro_mount() {
>  # mount: Stale file handle
>  _filter_error_mount()
>  {
> -	sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
> +	grep -v "dmesg(1) may have more information after failed mount" | \
> +		sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
>  }
>  
>  # Similar to _filter_error_mount, filter a busy mount output.
> @@ -440,8 +446,11 @@ _filter_error_mount()
>  # old: mount: <device> is already mounted or <mountpoint> busy
>  # new: mount: <mountpoint>: <device> already mounted or mount point busy.
>  # filtered: mount: device already mounted or mount point busy
> +# v2.38 and later, filter out:
> +# dmesg(1) may have more information after failed mount mount system call
>  _filter_busy_mount()
>  {
> +	grep -v "dmesg(1) may have more information after failed mount" | \
>  	sed -e "s/.*: .* already mounted or .* busy/mount: device already mounted or mount point busy/" | \
>  		_filter_ending_dot
>  }
> diff --git a/tests/xfs/154 b/tests/xfs/154
> index 3f90a397..548c9490 100755
> --- a/tests/xfs/154
> +++ b/tests/xfs/154
> @@ -48,7 +48,7 @@ test $? -eq 137 || echo "repair should have been killed??"
>  _check_scratch_xfs_features NEEDSREPAIR
>  _try_scratch_mount &> $tmp.mount
>  res=$?
> -_filter_scratch < $tmp.mount
> +_filter_error_mount < $tmp.mount
>  if [ $res -eq 0 ]; then
>  	echo "Should not be able to mount after needsrepair crash"
>  	_scratch_unmount
> diff --git a/tests/xfs/154.out b/tests/xfs/154.out
> index 12f154ab..1263f091 100644
> --- a/tests/xfs/154.out
> +++ b/tests/xfs/154.out
> @@ -1,4 +1,4 @@
>  QA output created by 154
>  FEATURES: NEEDSREPAIR:YES
> -mount: SCRATCH_MNT: mount(2) system call failed: Structure needs cleaning.
> +mount: Structure needs cleaning
>  FEATURES: NEEDSREPAIR:NO
> diff --git a/tests/xfs/158 b/tests/xfs/158
> index 505a9c73..4440adf6 100755
> --- a/tests/xfs/158
> +++ b/tests/xfs/158
> @@ -51,7 +51,7 @@ test $? -eq 137 || echo "repair should have been killed??"
>  _check_scratch_xfs_features NEEDSREPAIR INOBTCNT
>  _try_scratch_mount &> $tmp.mount
>  res=$?
> -_filter_scratch < $tmp.mount
> +_filter_error_mount < $tmp.mount
>  if [ $res -eq 0 ]; then
>  	echo "needsrepair should have prevented mount"
>  	_scratch_unmount
> diff --git a/tests/xfs/158.out b/tests/xfs/158.out
> index 4f9dfd08..5461031a 100644
> --- a/tests/xfs/158.out
> +++ b/tests/xfs/158.out
> @@ -8,7 +8,7 @@ FEATURES: INOBTCNT:NO
>  Fail partway through upgrading
>  Adding inode btree counts to filesystem.
>  FEATURES: NEEDSREPAIR:YES INOBTCNT:YES
> -mount: SCRATCH_MNT: mount(2) system call failed: Structure needs cleaning.
> +mount: Structure needs cleaning
>  Re-run repair to finish upgrade
>  FEATURES: NEEDSREPAIR:NO INOBTCNT:YES
>  Filesystem should be usable again
> -- 
> 2.31.1
> 

Looks good to me,
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

