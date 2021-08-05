Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E0C4338F
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Aug 2021 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F24560F02
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Aug 2021 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhHEToK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Aug 2021 15:44:10 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:59690 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhHEToJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Aug 2021 15:44:09 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 15:44:09 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 175JTYam123845;
        Thu, 5 Aug 2021 22:34:44 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 3a8bpe0dcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 22:34:43 +0300
Received: from [192.168.0.129] (62.78.240.173) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 5 Aug
 2021 22:34:43 +0300
Subject: Re: [PATCH RFC] add support for ntfs and ntfs3 file systems
References: <YQoVXWRFGeY19onQ@mit.edu>
To:     <fstests@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
From:   Ari Sundholm <ari@tuxera.com>
Message-ID: <6a086408-4ac2-f360-9aec-d258140abb1c@tuxera.com>
Date:   Thu, 5 Aug 2021 22:34:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQoVXWRFGeY19onQ@mit.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [62.78.240.173]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-GUID: lovQixx8KFrdH1ffzxsjczJaZZQ_DENz
X-Proofpoint-ORIG-GUID: lovQixx8KFrdH1ffzxsjczJaZZQ_DENz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_10:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050115
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi, Theodore!

Thank you for your patch. I read it with great interest, as I was 
working on something related myself.

Comments inline.

On 8/4/21 7:19 AM, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> Here are some patches which add support for testing the fuse ntfs
> implementation (shipped in the ntfs-3g package) as well as Paragon
> Software's proposed ntfs3 kernel submission.
> 
> Context: https://lore.kernel.org/r/YQnHxIU+EAAxIjZA@mit.edu
> Sample test run: https://www.kernel.org/pub/linux/kernel/people/tytso/fstests-results/results-ntfs3-2021-08-03.tar.xz
> 
>   common/config |  1 +
>   common/rc     | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 005fd50a..80510df2 100644
> --- a/common/config
> +++ b/common/config
> @@ -271,6 +271,7 @@ export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
>   export E2FSCK_PROG=$(type -P e2fsck)
>   export TUNE2FS_PROG=$(type -P tune2fs)
>   export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
> +export MKFS_NTFS_PROG=$(type -P mkfs.ntfs)
>   

This seems to work for Debian and last two Ubuntu LTS releases, although 
they seem to always be symlinks to mkntfs. Anyway, assuming the 
mkfs.$FSTYP pattern is probably a safe bet.

>   # SELinux adds extra xattrs which can mess up our expected output.
>   # So, mount with a context, and they won't be created.
> diff --git a/common/rc b/common/rc
> index 0fabea45..12e94b1c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -140,6 +140,10 @@ case "$FSTYP" in
>   	 ;;
>       pvfs2)
>   	;;
> +    ntfs)
> +	;;
> +    ntfs3)
> +	;;

Based on the description above the diffstat, these are the $FSTYP values 
used for ntfs-3g and ntfs3, respectively, correct?

I think it might be a good idea to simply call ntfs-3g ntfs-3g, as that 
is probably less likely to cause confusion with the in-tree ntfs driver.

>       ubifs)
>   	[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
>   	;;
> @@ -690,6 +694,9 @@ _test_mkfs()
>       ext2|ext3|ext4)
>   	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>   	;;
> +    ntfs|ntfs3)
> +	$MKFS_NTFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> +	;;
>       *)
>   	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
>   	;;
> @@ -729,6 +736,9 @@ _mkfs_dev()
>   	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* \
>   		2>$tmp.mkfserr 1>$tmp.mkfsstd
>   	;;
> +    ntfs|ntfs3)
> +        $MKFS_NTFS_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
> +	;;
>       *)
>   	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
>   		2>$tmp.mkfserr 1>$tmp.mkfsstd
> @@ -826,6 +836,10 @@ _scratch_mkfs()
>   		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>   		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
>   		;;
> +	ntfs|ntfs3)
> +		mkfs_cmd="$MKFS_NTFS_PROG"
> +		mkfs_filter="cat"
> +		;;
>   	*)
>   		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>   		mkfs_filter="cat"

Apart from the naming thing, these three hunks are essentially identical 
to what I have been working on, so looks OK.

> @@ -1091,6 +1105,10 @@ _scratch_mkfs_sized()
>   	bcachefs)
>   		$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
>   		;;
> +	ntfs|ntfs3)
> +		${MKFS_NTFS_PROG} $MKFS_OPTIONS $SCRATCH_DEV \
> +			$(expr $blocks / 2)
> +		;;
>   	*)
>   		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
>   		;;

Hmm. I do not think this will work. mkntfs takes the number of sectors 
on the volume as its last (optional) command line parameter before the 
device.

Given that blocks=$((fssize / blocksize)), the calculation above will 
essentially assume that the sector size is equal to that of 2 blocks. 
This is unlikely to be true in general.

The calculation is a bit more involved than that, as we need to consider 
both the block size requested as well as the (logical) sector size of 
the device on which the volume is to be created.

We can consider the NTFS cluster size to be the rough equivalent of 
blocksize here, but we also have to find out the sector size of the 
device to tell how many sectors the volume should contain.

Thus, given a device with the logical sector size sector_size and a 
testcase-specified value for blocksize and fssize,
NTFS cluster size = blocksize
Sectors per NTFS cluster = blocksize / sector_size
Length of volume in blocks = fssize / blocksize (truncating)
Length of volume in sectors = fssize / sector_size

Let num_sectors = length of volume in sectors

Then the invocation should be:
mkntfs -s sector_size -c blocksize num_sectors /dev/foo

(The "-s sector_size" part can usually be left out, as mkntfs 
auto-detects the sector size)

I hope the above makes sense. :)

> @@ -1173,6 +1191,9 @@ _scratch_mkfs_blocksized()
>   		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize \
>   								$SCRATCH_DEV
>   		;;
> +	ntfs|ntfs3)
> +		${MKFS_NTFS_PROG} -F $MKFS_OPTIONS -s $blocksize $SCRATCH_DEV
> +		;;
>   	*)
>   		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
>   		;;

This should probably use -c $blocksize instead of -s $blocksize.

> @@ -1247,6 +1268,10 @@ _repair_scratch_fs()
>   	# want the test to fail:
>   	_check_scratch_fs
>   	;;
> +    ntfs|ntfs3)
> +	$FSCK_NTFS_PROG $SCRATCH_DEV
> +	return $?
> +	;;
>       *)
>   	local dev=$SCRATCH_DEV
>   	local fstyp=$FSTYP > @@ -1294,6 +1319,10 @@ _repair_test_fs()
>   			res=$?
>   		fi
>   		;;
> +	ntfs|ntfs3)
> +		$FSCK_NTFS_PROG $TEST_DEV > $tmp.repair 2>&1
> +		return $?
> +		;;
>   	*)
>   		# Let's hope fsck -y suffices...
>   		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1

I do not think I see a value having been set for FSCK_NTFS_PROG in this 
patch? It probably should be set to ntfsfix, in the absence of a more 
comprehensive tool.

> @@ -1433,8 +1462,11 @@ _fs_type()
>       # Fix the filesystem type up here so that the callers don't
>       # have to bother with this quirk.
>       #
> -    _df_device $1 | $AWK_PROG '{ print $2 }' | \
> -        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
> +    local sed_prog="-e s/nfs4/nfs/ -e s/fuse.glusterfs/glusterfs/"
> +    if [ $FSTYP = ntfs ]; then
> +	sed_prog="$sed_prog -e s/fuseblk/ntfs/"
> +    fi
> +    _df_device $1 | $AWK_PROG '{ print $2 }' | sed $sed_prog
>   }
>   
>   # return the FS mount options of a mounted device

We could perhaps use the subtype mount option for ntfs-3g and other FUSE 
drivers, to be able to differentiate between different FUSE drivers 
here. Then we might see something like "fuseblk.mynicefs" and translate 
it to "mynicefs".

This does require a reverse mapping, too, which gets us to...

> @@ -2897,6 +2929,9 @@ _is_dev_mounted()
>   		exit 1
>   	fi
>   
> +	if [ $fstype = ntfs ]; then
> +	    fstype=fuseblk
> +	fi
>   	findmnt -rncv -S $dev -t $fstype -o TARGET | head -1
>   }
>   

It would be nice if we had a function that takes care of the reverse 
mapping instead of adding special cases in every function for every 
filesystem that requires this. I have sent you a patch with my suggested 
approach.

> @@ -3017,11 +3052,15 @@ _pre_fsck_prepare()
>   _check_generic_filesystem()
>   {
>       local device=$1
> +    local fsck_type=$2
>   
>       # If type is set, we're mounted
>       local type=`_fs_type $device`
>       local ok=1
>   
> +    if [ -z "$fsck_type" ]; then
> +       fsck_type="$FSTYP"
> +    fi
>       if [ "$type" = "$FSTYP" ]
>       then
>           # mounted ...
> @@ -3029,7 +3068,7 @@ _check_generic_filesystem()
>       fi
>   
>       _pre_fsck_prepare $device
> -    fsck -t $FSTYP $FSCK_OPTIONS $device >$tmp.fsck 2>&1
> +    fsck -t $fsck_type $FSCK_OPTIONS $device >$tmp.fsck 2>&1
>       if [ $? -ne 0 ]
>       then
>   	_log_err "_check_generic_filesystem: filesystem on $device is inconsistent"
> @@ -3150,6 +3189,9 @@ _check_test_fs()
>       btrfs)
>   	_check_btrfs_filesystem $TEST_DEV
>   	;;
> +    ntfs|ntfs3)
> +	_check_generic_filesystem $TEST_DEV $ntfs
> +	;;
>       tmpfs)
>   	# no way to check consistency for tmpfs
>   	;;
> @@ -3211,6 +3253,9 @@ _check_scratch_fs()
>       btrfs)
>   	_check_btrfs_filesystem $device
>   	;;
> +    ntfs|ntfs3)
> +	_check_generic_filesystem $device ntfs
> +	;;
>       tmpfs)
>   	# no way to check consistency for tmpfs
>   	;;
> 

The reverse mapping might let us eliminate the newly added extra 
parameter for _check_generic_filesystem().

I hope this was of some help, and hopefully I did not appear overly 
critical. :)

Best regards,
Ari Sundholm
ari@tuxera.com
