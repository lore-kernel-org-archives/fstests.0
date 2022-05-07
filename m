Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D31C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 07:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384541AbiEGHd5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386097AbiEGHds (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 03:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 909664505C
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651908601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WRRiDfyJoCnB7gneiHKhv29YR+7HKD175gMmBgjMUQU=;
        b=bD0dm3XtlvICTzHCp1Bx6riy6k1h6FsnWrg2rlmaPlUCP4zMFVnq+WBXSL6pB7pIF/xdH5
        scQu96sAQSeaQwerzaAfJWUAX199igAN4n6kRq8GHiimP1qi/bXumSic2seYzv2FdkuQNY
        UzAyqiss2QtGeQRFFCZ9d39rxn5u5qk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-_fj09QoCPpebHeMWAFc9ug-1; Sat, 07 May 2022 03:29:59 -0400
X-MC-Unique: _fj09QoCPpebHeMWAFc9ug-1
Received: by mail-qv1-f72.google.com with SMTP id kc6-20020a056214410600b0045a97658c7dso7630064qvb.16
        for <fstests@vger.kernel.org>; Sat, 07 May 2022 00:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WRRiDfyJoCnB7gneiHKhv29YR+7HKD175gMmBgjMUQU=;
        b=mP3DDajE3r7KZBjVCArSVsIwyRTL8z0ZPfIZW/+/xwPlKhVGTlTEJsTB+h1nhXxQ5W
         yqCsJDFeL8//sn4oP9szU30vt2LT5TsLGPn/odyXyLpRixpWNPUQ37Q5npohu+Pl0fjF
         9j7L1WTQ26tuDmlsKYU84YAWnVcHj+F3Iulnxmm0uFHAIDDOYe3ZGdf728n94ynrFAH7
         MqUoSSe/gL7yyReEOyKR5tAQHoeSB9dDbBeV5N5kV47O9uC4WuN+Dqc2xGqviZRP/7MP
         xMjeD6x6QxBx34o8+xUYOHoHn4feTXtj+FwcuUmY3D0GDg/g+wdgUfQMx26PIDgKySVT
         xdzg==
X-Gm-Message-State: AOAM530t+K4VvJK0ARInPMSXbFtccZV47xfeS5WqRYRFQHNfv0L3J+SU
        Ue4Z6M/uFHWuEXzi+F1vrMsR2FU0l/zSFEWOb5YrWS36LPrtPaoXQKfnl+g78c5pqFh7Iz7VYJZ
        V9Hbnm4bUkAGqoIxfUQ==
X-Received: by 2002:a05:622a:5c8:b0:2f3:c946:b0bd with SMTP id d8-20020a05622a05c800b002f3c946b0bdmr5050195qtb.298.1651908598659;
        Sat, 07 May 2022 00:29:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6zyyjvdb04McBRtO/l+dSnznvjqrzI5TOG6sFL7Mj4n4HhIA4yK6NrcASe2/jG84Fx3yZAw==
X-Received: by 2002:a05:622a:5c8:b0:2f3:c946:b0bd with SMTP id d8-20020a05622a05c800b002f3c946b0bdmr5050186qtb.298.1651908598409;
        Sat, 07 May 2022 00:29:58 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b002f3ce9c0601sm650760qti.3.2022.05.07.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:29:57 -0700 (PDT)
Date:   Sat, 7 May 2022 15:29:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Rishabh Dave <ridave@redhat.com>
Cc:     fstests@vger.kernel.org, jlayton@redhat.com, rishabhddave@gmail.com
Subject: Re: [PATCHv2] cephfs: add ceph-fuse suport for ceph-fuse
Message-ID: <20220507072952.dmtr3chfeofthorx@zlang-mailbox>
Mail-Followup-To: Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org,
        jlayton@redhat.com, rishabhddave@gmail.com
References: <20220506150141.333929-1-ridave@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506150141.333929-1-ridave@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 06, 2022 at 08:31:42PM +0530, Rishabh Dave wrote:
> Currently tests in xfstests-dev can be executed against CephFS only by
> mounting CephFS using kernel driver. Attempting to run tests against
> CephFS using FUSE doesn't work because xfstests-dev would remount CephFS
> using kernel. This patch adds the ability for xfstest-dev code to mount
> CephFS using FUSE.
> 
> Fixes: https://tracker.ceph.com/issues/55354
> Signed-off-by: Rishabh Dave <ridave@redhat.com>
> ---

This patch has been merged, refer to 1dac95cb ("cephfs: add ceph-fuse suport
for ceph-fuse") in fstests for-next branch. And I've helped to fix that ";;"
missing problem.

The release [ANNOUNCE] is:
https://lore.kernel.org/fstests/20220430190921.7BC56C385A7@smtp.kernel.org/

If you need to fix more issues, please write new patch base on the latest
fstests for-next branch.

Thanks,
Zorro

>  common/config |  2 ++
>  common/rc     | 47 +++++++++++++++++++++++++++++++++++------------
>  2 files changed, 37 insertions(+), 12 deletions(-)
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
> index 553ae350..a8252c7f 100644
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
> @@ -1870,6 +1891,8 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	ceph-fuse)
> +		;;
>  	cifs)
>  		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> @@ -3204,7 +3227,7 @@ _check_test_fs()
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> -    ceph)
> +    ceph|ceph-fuse)
>  	# no way to check consistency for CephFS
>  	;;
>      glusterfs)
> -- 
> 2.34.1
> 

