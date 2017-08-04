Received: from sandeen.net ([63.231.237.45]:40222 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdHDCVV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Aug 2017 22:21:21 -0400
Subject: Re: [PATCH Ve] xfs: test xfs_metadump for leaked strings
References: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
 <4e801980-9ea5-efaf-f45c-d98df8f1f7e3@sandeen.net>
 <8c54de65-b80f-1581-6b55-8c8100ca9ffd@sandeen.net>
 <20170802172922.GA4474@magnolia>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <2f9565b8-e559-3391-544e-7f6b28e99a22@sandeen.net>
Date: Thu, 3 Aug 2017 21:21:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170802172922.GA4474@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 8/2/17 12:29 PM, Darrick J. Wong wrote:
> On Tue, Aug 01, 2017 at 10:45:06PM -0500, Eric Sandeen wrote:
>> xfs_metadump by default sanitizes the image so that all strings
>> longer than 5 chars are obfusccated, and all stale data in metadata
>> blocks (i.e. unused/unwritten data) is zeroed out.  We didn't have
>> a test for this, though, so this does it.
>>
>> It patterns 256M of the scratch device, then uses djwong's
>> populate infrastructure to write all types of metadata,
>> metadumps & mdrestores it, then looks for either the leaked
>> pre-pattern or any leaked strings or filenames.
>>
>> The strings we look for are, unfortunately, a bit ad-hoc based on
>> what is currently used in the populate routines.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> V2: include .out file, minor whitespace & typo edits
>> V3: remove populate debug stuff that snuck in


>> +echo "Silence is golden"
>> +
>> +# Pattern the scratch disk, mkfs, and restore.
>> +$XFS_IO_PROG -d -c "pwrite 0 256M" $SCRATCH_DEV > $seqres.full 2>&1
> 
> pwrite -b 1m to speed this up a bit...

ok
 
>> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_populate nofill >> $seqres.full 2>&1
>> +
>> +# populate unmounts the fs for us
>> +
>> +_scratch_metadump $METADUMP_FILE
>> +xfs_mdrestore $METADUMP_FILE $MDRESTORE_FILE
>> +
>> +# Grep for stale data (leaked cd cd pattern) or strings
>> +# from populate routine
>> +
>> +hexdump -C $MDRESTORE_FILE | grep \
> 
> _require_command /usr/bin/hexdump "hexdump" ?

sure? other tests don't bother, but ok.

> 
>> +"cd cd cd cd\| \
>> +41 41 41 41\|\
>> +42 42 42 42\|\
>> +43 43 43 43\|\
>> +44 44 44 44\|\
>> +61 61 61 61\|\
>> +62 62 62 62\|\
>> +63 63 63 63\|\
>> +64 64 64 64\|\
>> +dummy\|\
>> +S_IF\|\
>> +FMT_\|\
>> +INLINE\|\
>> +BLOCK\|\
>> +LEAF\|\
>> +NODE\|\
>> +BTREE\|\
>> +LOCAL\|\
>> +EXTENTS\|\
>> +REMOTE\|\
>> +ATTR\|\
>> +SYSTEM\|\
>> +TRUSTED\|\
>> +SECURITY\|\
>> +attrvalfile\|\
>> +unused\|\
>> +BNOBT\|\
>> +RMAPBT\|\
>> +RTRMAPBT\|\
>> +REFCOUNTBT" && echo "Leaked data found; see comments in test to debug"
> 
> /me wonders if this grep pattern ought to be some kind of _filter
> function in common/populate?  That way if the xfs populate command adds
> more weird strings, the search pattern is right there in the rc file,
> not buried in tests/xfs/ somewhere.
> 
> OTOH a good counterargument is that this is the only test that cares
> about that, so why make it common code?  <sigh>

um, I totally agree with both your arguments... :/

i'll put it in populate I guess.

> 
> --D
