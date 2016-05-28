Received: from mx1.redhat.com ([209.132.183.28]:57568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbcE1Qml (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 28 May 2016 12:42:41 -0400
Date: Sun, 29 May 2016 00:42:39 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 1/2] common/rc: add functions to check or write objects
 under /sys/fs
Message-ID: <20160528164239.GB5507@dhcp12-143.nay.redhat.com>
References: <1464362482-7704-1-git-send-email-zlang@redhat.com>
 <07e71f2f-229e-e8bf-3b73-546bef86f98b@sandeen.net>
 <8311236a-820b-473d-7aab-2afa8c24a4af@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8311236a-820b-473d-7aab-2afa8c24a4af@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 27, 2016 at 01:27:56PM -0500, Eric Sandeen wrote:
> On 5/27/16 1:05 PM, Eric Sandeen wrote:
> 
> > So maybe something like this (not tested)
> > 
> > + /* Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTRY */
> > +_require_fs_sys_fs()
> > +{
> > +        local dev=$1
> > +        local target=$2
> > +        local dname=""
> > +        local tmp_mnt=`mktemp -d`
> > +
> > +        if [ ! -b "$dev" -o -z "$target" ];then
> > +	        echo "Usage: _require_fs_sys_fs <device> <sysfs_path>"
> > +                exit 1
> > +        fi
> > +
> > +        dname=$(basename $(readlink -f $dev))
> > +        _mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
> > +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
> > +                umount $tmp_mnt
> > +                rm -f $tmp_mnt
> > +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
> > +        fi
> > +        umount $SCRATCH_MNT
> > +        rm -f $tmp_mnt
> > +}
> > 
> > and it would work for either SCRATCH or TEST?
> 
> I guess nothing guarantees that the device is already mkfs'd, at least
> for scratch, so maybe it also needs to catch a mount failure,
> with a message about "could not mount; mkfs first in your test?"
> or something like that.

Yes, if we don't mkfs in _require_fs_sys_fs(), that means we need the
caller make sure they do that. I will check the mount error likes:

_mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
if [ $? -ne 0 ];then
	rm -f $tmp_mnt
	_notrun "could not mount; mkfs first in your test?"
elif [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
	....
fi

Thanks,
Zorro

> 
> -Eric
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
