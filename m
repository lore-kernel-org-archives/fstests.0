Received: from mx1.redhat.com ([209.132.183.28]:34818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbdF2Lys (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Jun 2017 07:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67839C08C308
        for <fstests@vger.kernel.org>; Thu, 29 Jun 2017 11:54:48 +0000 (UTC)
Date: Thu, 29 Jun 2017 07:54:47 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] generic/247: filter out expected XFS warnings for mixed
 mmap/direct I/O
Message-ID: <20170629115447.GB3291@bfoster.bfoster>
References: <20170628141442.10950-1-bfoster@redhat.com>
 <20170629061909.GL23360@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629061909.GL23360@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 29, 2017 at 02:19:09PM +0800, Eryu Guan wrote:
> On Wed, Jun 28, 2017 at 10:14:42AM -0400, Brian Foster wrote:
> > generic/247 reproduces some of the same, expected warnings from XFS
> > as generic/095. These warnings occur due to mixed buffered/mapped
> > I/O racing with direct I/O to the same file.
> > 
> > generic/095 contains a custom dmesg filter to prevent test failure
> > in the event of such warnings. Lift the helper from generic/095 to
> > common/xfs and reuse it in generic/247 to implement the same
> > behavior.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> Thanks a lot for doing this! It was in my todo list but I never got to
> it..
> 
> Some minor issues below, that I can fix them all at commit time.
> 

Ok.. the fixes look fine to me.. thanks!

Brian

> > ---
> >  common/xfs        | 18 ++++++++++++++++++
> >  tests/generic/095 | 20 +++-----------------
> >  tests/generic/247 | 11 +++++++++--
> >  3 files changed, 30 insertions(+), 19 deletions(-)
> > 
> > diff --git a/common/xfs b/common/xfs
> > index 0f0825b..0266f50 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -584,3 +584,21 @@ _require_xfs_mkfs_ciname()
> >  	_scratch_mkfs_xfs_supported -n version=ci >/dev/null 2>&1 \
> >  		|| _notrun "need case-insensitive naming support in mkfs.xfs"
> >  }
> > +
> > +# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
> > +# direct IO on the same file. This is a helper for _check_dmesg() to filter out
> > +# such warnings.
> > +filter_xfs_dmesg()
> 
> I've renamed it, added a leading underscore _filter_xfs_dmesg, it's
> common helper now.
> 
> > +{
> > +	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
> > +	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
> > +	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
> > +	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
> > +	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
> > +	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
> > +	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
> > +	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
> > +	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
> > +	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#"
> > +}
> > +
> > diff --git a/tests/generic/095 b/tests/generic/095
> > index d837564..9580aaf 100755
> > --- a/tests/generic/095
> > +++ b/tests/generic/095
> > @@ -117,28 +117,14 @@ _scratch_mount
> >  echo "Silence is golden"
> >  $FIO_PROG $fio_config >>$seqres.full 2>&1
> >  
> > +# umount before checking dmesg in case umount triggers any WARNING or Oops
> > +_scratch_unmount
> > +
> >  # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
> >  # direct IO on the same file. On the other hand, this fio job has been proven
> >  # to be potent, we don't want to simply _disable_dmesg_check which could miss
> >  # other potential bugs. So filter out the intentional WARNINGs, make sure test
> >  # doesn't fail because of this warning and fails on other WARNINGs.
> > -filter_xfs_dmesg()
> > -{
> > -	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
> > -	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
> > -	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
> > -	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
> > -	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
> > -	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
> > -	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
> > -	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
> > -	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
> > -	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#"
> > -}
> > -
> > -# umount before checking dmesg in case umount triggers any WARNING or Oops
> > -_scratch_unmount
> > -
> >  if [ "$FSTYP" == "xfs" ]; then
> >  	_check_dmesg filter_xfs_dmesg
> >  else
> > diff --git a/tests/generic/247 b/tests/generic/247
> > index 832ade1..f46ab30 100755
> > --- a/tests/generic/247
> > +++ b/tests/generic/247
> > @@ -80,6 +80,13 @@ wait
> >  
> >  echo "Silence is golden."
> >  
> > -# success, all done
> > -status=0
> > +# unmount and check dmesg, filtering out expected XFS warnings about mixed
> > +# mmap/dio
> > +_scratch_unmount
> 
> generic/247 doesn't take use of SCRATCH_DEV, _scratch_unmount and the
> associated comment can be removed.
> 
> Thanks,
> Eryu
> 
> > +if [ "$FSTYP" == "xfs" ]; then
> > +	_check_dmesg filter_xfs_dmesg
> > +else
> > +	_check_dmesg
> > +fi
> > +status=$?
> >  exit
> > -- 
> > 2.9.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
