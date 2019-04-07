Received: from mx2.suse.de ([195.135.220.15]:38910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfDGMpm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Apr 2019 08:45:42 -0400
Subject: Re: [PATCH v2] fstests: btrfs/048: amend property validation cases
References: <20190403165419.12666-1-anand.jain@oracle.com>
 <20190403170437.14448-1-anand.jain@oracle.com>
 <7de2d0fd-e777-2bec-5731-15ba2f2af4f2@suse.com>
 <20190406120207.GG2824@desktop>
 <20062818-d303-047c-358f-52ac9dad50de@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <d552fff5-b43d-6dff-dbb2-3d236041df41@suse.com>
Date: Sun, 7 Apr 2019 15:45:36 +0300
MIME-Version: 1.0
In-Reply-To: <20062818-d303-047c-358f-52ac9dad50de@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Anand Jain <anand.jain@oracle.com>, Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 7.04.19 =D0=B3. 14:54 =D1=87., Anand Jain wrote:
> On 6/4/19 8:02 pm, Eryu Guan wrote:
>> On Fri, Apr 05, 2019 at 04:21:10PM +0300, Nikolay Borisov wrote:
>>>
>>>
>>> On 3.04.19 =D0=B3. 20:04 =D1=87., Anand Jain wrote:
>>>> Add more property validation cases which are fixed by the patches [1=
]
>>>> =C2=A0 [1]
>>>> =C2=A0=C2=A0 btrfs: fix vanished compression property after failed s=
et
>>>> =C2=A0=C2=A0 btrfs: fix zstd compression parameter
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>
>> Thanks for the test and the review!
>>
>> But this looks like a targeted regression test that may fail an existi=
ng
>> test. It's better to write a new test for this.
>=20
> Regression is only when fstests is upgraded. This
> test case mentions the prerequisite kernel patches [1].
> So that should suffice the concern?

I agree with Anand here, this is an extension to an existing test, which
covers specific feature. IMO it's not good to always introduce new tests
because every invocation of a test comes with an overhead of spawning
processes and whatnot. THis is not a problem for 10 tests, but currently
for btrfs we execute around 600 tests each one "wasting" some cycles to
spawn bash processes to execute the actual test.

>=20
> Thanks, Anand
>=20
>>
>> Thanks,
>> Eryu
>>
>>>
>>>> ---
>>>> v2: correct kernel patch titles in the test header and change log
>>>>
>>>> =C2=A0 tests/btrfs/048=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++++++++++++=
+++++++
>>>> =C2=A0 tests/btrfs/048.out | 16 ++++++++++++++++
>>>> =C2=A0 2 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/tests/btrfs/048 b/tests/btrfs/048
>>>> index 588219579cc6..f6de0b8ca8b1 100755
>>>> --- a/tests/btrfs/048
>>>> +++ b/tests/btrfs/048
>>>> @@ -6,6 +6,9 @@
>>>> =C2=A0 #
>>>> =C2=A0 # Btrfs properties test. The btrfs properties feature was
>>>> introduced in the
>>>> =C2=A0 # linux kernel 3.14.
>=20
>=20
> [1]
>=20
>>>> +# Fails without the kernel patches:
>>>> +#=C2=A0 btrfs: fix vanished compression property after failed set
>>>> +#=C2=A0 btrfs: fix zstd compression parameter
>>>> =C2=A0 #
>>>> =C2=A0 seq=3D`basename $0`
>>>> =C2=A0 seqres=3D$RESULT_DIR/$seq
>>>> @@ -34,6 +37,7 @@ _supported_os Linux
>>>> =C2=A0 _require_test
>>>> =C2=A0 _require_scratch
>>>> =C2=A0 _require_btrfs_command "property"
>>>> +_require_btrfs_command inspect-internal dump-super
>>>> =C2=A0 =C2=A0 send_files_dir=3D$TEST_DIR/btrfs-test-$seq
>>>> =C2=A0 @@ -203,5 +207,24 @@ $BTRFS_UTIL_PROG property get
>>>> $SCRATCH_MNT/sv1 compression
>>>> =C2=A0 touch $SCRATCH_MNT/sv1/file2
>>>> =C2=A0 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1/file2 compress=
ion
>>>> =C2=A0 +echo -e "\nTesting argument validation, should fail"
>>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' |
>>>> _filter_scratch
>>>> +echo "***"
>>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' |
>>>> _filter_scratch
>>>> +echo "***"
>>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst' |
>>>> _filter_scratch
>>>> +
>>>> +echo -e "\nTesting if property is persistent across failed validati=
on"
>>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo'
>>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' |
>>>> _filter_scratch
>>>> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT compression
>>>> +
>>>> +echo -e "\nTesting generation is unchanged after failed validation"
>>>> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>>>> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep
>>>> '^generation'
>>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' |
>>>> _filter_scratch
>>>> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>>>> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep
>>>> '^generation'
>>>> +
>>>> =C2=A0 status=3D0
>>>> =C2=A0 exit
>>>> diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
>>>> index 3e4e3d28950a..00f39bc01227 100644
>>>> --- a/tests/btrfs/048.out
>>>> +++ b/tests/btrfs/048.out
>>>> @@ -76,3 +76,19 @@ compression=3Dzlib
>>>> =C2=A0 Testing subvolume property inheritance
>>>> =C2=A0 compression=3Dlzo
>>>> =C2=A0 compression=3Dlzo
>>>> +
>>>> +Testing argument validation, should fail
>>>> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
>>>> +***
>>>> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
>>>> +***
>>>> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
>>>> +
>>>> +Testing if property is persistent across failed validation
>>>> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
>>>> +compression=3Dlzo
>>>> +
>>>> +Testing generation is unchanged after failed validation
>>>> +generation=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7
>>>> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
>>>> +generation=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7
>>>>
>=20
>=20
