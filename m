Received: from mail-yw0-f196.google.com ([209.85.161.196]:32958 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967592AbeCALPZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Mar 2018 06:15:25 -0500
Received: by mail-yw0-f196.google.com with SMTP id l200so1942960ywb.0
        for <fstests@vger.kernel.org>; Thu, 01 Mar 2018 03:15:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ed8aec54-8b90-61cd-74c2-e8a1556849f6@gmx.com>
References: <20180301053821.18718-1-wqu@suse.com> <CAOQ4uxgUm-YnFG=M6YaMKqAvr+CewerL3d4S2V6WSwKKu13ebA@mail.gmail.com>
 <ed8aec54-8b90-61cd-74c2-e8a1556849f6@gmx.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Mar 2018 13:15:24 +0200
Message-ID: <CAOQ4uxhy7iU71dB9aTFx+aeMowNoi0QMVT2GDUM81R_CTZxxsA@mail.gmail.com>
Subject: Re: [RFC PATCH] fstests: Check if a fs can survive random (emulated)
 power loss
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>, dm-devel@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 1, 2018 at 11:25 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> On 2018=E5=B9=B403=E6=9C=8801=E6=97=A5 16:39, Amir Goldstein wrote:
>> On Thu, Mar 1, 2018 at 7:38 AM, Qu Wenruo <wqu@suse.com> wrote:
>>> This test case is originally designed to expose unexpected corruption
>>> for btrfs, where there are several reports about btrfs serious metadata
>>> corruption after power loss.
>>>
>>> The test case itself will trigger heavy fsstress for the fs, and use
>>> dm-flakey to emulate power loss by dropping all later writes.
>>
>> So you are re-posting the test with dm-flakey or converting it to
>> dm-log-writes??
>
> Working on the scripts to allow us to do --find and then replay.
>
> Since for xfs and ext4, their fsck would report false alerts just for
> dirty journal.
>
> I'm adding new macro to locate next flush and replay to it, then mount
> it RW before we call fsck.
>
> Or do we have options for those fscks to skip dirty journal?
>

No, you are much better off doing mount/umount before fsck.
Even though e2fsck can replay a journal, it does that much slower
then the kernel does.

But why do you need to teach --find to find next flush?
You could use a helper script to run every fua with --fsck --check fua.
Granted, for fstests context, I agree that --find next fua may look
nicer, so I have no objection to this implementation.

Thanks,
Amir.
