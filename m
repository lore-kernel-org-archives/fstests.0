Received: from szxga05-in.huawei.com ([45.249.212.191]:17142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfAOFbj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Jan 2019 00:31:39 -0500
Subject: Re: [PATCH] common/scsi_debug: make sure scsi_debug been removed
 correctly
References: <20190109054845.93810-1-yangerkun@huawei.com>
 <20190109210243.GG27534@dastard>
 <a91e3234-9a4a-27b4-2382-683f773e892c@huawei.com>
 <20190115034743.GS27534@dastard>
From: yangerkun <yangerkun@huawei.com>
Message-ID: <edf7a7c5-0ed2-7810-5acc-2aeed65db5d4@huawei.com>
Date: Tue, 15 Jan 2019 13:31:24 +0800
MIME-Version: 1.0
In-Reply-To: <20190115034743.GS27534@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: guaneryu@gmail.com, houtao1@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



Dave Chinner wrote on 2019/1/15 11:47:
> On Sat, Jan 12, 2019 at 10:20:26AM +0800, yangerkun wrote:
>>
>>
>> Dave Chinner wrote on 2019/1/10 5:02:
>>> On Wed, Jan 09, 2019 at 01:48:45PM +0800, yangerkun wrote:
>>>> Case generic/108 sometimes will fail while testing ext2, and the reson
>>>> is that rmmod scsi_debug in _put_scsi_debug_dev may randomly fail. Now
>>>> add the loop to do rmmod to make sure scsi_debug can be removed
>>>> correctly.
>>>
>>> Why does 'rmmod scsi_debug' randomly fail?
>>>
>>> What bug does ext2 have that prevents the scsi debug module from
>>> being released and hence removed?
>>
>> It's not a bug with ext2, ever been existing in ext4 too. This patch
>> is a reference to 'https://gitlab.com/cryptsetup/cryptsetup.git'
>> commit d7b9ed05f0931b416c33c8eb2ff1e6efa39270ff, and the reason why
>> need this is that the behavior of udev cannot be speculated, so
>> scsi_debug may rmmod failed since udev scan open the device and take
>> the reference of module scsi_debug.
> 
> IOWs, you copied a hack from cryptsetup tests because you didn't
> know about $UDEV_SETTLE_PROG and didn't think to ask if anyone knew
> a solution to this problem?

I have test to add udev settle before really do 'rmmod scsi_debug', and 
the result is the same, sometimes 'rmmod scsi_debug' may failed too. For 
this question, i have ask Ondrej Konzina, the question and answer are as 
follow:

Question:
"Hi,

While we are testing fs with xfstests, generic/108 will fail at some
times with the reson that rmmod find the refcnt of scsi_debug module
isn't 0 by checking /proc/modules. And this your patch is really
describe the same thing. But, i am confusing about the scene as you said:
    cleanup() {
           if [ -d "$MNT_DIR" ] ; then
               umount -f $MNT_DIR 2>/dev/null
               rmdir $MNT_DIR 2>/dev/null
           fi
           rm -f $LOCAL_FILE 2> /dev/null
-       udevadm settle >/dev/null 2>&1
-       rmmod scsi_debug 2> /dev/null
+       scsi_debug_teardown "$DEV" || exit 100
    }

After the settle, all the event has been finish, so who will trigger the
scan, and how to scan? Can you help to explain this? Thanks a lot!
"
Answer:
"Well, almost true. But by our experience udev settle command behaviour 
is not strictly defined (and also discouraged from using even by udev 
maintainers themselves IIRC). For example it will not synchronize you 
against events coming after you trigger the settle command. And you have 
zero control over when the event is added. So the long-term goal is to 
get rid of it from all tests in cryptsetup (not being on top of our todo 
list as you can clearly see if you grep scripts across tests 
subdirectory :)).

Due to many existing udev versions among many distributions we found out 
there's no more reliable way than trying to remove scsi_debug in retry 
loop. And that loop also handles some weird versions (legacy versions 
but we do sometimes test even old distros) where udev fails to remove 
device nodes from /dev from time to time."

Since settle can not resolve the problem, so there has no choice add the 
loop to do these. Maybe it is not a good way for this problem, do you 
have any suggestion?

Cheer,

Kun.
> 
> Cheers,
> 
> Dave.
> 
