Received: from szxga05-in.huawei.com ([45.249.212.191]:17114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726817AbfADI53 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 03:57:29 -0500
Subject: Re: [PATCH 5/5] fsx: check ENOSYS in test_copy_range()
References: <20181229023452.28074-1-houtao1@huawei.com>
 <20181229023452.28074-6-houtao1@huawei.com> <20181229081619.GH21777@desktop>
 <20181229185612.GB20474@magnolia>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <1aeec49c-3341-8c30-472f-e54e46970e50@huawei.com>
Date: Fri, 4 Jan 2019 16:57:22 +0800
MIME-Version: 1.0
In-Reply-To: <20181229185612.GB20474@magnolia>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

On 2018/12/30 2:56, Darrick J. Wong wrote:
> On Sat, Dec 29, 2018 at 04:16:19PM +0800, Eryu Guan wrote:
>> On Sat, Dec 29, 2018 at 10:34:52AM +0800, Hou Tao wrote:
>>> In configure script, we only check whether or not the build
>>> of copy-range test program is successful, but that doesn't
>>> mean the kernel has implemented the syscall, so checking
>>> for this case.
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  ltp/fsx.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/ltp/fsx.c b/ltp/fsx.c
>>> index 316f08eb..b84180f7 100644
>>> --- a/ltp/fsx.c
>>> +++ b/ltp/fsx.c
>>> @@ -1583,7 +1583,7 @@ test_copy_range(void)
>>>  	loff_t o1 = 0, o2 = 0;
>>>  
>>>  	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 0, 0) == -1 &&
>>> -	    (errno == EOPNOTSUPP || errno == ENOTTY)) {
>>> +	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
>>
>> Should we also check for ENOSYS in other operations like
>> {clone,dedupe}_range
> 
> Unimplemented ioctls usually return EOPNOTSUPP or ENOTTY, not ENOSYS, so
> I don't think that's necessary.... unless there are kernels that don't
> implement the ioctl syscall?
> 
> In any case, the manpage for clone and dedupe don't say anything about
> returning ENOSYS.
> 
>> and fallocate?
> > Yes.
I will send a v2 to also check test_fallocate(), and thanks for your review.

> 
> --D
> 
>> Other fixes look good to me, thanks a lot for the fixes!
>>
>> Thanks,
>> Eryu
>>
>>>  		if (!quiet)
>>>  			fprintf(stderr,
>>>  				"main: filesystem does not support "
>>> -- 
>>> 2.16.2.dirty
>>>
> 
> 
