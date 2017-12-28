Received: from szxga04-in.huawei.com ([45.249.212.190]:3178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752849AbdL1DRf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Dec 2017 22:17:35 -0500
Subject: Re: xfstests: generic/342 run failed in f2fs
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
 <20171225163102.GB14399@thunk.org>
 <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <ee17d403-6ede-e7a0-da54-baf276e1fc97@huawei.com>
Date: Thu, 28 Dec 2017 11:17:09 +0800
MIME-Version: 1.0
In-Reply-To: <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Eric Sandeen <sandeen@sandeen.net>, Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On 2017/12/28 3:11, Jaegeuk Kim wrote:
> On 12/25, Theodore Ts'o wrote:
>> On Sun, Dec 24, 2017 at 11:47:20PM -0800, Eric Sandeen wrote:
>>> Filesystems are free to do /more/ than the minimum required by posix -
>>> see ext4_sync_parent for example.  Or xfs_finish_rename, for synchronous
>>> mounts:
>>>
>>>          * If this is a synchronous mount, make sure that the rename transaction
>>>          * goes to disk before returning to the user.
>>>          */
>>>         if (tp->t_mountp->m_flags & (XFS_MOUNT_WSYNC|XFS_MOUNT_DIRSYNC))
>>>                 xfs_trans_set_sync(tp);
>>>
>>> so behavior can be fs-dependent, or mount option dependent, etc.
>>>
>>> But to be portable, if an app wants directory changes to be persistent
>>> before proceeding, it must fsync the directory after making changes.
>>>
>>> I don't know about f2fs's design intent, whether it guarantees more
>>> than posix requires, but to guarantee that this test works on any posix
>>> fs, I think that directory fsync is needed.
>>
>> Agreed that this is a test bug, and we should add the fsync to the
>> parent directory.

Agreeed.

> 
> Agreed too. Or, how about using "-o dirsync"?

IMO, according to comments of generic/342, it wants to test posix sematic
that supported by current fs' fsync(), if we want to test dirsync mount
option, that would be better in another testcase?

> 
>>
>> It might also be a good idea for f2fs to do more, given that fsync is
>> a slow enough operation that so long as you can make sure the fsync of
>> the parent directory happens within the same atomic update as the
>> child inode, you might as well give the more expansive guarantee.  But
>> obviously that's up to the f2fs developers to decide whether they want
>> to do that work.
> 
> Indeed. Actually, since one of our goals was to reduce fsync latencies for
> Android, we decided to support posix in a minimum way. In order to avoid

Agreed, in order to maximize performance of fsync regular file, we'd better
not change current sematic of f2fs' fsync so far, moreover, there is no
such requirement from upper layer application.

> complex directory updates recursively, however, we allowed the fsync on
> directories to trigger checkpoint requiring many IO operations.

Some applications use its own database software layer instead generic
sqlite in android, and they use deletion mode in their database, so
whenever they trigger database transaction, we need to do checkpoint. There
is such scenario that, before checkpoint it comes huge number of node &
meta updating, result in that checkpoint becomes very slow.

Maybe we can consider to fsync checkpointed directory with the way fsyncing
regular file rather than triggering checkpoint to improve its performance?

> 
> IMHO, as a quick fix, it seems we need to handle MS_DIRSYNC likewse xfs.
> #define MS_DIRSYNC      128     /* Directory modifications are synchronous */

We have supported that yet in commit b7e1d800031c ("f2fs: implement -o
dirsync"). ;)

Thanks,

> 
> Thanks,
> 
>>
>> Cheers,
>>
>>       	     	       	       	    - Ted
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

