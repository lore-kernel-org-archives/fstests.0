Received: from mx142.netapp.com ([216.240.21.19]:54847 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdKAPF4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Nov 2017 11:05:56 -0400
Subject: Re: [PATCH] generic/4[13,62]: restore TEST mount options
References: <20171030080831.7339-1-Omer.Zilberberg@netapp.com>
 <20171030203658.GA4094@dastard>
 <20171031043758.GF17339@eguan.usersys.redhat.com>
 <9513dd3d-22bf-0dde-6cfb-6d8f4bc9775c@netapp.com>
 <20171031113400.GM17339@eguan.usersys.redhat.com>
 <cfe58e4a-7f40-4a10-72a1-ba2f1baeea8b@netapp.com>
 <20171101125225.GS17339@eguan.usersys.redhat.com>
From: Omer Zilberberg <omerz@netapp.com>
Message-ID: <f1cc1f9d-7b1c-7cee-e926-0256a12d5060@netapp.com>
Date: Wed, 1 Nov 2017 17:03:21 +0200
MIME-Version: 1.0
In-Reply-To: <20171101125225.GS17339@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Omer Zilberberg <Omer.Zilberberg@netapp.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 11/01/2017 02:52 PM, Eryu Guan wrote:
> On Wed, Nov 01, 2017 at 02:06:27PM +0200, Omer Zilberberg wrote:
>>
>> On 10/31/2017 01:34 PM, Eryu Guan wrote:
>>> On Tue, Oct 31, 2017 at 12:25:51PM +0200, Omer Zilberberg wrote:
>>>> On 10/31/2017 06:37 AM, Eryu Guan wrote:
>>>>> On Tue, Oct 31, 2017 at 07:36:58AM +1100, Dave Chinner wrote:
>>>>>> On Mon, Oct 30, 2017 at 10:08:31AM +0200, Omer Zilberberg wrote:
>>>>>>> These tests locally change the TEST_FS_MOUNT_OPTS/MOUNT_OPTIONS
>>>>>>> environment variables, and run _test_cycle_mount. As a result, fo=
llowing
>>>>>>> tests using the TEST mount point may start with different mount o=
ptions,
>>>>>>> depending on run order.
>>>>>> I don't think that's the case. The change of the environment
>>>>>> variable should only affect the current test process and it's
>>>>>> children. When the test exits, we go back to the environment of th=
e
>>>>>> check process, where the TEST_FS_MOUNT_OPTS environment variable i=
s
>>>>>> still correctly set, and all future tests inherit from that. i.e.:
>>>>>>
>>>>>> $ export FOO=3Dfoo
>>>>>> $ echo $FOO
>>>>>> foo
>>>>>> $ bash
>>>>>> $ echo $FOO
>>>>>> foo
>>>>>> $ export FOO=3Dbar
>>>>>> $ echo $FOO
>>>>>> bar
>>>>>> $ exit
>>>>>> $ echo $FOO
>>>>>> foo
>>>>>> $
>>>>>>
>>>>>> And after each test, check runs _check_filesystems(), which cycles
>>>>>> the test mount, so for each new test process that is run they shou=
ld
>>>>>> already start in the correct state...
>>>>> I agreed, the changing of variables in a sub-shell won't affect the
>>>>> parent's copy, and check will restore the mounts with the untouched
>>>>> options.
>>>>>
>>>>> But the problem is that _check_test_fs() will cycle mount TEST_DEV =
with
>>>>> MOUNT_OPTIONS not TEST_FS_MOUNT_OPTS, so if you have different moun=
t
>>>>> options set for TEST_DEV and SCRATCH_DEV, you'll see mount options
>>>>> changed for TEST_DEV. e.g.
>>>>>
>>>>> MOUNT_OPTIONS=3D"-o dax" TEST_FS_MOUNT_OPTS=3D"" ./check generic/41=
3 generic/445
>>>>> generic/445 mount TEST_DEV with "-o dax" too
>>>>>
>>>>> MOUNT_OPTIONS=3D"" TEST_FS_MOUNT_OPTS=3D"-o dax" ./check generic/41=
3 generic/445
>>>>> generic/445 mount TEST_DEV without "-o dax"
>>>>>
>>>>> MOUNT_OPTIONS=3D"-o dax" TEST_FS_MOUNT_OPTS=3D"-o dax" ./check gene=
ric/413 generic/445
>>>>> both tests and both devices mount with "-o dax"
>>>>>
>>>>> That's been discussed in this thread:
>>>>> https://patchwork.kernel.org/patch/9742039/
>>>>>
>>>>> Omer, can you please confirm if you're hitting this issue?
>>>> I'm not 100% that's the case, so I better describe my settings more =
clearly:
>>>> I have a debug mount option on my system to recover the FS from a ba=
ckup.
>>>> When that flag is set, umount writes everything to the backup.
>>>> Mount restores from it, overwriting everything.
>>> If you're testing with setting your debug mount option to both
>>> TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS, and you still see the failure y=
ou
>>> were seeing, then that's a different problem.
>> Yeah, that's what I'm doing, setting both with that flag.
>>>> As long as generic/413 is not involved, everything works well.
>>>> All _test_cycle_mount() calls first back everything up on umount,
>>>> then restore upon mount. So I get the same FS contents.
>>>>
>>>> But, consider generic/118 running after generic/413:
>>>> - generic/413 finishes with a mount point with no mount options
>>>> - generic/118 begins with restored TEST_FS_MOUNT_OPTS, as you've poi=
nted out.
>>>> - some writes are performed to the FS
>>>> - next _test_cycle_mount:
>>>> =C2=A0 calls umount w/o backing up (debug flag previously unset by g=
eneric/413).
>>> Does this clear the backup too? If so, I suspect TEST_DEV got cleared=
 on
>>> first mount with the debug option in generic/118, because the backup =
has
>>> been cleared in the _test_cycle_mount call in generic/413.
>> Yeah the backup is cleared, which is normal behavior when the debug fl=
ag is off.
>> And exactly, it's generic/413 clearing the flag from the mount point,
>> that's caused this.
> IMHO, in this case fstests doesn't do anything wrong, all the mount
> options are restored when running the next test, it's just not
> compatible with your debug option and workflow.
But the mount options are not restored when running the next test...
Only the first _test_cycle_mount restores them.
In case I haven't made myself clear, here's a final demonstration.
If you still think this is valid, I'll back down :)

I've edited generic/118 locally, and after _require_test_reflink, I've ad=
ded:
mount | grep $TEST_DIR
Just to see the mount options the TEST FS has.

I've also put aside my debug option, and used -o strictatime instead.
If I mount w/o special options, I get the "relatime" mount option as defa=
ult.
If I mount with -o strictatime, I do not see "relatime". Now back to fste=
sts:

If the order of run is generic/118 followed by generic/413,
Then generic/118 does NOT print "relatime" in its options, because strict=
atime
is active.
However, if the order of run is reversed, then "relatime" IS printed, bec=
ause
the TEST FS' was left with default mount options by generic/413.

So, generic/118's start conditions depend on its predecessor.
Is that valid for TEST fs mount options?

>
>>>> =C2=A0 calls mount WITH the debug flag, and recovers from an empty b=
ackup,
>>>> =C2=A0 deleting the earlier writes.
>>>> - subsequent md5sum fails on "No such file or directory", as FS is n=
ow empty.
>>>>
>>>>> I think fixing _check_<fs>_filesystem() is the correct way. And I g=
uess
>>>>> we can refactor out a common function and call it in
>>>>> _check_[xfs|btrfs|generic]_filesystem, pass the correct mount optio=
ns
>>>>> based on what device we're working on.
>>>> If indeed we're talking about the same problem,
>>>> please let me know if you'd like me to prepare a different patch.
>>> Sure, really appreciated if you can prepare a different patch, even i=
f
>>> it's not the same problem :)
>> Ok.
>> But are we in agreement that there are 2 different issues here?
> Yes, the problem you hit is different with the issue I described above.
>
>> If so, please let me know what you think of this patch,
>> which does resolve that issue I had originally (at least locally for m=
e).
> I prefer not merging your patch, sorry. Because in this specific case,
> from fstests' point of view, it's all doing well and everything works a=
s
> expected.
>
>> And I'll explore the issue with check_test_fs and the different mount =
options,
>> based on what you've both written here and the thread you've pointed t=
o.
>> I'll send another patch to address that later.
> Thanks a lot!
>
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

