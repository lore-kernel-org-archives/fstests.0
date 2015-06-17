Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48983 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754981AbbFQVdY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 17:33:24 -0400
Message-ID: <5581E7A0.3080401@fb.com>
Date: Wed, 17 Jun 2015 14:33:20 -0700
From: Josef Bacik <jbacik@fb.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2] generic: add fiemap test that does prealloc
References: <1434573149-4471-1-git-send-email-jbacik@fb.com> <20150617213159.GG10224@dastard>
In-Reply-To: <20150617213159.GG10224@dastard>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 06/17/2015 02:32 PM, Dave Chinner wrote:
> On Wed, Jun 17, 2015 at 01:32:29PM -0700, Josef Bacik wrote:
>> I noticed that btrfs wasn't setting unwritten on prealloc test, and then
>> subsequently noticed that we weren't testing fiemap on prealloc extents with the
>> fiemap-tester.  This patch adds another test that does the same as generic/225
>> only with prealloc enabled.  Thanks,
>>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ....
>> +_require_xfs_io_command "fiemap"
>> +_require_xfs_io_command "falloc"
>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount > /dev/null 2>&1
>> +
>> +rm -f $seqres.full
>> +fiemapfile=$SCRATCH_MNT/$seq.fiemap
>> +
>> +[ -x $here/src/fiemap-tester ] || _notrun "fiemap-tester not built"
>> +
>> +seed=`date +%s`
>> +
>> +echo "using seed $seed" >> $seqres.full
>> +
>> +echo "fiemap run with sync"
>> +$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile 2>&1 | \
>> +	tee -a $seqres.full
>> +
>> +if [ $? -ne 0 ]; then
>> +	if grep -q "Operation not supported" $seqres.full; then
>> +	      _notrun "FIEMAP not supported by this filesystem type: $FSTYP"
>> +	fi
>> +	status=$?
>> +	exit
>> +fi
>
> No need for the FIEMAP not supported check - that is done by the
> '+_require_xfs_io_command "fiemap"' line above and so any failure
> of fiemap-tester is something that should fail the test.
>

Remind me to not copy+paste Sandeen's tests anymore.  I'll fix this up. 
  Thanks,

Josef

