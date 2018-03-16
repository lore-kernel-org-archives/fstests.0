Received: from mail-yw0-f195.google.com ([209.85.161.195]:38055 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeCPI3z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Mar 2018 04:29:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180316081952.GQ30836@localhost.localdomain>
References: <20180314090230.25055-1-wqu@suse.com> <20180314090230.25055-3-wqu@suse.com>
 <20180316040119.GN30836@localhost.localdomain> <90382d48-0f21-d758-3896-467d8616d74b@gmx.com>
 <20180316081952.GQ30836@localhost.localdomain>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Mar 2018 10:29:54 +0200
Message-ID: <CAOQ4uxjUJszLQn7Nah7055AiWSjhNqOnN26k9m+L64q4-7vOqA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA writes
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 16, 2018 at 10:19 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> On Fri, Mar 16, 2018 at 01:17:07PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 12:01, Eryu Guan wrote:
>> > On Wed, Mar 14, 2018 at 05:02:30PM +0800, Qu Wenruo wrote:
>> >> Basic test case which triggers fsstress with dm-log-writes, and then
>> >> check the fs after each FUA writes.
>> >> With needed infrastructure and special handlers for journal based fs.
>> >
>> > It's not clear to me why the existing infrastructure is not sufficient
>> > for the test. It'd be great if you could provide more information and/=
or
>> > background in commit log.
>>
>> The main problem of current infrastructure is we don't have the
>> following things:
>>
>> 1) Way to take full advantage of dm-log-writes
>>    The main thing is, we don't have test cases to check each FUA (this
>>    patch) and flush (later patch after clearing all the RFC comments).
>>
>>    We have some dm-flakey test cases to emulate power loss, but they are
>>    mostly for fsync.
>>    Here we are not only testing fsync, but also every superblock update.
>>    Which should be a super set of dm-flakey tests.
>>
>> 2) Workaround for journal replay
>>    In fact, if we only test btrfs, we don't even need such complicated
>>    work, just 'replay-log --fsck "btrfs check" --check fua' will be
>>    enough. As btrfs check doesn't report dirty journal (log tree) as
>>    problem.
>>    But for journal based fses, their fsck all report dirty journal as
>>    error, which needs current snapshot works to replay them before
>>    running fsck.
>
> And replay-to-fua doesn't guarantee a consistent filesystem state,
> that's why we need to mount/umount the target device to replay the
> filesystem journal, and to avoid replaying already-replayed-log over and
> over again, we create a snapshot of the target device and mount cycle &
> fsck the snapshot, right?
>
> I'm wondering if the overhead of repeatly create & destroy snapshots is
> larger than replaying log from start. Maybe snapshots take more time?
>

FYI, the snapshots flavor comes from Josef's scripts and it is called fast*=
**
I suppose this means the non-snapshot flavor is the original implementation
and it is slower. Josef?

>>
>> I would add them in next version if there is no extra comment on this.
>>
>> >
>> >>
>> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> >> ---
>> >> In my test, xfs and btrfs survives while ext4 would report error duri=
ng fsck.
>> >>
>> >> My current biggest concern is, we abuse $TEST_DEV and mkfs on it all =
by
>> >> ourselves. Not sure if it's allowed.
>> >
>> > As Amir already replied, that's not allowed, any destructive operation=
s
>> > should be done on $SCRATCH_DEV.
>>
>> Yep, I'm looking for similar case who uses $SCRATCH_DEV as LVM pv do get
>> extra device.
>>
>> Or can we reuse the scratch_dev_pool even for ext4/xfs?
>
> I think so, IMO pool devices are not limited to btrfs. But I think we
> could use a loop device reside on $TEST_DIR? Or if snapshots take longer
> time, then we don't need this extra device at all :)
>
> I have some other comments, will reply to the RFC patch in another
> email.
>
> Thanks,
> Eryu
