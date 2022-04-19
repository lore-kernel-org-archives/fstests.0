Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA7C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 18:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356171AbiDSSGx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356170AbiDSSGw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 14:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89A3C3B57A
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650391447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaIhc02kGZohQLz7V4Fs3AiJ+MUejdnViZfnkpg6UMI=;
        b=fgk6ogJ1yfg7BPuS5dYRX2IO0x6G8Tn4VMprEwQtSQVsTRpGFChhkFg2vYQu2zj5SrtoD4
        QeEt7dRwRg+pxCADLHTWPg2WMSizFt6n42COc7WBpmIJttdoK4qlYl48kASJbr2fv+tjXy
        Y6E41cMCW+cJiUFlU9/Yy09Sezzaqj0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-ku-Lb9T2Peq323G_QUXXIA-1; Tue, 19 Apr 2022 14:04:04 -0400
X-MC-Unique: ku-Lb9T2Peq323G_QUXXIA-1
Received: by mail-qk1-f197.google.com with SMTP id u6-20020a05620a430600b0069c0f5ad4e2so13035299qko.2
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SaIhc02kGZohQLz7V4Fs3AiJ+MUejdnViZfnkpg6UMI=;
        b=qoM9IDE5e0eJdlm4vSTYHQ8XQj0I7DWBYDyNzpTCz9RyFaEuDLtIuwRjz45c+4pnfJ
         EL1qaEPN2g8APabjIUSVr1LHkLBVcIMZJIJl8jyatwZrqI5VbfmyWDac6DIQuLHHpWab
         9j4/cibrkKUEk3DnuuiGZuBRlruyzpMRNmllUcbOmX+fwYqPm2dyLitHVBQIRVhMClON
         aR1vqtQEUN9Q+2lFON64VRF0rbNc3XVODrB87HVQi2a9eUd2BkKLeCVPip9kMNCHSC5L
         fo1tIMUzFfNcLkes4otuu1RIupMBDhGagIzZjxiwgp9/mTVMMV6+mO1X3fxDpAgK72yd
         RxDg==
X-Gm-Message-State: AOAM531vEhKTe4tiJZqd/q3XnLuzkMQXX1cr59JndpVDp2K4S19GRPew
        VvThWINUwoe9RZ/vmfQ5xzY5hVjiRl2mKSZd4Lrw2j/j0dz8p2kJo6qyQMaY6v4MNG15Boi6w6k
        6fdisA++F4JZFc0eITg==
X-Received: by 2002:a37:a78d:0:b0:69e:be50:a6c4 with SMTP id q135-20020a37a78d000000b0069ebe50a6c4mr3515684qke.61.1650391443761;
        Tue, 19 Apr 2022 11:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwikYa4Gy453kL7FGQ/CgHSV+hHSnCTS1ZTRsjiSb1YuQK694jCZJhdq+AxRxBB7QuptX0hGw==
X-Received: by 2002:a37:a78d:0:b0:69e:be50:a6c4 with SMTP id q135-20020a37a78d000000b0069ebe50a6c4mr3515668qke.61.1650391443481;
        Tue, 19 Apr 2022 11:04:03 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w3-20020a376203000000b0069e9a4568f9sm333762qkb.125.2022.04.19.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:04:02 -0700 (PDT)
Message-ID: <b80030d5be5158115dd71cb953701e86d9fc5621.camel@redhat.com>
Subject: Re: [PATCH] cephfs: add ceph-fuse suport for ceph-fuse
From:   Jeff Layton <jlayton@redhat.com>
To:     Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org
Cc:     rishabhddave@gmail.com
Date:   Tue, 19 Apr 2022 14:04:02 -0400
In-Reply-To: <20220419175811.602126-1-ridave@redhat.com>
References: <20220419175811.602126-1-ridave@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 2022-04-19 at 23:28 +0530, Rishabh Dave wrote:
> Currently tests in xfstests-dev can be executed against CephFS only by
> mounting CephFS using kernel driver. Attempting to run tests against
> CephFS using FUSE doesn't work because xfstests-dev would remount CephFS
> using kernel. This patch adds the ability for xfstest-dev code to mount
> CephFS using FUSE.
> 
> Fixes: https://tracker.ceph.com/issues/55354
> Signed-off-by: Rishabh Dave <ridave@redhat.com>
> ---
>  common/config |  2 ++
>  common/rc     | 46 ++++++++++++++++++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 1033b890..efcf12e9 100644
> --- a/common/config
> +++ b/common/config
> @@ -556,6 +556,8 @@ _check_device()
>  			_fatal "common/config: $name ($dev) is not a character device"
>  		fi
>  		;;
> +	ceph-fuse)
> +		;;
>  	*)
>  		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
>  	esac
> diff --git a/common/rc b/common/rc
> index 553ae350..868b3ddd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -500,10 +500,14 @@ _test_mount()
>  {
>      local mount_ret
>  
> -    if [ "$FSTYP" == "overlay" ]; then
> +    if [ "$FSTYP" == "ceph-fuse" ]; then
> +        $CEPH_FUSE_BIN_PATH $TEST_FS_MOUNT_OPTS $TEST_DIR 2> /dev/null
> +        return $?
> +    elif [ "$FSTYP" == "overlay" ]; then
>          _overlay_test_mount $*
>          return $?
>      fi
> +
>      _test_options mount
>      _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>      mount_ret=$?
> @@ -1446,7 +1450,8 @@ _fs_type()
>      # have to bother with this quirk.
>      #
>      _df_device $1 | $AWK_PROG '{ print $2 }' | \
> -        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
> +        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/' \
> +            -e 's/fuse.ceph-fuse/ceph-fuse/'
>  }
>  
>  # return the FS mount options of a mounted device
> @@ -1595,6 +1600,24 @@ _supported_fs()
>      _notrun "not suitable for this filesystem type: $FSTYP"
>  }
>  
> +_check_if_dev_already_mounted()
> +{
> +	local dev=$1
> +	local mnt=$2
> +
> +	# find $dev as the source, and print result in "$dev $mnt" format
> +	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
> +	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
> +
> +	# if it's mounted, make sure its on $mnt
> +	if [ "$mount_rec" != "$dev $mnt" ]; then
> +		echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
> +		echo "Already mounted result:"
> +		echo $mount_rec
> +		return 2 # 2 = mounted on wrong mnt
> +	fi
> +}
> +
>  # check if a FS on a device is mounted
>  # if so, verify that it is mounted on mount point
>  # if fstype is given as argument, verify that it is also
> @@ -1608,16 +1631,14 @@ _check_mounted_on()
>  	local mnt=$4
>  	local type=$5
>  
> -	# find $dev as the source, and print result in "$dev $mnt" format
> -	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
> -	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
> +	# this check doesn't work on ceph-fuse
> +	if [ "$dev" != "ceph-fuse" ]; then
> +		_check_if_dev_already_mounted $dev $mnt
> +		dev_already_mounted=$?
>  

Shouldn't there be a "fi" above?

> -	# if it's mounted, make sure its on $mnt
> -	if [ "$mount_rec" != "$dev $mnt" ]; then
> -		echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
> -		echo "Already mounted result:"
> -		echo $mount_rec
> -		return 2 # 2 = mounted on wrong mnt
> +		if [ $dev_already_mounted -ne 0 ]; then
> +			return $dev_already_mounted
> +		fi
>  	fi
>  
>  	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
> @@ -1869,6 +1890,7 @@ _require_test()
>  		if [ ! -d "$TEST_DIR" ]; then
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
> +	ceph-fuse)
>  		;;
>  	cifs)
>  		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
> @@ -3204,7 +3226,7 @@ _check_test_fs()
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> -    ceph)
> +    ceph|ceph-fuse)
>  	# no way to check consistency for CephFS
>  	;;
>      glusterfs)

-- 
Jeff Layton <jlayton@redhat.com>

