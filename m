Received: from mout.gmx.net ([212.227.15.15]:43877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbeHaTCE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 31 Aug 2018 15:02:04 -0400
Subject: Re: problem with tune2fs after ext4 godown
References: <1513324055-77618-1-git-send-email-cgxu519@icloud.com>
 <1513324055-77618-3-git-send-email-cgxu519@icloud.com>
 <CAOQ4uxgf=btK-MKed7-8_nmpfO-UnPyVJ4RyTtK1hMQuU8Y=-g@mail.gmail.com>
 <63598ea1-8fd3-1003-a5b1-cb177a9380d8@gmx.com>
 <6c2125c0-5a89-4a67-7a2c-2bebe8dd5b7e@gmx.com>
 <CAOQ4uxhu9rNBByXwZifcf=mmDekGwu8H4s8GsMrFMcanp-7A5Q@mail.gmail.com>
From: cgxu519 <cgxu519@gmx.com>
Message-ID: <92bd7ae7-3601-9682-d131-258500393e9b@gmx.com>
Date: Fri, 31 Aug 2018 22:53:54 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhu9rNBByXwZifcf=mmDekGwu8H4s8GsMrFMcanp-7A5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chengguang Xu <cgxu519@icloud.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On 08/31/2018 10:28 PM, Amir Goldstein wrote:
> [switching over to ext4 list]
>
> On Fri, Aug 31, 2018 at 5:19 PM cgxu519 <cgxu519@gmx.com> wrote:
>>
>> Hi Amir,
>>
>> It seems godown will cause side effect on ext4/tune2fs, mount an ext4
>> filesystem after running godown,
>> then tune2fs -l <dev> complains like below. so definitely it will not
>> pass d_type check.
>>
>>
>> [root@x201 xfstests-dev]# tune2fs -l /dev/mapper/test-test1
>> tune2fs 1.44.2 (14-May-2018)
>> tune2fs: Superblock checksum does not match superblock while trying to
>> open /dev/mapper/test-test1
>> Couldn't find valid filesystem superblock.
>>
>>
> Chengguang,
>
> Bringing this to the attention of ext4 developers,
> can you please re-iterate the reproducer (without the mention of
> overlayfs and genereic/474) to demonstrate the problem.

steps to reproduce:

1) mount an ext4 fs
2) write a file in the fs
3) sync / or do nothing
4) running godown tool in xfstest to the fs
5) umount the fs
6) mount the fs
7) tune2fs -l <dev>

tune2fs -l will fail with below error.

[root@x201 xfstests-dev]# tune2fs -l /dev/mapper/test-test1
tune2fs 1.44.2 (14-May-2018)
tune2fs: Superblock checksum does not match superblock while trying to
open /dev/mapper/test-test1
Couldn't find valid filesystem superblock.


If I do not write any file in (2), then tune2fs -l in (7) will finish 
successfully.
If I run tune2fs -l during (4) and (5) or during (5) and (6) also finish 
successfully.

NOTE, I don't know this is a real issue or just by design.


Thanks,
Chengguang
