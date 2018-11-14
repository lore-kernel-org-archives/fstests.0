Received: from mout.gmx.net ([212.227.17.21]:54833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeKNRUm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Nov 2018 12:20:42 -0500
Subject: Re: Any method to limit page cache usage in test cases?
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
 <c066af76-261d-0628-c881-bed1b27dec92@suse.com>
 <54caee6f-40a6-e3be-46a5-feb091f08f3c@gmx.com>
Message-ID: <74ff88e7-bdd3-2707-f693-c9a5542af09f@gmx.com>
Date: Wed, 14 Nov 2018 15:17:21 +0800
MIME-Version: 1.0
In-Reply-To: <54caee6f-40a6-e3be-46a5-feb091f08f3c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 2018/11/14 =E4=B8=8B=E5=8D=883:00, Qu Wenruo wrote:
>=20
>=20
> On 2018/11/14 =E4=B8=8B=E5=8D=882:47, Nikolay Borisov wrote:
>>
>>
>> On 14.11.18 =D0=B3. 2:31 =D1=87., Qu Wenruo wrote:
>>> Hi,
>>>
>>> Is there any (easy) method for a fstests test case to limit the page
>>> cache usage?
>>>
>>> I triggered btrfs/139 failure with 2G vRAM VM, and located the root
>>> cause of the problem.
>>
>> You can always size your test vm properly. Otherwise what about the
>> various sysctl tuning knobs? I.e Documentation/sysctl/vm.txt explains
>> some of them: dirty_bytes, dirty_background_bytes,
>> dirty_background_ratio, dirty_expire_centisecs
>=20
> Thanks for the hint about vm.txt!
>=20
> I just realized we could just drop_caches to force dirty page writeback=
,
> without the need to tweaking the complex memory pressure/watermark
> mechanism.

Well, this doesn't work as expected.

It will cause transaction commit, seems that kernel is trying too hard
to free page cache.

Is there any way to only flush dirty pages of a file?

Thanks,
Qu

>=20
> Thanks,
> Qu
>>
>>
>> So with a 2g machine the default settings are using only a fraction of
>> the ram. If you adjust the same settings for the larger ram size you
>> should get almost identical behavior.>
>>
>>
>>>
>>> However it's only really reproducible for small ram VM, since it coul=
d
>>> trigger dirty page writeback due to memory pressure.
>>>
>>> So I'm wondering if we could do such thing even for large RAM test ma=
chine.
>>>
>>> Thanks,
>>> Qu
>>>
