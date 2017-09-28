Received: from mx2.suse.de ([195.135.220.15]:36745 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752494AbdI1CKA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 22:10:00 -0400
Subject: Re: [PATCH 1/2] generic/461: Test RWF_NOWAIT
References: <20170927191003.10099-1-rgoldwyn@suse.de>
 <20170927213454.GD3666@dastard>
 <2292b367-9880-8e03-fe59-84dc1f2b13da@suse.de>
 <20170927215139.GE3666@dastard>
 <4be71a29-e84f-5e3d-67f6-6787f45e1b27@suse.de>
 <20170928015139.GH10621@dastard>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <a474211d-66a0-51bf-e12c-a5f5b7a146cc@suse.de>
Date: Wed, 27 Sep 2017 21:09:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170928015139.GH10621@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 09/27/2017 08:51 PM, Dave Chinner wrote:
> On Wed, Sep 27, 2017 at 05:24:49PM -0500, Goldwyn Rodrigues wrote:
>>
>>
>> On 09/27/2017 04:51 PM, Dave Chinner wrote:
>>> On Wed, Sep 27, 2017 at 04:39:20PM -0500, Goldwyn Rodrigues wrote:
>>>>
>>>>
>>>> On 09/27/2017 04:34 PM, Dave Chinner wrote:
>>>>> On Wed, Sep 27, 2017 at 02:10:02PM -0500, Goldwyn Rodrigues wrote:
>>>>>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>>>>>
>>>>>> Tests the RWF_NOWAIT flag so the I/O returns immediately on
>>>>>> a new file, without any block allocations.
>>>>>>
>>>>>> A new program which includes the pwritev2() call is used. This allows
>>>>>> passing flags for the I/O to be performed.
>>>>>
>>>>> Rather than write a one-off test program for this that effectively
>>>>> replicates xfs_io pread/pwrite functionality, please add RWF_NOWAIT
>>>>> flag support to xfs_io.
>>>>>
>>>>
>>>> This one off program is required because xfs_io does not support partial
>>>> writes. It tries to do that within the loop and does not return the
>>>> number of bytes written. This is required for test generic/462.
>>>
>>> Then please also extend xfs_io to support partial reads and writes
>>> in the manner you need.
>>>
>>
>> That will break existing tests which rely on nothing but the error
>> returned in case of partial writes.
> 
> So trigger necessary partial write behaviour only when the CLI
> option to use RWF_NOWAIT is present....
> 

Partial write test case is not related to RWF_NOWAIT test case. These
are two separate test cases.

Anyways, I am working on implementing this. Would you prefer pwritev2 be
a separate subcommand calling pwritev2() or should I transform pwritev()
to pwritev2()? The system call is relatively new and there are
overlapping features such as RWF_DSYNC and RWF_SYNC. I am assuming the
former.


-- 
Goldwyn
