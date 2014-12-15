Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:45530 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbaLOVjT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 16:39:19 -0500
Message-ID: <548F5505.4050807@sandeen.net>
Date: Mon, 15 Dec 2014 15:39:17 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] Reiser4 initial implementation
References: <alpine.LNX.2.00.1412152315300.21847@reiser4.gekom> <20141215210631.GT24183@dastard>
In-Reply-To: <20141215210631.GT24183@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Dushan Tcholich <dusanc@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/15/14 3:06 PM, Dave Chinner wrote:
> On Mon, Dec 15, 2014 at 11:19:43PM +0100, Dushan Tcholich wrote:
>>
>> This is initial xfstests implementation for Reiser4 filesystem.
>>
> 
> Policy question to the wider audience: should we support out of tree
> filesystems in fstests? I can't verify the patches nor maintain
> support for such filesystems, nor is there a wide developer or
> distro demand for testing such filesystems. If there's only one or
> two developers that need support for reiser4, then it might be best
> for to maintain the xfstests patches out of tree, too.
> 
> What does everyone think?

I think you have your hands completely full with in-tree filesystems,
and opening the door to many new tests for out-of-tree filesystems could
lead to Too Much Work.

But simply adding the simple things in this patch to make generic tests
work seems fairly harmless; it should be a one-shot deal, with no ongoing load.
So from where I sit I don't see a big problem with a patch like this.

Adding a lot of reiser4 specific tests is probably a different question,
though.

In theory it shouldn't be hard for out-of-tree filesystems to maintain
their own tree of tests which could just drop in under tests/ right?

-Eric

>> Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
>>
>> --- xfstests.orig/common/rc	2014-12-14 15:17:59.000000000 +0100
>> +++ xfstests/common/rc	2014-12-15 19:40:36.000000000 +0100
>> @@ -622,7 +622,7 @@
>>      xfs)
>>  	def_blksz=`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
>>  	;;
>> -    ext2|ext3|ext4|ext4dev|udf|btrfs)
>> +    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4)
>>  	def_blksz=`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
>>  	;;
>>      esac
>> @@ -640,6 +640,7 @@
>>      fi
>>  
>>      blocks=`expr $fssize / $blocksize`
>> +    fssizeK=`expr $fssize / 1024`K
> 
> Is mkfs.resier4 really unable to take a byte or block size count for
> the filesystem size?
> 
>>  
>>      if [ "$HOSTOS" == "Linux" ]; then
>>  	devsize=`blockdev --getsize64 $SCRATCH_DEV`
>> @@ -665,6 +666,9 @@
>>      btrfs)
>>  	$MKFS_BTRFS_PROG $MKFS_OPTIONS -b $fssize $SCRATCH_DEV
>>  	;;
>> +    reiser4)
>> +        ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV $fssizeK 
>> +        ;;
> 
> You need to add support for MKFS_REISER4_PROG, etc. into
> common/config
> 
>>      *)
>>  	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
>>  	;;
>>
>> --- xfstests.orig/common/config	2014-12-14 15:17:59.000000000 +0100
>> +++ xfstests/common/config	2014-12-12 13:27:40.000000000 +0100
>> @@ -258,6 +256,9 @@
>>  		# acls & xattrs aren't turned on by default on reiserfs
>>  		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
>>  		;;
>> +	reiser4)
>> +		export MOUNT_OPTIONS=$REISER4_MOUNT_OPTIONS
>> +		;;
>>  	gfs2)
>>  		# acls aren't turned on by default on gfs2
>>  		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
>> @@ -302,6 +303,9 @@
>>  	reiserfs)
>>  		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
>>  		;;
>> +	reiser4)
>> +                export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
>> +                ;;
> 
> whitespae damage.
> 
>>  	gfs2)
>>  		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
>>  		;;
>> @@ -322,6 +326,9 @@
>>  	reiserfs)
>>  		export FSCK_OPTIONS="--yes"
>>  		;;
>> +	reiser4)
>> +                export FSCK_OPTIONS="--yes"
>> +                ;;
> 
> Whitespace damage. You could also just do:
> 
> -	reiserfs)
> +	reiser*)
> 
> You also need to add the setup checks to the top of common/rc (i.e
> after the "check for correct setup" comment).
> 
> Cheers,
> 
> Dave.
> 

