Received: from youngberry.canonical.com ([91.189.89.112]:43393 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCUJAK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Mar 2018 05:00:10 -0400
Received: from mail-pf0-f197.google.com ([209.85.192.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1eyZbM-0000zl-SX
        for fstests@vger.kernel.org; Wed, 21 Mar 2018 09:00:09 +0000
Received: by mail-pf0-f197.google.com with SMTP id j12so2316400pff.18
        for <fstests@vger.kernel.org>; Wed, 21 Mar 2018 02:00:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316050438.GB4866@magnolia>
References: <CAMy_GT_VxnTVN=7VHGdPwWk7N44d7o9rqHNRrJLKHj3Z9dY7Pg@mail.gmail.com>
 <20180316050438.GB4866@magnolia>
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 21 Mar 2018 17:00:05 +0800
Message-ID: <CAMy_GT_FUTTVDPd3QLoqZoVFQqupiFVoD-JGv5OsyL6pptLROw@mail.gmail.com>
Subject: Re: Reproducible hang in generic/430 test with latest mainline kernel
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello Darrick,

thank you for the information, this issue has gone with xfs_io built
from xfsrpogs 4.15.1

Cheers

On Fri, Mar 16, 2018 at 1:04 PM, Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Fri, Mar 16, 2018 at 11:21:20AM +0800, Po-Hsu Lin wrote:
>> Hello,
>>
>> I'm experiencing the test hang issue caused by test generic/430 with
>> ext4/xfs/btrfs partition created on /dev/sdb
>>
>> It looks like this issue was caused by the following command to copy
>> beyond the target file:
>> /usr/sbin/xfs_io -i -f -c "copy_range -s 4000 -l 2000
>> /home/ubuntu/test/test-430/file" "/home/ubuntu/test/test-430/beyond"
>>
>> The -l works only with <= 1000, any other number that will make it
>> larger the size of test-430/file (5000) are not working.
>>
>> The copied file will have a correct MD5 as expected, but the command
>> will never return:
>> e68d4a150c4e42f4f9ea3ffe4c9cf4ed  beyond
>>
>> This issue could be seen from 4.10rc1, with 4.9.87 kernel, the test
>> will fail with all of the copy action, so it won't get stuck.
>>
>>
>> Release: Ubuntu Artful
>> Kernel:4.16.0-041600rc5-generic
>> xfsprogs version 4.9.0+nmu1ubuntu1
>
> Could you try this with xfsprogs 4.15.1?  iirc Anna sent in a patch a
> while ago to fix an infinite looping error in io/copy_file_range.c.
>
> Ah, yes, 43141802cd ("xfs_io: Improvements to copy_range return code
> handling").
>
> --D
>
>> BugLink: https://bugs.launchpad.net/bugs/1755999
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
