Received: from sandeen.net ([63.231.237.45]:34812 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeJVVoP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Oct 2018 17:44:15 -0400
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper
 (CrashMonkey)
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop>
 <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org>
 <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard>
 <CAOQ4uxhxgY0Kpk87zxWdfqUcH=ZBiajzBmnrCCb1M_+V2NPcuQ@mail.gmail.com>
 <CA+EzBbDGcryv+eiChoYEhCGKS87DBFMxiUvZGy8-VD-80YCetQ@mail.gmail.com>
 <20181022041533.GO18822@dastard>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <df49deaf-e6ea-40c4-b63f-ea856fcc8cb4@sandeen.net>
Date: Mon, 22 Oct 2018 08:25:39 -0500
MIME-Version: 1.0
In-Reply-To: <20181022041533.GO18822@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Jayashree Mohan <jayashree2912@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 10/21/18 11:15 PM, Dave Chinner wrote:
> On Sun, Oct 21, 2018 at 10:09:01PM -0500, Jayashree Mohan wrote:
>> On Sun, Oct 21, 2018 at 9:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>>
>>>>>
>>>>>> See the file xfstests-dev/tests/generic/group to see how groups get
>>>>>> assigned to tests.  I suppose all of the crashmonkey tests should be
>>>>>> assigned to a new group, say, "crashmonkey".
>>>
>>> Wait, let me get it straight. Did crashmonkey produce 300 test cases or
>>> did it find 300 bugs? Are all those test cases passing on all filesystems?
>>> Some test cases failing on some filesystems?
>>
>> CrashMonkey generates 300 workloads, out of which 3 tests result in
>> bugs in two file systems (btrfs and F2FS). Others passed clean for
>> ext4, xfs, btrfs and F2FS. Given that xfstest is a regression test
>> suite, we thought it would be beneficial to add all 300 workloads to
>> the generic test -
> 
> Perhaps you should port a test or two so we can have a look at what
> these tests are before we make any recomendations on the best way to
> integrate them. 300 new tests is an awful lot to maintain if we ever
> want to change anything....

I agree with this, do a couple and let people take a look.

-Eric
