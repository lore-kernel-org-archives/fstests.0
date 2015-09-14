Received: from mail-yk0-f176.google.com ([209.85.160.176]:34000 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbINJ3F (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 14 Sep 2015 05:29:05 -0400
Received: by ykdg206 with SMTP id g206so146790410ykd.1
        for <fstests@vger.kernel.org>; Mon, 14 Sep 2015 02:29:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7+do645WXZkvVeFhyzcxdWuv=EvgXMVeT1kKN-RcLvcQ@mail.gmail.com>
References: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
	<CAL3q7H48_juhy1vagw6KR5MPgjc2GO4Spy7PU8tLMUiaqReCWw@mail.gmail.com>
	<CAPBX1x+GZ0iorNojS90o7eAw4-0Z3LWsLN_8Bz8vscwJ0vEjQQ@mail.gmail.com>
	<CAL3q7H7+do645WXZkvVeFhyzcxdWuv=EvgXMVeT1kKN-RcLvcQ@mail.gmail.com>
Date: Mon, 14 Sep 2015 17:29:04 +0800
Message-ID: <CAPBX1x+1K9LuL2qi-LJ2egaVHnUANK-HUheQxfAKVjDgvES36A@mail.gmail.com>
Subject: Re: [PATCH] generic/027: enlarge fs size for btrfs in bigger
 page-size machine
From: George Wang <xuw2015@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 14, 2015 at 4:35 PM, Filipe David Manana <fdmanana@gmail.com> wrote:
> On Mon, Sep 14, 2015 at 4:40 AM, George Wang <xuw2015@gmail.com> wrote:
>> On Fri, Sep 11, 2015 at 8:06 PM, Filipe David Manana <fdmanana@gmail.com> wrote:
>>> On Fri, Sep 11, 2015 at 12:41 PM,  <xuw2015@gmail.com> wrote:
>>>> From: George Wang <xuw2015@gmail.com>
>>>>
>>>> btrfs on bigger page-size machine(such as ppc64/ppc64le), the min fs
>>>> size shoule be more than 480MB. Otherwise, the mount will fail.
>>>
>>> Interesting, wasn't aware of that.
>>> How does it fail? What error message do you get?
>>
>> The ppc64/ppc64le page size is 64KB, and if the fs size is less than
>> 480MB, the first
>> mount operation failed, the 2nd time succeeded.
>
> (adding back fstests list)
>
> Yes, but can you please mention if there's any btrfs
> error/warning/stack trace in syslog?
>

Of course, I can provide the logs:

[root@ibm-p8-01-lp5 ~]# export LANG='C'
[root@ibm-p8-01-lp5 ~]# fallocate -l 256MB ~/btrfs.img
[root@ibm-p8-01-lp5 ~]# mkfs.btrfs ~/btrfs.img
SMALL VOLUME: forcing mixed metadata/data groups
btrfs-progs v3.19.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'mixed-bg': mixed data and metadata block groups
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
Created a data/metadata chunk of size 8388608
ERROR: device scan failed '/root/btrfs.img' - Block device required
fs created label (null) on /root/btrfs.img
    nodesize 65536 leafsize 65536 sectorsize 65536 size 244.12MiB
[root@ibm-p8-01-lp5 ~]# mkdir /mnt/btrfs
[root@ibm-p8-01-lp5 ~]# mount ~/btrfs.img /mnt/btrfs
mount: mount /dev/loop0 on /mnt/btrfs failed: No space left on device
[root@ibm-p8-01-lp5 ~]# mount ~/btrfs.img /mnt/btrfs
<this time succeeded>

dmesg:
[ 7505.909441] Btrfs loaded
[ 7524.291277] attempt to access beyond end of device
[ 7524.291288] loop0: rw=0, want=500096, limit=500000
[ 7524.307093] BTRFS: device fsid c3e9f64e-81ea-4670-98f1-abcc9cec7ce9
devid 1 transid 4 /dev/loop0
[ 7524.308314] BTRFS info (device loop0): disk space caching is enabled
[ 7524.308322] BTRFS: has skinny extents
[ 7524.314560] BTRFS: creating UUID tree
[ 7524.331911] BTRFS: failed to create the UUID tree -28
[ 7524.503742] BTRFS: open_ctree failed
[ 7528.031807] attempt to access beyond end of device
[ 7528.031818] loop0: rw=0, want=500096, limit=500000
[ 7528.032981] BTRFS info (device loop0): disk space caching is enabled
[ 7528.032990] BTRFS: has skinny extents
[ 7528.036360] BTRFS: creating UUID tree
[ 7528.037789] SELinux: initialized (dev loop0, type btrfs), uses xattr

>> The following is my analysis:
>>
>> btrfs do the space allocation by do_chunk_alloc, but this function
>> does not care about
>> the size wanted to allocate, it just alloc the chunk size on its rule.
>>
>> the open_ctree will try to create the uuid tree, which needs to
>> reserve some space in
>> btrfs_start_transaction. if no engough space, the
>> reserve_metadata_bytes will call the
>> flush_space for space reclaiming. it will call flush_space many times,
>> every time with
>> different flush level. when the flush level is ALLOC_CHUNK, it will call the
>> do_chunk_alloc to allocate a chunk. Unfortunately, the new chunk may be smaller
>> than the size we want, so the first time to mount will fail. And we
>> mount it again, it
>> will allocate a chunk again, then the size can meet our requirement.
>
> So the second mount succeeds and it's able to allocate a big enough
> chunk while the first mount isn't?
> If so, than that's more likely to be a bug in btrfs rather than a
> problem in the test imho.
>

I am not sure. But from the standpoint of this test, it will test the fs on the
SCRATCH_MNT. So the fs mount failed, it should not run the following
test. So I think at lease we should check the success of mounting.

Besides, I am not sure if this is a big deal for btrfs testing with 512MB fs.
But obviously, this is the easiest way to make this test run anywhere.

> On x86 running the test with MKFS_OPTIONS="-n 65536" should then
> theoretically allow to reproduce the issue, since the size of the
> files the test creates are multiples of both 4K and 64K. For me that
> (the mount "failure") doesn't happen, but instead the test has been
> running for over 2 hours with such a node size when it usually takes a
> couple minutes.
>
I tried use the "-n 65536" opt, but it seems not the things I expect:

Performing full device TRIM (1.00GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/loop0
nodesize 65536 leafsize 65536 sectorsize 4096 size 1.00GiB

^^^^^^^^^^^^^^^^^here, the page size

I also tried use the "-s 65536 -n 65536" opts,  mkfs OK,  but can't mount with
following error:
[503272.399142] BTRFS: Incompatible sector size(65536) found on loop0
And the code's is like following:
2646     if (sectorsize != PAGE_SIZE) {
2647         printk(KERN_WARNING "BTRFS: Incompatible sector size(%lu) "
2648                "found on %s\n", (unsigned long)sectorsize, sb->s_id);
2649         goto fail_sb_buffer;
2650     }

So I don't think you can simulate the context(64KB page) in the x86_64 machines
with 4k page size.

Thanks

George

> thanks
>
>>
>>>
>>> How did you calculate those values (480Mb and 512Mb)?
>>
>> I did not calculate, just test many times by binary-search method. for example:
>> (256~512)->(384~512)->...
>> And I do not think 480MB is the accurate number, but for reproduce the
>> problem, it's
>> enough.
>>
>> Thanks
>>
>> George
>>
>>>
>>> thanks
>>>
>>>> So we shoud adjust the fs size to 512MB for btrfs to run this test
>>>> correctly. And we also provide a double check: if mount fails, we should
>>>> never run this test.
>>>>
>>>> Signed-off-by: George Wang <xuw2015@gmail.com>
>>>> ---
>>>>  tests/generic/027 | 19 +++++++++++--------
>>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tests/generic/027 b/tests/generic/027
>>>> index d2e59d6..c42b9a6 100755
>>>> --- a/tests/generic/027
>>>> +++ b/tests/generic/027
>>>> @@ -65,8 +65,17 @@ _require_scratch
>>>>  rm -f $seqres.full
>>>>  echo "Silence is golden"
>>>>
>>>> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
>>>> -_scratch_mount
>>>> +loop=100
>>>> +fs_size=$((256 * 1024 * 1024))
>>>> +# btrfs takes much longer time, reduce the loop count
>>>> +# btrfs takes much more space when first mount on bigger page-size machine
>>>> +if [ "$FSTYP" == "btrfs" ]; then
>>>> +       loop=10
>>>> +       fs_size=$((512 * 1024 * 1024))
>>>> +fi
>>>> +
>>>> +_scratch_mkfs_sized $(fs_size) >>$seqres.full 2>&1
>>>> +_scratch_mount || _notrun "scratch dev is not mounted successfully"
>>>>
>>>>  echo "Reserve 2M space" >>$seqres.full
>>>>  $XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
>>>> @@ -75,12 +84,6 @@ $XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
>>>>  echo "Remove reserved file" >>$seqres.full
>>>>  rm -f $SCRATCH_MNT/testfile
>>>>
>>>> -loop=100
>>>> -# btrfs takes much longer time, reduce the loop count
>>>> -if [ "$FSTYP" == "btrfs" ]; then
>>>> -       loop=10
>>>> -fi
>>>> -
>>>>  dir=$SCRATCH_MNT/testdir
>>>>  echo -n "iteration" >>$seqres.full
>>>>  i=1
>>>> --
>>>> 1.9.3
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Filipe David Manana,
>>>
>>> "Reasonable men adapt themselves to the world.
>>>  Unreasonable men adapt the world to themselves.
>>>  That's why all progress depends on unreasonable men."
>
>
>
> --
> Filipe David Manana,
>
> "Reasonable men adapt themselves to the world.
>  Unreasonable men adapt the world to themselves.
>  That's why all progress depends on unreasonable men."
