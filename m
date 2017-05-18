Received: from mx1.redhat.com ([209.132.183.28]:43140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933649AbdERLfO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 May 2017 07:35:14 -0400
Date: Thu, 18 May 2017 19:35:10 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] Add support for UBIFS
Message-ID: <20170518113510.GM7250@eguan.usersys.redhat.com>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
 <20170517095531.11818-2-david.oberhollenzer@sigma-star.at>
 <20170517115355.GE7250@eguan.usersys.redhat.com>
 <20170517184535.GB91213@gmail.com>
 <7fb3a661-98b5-cb7e-3994-722ae7be0832@sigma-star.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb3a661-98b5-cb7e-3994-722ae7be0832@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: Eric Biggers <ebiggers3@gmail.com>, fstests@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at
List-ID: <fstests@vger.kernel.org>

On Thu, May 18, 2017 at 10:41:27AM +0200, David Oberhollenzer wrote:
> On 05/17/2017 01:53 PM, Eryu Guan wrote:
> > On Wed, May 17, 2017 at 11:55:29AM +0200, David Oberhollenzer wrote:
> >>  	-g)	group=$2 ; shift ;
> >>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> >> diff --git a/common/config b/common/config
> >> index 59041a39..6c58e888 100644
> >> --- a/common/config
> >> +++ b/common/config
> >> @@ -336,6 +336,9 @@ _mount_opts()
> >>  		# We need to specify the size at mount, use 1G by default
> >>  		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
> >>  		;;
> >> +	ubifs)
> >> +		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
> >> +		;;
> >>  	*)
> >>  		;;
> >>  	esac
> >> @@ -475,6 +478,10 @@ _check_device()
> >>  		if [ ! -d "$dev" ]; then
> >>  			_fatal "common/config: $name ($dev) is not a directory for overlay"
> >>  		fi
> >> +	elif [ "$FSTYP" == "ubifs" ]; then
> >> +		if [ ! -c "$dev" ]; then
> >> +			_fatal "common/config: $name ($dev) is not a character device"
> >> +		fi
> >>  	else
> >>  		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
> > 
> > This error message should be updated too. And turning this if-elif-fi
> > block to a case switch on $FSTYP seems cleaner.
> > 
> > And you need to setup MKFS_UBIFS_PROG and all other needed tools in
> > common/config too, and check if the tools are available in common/rc and
> > abort if the required tools are not met. e.g.
> > 
> > [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> > 
> 
> mkfs.ubifs itself isn't needed as empty ubi volumes are formated when
> mounting them with UBIFS.

But there's still a mkfs.ubifs binary, right? I searched fstests mail
archive and found that Dongsheng Yang did set MKFS_UBIFS_PROG in his
patch in 2015. Then I suspect if mkfs.ubifs binary is unavailable, then
_scratch_mkfs would complain mkfs.ubifs not found and fail the test.

If it's not needed or there's no mkfs.ubifs exists, then _scratch_mkfs
needs some updates I guess, and describe this in commit log too, because
it's too different from other block device based local filesystems.

> 
> I think it would make sense to add a check for ubiupdatevol to
> _require_scratch_encryption (used in _scratch_mkfs_encrypted to
> whipe an existing volume).

Agreed.

> 
> 
> On 05/17/2017 08:45 PM, Eric Biggers wrote:
> > On Wed, May 17, 2017 at 07:53:55PM +0800, Eryu Guan wrote:
> >> As being pointed out in previous reviews, it'll be great if we can probe
> >> ubifs from the char device if possible instead of adding new fs-specific
> >> option, just as what we're doing at the end of common/config for other
> >> local filesystems. But I'm not sure if blkid works for char device and
> >> ubifs (probably not).
> >>
> > 
> > It seems to work fine without the -ubifs option:
> > 
> > # blkid -o value -s TYPE /dev/ubi0_0
> > ubifs
> 
> I can't really reproduce this on my end. Neither on my Debian test VM,
> nor on the OpenSUSE system that I'm working on right now. I get no
> output from blkid, neither before nor after mounting the ubi volume.
> 
> To be fair, the Debian version (and thus its blkid version) is rather
> old (blkid 1.0.0 (12-Feb-2003)), but the one on OpenSUSE seems to be
> fairly recent:
> 
> $ blkid -v
> blkid from util-linux 2.28  (libblkid 2.28., 12-Apr-2016)
> 
> 
> Would it make sense to patch the check in common/config instead,
> to default to ubifs if FSTYP is not set and the target is a
> character device? Or simply require on FSTYP to be set in the
> config file?

If there's really no standard way to probe for ubifs, a "-ubifs" option
would be the only choice I think, and better to have some comments too.

Thanks,
Eryu
