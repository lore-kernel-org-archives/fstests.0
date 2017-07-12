Received: from mx1.redhat.com ([209.132.183.28]:37732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbdGLMNm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Jul 2017 08:13:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D69853DBC1
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2017 12:13:41 +0000 (UTC)
Date: Wed, 12 Jul 2017 14:13:38 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] xfstests: Test filesystem lockup on full overprovisioned
 dm-thin
Message-ID: <20170712121338.gtkhowgny2syjdvu@eorzea.usersys.redhat.com>
References: <20170712080527.826-1-cmaiolino@redhat.com>
 <20170712091438.GA7015@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712091438.GA7015@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Ugh, sorry, I missed these comments during my past reply

> > +
> > +_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> 
> Sorry, I should've asked earlier in your RFC patch.. can all these setup
> work be done with helpers in common/dmthin? e.g. _dmthin_init,
> _dmthin_grow, the backing dev size, virtual size etc. are handled
> properly in dmthin helpers. You could take generic/347 as an example.
> 

I could do that if strictly required, but I'll also need to add a new dmthin
helper to create snapshots, once this tests requires a snapshot. IIRC, LVM uses
some 'tricks' to create snapshots (see device-mapper doc in kernel source), so
this might add unneeded complexity to the test.

I can use the helpers in common/dmthin for sure, but if this is not strictly
required, I'd just stay with LVM instead of using device-mapper directly.


> > +
> > +
> > +$LVM_PROG lvcreate  -k n -s $vgname/$lvname \
> > +		    -n $snapname >>$seqres.full 2>&1
> > +
> > +_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT
> > +
> > +# Consume all space available in the volume and freeze to ensure everything
> > +# required to make the fs consistent is flushed to disk.
> > +$XFS_IO_PROG -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
> > +
> > +# In XFS, this freeze will never complete until the dm-thin POOL device is
> > +# extended. It is expected, and is only used so xfsaild is triggered to
> > +# flush AIL items, other filesystems usually get remounted as read-only during
> > +# the above write process.
> > +fsfreeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
> > +freezeid=$!
> > +
> > +# Wait enough so xfsaild can run
> > +sleep 10
> > +
> > +# Make some extra space available so the freeze above can proceed
> > +$LVM_PROG lvextend -L $newpsize $vgname/$poolname >>$seqres.full 2>&1
> > +
> > +wait -n $freezeid
> 
> Just "wait $freezeid", no '-n' is needed.
> 

np.

> > +ret=$?
> > +
> > +
> > +# Different filesystems will handle the lack of real space in different ways,
> > +# some will remount the filesystem in read-only mode, some will not. These tests
> > +# will check if:
> > +#	- The filesystem turns into Read-Only and reject further writes
> > +#	- The filesystem stays in Read-Write mode, but can be frozen/thawed
> > +#	  without getting stuck.
> > +ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
> > +
> > +if [ $ret -ne 0 ]; then
> > +	if [ -n "$ISRO" ]; then
> > +		echo "Test OK"
> > +	else
> > +		echo "Freeze failed and FS isn't Read-Only. Test Failed"
> > +		status=1
> > +		exit
> > +	fi
> > +else
> > +	# Try to thaw the filesystem, and complete test if if succeed.
> > +	# NOTE: This will hang on affected XFS filesystems.
> > +	fsfreeze -u $SCRATCH_MNT >>$seqres.full 2>&1
> > +	echo "Test OK"
> > +fi
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/447.out b/tests/generic/447.out
> > new file mode 100644
> > index 0000000..3531fb9
> > --- /dev/null
> > +++ b/tests/generic/447.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 447
> > +Test OK
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 8c1e21a..6a360fa 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -449,3 +449,4 @@
> >  444 auto quick acl
> >  445 auto quick rw
> >  446 auto quick rw dangerous
> > +447 auto dangerous
> 
> Then I'll merge it only when the fix is upstream :)
> 
yup, I was expecting that :)

-- 
Carlos
