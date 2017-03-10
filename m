Received: from mx1.redhat.com ([209.132.183.28]:40110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933867AbdCJOUx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Mar 2017 09:20:53 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71B17C04BD2D
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 14:20:38 +0000 (UTC)
Subject: Re: [PATCH] xfstests: test orphan inode recovery on RO mount
References: <517ceead-de32-1fdb-f002-ce9d7acdf330@redhat.com>
 <20170310043612.GL14226@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <e3f1b026-16e7-38e5-5af3-4e475caa94d8@redhat.com>
Date: Fri, 10 Mar 2017 08:20:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170310043612.GL14226@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 3/9/17 10:36 PM, Eryu Guan wrote:
> On Thu, Mar 09, 2017 at 03:31:43PM -0600, Eric Sandeen wrote:
>> There's a bug in xfs where the orphan inode list
>> is not processed on a readonly mount, and is still not
>> processed even if it gets mounted rw.  This test exercises
>> that, and makes sure that the unlinked list is empty after
>> a transition to rw and an unmount.
>>
>> While we're at it, sanity check the same thing for pure ro
>> and rw unmounts.
>>
>> Now that shutdown is generic, we can test other filesystems
>> as well, so this is in the generic group.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

...

> Do we really need 10s? That seems a bit long to me, and I tested with
> sleep 3, it also reproduced on XFS (4.11-rc1).
> 
> Otherwise look good to me. I can fix them all at commit time if you're
> OK with "sleep 3".

Sure, thanks.  The 10s came from another test w/ the same setup.
Happy to resend too, if you'd prefer.

-Eric
 
> Thanks,
> Eryu
> 

