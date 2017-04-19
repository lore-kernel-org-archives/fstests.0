Received: from sandeen.net ([63.231.237.45]:36780 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969019AbdDSTFS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Apr 2017 15:05:18 -0400
Subject: Re: [PATCH] make xfs/293 more robust
References: <bf7bdb00-59d0-2283-e040-af1e86f14b95@redhat.com>
 <20170419185610.GA5190@birch.djwong.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <824658ad-6898-57e2-0dd6-a07b554023fa@sandeen.net>
Date: Wed, 19 Apr 2017 14:05:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170419185610.GA5190@birch.djwong.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 4/19/17 1:56 PM, Darrick J. Wong wrote:
> On Wed, Apr 19, 2017 at 01:09:45PM -0500, Eric Sandeen wrote:
>> xfs/293 is supposed to make sure every command in xfs_io
>> is documented, but it was missing the inode command because
>> it's a common word, and depending on how man formatted the
>> page, the magic "   inode" string could show up and appear
>> to indicate that documentation is present for the command
>> when it's not actually there.
>>
>> Change the test to inspect the manpage source directly, with
>> the assumption that each documented command will start
>> with ^\.B.*$COMMAND on a manpage line.
>>
>> This handles a few different compressed manpage formats -
>> I don't know if anybody uses bz2 or xz, but hey.
> 
> The man manpage on my system says it only ever supports .Z, .z, or .gz.

for now! ;)

>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/tests/xfs/293 b/tests/xfs/293
>> index ade6015..a342cb6 100755
>> --- a/tests/xfs/293
>> +++ b/tests/xfs/293
>> @@ -48,8 +48,24 @@ _supported_os IRIX Linux
>>  
>>  echo "Silence is golden"
>>  
>> +MANPAGE=`man --path xfs_io`
>> +
>> +[ -z "$MANPAGE" ] && _notrun "xfs_io manpage not found"
>> +
>> +if `echo $MANPAGE | grep -q .gz$`; then
>> +	CAT=zcat
>> +elif `echo $MANPAGE | grep -q .bz2$`; then
>> +	CAT=bzcat
>> +elif `echo $MANPAGE | grep -q .xz$`; then
>> +	CAT=xzcat
>> +else
>> +	CAT=cat
> 
> Ewwww...
> 
> case "$MANPAGE" in
> *.gz)	CAT=zcat;;
> *.bz2)	CAT=bzcat;;
> *.exe)	CAT="FORMAT /U C:";;
> *)	CAT=cat;;
> esac

Hehe, I knew there was a better way, but I'm not ashamed of
not being a bash expert ;)

-Eric
