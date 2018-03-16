Received: from aserp2130.oracle.com ([141.146.126.79]:55700 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeCPFEn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Mar 2018 01:04:43 -0400
Date: Thu, 15 Mar 2018 22:04:38 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Reproducible hang in generic/430 test with latest mainline kernel
Message-ID: <20180316050438.GB4866@magnolia>
References: <CAMy_GT_VxnTVN=7VHGdPwWk7N44d7o9rqHNRrJLKHj3Z9dY7Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy_GT_VxnTVN=7VHGdPwWk7N44d7o9rqHNRrJLKHj3Z9dY7Pg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 16, 2018 at 11:21:20AM +0800, Po-Hsu Lin wrote:
> Hello,
> 
> I'm experiencing the test hang issue caused by test generic/430 with
> ext4/xfs/btrfs partition created on /dev/sdb
> 
> It looks like this issue was caused by the following command to copy
> beyond the target file:
> /usr/sbin/xfs_io -i -f -c "copy_range -s 4000 -l 2000
> /home/ubuntu/test/test-430/file" "/home/ubuntu/test/test-430/beyond"
> 
> The -l works only with <= 1000, any other number that will make it
> larger the size of test-430/file (5000) are not working.
> 
> The copied file will have a correct MD5 as expected, but the command
> will never return:
> e68d4a150c4e42f4f9ea3ffe4c9cf4ed  beyond
> 
> This issue could be seen from 4.10rc1, with 4.9.87 kernel, the test
> will fail with all of the copy action, so it won't get stuck.
> 
> 
> Release: Ubuntu Artful
> Kernel:4.16.0-041600rc5-generic
> xfsprogs version 4.9.0+nmu1ubuntu1

Could you try this with xfsprogs 4.15.1?  iirc Anna sent in a patch a
while ago to fix an infinite looping error in io/copy_file_range.c.

Ah, yes, 43141802cd ("xfs_io: Improvements to copy_range return code
handling").

--D

> BugLink: https://bugs.launchpad.net/bugs/1755999
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
