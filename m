Received: from mail-yw0-f193.google.com ([209.85.161.193]:39207 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030347AbeCAMu2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Mar 2018 07:50:28 -0500
Received: by mail-yw0-f193.google.com with SMTP id l24so2021140ywk.6
        for <fstests@vger.kernel.org>; Thu, 01 Mar 2018 04:50:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0abab816-a2a4-82bf-e43e-37535f1228a8@gmx.com>
References: <20180301053821.18718-1-wqu@suse.com> <CAOQ4uxgUm-YnFG=M6YaMKqAvr+CewerL3d4S2V6WSwKKu13ebA@mail.gmail.com>
 <ed8aec54-8b90-61cd-74c2-e8a1556849f6@gmx.com> <CAOQ4uxhy7iU71dB9aTFx+aeMowNoi0QMVT2GDUM81R_CTZxxsA@mail.gmail.com>
 <0abab816-a2a4-82bf-e43e-37535f1228a8@gmx.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Mar 2018 14:50:27 +0200
Message-ID: <CAOQ4uxgw=MmrTW-1CG=RHWY65Ej1pb_rF6G5wRC1J6B5jLRpTw@mail.gmail.com>
Subject: Re: [RFC PATCH] fstests: Check if a fs can survive random (emulated)
 power loss
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>, dm-devel@redhat.com, Josef Bacik <josef@toxicpanda.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 1, 2018 at 1:48 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> On 2018=E5=B9=B403=E6=9C=8801=E6=97=A5 19:15, Amir Goldstein wrote:
>> On Thu, Mar 1, 2018 at 11:25 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>
>>>
>>> On 2018=E5=B9=B403=E6=9C=8801=E6=97=A5 16:39, Amir Goldstein wrote:
>>>> On Thu, Mar 1, 2018 at 7:38 AM, Qu Wenruo <wqu@suse.com> wrote:
>>>>> This test case is originally designed to expose unexpected corruption
>>>>> for btrfs, where there are several reports about btrfs serious metada=
ta
>>>>> corruption after power loss.
>>>>>
>>>>> The test case itself will trigger heavy fsstress for the fs, and use
>>>>> dm-flakey to emulate power loss by dropping all later writes.
>>>>
>>>> So you are re-posting the test with dm-flakey or converting it to
>>>> dm-log-writes??
>>>
>>> Working on the scripts to allow us to do --find and then replay.
>>>
>>> Since for xfs and ext4, their fsck would report false alerts just for
>>> dirty journal.
>>>
>>> I'm adding new macro to locate next flush and replay to it, then mount
>>> it RW before we call fsck.
>>>
>>> Or do we have options for those fscks to skip dirty journal?
>>>
>>
>> No, you are much better off doing mount/umount before fsck.
>> Even though e2fsck can replay a journal, it does that much slower
>> then the kernel does.
>>
>> But why do you need to teach --find to find next flush?
>> You could use a helper script to run every fua with --fsck --check fua.
>> Granted, for fstests context, I agree that --find next fua may look
>> nicer, so I have no objection to this implementation.
>
> The point is, in my opinion fua is not the worst case we need to test.
> Only flush could leads us to the worst case we really need to test.
>
> In btrfs' case, if we finished flush, but without fua, we have a super
> block points to all old trees, but all new trees are already written to
> disk.
>
> In that flush entry, we could reach to the worst case scenario to verify
> all btrfs tricks are working all together to get a completely sane btrfs
> (even all data should be correct).
>
> This should also apply to journal based filesystems (if I understand the
> journal thing correctly), even when all journals written but superblock
> not updated, we should be completely fine.
> (Although for journal, we may need to reach fua entry instead of flush?)
>
> And the other reason why we need to find next flush/fua manually is,
> mount will write new data, and we need to replay all the sequence until
> next flush/fua.
>

OK. but Josef addressed this in his script using dm snapshots, rather
than replaying each time. I guess this is the reason the script is called
replay-individual-faster.sh. You don't have to do the same, but I expect
the test would run faster if you learn from experience of Josef.

>
> And finally the reason about why need manually mount is, we need to
> workaround e2fsck/xfs_repair, so that they won't report dirty journal as
> error. If we have extra options to disable such behavior, I'm completely
> OK with current --check flush/fua --fsck method.
> (BTW, for my btrfs testing, --check flush --fsck is completely good
> enough, to exposed possible free space cache related problems)
>

What I was suggesting as an alternative is --fsck ./replay-fsck-wrapper.sh
where the wrapper script does the needed mount/umount and if you
also use dm snapshot for the mounted volume you can continue to replay
from the same point and don't need to replay from the start.

Cheers,
Amir.
