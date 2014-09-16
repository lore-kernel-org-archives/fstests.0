Return-Path: <fstests-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbaIPNuy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Sep 2014 09:50:54 -0400
Message-ID: <5418403A.8020004@nod.at>
Date: Tue, 16 Sep 2014 15:50:50 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH] Add UBIFS support
References: <1410772280-9771-1-git-send-email-richard@nod.at> <20140915215218.GH4322@dastard>
In-Reply-To: <20140915215218.GH4322@dastard>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

Am 15.09.2014 23:52, schrieb Dave Chinner:
> On Mon, Sep 15, 2014 at 11:11:20AM +0200, Richard Weinberger wrote:
>> UBIFS needs some extra care, the device node is of type character and
>> it has no fsck tool.
> 
> Not being familiar with UBIFS, the explaination is rather brief and
> doesn't explain anything to me. Can you document how where supposed
> to treat a filesystem that doesn't exist on a block device for all
> the tests that assume that the local fileystem is on a block device?
> e.g. how do all the generic tests that use loopback devices work?
> What about dm-flakey?

UBIFS is a filesystem designed for MTD devices.
It works on top of UBI which is kind of a LVM for NAND and NOR flashes.
On Linux MTD devices are represented as character devices, this is why
the UBI device nodes are of type character.
For more details please see:
http://www.linux-mtd.infradead.org/doc/ubi.html
http://www.linux-mtd.infradead.org/doc/ubifs.html

Of course UBIFS will not work on top of loop or dm-flakey.
AFAIK the generic tests don't use them anyway.

I'd like to have UBIFS tested with xfstests because xfstests has a very
good set of generic fs tests.
Currently UBIFS fails 20 out of 76 generic tests.
At least one issue is real. As soon I have the time I'll
inspect all other failures in detail.

>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  README        |  1 +
>>  check         |  2 ++
>>  common/config |  4 ++--
>>  common/rc     | 18 ++++++++++++++++++
>>  4 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/README b/README
>> index 8a362bd..96adc44 100644
>> --- a/README
>> +++ b/README
>> @@ -100,6 +100,7 @@ Running tests:
>>        Running all the udf tests: ./check -udf -g udf
>>      - for running nfs tests: ./check -nfs [test(s)]
>>      - for running cifs/smb3 tests: ./check -cifs [test(s)]
>> +    - for running ubifs tests: ./check -ubifs [test(s)]
>>      - To randomize test order: ./check -r [test(s)]
>>  
>>      
>> diff --git a/check b/check
>> index 42a1ac2..57ec612 100755
>> --- a/check
>> +++ b/check
>> @@ -70,6 +70,7 @@ check options
>>      -nfs                test NFS
>>      -cifs               test CIFS
>>      -tmpfs              test TMPFS
>> +    -ubifs              test UBIFS
>>      -l			line mode diff
>>      -udiff		show unified diff (default)
>>      -n			show me, do not run tests
> 
> I'd like to avoid adding command line switches for random filesystem
> types if at all possible. I'd much prefer that it be derived from
> the current TEST_DEV if at all possible. Can you probe for UBIFS
> similar to using blkid for local filesystems?

I fear blkid does not detect UBIFS, but we can match it from the device node name.
UBIFS can only work on top of an UBI volume. UBI volumes have names like /dev/ubiX_Y.
Where X is the UBI image number and Y the volume number.

>> diff --git a/common/config b/common/config
>> index fc21b37..af082ea 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -430,7 +430,7 @@ get_next_config() {
>>  		exit 1
>>  	fi
>>  
>> -	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
>> +	echo $TEST_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
>>  	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
>>  		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
>>  		exit 1
> 
> Needs a comment explaining what format we are searching for there?

See above. I match the string "ubi" in /dev/ubiX_Y.

>> @@ -453,7 +453,7 @@ get_next_config() {
>>  		export SCRATCH_DEV_NOT_SET=true
>>  	fi
>>  
>> -	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
>> +	echo $SCRATCH_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
>>  	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
>>  		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
>>  		exit 1
>> diff --git a/common/rc b/common/rc
>> index b8f711a..064b987 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1034,6 +1034,12 @@ _require_scratch_nocheck()
>>  		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
>>  		fi
>>  		;;
>> +	ubifs)
>> +		if [ -z "$SCRATCH_DEV" -o ! -c "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
>> +		then
>> +		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
>> +		fi
>> +		;;
> 
> s/unique/valid/

Will fix!

Thanks,
//richard
