Received: from sandeen.net ([63.231.237.45]:32780 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeCVUh7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Mar 2018 16:37:59 -0400
Subject: Re: [PATCH] xfs/278: mkfs with v4 format
References: <bde6f5a1-1107-9c03-402d-486bfbdcbd35@redhat.com>
 <20180322202644.GE4810@magnolia>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <1083054b-f89c-57a0-d9d2-d254baf3bd57@sandeen.net>
Date: Thu, 22 Mar 2018 15:37:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180322202644.GE4810@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 3/22/18 3:26 PM, Darrick J. Wong wrote:
> 
>>> parsing error
>>> field u not found
>>> parsing error
>>
>> ...
>>
>> Switch back to the original behavior by turning off crcs,
>> and catch such failures if they crop up again by looking
>> for xfs_db errors in $seqres.full.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> (is it horrific to grep $seqres.full?  xfs_db doesn't exit
>> with failure in this case :( )
>>
>> and now this causes repair to fail on a verifier error, but
>> I just sent an xfsprogs patch to fix that as well.
>>
>> diff --git a/tests/xfs/278 b/tests/xfs/278
>> index b94ee9c..c0e09c7 100755
>> --- a/tests/xfs/278
>> +++ b/tests/xfs/278
>> @@ -48,7 +48,7 @@ _supported_os Linux
>>  _require_scratch
>>  
>>  rm -f $seqres.full
>> -_scratch_mkfs >$seqres.full 2>&1
>> +_scratch_mkfs -m crc=0 -n ftype=0 >$seqres.full 2>&1
> 
> This is still a problem on v5 filesystems, isn't it?

... but the above makes it V4, right?

> 
>>  _scratch_mount
>>  
>>  mkdir -p $SCRATCH_MNT/dir/subdir
>> @@ -73,6 +73,8 @@ _scratch_xfs_db -x -c "inode $DIR_INO" -c "write core.nlinkv2 0"  >> $seqres.ful
>>  _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write u.sfdir2.hdr.parent.i4 0"  >> $seqres.full
> 
> So I think the problem here is that between v4 and v5 the field names
> changed slightly?
> 
> u.sfdir2.hdr.parent.i4 vs. u3.sfdir3.hdr.parent.i4?
> 
> So we ought to be able to _scratch_xfs_get_metadata_field to see if the
> v4 field name exists, then _scratch_xfs_set_metadata_field with the
> appropriate name to set the field?
> 
> ino_loc="inode $SUBDIR_INO"
> if [ -n "$(_scratch_xfs_get_metadata_field "u.sfdir2.hdr.parent.i4" "$ino_loc" ]; then
> 	_scratch_xfs_set_metadata_field "u.sfdir2.hdr.parent.i4" 0 "$ino_loc"
> else
> 	_scratch_xfs_set_metadata_field "u3.sfdir3.hdr.parent.i4" 0 "$ino_loc"
> fi
> 
> Or something like that.
> 

yeah, could do, is it worth it?  Trying to exercise repair's lost+found behavior,
I'm not sure how valuable it is to add a bunch of code to handle every possible
format to get to the same endpoint...

My original plan was to just constrain the test to a known quantity to test
the target functionality that way ...

-Eric
