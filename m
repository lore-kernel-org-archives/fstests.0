Received: from aserp2120.oracle.com ([141.146.126.78]:39582 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeCVU0s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Mar 2018 16:26:48 -0400
Date: Thu, 22 Mar 2018 13:26:44 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/278: mkfs with v4 format
Message-ID: <20180322202644.GE4810@magnolia>
References: <bde6f5a1-1107-9c03-402d-486bfbdcbd35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde6f5a1-1107-9c03-402d-486bfbdcbd35@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>


> > parsing error
> > field u not found
> > parsing error
> 
> ...
> 
> Switch back to the original behavior by turning off crcs,
> and catch such failures if they crop up again by looking
> for xfs_db errors in $seqres.full.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> (is it horrific to grep $seqres.full?  xfs_db doesn't exit
> with failure in this case :( )
> 
> and now this causes repair to fail on a verifier error, but
> I just sent an xfsprogs patch to fix that as well.
> 
> diff --git a/tests/xfs/278 b/tests/xfs/278
> index b94ee9c..c0e09c7 100755
> --- a/tests/xfs/278
> +++ b/tests/xfs/278
> @@ -48,7 +48,7 @@ _supported_os Linux
>  _require_scratch
>  
>  rm -f $seqres.full
> -_scratch_mkfs >$seqres.full 2>&1
> +_scratch_mkfs -m crc=0 -n ftype=0 >$seqres.full 2>&1

This is still a problem on v5 filesystems, isn't it?

>  _scratch_mount
>  
>  mkdir -p $SCRATCH_MNT/dir/subdir
> @@ -73,6 +73,8 @@ _scratch_xfs_db -x -c "inode $DIR_INO" -c "write core.nlinkv2 0"  >> $seqres.ful
>  _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write u.sfdir2.hdr.parent.i4 0"  >> $seqres.full

So I think the problem here is that between v4 and v5 the field names
changed slightly?

u.sfdir2.hdr.parent.i4 vs. u3.sfdir3.hdr.parent.i4?

So we ought to be able to _scratch_xfs_get_metadata_field to see if the
v4 field name exists, then _scratch_xfs_set_metadata_field with the
appropriate name to set the field?

ino_loc="inode $SUBDIR_INO"
if [ -n "$(_scratch_xfs_get_metadata_field "u.sfdir2.hdr.parent.i4" "$ino_loc" ]; then
	_scratch_xfs_set_metadata_field "u.sfdir2.hdr.parent.i4" 0 "$ino_loc"
else
	_scratch_xfs_set_metadata_field "u3.sfdir3.hdr.parent.i4" 0 "$ino_loc"
fi

Or something like that.

--D

>  _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write core.nlinkv2 0"  >> $seqres.full
>  
> +grep -q "not found\|parsing error" $seqres.full && _fail "xfs_db commands failed"
> +
>  echo "===== BEGIN of xfs_repair =====" >> $seqres.full
>  echo "" >>$seqres.full
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
