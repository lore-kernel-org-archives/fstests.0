Received: from mx2.suse.de ([195.135.220.15]:45120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbeKNRXu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Nov 2018 12:23:50 -0500
Subject: Re: Any method to limit page cache usage in test cases?
References: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
 <c066af76-261d-0628-c881-bed1b27dec92@suse.com>
 <54caee6f-40a6-e3be-46a5-feb091f08f3c@gmx.com>
 <74ff88e7-bdd3-2707-f693-c9a5542af09f@gmx.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <af32c900-1fd4-3440-7e96-ac189c4d9f9e@suse.com>
Date: Wed, 14 Nov 2018 09:21:47 +0200
MIME-Version: 1.0
In-Reply-To: <74ff88e7-bdd3-2707-f693-c9a5542af09f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 14.11.18 =D0=B3. 9:17 =D1=87., Qu Wenruo wrote:
>=20
>=20
> On 2018/11/14 =E4=B8=8B=E5=8D=883:00, Qu Wenruo wrote:
>>
>>
>> On 2018/11/14 =E4=B8=8B=E5=8D=882:47, Nikolay Borisov wrote:
>>>
>>>
>>> On 14.11.18 =D0=B3. 2:31 =D1=87., Qu Wenruo wrote:
>>>> Hi,
>>>>
>>>> Is there any (easy) method for a fstests test case to limit the page
>>>> cache usage?
>>>>
>>>> I triggered btrfs/139 failure with 2G vRAM VM, and located the root
>>>> cause of the problem.
>>>
>>> You can always size your test vm properly. Otherwise what about the
>>> various sysctl tuning knobs? I.e Documentation/sysctl/vm.txt explains
>>> some of them: dirty_bytes, dirty_background_bytes,
>>> dirty_background_ratio, dirty_expire_centisecs
>>
>> Thanks for the hint about vm.txt!
>>
>> I just realized we could just drop_caches to force dirty page writebac=
k,
>> without the need to tweaking the complex memory pressure/watermark
>> mechanism.
>=20
> Well, this doesn't work as expected.
>=20
> It will cause transaction commit, seems that kernel is trying too hard
> to free page cache.
>=20
> Is there any way to only flush dirty pages of a file?

well fdatasync causes ->fsync to run, in btrfs that will be
btrfs_sync_file. One of the first thing it does is start_ordered_ops
which does btrfs_fdatawrite_range, which in turn is filemap_fdatawrite_ra=
nge


>=20
> Thanks,
> Qu
>=20
>>
>> Thanks,
>> Qu
>>>
>>>
>>> So with a 2g machine the default settings are using only a fraction o=
f
>>> the ram. If you adjust the same settings for the larger ram size you
>>> should get almost identical behavior.>
>>>
>>>
>>>>
>>>> However it's only really reproducible for small ram VM, since it cou=
ld
>>>> trigger dirty page writeback due to memory pressure.
>>>>
>>>> So I'm wondering if we could do such thing even for large RAM test m=
achine.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>=20
