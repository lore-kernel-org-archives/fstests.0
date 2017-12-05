Received: from LGEAMRELO13.lge.com ([156.147.23.53]:47072 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbdLEFQr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Dec 2017 00:16:47 -0500
Subject: Re: False lockdep completion splats with loop device
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
Date: Tue, 5 Dec 2017 14:16:45 +0900
MIME-Version: 1.0
In-Reply-To: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On 12/5/2017 12:03 PM, Theodore Ts'o wrote:
> There are a ton of false lockdep splats that were introduced with
> commit 2dcd5adfb740: "locking/lockdep: Remove the BROKEN flag from
> CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS".
> 
> I'm seeing this triggered by a number of xfstests tests, including
> shared/298.  I see there was some discussion about this here:
> 
>    https://www.spinics.net/lists/linux-xfs/msg10832.html
> 
> ... but I don't see any solution yet.  Is anyone working on this?
> 

Hello,

I believe that the commit e319e1fbd9d42 "block, locking/lockdep: Assign
a lock_class per gendisk used for wait_for_completion()" solved the
false positive.

Could you tell me if it doesn't handle it, with the report? Then, I
will follow up and try to solve it.

> Failing that can we please make the completion lockdep something which
> is optional since the false positives are incredibly !@#@!?! annoying?
> That way I can still use most of lockdep, instead of being forced to
> completely disable lockdep?
> 
> Thanks,
> 
> 						- Ted
> 

-- 
Thanks,
Byungchul
