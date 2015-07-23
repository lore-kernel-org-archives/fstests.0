Received: from sandeen.net ([63.231.237.45]:41638 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbbGWD4u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 22 Jul 2015 23:56:50 -0400
Message-ID: <55B06601.2080204@sandeen.net>
Date: Wed, 22 Jul 2015 22:56:49 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/078: omit -m crc=0 mkfs option if mkfs.xfs has no
 meta support
References: <1437553336-30408-1-git-send-email-eguan@redhat.com> <55AFB550.5020904@sandeen.net> <20150723035406.GG3945@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150723035406.GG3945@dhcp-13-216.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 7/22/15 10:54 PM, Eryu Guan wrote:
> On Wed, Jul 22, 2015 at 10:22:56AM -0500, Eric Sandeen wrote:
>> On 7/22/15 3:22 AM, Eryu Guan wrote:
>>> This basically does the same as in commit
>>>
>>> 90a3bfc xfs: be compatible with older mkfs.xfs which has no v5 support
>>>
>>> which left xfs/078 behind.
>>>
>>> Signed-off-by: Eryu Guan <eguan@redhat.com>
>>
>> This is fine as far as it goes, but I think xfs/045 needs it too:
>>
>>
>> if ! _scratch_mkfs_xfs -m crc=0 >$tmp.out 2>&1
>> then
>>     cat $tmp.out
>>     echo "!!! failed to mkfs on $SCRATCH_DEV"
>>     exit
>> fi
>>
>> It fails "gracefully" but it doesn't need to, in this case.
> 
> xfs/045 passed on my RHEL6 test box, I think that's because xfs/045 (and
> some other tests) takes use of _scratch_mkfs_xfs not call $MKFS_XFS_PROG
> directly, so commit 90a3bfc takes care of all the dirty work.
> 
> Thanks for the review!

Oh, you are right ... how did I miss that it's calling _scratch_mkfs_xfs,
I'm sorry!

Yes, your patch is fine, and complete.  Oops! :)

Thanks,
-Eric
