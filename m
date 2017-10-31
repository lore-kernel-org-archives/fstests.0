Received: from mx141.netapp.com ([216.240.21.12]:7748 "EHLO mx141.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbdJaK0J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Oct 2017 06:26:09 -0400
Subject: Re: [PATCH] generic/4[13,62]: restore TEST mount options
References: <20171030080831.7339-1-Omer.Zilberberg@netapp.com>
 <20171030203658.GA4094@dastard>
 <20171031043758.GF17339@eguan.usersys.redhat.com>
From: Omer Zilberberg <omerz@netapp.com>
Message-ID: <9513dd3d-22bf-0dde-6cfb-6d8f4bc9775c@netapp.com>
Date: Tue, 31 Oct 2017 12:25:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171031043758.GF17339@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>, Dave Chinner <david@fromorbit.com>, Omer Zilberberg <Omer.Zilberberg@netapp.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 10/31/2017 06:37 AM, Eryu Guan wrote:
> On Tue, Oct 31, 2017 at 07:36:58AM +1100, Dave Chinner wrote:
>> On Mon, Oct 30, 2017 at 10:08:31AM +0200, Omer Zilberberg wrote:
>>> These tests locally change the TEST_FS_MOUNT_OPTS/MOUNT_OPTIONS
>>> environment variables, and run _test_cycle_mount. As a result, follow=
ing
>>> tests using the TEST mount point may start with different mount optio=
ns,
>>> depending on run order.
>> I don't think that's the case. The change of the environment
>> variable should only affect the current test process and it's
>> children. When the test exits, we go back to the environment of the
>> check process, where the TEST_FS_MOUNT_OPTS environment variable is
>> still correctly set, and all future tests inherit from that. i.e.:
>>
>> $ export FOO=3Dfoo
>> $ echo $FOO
>> foo
>> $ bash
>> $ echo $FOO
>> foo
>> $ export FOO=3Dbar
>> $ echo $FOO
>> bar
>> $ exit
>> $ echo $FOO
>> foo
>> $
>>
>> And after each test, check runs _check_filesystems(), which cycles
>> the test mount, so for each new test process that is run they should
>> already start in the correct state...
> I agreed, the changing of variables in a sub-shell won't affect the
> parent's copy, and check will restore the mounts with the untouched
> options.
>
> But the problem is that _check_test_fs() will cycle mount TEST_DEV with
> MOUNT_OPTIONS not TEST_FS_MOUNT_OPTS, so if you have different mount
> options set for TEST_DEV and SCRATCH_DEV, you'll see mount options
> changed for TEST_DEV. e.g.
>
> MOUNT_OPTIONS=3D"-o dax" TEST_FS_MOUNT_OPTS=3D"" ./check generic/413 ge=
neric/445
> generic/445 mount TEST_DEV with "-o dax" too
>
> MOUNT_OPTIONS=3D"" TEST_FS_MOUNT_OPTS=3D"-o dax" ./check generic/413 ge=
neric/445
> generic/445 mount TEST_DEV without "-o dax"
>
> MOUNT_OPTIONS=3D"-o dax" TEST_FS_MOUNT_OPTS=3D"-o dax" ./check generic/=
413 generic/445
> both tests and both devices mount with "-o dax"
>
> That's been discussed in this thread:
> https://patchwork.kernel.org/patch/9742039/
>
> Omer, can you please confirm if you're hitting this issue?
I'm not 100% that's the case, so I better describe my settings more clear=
ly:
I have a debug mount option on my system to recover the FS from a backup.
When that flag is set, umount writes everything to the backup.
Mount restores from it, overwriting everything.

As long as generic/413 is not involved, everything works well.
All _test_cycle_mount() calls first back everything up on umount,
then restore upon mount. So I get the same FS contents.

But, consider generic/118 running after generic/413:
- generic/413 finishes with a mount point with no mount options
- generic/118 begins with restored TEST_FS_MOUNT_OPTS, as you've pointed =
out.
- some writes are performed to the FS
- next _test_cycle_mount:
=C2=A0 calls umount w/o backing up (debug flag previously unset by generi=
c/413).
=C2=A0 calls mount WITH the debug flag, and recovers from an empty backup=
,
=C2=A0 deleting the earlier writes.
- subsequent md5sum fails on "No such file or directory", as FS is now em=
pty.

> I think fixing _check_<fs>_filesystem() is the correct way. And I guess
> we can refactor out a common function and call it in
> _check_[xfs|btrfs|generic]_filesystem, pass the correct mount options
> based on what device we're working on.
If indeed we're talking about the same problem,
please let me know if you'd like me to prepare a different patch.
>
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

