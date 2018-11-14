Received: from mout.gmx.net ([212.227.17.21]:45275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbeKNREQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Nov 2018 12:04:16 -0500
Subject: Re: Any method to limit page cache usage in test cases?
References: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
 <c066af76-261d-0628-c881-bed1b27dec92@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <54caee6f-40a6-e3be-46a5-feb091f08f3c@gmx.com>
Date: Wed, 14 Nov 2018 15:00:57 +0800
MIME-Version: 1.0
In-Reply-To: <c066af76-261d-0628-c881-bed1b27dec92@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 2018/11/14 =E4=B8=8B=E5=8D=882:47, Nikolay Borisov wrote:
>=20
>=20
> On 14.11.18 =D0=B3. 2:31 =D1=87., Qu Wenruo wrote:
>> Hi,
>>
>> Is there any (easy) method for a fstests test case to limit the page
>> cache usage?
>>
>> I triggered btrfs/139 failure with 2G vRAM VM, and located the root
>> cause of the problem.
>=20
> You can always size your test vm properly. Otherwise what about the
> various sysctl tuning knobs? I.e Documentation/sysctl/vm.txt explains
> some of them: dirty_bytes, dirty_background_bytes,
> dirty_background_ratio, dirty_expire_centisecs

Thanks for the hint about vm.txt!

I just realized we could just drop_caches to force dirty page writeback,
without the need to tweaking the complex memory pressure/watermark
mechanism.

Thanks,
Qu
>=20
>=20
> So with a 2g machine the default settings are using only a fraction of
> the ram. If you adjust the same settings for the larger ram size you
> should get almost identical behavior.>
>=20
>=20
>>
>> However it's only really reproducible for small ram VM, since it could
>> trigger dirty page writeback due to memory pressure.
>>
>> So I'm wondering if we could do such thing even for large RAM test mac=
hine.
>>
>> Thanks,
>> Qu
>>
