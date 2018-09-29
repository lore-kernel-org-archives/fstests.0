Received: from szxga07-in.huawei.com ([45.249.212.35]:59830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbeI2M1A (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 29 Sep 2018 08:27:00 -0400
Subject: Re: [PATCH] generic: add a testcase to test uid/gid recovery
References: <20180925084558.77190-1-yuchao0@huawei.com>
 <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
 <20180928122823.GG17817@desktop>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c92ea484-7dcc-9675-59d4-4f921daa5962@huawei.com>
Date: Sat, 29 Sep 2018 13:59:47 +0800
MIME-Version: 1.0
In-Reply-To: <20180928122823.GG17817@desktop>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On 2018/9/28 20:28, Eryu Guan wrote:
> On Tue, Sep 25, 2018 at 05:16:31PM +0800, Chao Yu wrote:
>> Hi Eryu,
>>
>> There are several fields in inode rather than uid/gid didn't recover in
>> f2fs, I'm not sure we need to cover all of them with one generic testcase,
>> or with several testcases. Any suggestion?
> 
> Sorry for the late response!
> 
> Several targeted test cases would be fine.

Okay, let me work on the others.

> 
> Thanks,
> Eryu
> 
> 
