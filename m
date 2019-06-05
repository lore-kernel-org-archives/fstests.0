Received: from mout.gmx.net ([212.227.15.18]:37031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEMFc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Jun 2019 08:05:32 -0400
Subject: Re: [PATCH v2] fstests: generic/260: Make it handle btrfs more
 gracefully
References: <20190603064009.9891-1-wqu@suse.com>
 <261bff5e-c0c1-2a38-28d9-964a6c713745@suse.com>
 <88a52f0f-da5a-0097-afe1-c1a207f9a318@gmx.com>
 <f173ae7b-08c8-8eac-f3df-a07a63e56157@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <00f12e5c-cff4-03fa-99bf-4f8b7c7a7adc@gmx.com>
Date: Wed, 5 Jun 2019 20:05:06 +0800
MIME-Version: 1.0
In-Reply-To: <f173ae7b-08c8-8eac-f3df-a07a63e56157@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 2019/6/5 =E4=B8=8B=E5=8D=887:54, Nikolay Borisov wrote:
>
>
> On 5.06.19 =D0=B3. 14:53 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/6/5 =E4=B8=8B=E5=8D=887:16, Nikolay Borisov wrote:
>>>
>>>
>>> On 3.06.19 =D0=B3. 9:40 =D1=87., Qu Wenruo wrote:
>>>> If a filesystem doesn't map its logical address space (normally the
>>>> bytenr/blocknr returned by fiemap) directly to its devices(s), the
>>>> following assumptions used in the test case is no longer true:
>>>> - trim range start beyond the end of fs should fail
>>>> - trim range start beyond the end of fs with len set should fail
>>>>
>>>> Under the following example, even with just one device, btrfs can sti=
ll
>>>> trim the fs correctly while breaking above assumption:
>>>>
>>>> 0		1G		1.25G
>>>> |---------------|///////////////|-----------------| <- btrfs logical
>>>> 		   |				       address space
>>>>         ------------  mapped as SINGLE
>>>>         |
>>>> 0	V	256M
>>>> |///////////////|			<- device address space
>>>>
>>>> Thus trim range start=3D1G len=3D256M will cause btrfs to trim the 25=
6M
>>>> block group, thus return correct result.
>>>>
>>>> Furthermore, there is no cleared defined behavior for whether a fs sh=
ould
>>>> trim the unmapped space. (only for indirectly mapped fs)
>>>>
>>>> Btrfs currently will always trim the unmapped space, but the behavior
>>>> can change as large trim can be very expensive.
>>>>
>>>> Despite the change to skip certain tests for btrfs, still run the
>>>> following tests for btrfs:
>>>> - trim start=3DU64_MAX with lenght set
>>>>   This will expose a bug that btrfs doesn't check overflow of the ran=
ge.
>>>>   This bug will be fixed soon.
>>>>
>>>> - trim beyond the end of the fs
>>>>   This will expose a bug where btrfs could send trim command beyond t=
he
>>>>   end of its device.
>>>>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("=
btrfs:
>>>>   Honour FITRIM range constraints during free space trim")
>>>>
>>>> With proper fixes for btrfs, this test case should pass on btrfs, ext=
4,
>>>> xfs.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> changelog:
>>>> v2:
>>>> - Return 0/1 instead of echo "1"/"0" for _is_fs_directly_mapped
>>>>   Although it may be a little confusing, but make
>>>>   "if _is_fs_directly_mapped; then" much cleaner.
>>>> - Comment change.
>>>> ---
>>>
>>> Nope, the output is rather unhelpful. Current misc-next of btrfs fails
>>> and the output is:
>>
>> This is not the output. This is seqres.full.
>>
>> For output, using 5.2-rc2, btrfs would fail like:
>> [+] Optional trim range test (fs dependent)
>> [+] Default length (should succeed)
>> [+] Default length with start set (should succeed)
>> [+] Length beyond the end of fs (should succeed)
>> [+] Length beyond the end of fs with start set (should succeed)
>> Unexpected error happened during trim
>> Test done
>>
>> Which is already good enough to show what's wrong.
>>
>>>
>>> [+] Start =3D 2^64-1 and len is set (should fail)
>>>
>>> [+] Trim an empty fs
>>>
>>> 13554941952 trimed
>>>
>>> [+] Try to trim beyond the end of the fs
>>>
>>> [+] Try to trim the fs with large enough len
>>>
>>> 15727198208 trimed
>>
>> For this full, try it on 5.2-rc2, then you would understand why it's he=
re:
>>
>> [+] Start =3D 2^64-1 and len is set (should fail)  << It doesn't fail
>> [+] Trim an empty fs
>> 0 trimed  << It trimmed 0 bytes, isn't it already a problem?
>> [+] Try to trim beyond the end of the fs
>> fstrim: /mnt/scratch: FITRIM ioctl failed: Input/output error  << Beyon=
d
>> device end bug
>> [+] Try to trim the fs with large enough len
>> 5367267328 trimed  << The only good result here.
>>
>>>
>>> generic/260	[failed, exit status 1]
>>>
>>>
>>> There is no 260.out file which is supposed to contain some of the erro=
r
>>> strings which in turn makes the test tedious to debug...
>>
>> I'm afraid you're checking the wrong file.
>
> I don't have an .out file produced!

Then it's because the output matches.
Only status is wrong.

For latest misc branch, the only test it will fail should be that start
=3D -1 with len set one.
Since that subtest is inside the optional fs dependent test, thus it
doesn't output into stdio but completely rely on seqres.full.

In that case, the seqres.full output should be enough to show the problem.

> [+] Start =3D 2^64-1 and len is set (should fail)

Should fail but no error message? Isn't that the reason why it fails?

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> <snip>
>>>
>>
